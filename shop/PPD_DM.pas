unit PPD_DM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBClient, MConnect, SConnect, Db, inifiles, DateUtil, ObjBrkr, ResList;

type
  TDM = class(TDataModule)
    cds_teh: TClientDataSet;
    SockTo: TSocketConnection;
    cds_tmp: TClientDataSet;
    cds_work: TClientDataSet;
    cds_calc: TClientDataSet;
    procedure DMCreate(Sender: TObject);
    procedure SocktoAfterConnect(Sender: TObject);
  private
    inifil : TIniFile;
    GMT : integer;
    SetTimeState : boolean;
    HostName : string;
    procedure TestTime;
    procedure GetINI;
    function TestWellState : boolean;
    { Private declarations }
  public
    XL_path : string;
    XL_Pump : string;
    XL_Kns : string;
    XL_Svoda : string;
    legendimgname : string;
    Procedure SetVr1(vrr : integer);
    Function GetData(param : variant) : Variant;
    Function GetTehData(param : variant) : Variant;
    Function GetTehDataNams(param,nams : variant) : Variant;
    Function RunSQL(param : variant) : Integer;
    Function RSQL(param : variant) : Integer;
    procedure StartTrans;
    procedure ComTrans;
    procedure BackTrans;
    function StateDB: Integer;
    function GetLastID : Integer;
    function GETNextID : Integer;
    Function DoCalc : boolean;
    Function CalcZREg(par:variant) : variant;
    Function GetAgrForExel(agrid : integer) : variant;
    Function GetKnsForExel(knsid : integer) : variant;
    function GetPeriodList : string;
    function GetResElements(id, tp, per: Integer) : variant;
    function GetResElementAll(id, tp, per: Integer) : variant;
    function GetUnitName(id:integer) : string;
    function GetUnitRes(id: Integer): Variant;
    function GetMinMaxSpeedPipePer(per, mx: Integer): Variant;
    function GetParamINI(sect,par,def : string) : string;
    Procedure SetParamINI(sect,parn,parv : string);
    Function GetShopName(id : integer):string;
    Function GetDepositName(id : integer):string;
    Function GetLocalMinutesFromTime(hr,mn : integer) : integer;
    Function GetStrTimeFromLocalMinutes(mn : integer) : string;
    Function GetNameSetWorkPlan : string;
    Function GetAboutPeriod(per : integer) : string;
    Function GetKnsNsName(knsid,nsid : variant) : string;
    function IsBaseMap : boolean;
    function SetMapWork(id : integer) : integer;
    Function CopyShem(id: Integer): Integer;
    Function GetBaseUnits : boolean;
    function GetMapID: Integer;
    function GetPipeSelect(prr,pcc : variant) : Variant;
    function SetEditMap : Integer;
    function GetDefaultVarDB : Variant;
    function GetPeriodTimeList : string;
    function GetCalcYear : integer;
    procedure SetCalcYear (yy : integer);
    { Public declarations }
  end;

  TStateCalc = (stIsCalc,stIsNotCalc,stCannotCalc);

  TCatchUnitPress = class(TObject)
  private
    Fstate : TStateCalc;
    rpress : real;
    Frproc : real;
    Fopened : real;
  public
    coment : string;
    catch_id : integer;
    unit_id : integer;
    press : real;
    constructor Create(str : string; catchid,unitid : integer; pres : real);
    property state : TStateCalc read Fstate;
    procedure SetCalcRes(pres,opn,prc : real; rezst : boolean);
    function GetResult : variant;
    function GetParamForCalc : variant;
  end;

  TCatchUnitPressList = class(TObject)
  private
     FCUPlst : TList;
  public
     property CUPlst : TList read FCUPlst;
     constructor Create;
     function Add(name : string; catch_id,unit_id : integer; press : real) : integer;
     procedure Delete(index : integer);
     procedure Clear;
     destructor Destroy;  override;
     function IndexOfParam(catch_id,unit_id : integer) : integer;
  end;



Function StartDM : boolean;

Procedure CloseDM;

