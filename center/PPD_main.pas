unit PPD_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PPD_DM, PSWrd, Menus, ComCtrls, ActnList, ImgList, ExtCtrls, ToolWin,
  shop_ch;

type
  Tfr_main = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    n_open: TMenuItem;
    N3: TMenuItem;
    n_exit: TMenuItem;
    n_reconnect: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    StatusBar1: TStatusBar;
    CoolBar1: TCoolBar;
    Panel1: TPanel;
    Img_lst_tools: TImageList;
    act_tools: TActionList;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure n_exitClick(Sender: TObject);
    procedure n_openClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fr_main: Tfr_main;

implementation

{$R *.DFM}

procedure Tfr_main.FormCreate(Sender: TObject);
begin
  conn:=false;
  try
    If StartDM Then Begin
      If CreatBridge=0 Then conn:=true;
    end
    Else MessageDlg('Непреодолимая ошибка!', mtError, [mbOk], 0);
  except
  end;
  fr_main.Caption:=fr_main.Caption+' '+vers;
end;

procedure Tfr_main.FormActivate(Sender: TObject);
begin
  If not conn Then Close;
end;

procedure Tfr_main.n_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_main.n_openClick(Sender: TObject);
begin
  ShowMessage(IntToStr(GetOpenShop));
end;

end.
