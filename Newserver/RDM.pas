unit RDM;

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, PPD_SRV_TLB, StdVcl, Provider, IBStoredProc, Db,
  IBCustomDataSet, IBQuery, IBDatabase, StrUtils, Formula;

type
  TPPD_Server_2 = class(TRemoteDataModule, IPPD_Server_2)
    IBDB: TIBDatabase;
    IBTrans: TIBTransaction;
    q_SQL: TIBQuery;
    q_users: TIBQuery;
    sp_next_id: TIBStoredProc;
    q_default: TIBQuery;
    pr_teh: TDataSetProvider;
    cds_teh: TClientDataSet;
    cds_work: TClientDataSet;
    DBtmp: TIBDatabase;
    IBTransTMP: TIBTransaction;
    q_tmp: TIBQuery;
    pr_tmp: TDataSetProvider;
    cds_tmp: TClientDataSet;
    cds_calc: TClientDataSet;
    procedure RemoteDataModuleCreate(Sender: TObject);
    procedure RemoteDataModuleDestroy(Sender: TObject);
  private
    pravo : integer;
    IsRiteConnect : boolean;
    IsSystem : boolean;
    IsADM : boolean;
    new_id : integer;
    oper : integer;
    sys_op : boolean;
    logn : string;
    vr1 : integer;
    function CheckLogin(log,psw : string) : integer;
    function GetSQL(sqlnom,pra :integer) : variant;
    function TranslateSQL(params : variant) : string;
    function GetDataS(param: Variant): Variant;
    function RunSQLS(params: Variant): Integer;
    function TransSQLS(params: Variant): String;
    function MakeDataForCalc : boolean;
    function ElementToCalc(ename,defn : string; par : variant) : boolean;
    function PumpToCalc : boolean;
    function CatchToCalc : boolean;
    function KNSToCalc : boolean;
    function NSToCalc : boolean;
    function StokToCalc : boolean;
    function PipeToCalc : boolean;
    function VRPToCalc : boolean;
    function WellToCalc : boolean;
    function UnitToCalc : boolean;
    function UnitBalToCalc : boolean;
    function PumpPlanToCalc : boolean;
    function CreateDBtemp : boolean;
    Function ElementCalcToDB(sqb,elm,dfel : string; tip : integer) : boolean;
    function GetDataFromRes(par : variant) : Variant;
    function RunSQLres(par : variant) : boolean;
    function GetResValuesElements(ename,defn : string;tp,sqn,id,per : integer) : variant;
    Function CheckOperationRules(op, rul : integer) : boolean;
    { Private declarations }
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Timing: OleVariant; safecall;
    procedure StartTrans; safecall;
    procedure CommitTrans; safecall;
    procedure BackTrans; safecall;
    function GetStateTrans: Integer; safecall;
    function GetLastID: Integer; safecall;
    function LogDB(lg, ps: OleVariant): Integer; safecall;
    function GetData(param: OleVariant): OleVariant; safecall;
    function RunSQL(params: OleVariant): Integer; safecall;
    function GETNextID: Integer; safecall;
    function DoCalculate: Integer; safecall;
    function GetAgrForExel(AgrID:integer): OleVariant; safecall;
    function GetPeriodsList: OleVariant; safecall;
    function GetResElements(id, tp, per: Integer): OleVariant; safecall;
    procedure SetVr1(vrr: Integer); safecall;
    function GetUnitRes(id: Integer): OleVariant; safecall;
    function GetKnsForExel(KnsID: Integer): OleVariant; safecall;
    function UpdateSQL(dt: OleVariant): Integer; safecall;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Uses Srv_face;

class procedure TPPD_Server_2.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

function TPPD_Server_2.Timing: OleVariant;
begin
  Result:=now;
end;

procedure TPPD_Server_2.StartTrans;
begin
  If not IBTrans.InTransaction Then IBTrans.StartTransaction;
end;

procedure TPPD_Server_2.CommitTrans;
begin
  If IBTrans.InTransaction Then IBTrans.Commit;
end;

procedure TPPD_Server_2.BackTrans;
begin
  If IBTrans.InTransaction Then IBTrans.Rollback;
end;

function TPPD_Server_2.GetStateTrans: Integer;
begin
  If IBTrans.InTransaction Then Result:=1 Else Result:=0;
end;

function TPPD_Server_2.GetLastID: Integer;
begin
  Result:=new_id;
end;

function TPPD_Server_2.LogDB(lg, ps: OleVariant): Integer;
var
 rr : integer;