var
  DM: TDM;
  conn : boolean;
  cod_err,daystart,num_plan_work : integer;
  rus, lat : HKL;
  vers : string;
  iidd : variant;
  isCalcOk : boolean;
  Year_calc : integer;
  ChengingUnits : TStringList;
  ChangingPipes : TStringList;
  CUPL : TCatchUnitPressList;
  CUPLprc : real;
  bu1,bu2 : integer;
  findList : TList;

implementation

{$R *.DFM}

constructor TCatchUnitPress.Create(str : string; catchid,unitid : integer; pres : real);
Begin
  inherited Create;
  Fstate:=stIsNotCalc;
  rpress:=0;
  Frproc:=0;
  Fopened:=0;
  coment:=str;
  catch_id:=catchid;
  unit_id:=unitid;
  press:=pres;
end;

procedure TCatchUnitPress.SetCalcRes(pres,opn,prc : real; rezst : boolean);
Begin
  rpress:=pres;
  Frproc:=prc;
  Fopened:=opn;
  If rezst Then Fstate:=stIsCalc Else Fstate:=stCannotCalc;
end;

function TCatchUnitPress.GetResult : variant;
Begin
  Result:=null;
  If Fstate=stIsCalc Then Result:=VarArrayOf([catch_id,unit_id,rpress,Fopened,Frproc]);
end;

function TCatchUnitPress.GetParamForCalc : variant;
Begin
  Fstate:=stIsNotCalc;
  Result:=VarArrayOf([unit_id,press,catch_id]);
end;

constructor TCatchUnitPressList.Create;
Begin
  inherited Create;
  FCUPlst:=TList.Create;
end;

function TCatchUnitPressList.Add(name : string; catch_id,unit_id : integer; press : real) : integer;
var
  CUP : TCatchUnitPress;
Begin
  CUP:=TCatchUnitPress.Create(name,catch_id,unit_id,press);
  Result:=FCUPlst.Add(CUP);
end;

procedure TCatchUnitPressList.Delete(index : integer);
var
  pp : pointer;
Begin
  If FCUPlst.Count>index Then Begin
     pp:=FCUPlst.Items[index];
     FCUPlst.Items[index]:=nil;
     FCUPlst.Delete(index);
     TCatchUnitPress(pp).Free;
  end;
end;

procedure TCatchUnitPressList.Clear;
var
  pp : pointer;
  ii,cc : integer;
Begin
  cc:=FCUPlst.Count;
  If cc>0 Then Begin
     For ii:=0 To cc-1 Do Begin
         pp:=FCUPlst.Items[ii];
         FCUPlst.Items[ii]:=nil;
         If pp<>nil Then TCatchUnitPress(pp).Free;
     end;
     FCUPlst.Clear;
  end;
end;

destructor TCatchUnitPressList.Destroy;
Begin
  Clear;
  FCUPlst.Free;
end;

function TCatchUnitPressList.IndexOfParam(catch_id,unit_id : integer) : integer;
var
  cc,ii : integer;
  pp : TCatchUnitPress;
Begin
  Result:=-1;
  cc:=FCUPlst.Count;
  If cc=0 Then Exit;
  for ii:=0 To cc-1 Do Begin
      pp:=FCUPlst.Items[ii];
      If (pp.catch_id=catch_id)and(pp.unit_id=unit_id) Then Begin
         Result:=ii;
         Break;
      end;
  end;
end;

Function StartDM : boolean;
Begin
  Result:=false;
  num_plan_work:=0;
  iidd:=null;
  bu1:=0;
  bu2:=0;
  Year_calc:=2006;
  CUPLprc:=40;
  ChengingUnits:=TStringList.Create;
  ChangingPipes:=TStringList.Create;
  CUPL:=TCatchUnitPressList.Create;
  try
    try
      DM:=TDM.Create(Application);
      DM.SockTo.Connected:=true;
      Result:=true;
    finally
    end;
  except
  end;
end;

Procedure CloseDM;
Begin
  DM.SockTo.Connected:=false;
  ChengingUnits.Free;
  ChangingPipes.Free;
  CUPL.free;
  findList.Free;
  DM.Free;
end;

function TDM.GetLastID : Integer;
Begin
  Result:=SockTo.AppServer.GetLastID;
end;

