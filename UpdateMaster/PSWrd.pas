unit PSWrd;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, UnxCrypt, PPD_DM, Dialogs;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    logname: TEdit;
    Label2: TLabel;
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function CreatBridge : integer;

var
  PasswordDlg: TPasswordDlg;
  otv : integer;
  ii : integer;

implementation

Uses  Splash;

{$R *.DFM}

Function CreatBridge : integer;
Begin
  Result:=-1;
  otv:=-1;
  ii:=0;
  try
    try
      PasswordDlg:=TPasswordDlg.Create(Application);
      fr_splash.Hide;
      PasswordDlg.ShowModal;
      Result:=otv;
    finally
      PasswordDlg.Free;
    end;
  except
  end;
end;

procedure TPasswordDlg.CancelBtnClick(Sender: TObject);
begin
  PasswordDlg.Close;
end;

procedure TPasswordDlg.OKBtnClick(Sender: TObject);
var
 des_parol : string;
 rz : integer;
begin
  des_parol:=CreateInterbasePassword(Password.text);
  rz:=DM.SockTo.AppServer.LogDB(logname.text,des_parol);
  If rz<>0 Then Begin
     If rz=1 Then MessageDlg('База данных недоступна!', mtError, [mbOk], 0)
     Else MessageDlg('Неверные пароль или имя!', mtError, [mbOk], 0);
     logname.SetFocus;
     Inc(ii);
     If ii<3 Then Exit;
  end
  Else otv:=0;
  PasswordDlg.Close;
end;

end.