begin
  rr:=-1;
  If not IBDB.Connected Then Begin
     result:=1;
     Exit;
  end;
  try
  pravo:=CheckLogin(lg, ps);
  If pravo<1001 Then Begin
     IsRiteConnect:=true;
     logn:=lg;
     fr_face.ShowMember (lg);
     rr:=0;
     Case pravo of
        0,1 : IsSystem:=true;
        2..10 : IsADM:=true;
     Else Begin
           IsSystem:=false;
           IsADM:=false;
          end
     end;
  end;
  finally
    result:=rr;
  end;
end;

function TPPD_Server_2.GetData(param: OleVariant): OleVariant;
begin
  Result:=null;
  If RunSQL(param)=0 Then Begin
     try
       cds_teh.Active:=false;
       cds_teh.Open;
       Result:=cds_teh.Data;
       cds_teh.Active:=false;
     except
     end;
  end;
end;

function TPPD_Server_2.RunSQL(params: OleVariant): Integer;
Var
  sqltxt : variant;
  ii : integer;
begin
  sqltxt:=TranslateSQL(params);
  If sqltxt='' Then Begin
     Result:=1;
     Exit;
  end;
  If sqltxt='-' Then Begin
     Result:=-1;
     Exit;
  end;
  q_default.SQL.Text:=sqltxt;
  fr_face.ShowLastSql(sqltxt);
  If not VarIsNull(params[1]) Then
  For ii:=0 To VarArrayHighBound(params[1],1) Do
      If String(Params[1][ii])[1]<>'!' Then Begin
        If VarIsNull(Params[2][ii]) Then q_default.ParamByName(Params[1][ii]).Value:=null
        Else
        Case VarType(Params[2][ii]) of
          varNull      : q_default.ParamByName(Params[1][ii]).Value:=Params[2][ii];
          varSmallint  : q_default.ParamByName(Params[1][ii]).AsInteger:=Params[2][ii];
          varInteger   : q_default.ParamByName(Params[1][ii]).AsInteger:=Params[2][ii];
          varSingle    : q_default.ParamByName(Params[1][ii]).AsFloat:=Params[2][ii];
          varDouble    : q_default.ParamByName(Params[1][ii]).AsFloat:=Params[2][ii];
          varDate      : q_default.ParamByName(Params[1][ii]).AsDate:=Params[2][ii];
          varBoolean   : q_default.ParamByName(Params[1][ii]).AsBoolean:=Params[2][ii];
          varVariant   : q_default.ParamByName(Params[1][ii]).AsBlob:=Params[2][ii];
          varString    : q_default.ParamByName(Params[1][ii]).AsString:=Params[2][ii];
          varOleStr    : q_default.ParamByName(Params[1][ii]).AsString:=Params[2][ii];
        end;
      end;
  Result:=0;
  If (q_default.SQL.Text[1]<>'s') and (q_default.SQL.Text[1]<>'S') Then Begin
     try
       q_default.ExecSQL;
     except
       Result:=-1;
     end;
  end;
end;

function TPPD_Server_2.GETNextID: Integer;
begin
   Result:=-1;
   If not IsRiteConnect Then Exit;
   sp_next_id.Prepare;
   sp_next_id.ExecProc;
   new_id:=sp_next_id.Params[0].AsInteger;
   Result:=new_id;
end;

function TPPD_Server_2.CheckLogin(log,psw : string) : integer;
var
  rr : integer;
  rc : integer;
Begin
   q_users.Params[0].AsString:=log;
   q_users.Prepare;
   rr:=1001;
   try
     q_users.Open;
     rc:=q_users.RecordCount;
     If q_users.FieldByName('PSW').AsString=psw Then
         rr:=q_users.FieldByName('roles_id').AsInteger;
   finally
     If rr<1001 Then oper:=q_users.FieldByName('id').AsInteger
     Else oper:=-1;
     q_users.Active:=false;
     Result:=rr;
   end;
end;

function TPPD_Server_2.GetSQL(sqlnom,pra :integer) : variant;
var
  rr : variant;
Begin
  rr:=null;
  try
    q_sql.Params[0].AsInteger:=sqlnom;
    q_sql.Params[1].AsInteger:=pra;
    q_sql.Active:=true;
    rr:=q_sql.FieldByName('SQL').AsString;
  finally
    q_sql.Active:=false;
    Result:=rr;
  end;
end;

function TPPD_Server_2.TranslateSQL(params : variant) : string;
Var
  sqltxt : variant;
  ii : integer;
  ppr : integer;