function TDM.GetUnitName(id:integer) : string;
var
  par,res : variant;
Begin
  Result:='';
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=131;
  par[1]:=VarArrayOf(['u']);
  par[2]:=VarArrayOf([id]);
  res:=GetTehData(par);
  If VarIsNull(res) Then Exit;
  If VarIsNull(res[1]) Then Exit;
  Result:=res[1];
end;

function TDM.GetNextID : Integer;
Begin
  Result:=SockTo.AppServer.GetNextID;
end;

Procedure TDM.SetVr1(vrr : integer);
Begin
  SockTo.AppServer.SetVr1(vrr);
end;

Function TDM.GetData(param : variant) : Variant;
var
  rs : variant;
Begin
  Result:=null;
  If SockTo.Connected and conn Then Begin
     screen.cursor:=crSQLWait;
     try
     rs:=SockTo.AppServer.GetData(param);
     finally
     screen.cursor:=crDefault;
     end;
     If VarIsNull(rs) Then Begin
        MessageDlg('Нет прав на операцию или операция не доступна! Предупреждение №01/'+IntToStr(cod_err), mtError, [mbOk], 0);
        Exit;
     end;
     Result:=rs;
  end;
end;

function TDM.GetDefaultVarDB : Variant;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=186;
  par[1]:=null;
  par[2]:=null;
  Result:=GetTehData(par);
end;

Function TDM.GetTehData(param : variant) : Variant;
var
  rs,otv : variant;
  ii,i : integer;
Begin
  Result:=null;
  If SockTo.Connected and conn Then Begin
     screen.cursor:=crSQLWait;
     try
     rs:=SockTo.AppServer.GetData(param);
     finally
     screen.cursor:=crDefault;
     end;
     If VarIsNull(rs) Then Begin
        MessageDlg('Нет прав на операцию или операция не доступна! Предупреждение №02/'+IntToStr(cod_err), mtError, [mbOk], 0);
        Exit;
     end;
     cds_teh.Active:=false;
     cds_teh.Data:=rs;
     If cds_teh.RecordCount=0 Then Begin
        cds_teh.Active:=false;
        Exit;
     end;
     ii:=cds_teh.Fields.Count;
     If ii>0 Then If ii>1 Then Begin
      otv:=VarArrayCreate([0, ii-1], varVariant);
      For i:=0 to ii-1 Do
        otv[i]:=cds_teh.Fields.Fields[i].Value;
      Result:=otv;
     end
     Else Result:=cds_teh.Fields.Fields[0].Value;
  end;
end;

Function TDM.GetTehDataNams(param,nams : variant) : Variant;
var
  rs,otv : variant;
  ii,i : integer;
Begin
  Result:=null;
  If SockTo.Connected and conn Then Begin
     screen.cursor:=crSQLWait;
     try
     rs:=SockTo.AppServer.GetData(param);
     finally
     screen.cursor:=crDefault;
     end;
     If VarIsNull(rs) Then Begin
        MessageDlg('Нет прав на операцию или операция не доступна! Предупреждение №02/'+IntToStr(cod_err), mtError, [mbOk], 0);
        Exit;
     end;
     cds_teh.Active:=false;
     cds_teh.Data:=rs;
     If cds_teh.RecordCount=0 Then Begin
        cds_teh.Active:=false;
        Exit;
     end;
     try
     ii:=VarArrayHighBound(nams,1);
     except
       Result:=null;
       Exit;
     end;
     otv:=VarArrayCreate([0, ii], varVariant);
     For i:=0 to ii Do otv[i]:=cds_teh.Fields.FieldByName(nams[i]).Value;
     Result:=otv;
  end;
end;

Function TDM.RunSQL(param : variant) : Integer;
var
  rs : integer;
Begin
  Result:=-1;
  If SockTo.Connected and conn Then Begin
     screen.cursor:=crSQLWait;
     try
     rs:=SockTo.AppServer.RunSQL(param);
     finally
     screen.cursor:=crDefault;
     end;
     Case rs of
        -1 : Begin
               MessageDlg('Операция не доступна! Предупреждение №03/'+IntToStr(cod_err), mtError, [mbOk], 0);
             end;
         1 : Begin
               MessageDlg('Нет прав на операцию! Предупреждение №04/'+IntToStr(cod_err), mtError, [mbOk], 0);
             end;
     end;
     Result:=rs;
  end;
