unit PPD_DM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBClient, MConnect, SConnect, Db, inifiles, DateUtil;

type
  TDM = class(TDataModule)
    SockTo: TSocketConnection;
    cds_teh: TClientDataSet;
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
    Function GetData(param : variant) : Variant;
    Function GetTehData(param : variant) : Variant;
    Function GetTehDataNams(param,nams : variant) : Variant;
    Function RunSQL(param : variant) : Integer;
    procedure StartTrans;
    procedure ComTrans;
    procedure BackTrans;
    function StateDB: Integer;
    function GetLastID : Integer;
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

implementation

{$R *.DFM}

Function StartDM : boolean;
Begin
  Result:=false;
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
  DM.Free;
end;

function TDM.GetLastID : Integer;
Begin
  Result:=SockTo.AppServer.GetLastID;
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
     If cds_teh.RecordCount>0 Then Begin
        ii:=cds_teh.Fields.Count;
        otv:=VarArrayCreate([0, ii], varVariant);
        For i:=0 to ii-1 Do
           otv[i]:=cds_teh.Fields.Fields[i].Value;
        Result:=otv;
     end;
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

procedure TDM.StartTrans;
Begin
  If SockTo.Connected and conn Then
     SockTo.AppServer.StartTrans;
end;

procedure TDM.ComTrans;
Begin
  If SockTo.Connected and conn Then
     SockTo.AppServer.CommitTrans;
end;

procedure TDM.BackTrans;
Begin
  If SockTo.Connected and conn Then
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

Function TDM.GetTehDataNams(param,nams : variant) : Variant;
var
  rs,otv : variant;
  ii,i : integer;
Begin
  Result:=null;
  otv:=null;
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

end.