Begin
  Result:='';
  //Test rite connect
  If not IsRiteConnect Then Exit;
  If sys_op Then ppr:=0 Else ppr:=pravo;
  sqltxt:=GetSQL(params[0],ppr);
  If VarIsNull(sqltxt) Then Exit;
  fr_face.ShowLastPar(logn+'> SQL # '+IntToStr(params[0]));
  //Удаление коментариев
  If (VarArrayHighBound(params,1)>2)and(not VarIsNull(params[3])) Then
     For ii:=0 To VarArrayHighBound(params[3],1) Do Begin
        sqltxt:=ReplaceStr(sqltxt,'/*'+Params[3][ii]+'!','');
        sqltxt:=ReplaceStr(sqltxt,'!'+Params[3][ii]+'*/','');
     end;
  //Проверка наличия стандартных переменных
  If Pos('!id!',sqltxt)>0 Then Begin
     sp_next_id.Prepare;
     sp_next_id.ExecProc;
     new_id:=sp_next_id.Params[0].AsInteger;
     sqltxt:=ReplaceStr(sqltxt,'!id!',IntToStr(new_id));
  end;
  If Pos('!op!',sqltxt)>0 Then    //Вставка кода оператора
      sqltxt:=ReplaceStr(sqltxt,'!op!',IntToStr(oper));
  //Подстановка параметров в текст SQL
  If not VarIsNull(params[1]) Then
  If VarArrayHighBound(params[1],1)<>VarArrayHighBound(params[2],1) Then begin
     Result:='-';
     Exit;
  end;
  If not VarIsNull(params[1]) Then
  For ii:=0 To VarArrayHighBound(params[1],1) Do Begin
      If Pos(Params[1][ii]+'!',sqltxt)=0 Then Begin
         Raise EMathError.Create('Лишний параметр!!  Имя параметра: '+Params[1][ii])
      end;
      if String(Params[1][ii])[1]='!' then Begin
         sqltxt:=ReplaceStr(sqltxt,Params[1][ii]+'!',Params[2][ii])
      end
      Else Begin
        sqltxt:=ReplaceStr(sqltxt,'!'+Params[1][ii]+'!',':'+Params[1][ii]);
      end;
  end;
  DelBSpace(sqltxt);
  Result:=sqltxt;
end;

function TPPD_Server_2.TransSQLS(params: Variant): String;
Begin
   Result:='';
   try
     sys_op:=true;
     Result:=TranslateSQL(params);
   finally
     sys_op:=false;
   end;
end;

function TPPD_Server_2.GetDataS(param: Variant): Variant;
Begin
   Result:=null;
   try
     sys_op:=true;
     Result:=GetData(param);
   finally
     sys_op:=false;
   end;
end;

function TPPD_Server_2.RunSQLS(params: Variant): Integer;
Begin
   try
     sys_op:=true;
     Result:=RunSQL(params);
   finally
     sys_op:=false;
   end;
end;

procedure TPPD_Server_2.RemoteDataModuleCreate(Sender: TObject);
begin
  IBDB.DatabaseName:=bd_path;
  oper:=-1;
  new_id:=-1;
  vr1:=-1;
  IsRiteConnect:=false;
  IsSystem:=false;
  IsADM:=false;
  sys_op:=false;
  try
   IBDB.Connected:=true;
  except
  end;
  IBTrans.Active:=true;
end;

function TPPD_Server_2.CreateDBtemp : boolean;
var
  namdb : string;
  id,ii : integer;
  par, pp : variant;
  rr : integer;
  sqlt : string;
Begin
  Result:=DBtmp.Connected;
  If Result Then Exit;
  id:=GETNextID;
  namdb:=db_tmp+IntToStr(id)+'.tmp';
  DBtmp.DatabaseName:=namdb;
  try
    DBtmp.CreateDatabase;
  except
    fr_face.ShowLastPar('DB create ERROR!!');
    Exit;
  end;
  fr_face.ShowLastPar('DB create Ok!!');
  // Создаем таблицы
  sqlt:=GetSQL(1000,0);
  pp:=AnalizeStr(sqlt,'!',false);
  if VarIsNull(pp) Then Exit;
  If not IBTransTMP.InTransaction Then IBTransTMP.StartTransaction;
  For ii:=0 To VarArrayHighBound(pp,1) Do Begin
    q_tmp.SQL.Text:=pp[ii];
    fr_face.ShowLastSql(pp[ii]);
    try
      q_tmp.ExecSQL;
    except
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      If DBtmp.Connected Then DBtmp.DropDatabase;
      fr_face.ShowLastPar('Create tables break... Bad SQL...');
      Exit;
    end;
  end;
  If IBTransTMP.InTransaction Then IBTransTMP.Commit;
  fr_face.ShowLastPar('Tables create Ok!!');
  Result:=true;
end;

procedure TPPD_Server_2.RemoteDataModuleDestroy(Sender: TObject);
begin
  fr_face.HideMember (logn);
  IBTransTMP.Active:=false;
  try
    If DBtmp.Connected Then DBtmp.DropDatabase;
  except
  end;
  IBTrans.Active:=false;
  IBDB.Connected:=false;