end;

Function TDM.RSQL(param : variant) : Integer;
var
  rs : integer;
Begin
  Result:=-1;
  If SockTo.Connected and conn Then Begin
     screen.cursor:=crSQLWait;
     try
     rs:=SockTo.AppServer.RunSQL(param);
     finally
     screen.cursor:=crDefault;
     end;
     Result:=rs;
  end;
end;

procedure TDM.StartTrans;
Begin
  If StateDB=0 Then
     SockTo.AppServer.StartTrans;
end;

procedure TDM.ComTrans;
Begin
  If StateDB=1 Then
     SockTo.AppServer.CommitTrans;
end;

procedure TDM.BackTrans;
Begin
  If StateDB=1 Then
     SockTo.AppServer.BackTrans;
end;

function TDM.StateDB: Integer;
Begin
  Result:=-1;
  If SockTo.Connected and conn Then
     Result:=SockTo.AppServer.GetStateTrans;
end;

procedure TDM.GetINI;
var
  strpar : string;
Begin
  inifil:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'\client.ini');
  With inifil Do Begin
    strpar:=ReadString('Times', 'SetStationTime', '0');
    If StrToInt(strpar)=0 Then SetTimeState:=false Else SetTimeState:=true;
    strpar:=ReadString('Times', 'GMT+', '0');
    GMT:=StrToInt(strpar);
    strpar:=ReadString('Times', 'DAYSTART', '0');
    daystart:=StrToInt(strpar);
    strpar:=ReadString('Network', 'HostName', 'localhost');
    HostName:=strpar;
    XL_path:=ReadString('Path', 'XLS', ExtractFilePath(Application.ExeName));
    XL_Pump:=ReadString('XLS', 'PUMP', 'agrtim.xls');
    XL_Kns:=ReadString('XLS', 'KNS', 'knstim.xls');
    XL_Svoda:=ReadString('XLS', 'SVODA', 'Svodka.xls');
    legendimgname:=ReadString('Path', 'LEGENDIMG', ExtractFilePath(Application.ExeName)+'\pleg.bmp');
  end;
  inifil.free;
end;

function TDM.GetParamINI(sect,par,def : string) : string;
var
  strpar : string;
Begin
  strpar:='';
  inifil:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'\client.ini');
  With inifil Do Begin
    strpar:=ReadString(sect, par, def);
    WriteString(sect,par,strpar);
  end;
  inifil.free;
  Result:=strpar;
end;

Procedure TDM.SetParamINI(sect,parn,parv : string);
Begin
  inifil:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'\client.ini');
  With inifil Do Begin
    WriteString(sect,parn,parv);
  end;
  inifil.free;
end;

procedure TDM.TestTime;
var
  SrvTime : TDateTime;
  sys_date : TSystemTime;
Begin
 SrvTime:=Sockto.AppServer.Timing;
 If (Trunc(date)<>Trunc(SrvTime))and(SetTimeState) Then Begin
     SrvTime:=IncHour(SrvTime,-1*GMT);
     DateTimeToSystemTime(SrvTime,sys_date);
     SetSystemTime(sys_date);
 end;
end;

procedure TDM.DMCreate(Sender: TObject);
begin
  GetINI;
  SockTo.Host:=HostName;
  rus:=LoadKeyboardLayout('00000419', 0);
  lat:=LoadKeyboardLayout('00000409', 0);
  ActivateKeyboardLayout(lat,0);
  findList:=TList.Create;
end;

procedure TDM.SocktoAfterConnect(Sender: TObject);
var
  ddt : TDateTime;
  Year, Month, Day : word;
begin
  TestTime;
  ddt:=Date;
  DecodeDate(ddt,Year, Month, Day);
  SetCalcYear(Year);
end;

Function TDM.GetAgrForExel(agrid : integer) : variant;
Begin
   Result:=Sockto.AppServer.GetAgrForExel(agrid);
end;

