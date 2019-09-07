unit PPD_DM;
              
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBClient, MConnect, SConnect, Db, inifiles, DateUtil, ObjBrkr;

type
  TDM = class(TDataModule)
    cds_teh: TClientDataSet;
    SockTo: TSocketConnection;
    cds_tmp: TClientDataSet;
    cds_work: TClientDataSet;
    procedure DMCreate(Sender: TObject);
    procedure SocktoAfterConnect(Sender: TObject);
  private
    inifil : TIniFile;
    GMT : integer;
    SetTimeState : boolean;
    HostName : string;
    procedure TestTime;
    procedure GetINI;
    { Private declarations }
  public 
    Procedure SetVr1(vrr : integer);
    Function GetData(param : variant) : Variant;
    Function GetTehData(param : variant) : Variant;
    Function RunSQL(param : variant) : Integer;
    Function RSQL(param : variant) : Integer;
    procedure StartTrans;
    procedure ComTrans;
    procedure BackTrans;
    function StateDB: Integer;
    function GetLastID : Integer;
    function GETNextID : Integer;
    Function DoCalc : boolean;
    Function GetAgrForExel(agrid : integer) : variant;
    Function GetKnsForExel(knsid : integer) : variant;
    function GetPeriodList : string;
    function GetResElements(id, tp, per: Integer) : variant;
    function GetUnitName(id:integer) : string;
    function GetUnitRes(id: Integer): Variant;
    function UpdateSQL(dt : Variant) : integer;
    function UpdateDB(dt: string): Integer;
    { Public declarations }
  end;

Function StartDM : boolean;

Procedure CloseDM;

var
  DM: TDM;
  conn : boolean;
  cod_err : integer;
  rus, lat : HKL;
  vers : string;
  iidd : variant;
  isCalcOk : boolean;
  ChengingUnits : TStringList;

implementation

{$R *.DFM}

Function StartDM : boolean;
Begin
  Result:=false;
  iidd:=null;
  ChengingUnits:=TStringList.Create;
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
    strpar:=ReadString('Network', 'HostName', 'localhost');
    HostName:=strpar;
    //XL_path:=ReadString('Path', 'XLS', ExtractFilePath(Application.ExeName));

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
end;

procedure TDM.SocktoAfterConnect(Sender: TObject);
begin
  TestTime;
end;

Function TDM.GetAgrForExel(agrid : integer) : variant;
var
 res : variant;
Begin
   Result:=Sockto.AppServer.GetAgrForExel(agrid);
end;

Function TDM.GetKnsForExel(knsid : integer) : variant;
var
 res : variant;
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
  Result:=SockTo.AppServer.GetResElements(id, tp, per);
  If tp>12 Then SetVr1(-1);
end;

function TDM.UpdateSQL(dt : Variant) : integer;
Begin
  Result:=SockTo.AppServer.UpdateSQL(dt);
  { Результаты: 0 - Ок!!, -2 Нет прав, -1 НУЛ, 1 - нет записей,
                2 - ошибка изменения, 3 - ошибка вставки}
  Case Result of
       0 : MessageDlg('Пополнение принято успешно!', mtInformation, [mbOk], 0);
       1 : MessageDlg('Нет записей в пополнении.', mtError, [mbOk], 0);
      -2 : MessageDlg('Нет прав на операцию.', mtError, [mbOk], 0);
      -1 : MessageDlg('Нулевой аргумент.', mtError, [mbOk], 0);
       2 : MessageDlg('Ошибка изменения SQL.', mtError, [mbOk], 0); 
       3 : MessageDlg('Ошибка добавления SQL.', mtError, [mbOk], 0);
  end;
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

Function TDM.DoCalc : boolean;
var
  r1 : integer;
Begin
   Result:=false;
   r1:=SockTo.AppServer.DoCalculate;
   Case r1 of
       0 : Result:=true;
      -1 : MessageDlg('Неожиданная ошибка при расчетах.', mtError, [mbOk], 0);
       1 : MessageDlg('Ошибка при подготовке данных для расчета.', mtError, [mbOk], 0);
   end;
end;

function TDM.UpdateDB(dt: string): Integer;
Begin
  Result:=SockTo.AppServer.UpdateDB(dt);
  Case Result of
     -1 : MessageDlg('Нет прав на операцию.', mtError, [mbOk], 0);
      1 : MessageDlg('Ошибка обновления БД.', mtError, [mbOk], 0);
  end;
end;

end.