end;

function TPPD_Server_2.MakeDataForCalc : boolean;
Begin
  Result:=false;
  CanWriteToFile.Enter;
  try
   try
     If not PumpToCalc Then Raise EMathError.Create('');
     If not CatchToCalc Then Raise EMathError.Create('');
     If not KNSToCalc Then Raise EMathError.Create('');
     If not NSToCalc Then Raise EMathError.Create('');
     If not StokToCalc Then Raise EMathError.Create('');
     If not PipeToCalc Then Raise EMathError.Create('');
     If not WellToCalc Then Raise EMathError.Create('');
     If not VRPToCalc Then Raise EMathError.Create('');
     If not UnitToCalc Then Raise EMathError.Create('');
     If not UnitBalToCalc Then Raise EMathError.Create('');
     If not PumpPlanToCalc Then Raise EMathError.Create('');
     Result:=true;
   finally
    CanWriteToFile.Leave;
   end;
  except
  end;
end;

function TPPD_Server_2.ElementToCalc(ename,defn : string; par : variant) : boolean;
var
  re,pp,ll : variant;
  fn,ss,fini,bbr,coment_prn : string;
  ii, cc : integer;
Begin
  coment_prn:='';
  Result:=false;
  cds_work.active:=false;
  fn:=fr_face.ReadParamFromINI('ppd_srv.ini','Files',ename,defn);
  fini:=fn+OUT_PARAMS;
  fn:=ToCalc+fn+OUT_FORMAT;
  cc:=StrToInt(fr_face.ReadParamFromINI(fini,'Fields','count','0'));
  bbr:=fr_face.ReadParamFromINI(fini,'Design','break',' ');
  coment_prn:=fr_face.ReadParamFromINI(fini,'Coments','show','0');
  pp:=VarArrayCreate([0, cc-1], varVariant);
  ll:=VarArrayCreate([0, cc-1], varVariant);
  try
   try
    re:=GetDataS(par);
    If VarIsNull(re) Then Raise EMathError.Create('');
    cds_work.data:=re;
    fr_face.BeginWFile(fn);
    For ii:=1 To cc Do Begin
       ss:=fr_face.ReadParamFromINI(fini,'Coments',IntToStr(ii),'');
       ll[ii-1]:=StrToInt(fr_face.ReadParamFromINI(fini,'Len',IntToStr(ii),'1'));
       If (ss<>'')and(coment_prn='1') Then fr_face.WriteStrToFile(IntToStr(ii)+'. '+ss);
    end;
    fr_face.WriteStrToFile('');
    While not cds_work.EOF Do Begin
       For ii:=1 To cc Do Begin
         ss:=fr_face.ReadParamFromINI(fini,'Fields',IntToStr(ii),'');
         if ss<>'' Then pp[ii-1]:=cds_work.FieldByName(ss).Value;
       end;
       ss:=fr_face.MakeFormatStr(pp,ll,bbr);
       fr_face.WriteStrToFile(ss);
       cds_work.Next;
    end;
    Result:=true;
   finally
     fr_face.EndFile;
     cds_work.active:=false;
   end;
  except
  end;
end;

function TPPD_Server_2.PumpToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=114;
  par[1]:=null;
  par[2]:=null;
  Result:=ElementToCalc('PUMP','Agr',par);
end;

function TPPD_Server_2.CatchToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=115;
  par[1]:=null;
  par[2]:=null;
  Result:=ElementToCalc('CATCH','Zad',par);
end;

function TPPD_Server_2.KNSToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=116;
  par[1]:=VarArrayOf(['st']);
  par[2]:=VarArrayOf([0]);
  Result:=ElementToCalc('KNS','Kns',par);
end;

function TPPD_Server_2.NSToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=24;
  par[1]:=null;
  par[2]:=null;
  Result:=ElementToCalc('NS','Ns',par);
end;

function TPPD_Server_2.StokToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=116;
  par[1]:=VarArrayOf(['st']);
  par[2]:=VarArrayOf([1]);
  Result:=ElementToCalc('STOK','Stok',par);
end;

function TPPD_Server_2.PipeToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=117;
  par[1]:=Null;
  par[2]:=Null;
  Result:=ElementToCalc('PIPE','Ww',par);
end;

function TPPD_Server_2.WellToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=119;
  par[1]:=Null;
  par[2]:=Null;
  Result:=ElementToCalc('WELL','Well',par);
end;

function TPPD_Server_2.VRPToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=120;
  par[1]:=Null;
  par[2]:=Null;
  Result:=ElementToCalc('VRP','Vrp',par);
end;

function TPPD_Server_2.UnitToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=121;
  par[1]:=Null;
  par[2]:=Null;
  Result:=ElementToCalc('UZ','Uz',par);