Function TDM.GetKnsForExel(knsid : integer) : variant;
Begin
   Result:=Sockto.AppServer.GetKnsForExel(knsid);
end;

function TDM.GetPeriodList : string;
var
 res : variant;
 ls : TStringList;
Begin
  Result:='';
  res:=SockTo.AppServer.GetPeriodsList;
  If VarIsNull(res) Then Exit;
  cds_work.Data:=res;
  ls:=TStringList.Create;
  While not cds_work.Eof Do Begin
    ls.Add(cds_work.FieldByName('period').AsString);
    cds_work.Next;
  end;
  Result:=ls.Text;
  ls.free;
end;

function TDM.GetResElements(id, tp, per: Integer) : variant;
Begin
  //If tp>12 Then SetVr1(-1);
  Result:=SockTo.AppServer.GetResElements(id, tp, per);
  If tp>12 Then SetVr1(-1);
end;

function TDM.GetResElementAll(id, tp, per: Integer) : variant;
Begin
  Result:=SockTo.AppServer.GetResElementAll(id, tp, per);
  If tp>12 Then SetVr1(-1);
end;

function TDM.GetUnitRes(id: Integer): Variant;
var
  rr : variant;
  ii,cc : integer;
Begin
  Result:=null;
  rr:=SockTo.AppServer.GetUnitRes(id);
  If VarIsNull(rr) Then Exit;
  cds_tmp.Data:=rr;
  cc:=cds_tmp.RecordCount;
  If cc=0 Then Exit;
  rr:=VarArrayCreate([0,cc-1],varVariant);
  ii:=0;
  While not cds_tmp.EOF Do Begin
     rr[ii]:=VarArrayOf([cds_tmp.FieldByName('PERIOD').AsString+'-й пер.',
                         cds_tmp.FieldByName('PRESSURE').AsFloat]);
     Inc(ii);
     cds_tmp.Next;
  end;
  Result:=rr;
end;

function TDM.GetMinMaxSpeedPipePer(per, mx: Integer): Variant;
Begin
  Result:=SockTo.AppServer.GetMinMaxSpeedPipePer(per, mx);
end;

function TDM.TestWellState : boolean;
var
  pp, par : variant;
  str : string;
Begin
  Result:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=185;
  par[1]:=null; //имена
  par[2]:=null; //значения
  cds_tmp.Active:=false;
  pp:=GetData(par);
  If not VarIsNull(pp) Then Begin
     cds_tmp.data:=pp;
     If cds_tmp.RecordCount>0 Then Begin
        MessageDlg('Ошибочные данные скважин!', mtError, [mbOk], 0);
        InicResList('Ошибочные данные скважин.','Список скважин:');
        fr_lstresult.AddStr('');
        While not cds_tmp.EOF Do Begin
           str:='Скважина № '+cds_tmp.FieldByName('NOMER').AsString+' ID('+cds_tmp.FieldByName('ID').AsString+') АКТИВНА при Pуст=0';
           fr_lstresult.AddStr(str);
           Application.ProcessMessages;
           cds_tmp.Next;
        end;
     end
     Else Result:=true;
  end;
end;

Function TDM.DoCalc : boolean;
var
  r1 : integer;
Begin
   Result:=false;
   If num_plan_work=0 Then
      If MessageDlg('Не установлен план событий! Продолжить расчет без плана событий?', mtConfirmation, [mbYes, mbNo], 0) = mrNo Then Exit;
   If not TestWellState Then Exit;
   screen.cursor:=crHourGlass;
   try
     r1:=SockTo.AppServer.DoCalculate(num_plan_work,null);
   finally
     screen.cursor:=crDefault;
   end;
   Case r1 of
       0 : Result:=true;
      -1 : MessageDlg('Нет прав на операцию.', mtError, [mbOk], 0);
       1 : MessageDlg('Ошибка при подготовке данных для расчета.', mtError, [mbOk], 0);
       2 : MessageDlg('Ошибка запуска процедуры расчета.', mtError, [mbOk], 0);
       3 : MessageDlg('Пустой файл ian.', mtError, [mbOk], 0);
       4 : MessageDlg('Ошибка при вычислении.', mtError, [mbOk], 0);
       5 : MessageDlg('Превышен период ожидания завершения расчетов.', mtError, [mbOk], 0);
       6 : MessageDlg('Ошибка при очистке места под результаты в БД.', mtError, [mbOk], 0);
       7 : MessageDlg('Ошибка при заливке результатов расчета.', mtError, [mbOk], 0);
       8 : MessageDlg('Ошибка при заливке расчета задвижек.', mtError, [mbOk], 0);
   end;
end;

Function TDM.CalcZREg(par:variant) : variant;
var
  r1 : integer;
Begin
   Result:=null;
   If not TestWellState Then Exit;
   screen.cursor:=crHourGlass;
   try
     r1:=SockTo.AppServer.DoCalculate(0,par);
   finally
     screen.cursor:=crDefault;
   end;
   Case r1 of
       0 : Result:=SockTo.AppServer.Get_Zreg;
      -1 : MessageDlg('Нет прав на операцию.', mtError, [mbOk], 0);
       1 : MessageDlg('Ошибка при подготовке данных для расчета.', mtError, [mbOk], 0);
       2 : MessageDlg('Ошибка запуска процедуры расчета.', mtError, [mbOk], 0);
       3 : MessageDlg('Пустой файл ian.', mtError, [mbOk], 0);
       4 : MessageDlg('Ошибка при вычислении.', mtError, [mbOk], 0);
       5 : MessageDlg('Превышен период ожидания завершения расчетов.', mtError, [mbOk], 0);
       6 : MessageDlg('Ошибка при очистке места под результаты в БД.', mtError, [mbOk], 0);
       7 : MessageDlg('Ошибка при заливке результатов расчета.', mtError, [mbOk], 0);
       8 : MessageDlg('Ошибка при заливке расчета задвижек.', mtError, [mbOk], 0);
   end;
end;

Function TDM.GetShopName(id : integer):string;
var
  pp, par : variant;
Begin
  Result:='';
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=143;
  par[1]:=VarArrayOf(['shp']); //имена
  par[2]:=VarArrayOf([id]); //значения
  pp:=GetTehData(par);
  If not VarIsNull(pp) Then Result:=pp;
end;

Function TDM.GetDepositName(id : integer):string;
var
  pp, par : variant;
Begin
  Result:='';
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=144;
  par[1]:=VarArrayOf(['dep']); //имена
  par[2]:=VarArrayOf([id]); //значения
  pp:=GetTehData(par);
  If not VarIsNull(pp) Then Result:=pp;
end;

Function TDM.GetNameSetWorkPlan : string;
var
  pp, par : variant;
Begin
  Result:='Нет активных планов работы НА !';
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=145;
  par[1]:=VarArrayOf(['plan']); //имена
  par[2]:=VarArrayOf([num_plan_work]); //значения
  pp:=GetTehData(par);
  If not VarIsNull(pp) Then Result:=pp;
end;

Function TDM.GetLocalMinutesFromTime(hr,mn : integer) : integer;
Begin
  Result:=0;
  Result:=hr*60+mn;
  If Result<daystart Then Result:=Result+1440;
end;

Function TDM.GetStrTimeFromLocalMinutes(mn : integer) : string;
var
  mnt,chs : integer;
  ttt : real;
Begin
  Result:='';
  if mn>1440 Then mn:=mn-1440;
  chs:=Trunc(mn/60);
  mnt:=mn-chs*60;
  Result:=IntToStr(chs)+' ч. '+IntToStr(mnt)+' мин. '
end;

Function TDM.GetKnsNsName(knsid,nsid : variant) : string;
var
 pp, par,res,nms : variant;
 id : integer;
Begin
  Result:='';
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=19;
  par[1]:=VarArrayOf(['KNS']);
  res:=knsid;
  If VarIsNull(res) Then Begin
     res:=nsid;
     par[0]:=22;
     par[1]:=VarArrayOf(['NS']);
  end;
  If VarIsNull(res) Then Exit;
  id:=Integer(res);
  par[2]:=VarArrayOf([id]);
  cod_err:=326;
  nms:=VarArrayOf(['NAME']);
  res:=DM.GetTehDataNams(par,nms);
  If VarIsNull(res) Then Exit;
  Result:=String(res[0]);