end;

function TPPD_Server_2.UnitBalToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=122;
  par[1]:=Null;
  par[2]:=Null;
  Result:=ElementToCalc('BALANS','Bal',par);
end;

function TPPD_Server_2.PumpPlanToCalc : boolean;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=127;
  par[1]:=Null;
  par[2]:=Null;
  Result:=ElementToCalc('PUMP PLANE','Sob',par);
end;

function TPPD_Server_2.DoCalculate: Integer;
var
 sqtxt,prcname,rrcpth,rexe, rrexe : string;
 bl : boolean;
 exeres,itter,rs : integer;
 par : variant;
begin
  Result:=-1;
  If not CheckOperationRules(1,pravo) Then Exit;
  bl:=MakeDataForCalc;
  If not bl Then Begin
     Result:=1;
     Exit;
  end;
  // Запуск программы расчета
  // ++++++++++++++++++++++++
  prcname:=fr_face.ReadParamFromINI('ppd_srv.ini','Files','EXE','PPD3.exe');
  rrcpth:=fr_face.ReadParamFromINI('ppd_srv.ini','PATH','ppd',exe_path);
  prcname:=rrcpth+prcname;
  exeres:=32;
  try
    rexe:=fr_face.ReadParamFromINI('ppd_srv.ini','PARAMS','RUNEXE','0');
    rrexe:=fr_face.ReadParamFromINI('ppd_srv.ini','Files','OKEXEC','24');
    itter:=StrToInt(fr_face.ReadParamFromINI('ppd_srv.ini','PARAMS','WAIT','0'));
    If rexe='1' Then Begin
      If fr_face.IsFile(rrcpth+rrexe) Then
         If not fr_face.DelFile(rrcpth+rrexe) Then Begin
            fr_face.ShowLastPar('Can`t delete rfile');
            Exit;
         end;
      fr_face.ShowLastPar(prcname);
      exeres:=WinExec(PChar(prcname+#0),SW_SHOW{SW_HIDE});
    end;
  except
  end;
  If exeres<32 Then Begin
     fr_face.ShowLastPar('Error execute EXE:');
     Result:=2;
     CASE exeres of
         0 : fr_face.ShowLastPar('out of memory');
         ERROR_BAD_FORMAT : fr_face.ShowLastPar('EXE file is invalid');
         ERROR_FILE_NOT_FOUND : fr_face.ShowLastPar('file not found');
         ERROR_PATH_NOT_FOUND : fr_face.ShowLastPar('path not found');
         Else fr_face.ShowLastPar('Error '+IntToStr(exeres));
     end;
     Exit;
  end;
  If rexe='1' Then Begin
     try
     While (not fr_face.IsFile(rrcpth+rrexe))and(itter>0) Do Dec(itter);
     If itter>0 Then Begin
        fr_face.ShowLastPar('wait='+IntToStr(itter));
        fr_face.BeginRFile(rrcpth+rrexe);
        If fr_face.IsEndFile Then Begin
           Result:=3;
           fr_face.EndFile;
           fr_face.ShowLastPar('Empty rfile');
           Exit;
        end;
        If fr_face.ReadFromFile<>'1' Then Begin
           Result:=4;
           fr_face.EndFile;
           fr_face.ShowLastPar('Bad calc!');
           Exit;
        end;
        fr_face.ShowLastPar('Good calc!');
        fr_face.EndFile;
     end
     Else Begin
        Result:=5;
        fr_face.ShowLastPar('Long calc');
        Exit;
     end;
     except
     end;
  end;
  // Создание временной БД для хранения результатов вычисления
  If not CreateDBtemp Then Exit;

  // Сперва удалим все чо было
  IBTransTMP.StartTransaction;
  try
    q_tmp.SQL.Text:='Delete from PUMP_TIME_RES';
    q_tmp.ExecSQL;
    q_tmp.SQL.Text:='Delete from TIM';
    q_tmp.ExecSQL;
    q_tmp.SQL.Text:='Delete from PIPE_RES';
    q_tmp.ExecSQL;
    q_tmp.SQL.Text:='Delete from CATCH_RES';
    q_tmp.ExecSQL; 
    q_tmp.SQL.Text:='Delete from WELL_RES';
    q_tmp.ExecSQL;
    q_tmp.SQL.Text:='Delete from UZ_RES';
    q_tmp.ExecSQL;
    q_tmp.SQL.Text:='Delete from STOK_RES';
    q_tmp.ExecSQL;
    q_tmp.SQL.Text:='Delete from PLAST_RES';
    q_tmp.ExecSQL;
    q_tmp.SQL.Text:='Delete from KNS_TIME_RES';
    q_tmp.ExecSQL;
    fr_face.ShowLastPar('Del Ok!');
  except
    Result:=6;
    IBTransTMP.Rollback;
    Exit;
  end;
  CanWriteToFile.Enter;
  try
  try
   // Заливаем результаты по агрегатам по минутам
   Result:=7;
   sqtxt:='Insert into PUMP_TIME_RES (';
   If not ElementCalcToDB(sqtxt,'PUMP','Agr',0) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем результаты по КНС по минутам
   sqtxt:='Insert into KNS_TIME_RES (';
   If not ElementCalcToDB(sqtxt,'KNS','Kns',0) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем результаты по водоводам
   sqtxt:='Insert into PIPE_RES (';
   If not ElementCalcToDB(sqtxt,'PIPE','Ww',1) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем результаты по задвижкам
   sqtxt:='Insert into CATCH_RES (';
   If not ElementCalcToDB(sqtxt,'CATCH','Zad',1) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем результаты по скважинам
   sqtxt:='Insert into WELL_RES (';
   If not ElementCalcToDB(sqtxt,'WELL','Well',1) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем результаты по пластам
   sqtxt:='Insert into PLAST_RES (';
   If not ElementCalcToDB(sqtxt,'PLAST','Plast',1) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем результаты по стокам
   sqtxt:='Insert into STOK_RES (';
   If not ElementCalcToDB(sqtxt,'STOK','Stok',1) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем результаты по узлам
   sqtxt:='Insert into UZ_RES (';
   If not ElementCalcToDB(sqtxt,'UZ','Uz',1) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;
   // Заливаем таблицу периодов
   par:=VarArrayCreate([0,2],varVariant);
   par[0]:=1012;
   par[1]:=null;
   par[2]:=null;
   If not RunSQLres(par) Then Begin
      If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
      CanWriteToFile.Leave;
      Exit
   end;

   IBTransTMP.Commit;
   Result:=0;
  finally
    CanWriteToFile.Leave;
  end;
  Except
     If IBTransTMP.InTransaction Then IBTransTMP.Rollback;
  end;
end;

Function TPPD_Server_2.ElementCalcToDB(sqb,elm,dfel : string; tip : integer) : boolean;
Var
 par : variant;
 sqltxt,fini,bbr,fnam,ss : string;
 sqlst : TStringList;
 br : char;
 mn : real;
 rr,len,ii : integer;
Begin
  Result:=false;
  sqlst:=TStringList.Create;
  CASE tip of
     0 : ss:=TIME_PARAMS;
     1 : ss:=IN_PARAMS;
  end;
  fini:=fr_face.ReadParamFromINI('ppd_srv.ini','Files',elm,dfel)+ss;
  len:=StrToInt(fr_face.ReadParamFromINI(fini,'Fields','count','0'));
  sqltxt:=sqb;
  If len>0 Then Begin
    fr_face.ShowLastPar('Заливаем : '+elm);
    For ii:=0 To len-1 Do If ii=0 Then sqltxt:=sqltxt+fr_face.ReadParamFromINI(fini,'Fields',IntToStr(ii+1),'')
                          Else sqltxt:=sqltxt+', '+fr_face.ReadParamFromINI(fini,'Fields',IntToStr(ii+1),'');
    sqltxt:=sqltxt+')';
    sqlst.Add(sqltxt);
    sqlst.Add(' ');
    bbr:=fr_face.ReadParamFromINI(fini,'Design','break','!');
    br:=bbr[1];
    sqltxt:='Values';
    CASE tip of
       0 : ss:=TIME_FORMAT;
       1 : ss:=IN_FORMAT;
    end;
    fnam:=FromCalc+fr_face.ReadParamFromINI('ppd_srv.ini','Files',elm,dfel)+ss;
    ss:='';
    If fr_face.BeginRFile(fnam) Then Begin
     While not fr_face.IsEndFile Do Begin
       ss:=fr_face.ReadFromFile;
       If ss<>'' Then Begin
         par:=AnalizeStr(ss,br,true);
         For ii:=0 To len-1 Do Begin
            ss:=fr_face.ReadParamFromINI(fini,'Round',IntToStr(ii+1),'');
            If ss<>'' Then Begin
               mn:=StrToInt(ss)*10;
               If mn=0 Then mn:=1;
               par[ii]:=FloatToStr(Round(StrToFloat(par[ii])*mn)/mn);
            end;
         end;
         ss:='';
         For ii:=0 To len-1 Do ss:=ss+','+par[ii];
         ss[1]:='(';
         ss:=ss+')';
         sqlst.Strings[1]:=sqltxt+ss;
         q_tmp.SQL.Text:=sqlst.Text;
         try
           q_tmp.ExecSQL;
           fr_face.ShowLastSql(sqlst.Text);
         except
          fr_face.ShowLastSql('Не выполнен SQL: '+sqlst.Text);
          fr_face.EndFile;
          Exit;
         end;
       end;
     end;
     fr_face.EndFile;
    end
    Else Exit;
    Result:=true;
  end;
  sqlst.Free;
end;

function TPPD_Server_2.GetDataFromRes(par : variant) : Variant;
Var
  sqltxt : string;
begin
  Result:=null;
  If not DBtmp.Connected Then Exit;
  sqltxt:=TransSQLS(par);
  If (sqltxt<>'')and(sqltxt<>'-') Then Begin
     q_tmp.SQL.Text:=sqltxt;
     try
     cds_tmp.Active:=true;
     except
       Exit;
     end;
     Result:=cds_tmp.Data;
     cds_tmp.Active:=false;
  end;
end;

function TPPD_Server_2.RunSQLres(par : variant) : boolean;
Var
  sqltxt : string;
Begin
  Result:=false;
  If not DBtmp.Connected Then Exit;
  sqltxt:=TransSQLS(par);
  If (sqltxt<>'')and(sqltxt<>'-') Then Begin
     If (sqltxt[1]='S')or(sqltxt[1]='s') Then Exit;
     q_tmp.SQL.Text:=sqltxt;
     try
     cds_tmp.Execute;
     except
       Exit;
     end;
     Result:=True;
  end;
end;

function TPPD_Server_2.GetAgrForExel(AgrID:integer): OleVariant;
Var
  par : variant;
begin
  Result:=null;
  par:=VarArrayCreate([0,2],varVariant);
  par[0]:=1001;
  par[1]:=VarArrayOf(['!pump']);
  par[2]:=VarArrayOf([IntToStr(AgrID)]);
  Result:=GetDataFromRes(par);
end;

function TPPD_Server_2.GetPeriodsList: OleVariant;
Var
  par : variant;
begin
  Result:=null;
  par:=VarArrayCreate([0,2],varVariant);
  par[0]:=1002;
  par[1]:=null;
  par[2]:=null;
  Result:=GetDataFromRes(par);
end;

function TPPD_Server_2.GetResValuesElements(ename,defn : string;tp,sqn,id,per : integer) : variant;
var
 ss,fini,fn,comt : string;
 len,ii,bb : integer;
 rr,par,res : variant;
Begin
  result:=null;
  par:=VarArrayCreate([0,2],varVariant);
  par[0]:=sqn;
  If tp=2 Then Begin
    par[1]:=VarArrayOf(['!kd','!per','!kdd']);
    par[2]:=VarArrayOf([IntToStr(id),IntToStr(per),IntToStr(vr1)]);
  end
  Else Begin
    par[1]:=VarArrayOf(['!kd','!per']);
    par[2]:=VarArrayOf([IntToStr(id),IntToStr(per)]);
  end;
  res:=GetDataFromRes(par);
  If VarIsNull(res) Then Exit;
  cds_calc.data:=res;
  If cds_calc.RecordCount=0 Then Exit;
  CASE tp of
     0 : ss:=TIME_PARAMS;
   1,2 : ss:=IN_PARAMS;
  end;
  fini:=fr_face.ReadParamFromINI('ppd_srv.ini','Files',ename,defn)+ss;
  len:=StrToInt(fr_face.ReadParamFromINI(fini,'Fields','count','0'));
  If len=0 Then Exit;
  rr:=VarArrayCreate([0,len],varVariant);
  bb:=0;
  For ii:=0 To len Do Begin
    rr[ii]:=null;
    ss:=fr_face.ReadParamFromINI(fini,'ValNames',IntToStr(ii),'');
    If ss<>'' Then Begin
      fn:=fr_face.ReadParamFromINI(fini,'Fields',IntToStr(ii),'');
      If fn='' Then Exit;
      comt:=fr_face.ReadParamFromINI(fini,'Coments',IntToStr(ii),'');
      rr[bb]:=VarArrayOf([comt,cds_calc.FieldByName(fn).AsString,ss]);
      Inc(bb);
    end;
  end;
  Result:=rr;
end;

function TPPD_Server_2.GetResElements(id, tp, per: Integer): OleVariant;
begin
  Result:=null;
  CASE tp of
    15 : Begin
           Result:=GetResValuesElements('PLAST','Plast',2,1009,id,per);
         end;
   1,2 : Begin
           Result:=GetResValuesElements('KNS','Kns',0,1008,id,per);
         end;
     3 : Begin
           Result:=GetResValuesElements('STOK','Stok',1,1004,id,per);
         end;
     4 : Begin
           Result:=GetResValuesElements('PIPE','Ww',1,1005,id,per);
         end;
     5 : Begin
           Result:=GetResValuesElements('PUMP','Agr',0,1003,id,per);
         end;
     8 : Begin
           Result:=GetResValuesElements('Well','Well',1,1006,id,per);
         end;
     9 : Begin
         end;
    10 : Begin
           Result:=GetResValuesElements('CATCH','Zad',1,1007,id,per);
         end;
  end;
end;

procedure TPPD_Server_2.SetVr1(vrr: Integer);
begin
   vr1:=vrr;
end;

function TPPD_Server_2.GetUnitRes(id: Integer): OleVariant;
Var
  par : variant;
begin
  Result:=null;
  par:=VarArrayCreate([0,2],varVariant);
  par[0]:=1010;
  par[1]:=VarArrayOf(['!kd']);
  par[2]:=VarArrayOf([IntToStr(id)]);
  Result:=GetDataFromRes(par);
end;

function TPPD_Server_2.GetKnsForExel(KnsID: Integer): OleVariant;
Var
  par : variant;
begin
  Result:=null;
  par:=VarArrayCreate([0,2],varVariant);
  par[0]:=1011;
  par[1]:=VarArrayOf(['!kns']);
  par[2]:=VarArrayOf([IntToStr(KnsID)]);
  Result:=GetDataFromRes(par);
end;

Function TPPD_Server_2.CheckOperationRules(op, rul : integer) : boolean;
Var
  par,res : variant;
  rr : integer;
Begin
  Result:=false;
  par:=VarArrayCreate([0,2],varVariant);
  par[0]:=133;
  par[1]:=VarArrayOf(['oper']);
  par[2]:=VarArrayOf([op]);
  cds_work.Active:=false;
  res:=GetDataS(par);
  If VarIsNull(res) Then Exit;
  cds_work.Data:=res;
  If cds_work.RecordCount=0 Then Exit;
  rr:=cds_work.FieldByName('roles_id').AsInteger;
  If rr>=rul Then Result:=true;
end;

function TPPD_Server_2.UpdateSQL(dt: OleVariant): Integer;
var
  cc,id,rr : integer;
  par : variant;
begin
  { Результаты: 0 - Ок!!, -2 Нет прав, -1 НУЛ, 1 - нет записей,
                2 - ошибка изменения, 3 - ошибка вставки}
  If not CheckOperationRules(1,pravo) Then Begin
    Result:=-2;
    Exit;
  end;
  Result:=-1;
  cds_work.Active:=false;
  If VarIsNull(dt) Then Exit;
  cds_work.Data:=dt;
  par:=VarArrayCreate([0,2],varVariant);
  par[1]:=VarArrayOf(['kd','rol','dt','sql','com']);
  If cds_work.RecordCount=0 Then Begin
    Result:=1;
    Exit;
  end;
  try
  If IBTrans.InTransaction Then IBTrans.Commit;
  IBTrans.StartTransaction;
  While not cds_work.Eof Do Begin
     q_SQL.Active:=false;
     id:=cds_work.FieldByName('id').AsInteger;
     q_SQL.ParamByName('id').AsInteger:=id;
     q_SQL.ParamByName('pravo').AsInteger:=0;
     q_SQL.Prepare;
     q_SQL.Active:=true;
     cc:=q_SQL.RecordCount;
     par[2]:=VarArrayOf([id,cds_work.FieldByName('ROLES_ID').AsInteger,
                                   cds_work.FieldByName('CHANGE_DATE').AsDateTime,
                                   cds_work.FieldByName('SQL').Value,
                                   cds_work.FieldByName('COMENT').Value]);
     If cc>0 Then Begin
        If q_SQL.FieldByName('CHANGE_DATE').AsDateTime <
           cds_work.FieldByName('CHANGE_DATE').AsDateTime Then Begin
               q_SQL.Active:=false;
               // Обнавляем SQL
               par[0]:=1013;
               rr:=RunSQLS(par);
               If rr<>0 Then Begin
                  Result:=2;
                  If IBTrans.InTransaction Then IBTrans.Rollback;
                  Exit
               end;
           end;
     end
     Else Begin
         q_SQL.Active:=false;
         // Вставляем новый SQL
         par[0]:=1014;
         rr:=RunSQLS(par);
         If rr<>0 Then Begin
            Result:=3;
            If IBTrans.InTransaction Then IBTrans.Rollback;
            Exit
         end;
     end;
     cds_work.Next;
  end;
  If IBTrans.InTransaction Then IBTrans.Commit;
  Result:=0;
  except
     If IBTrans.InTransaction Then IBTrans.Rollback;
  end;
end;

initialization
  TComponentFactory.Create(ComServer, TPPD_Server_2,
    Class_PPD_Server_2, ciMultiInstance, tmApartment);
end.