end;

Function TDM.GetAboutPeriod(per : integer) : string;
var
 pp, par : variant;
 ls : TStringList;
 str : string;
 rr,tn : integer;
Begin
  Result:='';
  if per<=0 Then Exit;
  if not isCalcOk Then Exit;
  rr:= SockTo.AppServer.GetStartPeriod(per);
  If rr>=0 Then Begin
     tn:=rr;
     ls:=TStringList.Create;
     str:='Параметры периода: '+IntToStr(per);
     If per=1 Then str:=str+' (начальный период)';
     ls.Add(str);
     str:='Начало: '+GetStrTimeFromLocalMinutes(rr)+' - Окончание: ';
     rr:= SockTo.AppServer.GetStartPeriod(per+1);
     If rr>0 Then str:=str+GetStrTimeFromLocalMinutes(rr) Else str:=str+'2 ч. 0 мин.';
     ls.Add(str);
     par:=VarArrayCreate([0, 3], varVariant);
     par[0]:=150;
     par[1]:=VarArrayOf(['wp','dt','tm']);
     par[2]:=VarArrayOf([num_plan_work,daystart,tn]);
     par[3]:=VarArrayOf(['com']);
     cod_err:=324;
     pp:=DM.GetData(par);
     If not VarIsNull(pp) Then Begin
        cds_tmp.Active:=false;
        cds_tmp.data:=pp;
        If cds_tmp.RecordCount>0 Then Begin
           While not cds_tmp.eof Do Begin
              str:=GetKnsNsName(cds_tmp.FieldByName('KNS_ID').Value,cds_tmp.FieldByName('NS_ID').Value);
              if str<>'' Then Begin
                 ls.Add('Насосная станция : '+str);
                 ls.Add('НА : '+cds_tmp.FieldByName('NAME').AsString);
                 ls.Add(cds_tmp.FieldByName('TYPENAM').AsString);
                 ls.Add('Переведен в состояние: "'+cds_tmp.FieldByName('STATNAME').AsString+'"');
              end;
              cds_tmp.next;
           end;
        end;
        cds_tmp.Active:=false;
     end;
     Result:=ls.Text;
     ls.free;
  end;
end;

function TDM.IsBaseMap : boolean;
Begin
  if SockTo.AppServer.IsBaseMap=0 Then Result:=false Else Result:=true;
end;

function TDM.GetPeriodTimeList : string;
var
 pp, par : variant;
 ls : TStringList;
 str : string;
Begin
  Result:='';
  ls:=TStringList.Create;
  par:=VarArrayCreate([0, 2], varVariant);



  Result:=ls.Text;
  ls.free;
end;

function TDM.CopyShem(id: Integer): Integer;
Begin
  Result:=SockTo.AppServer.CopyShem(id);
end;

function TDM.SetMapWork(id : integer) : integer;
Begin
  Result:=SockTo.AppServer.SetMapWork(id);
end;

function TDM.GetMapID: Integer;
Begin
  Result:=SockTo.AppServer.GetMapID;
end;

function TDM.GetPipeSelect(prr,pcc : variant) : Variant;
Begin
  Result:=SockTo.AppServer.GetPipeSelect(prr,pcc);
end;

function TDM.SetEditMap : Integer;
Begin
  Result:=SockTo.AppServer.SetEditMap;
end;

Function TDM.GetBaseUnits : boolean;
var
 p1,p2, par : variant;
Begin
  Result:=false;
  bu1:=0;
  bu2:=0;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=176;
  par[1]:=VarArrayOf(['!x']);
  par[2]:=VarArrayOf([1]);
  p1:=GetTehData(par);
  If VarIsNull(p1) Then exit;
  par[2]:=VarArrayOf([2]);
  p2:=GetTehData(par);
  If VarIsNull(p2) Then exit;
  bu1:=p1;
  bu2:=p2;
end;

function TDM.GetCalcYear : integer;
Begin
  Result:=SockTo.AppServer.calcyear;
end;

procedure TDM.SetCalcYear (yy: integer);
Begin
  SockTo.AppServer.calcyear:=yy;
end;
end.
