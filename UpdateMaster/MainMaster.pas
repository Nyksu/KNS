unit MainMaster;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, ComCtrls, ToolWin, ImgList, Menus, PPD_DM,
  ExtCtrls, PSWrd, About, Db, DBClient;

type
  Tfr_main_upd = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    n_exit: TMenuItem;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    tbt_UpdateSql: TToolButton;
    tbt_UpdateDB: TToolButton;
    FilenameEdit1: TFilenameEdit;
    N2: TMenuItem;
    n_about: TMenuItem;
    StatusBar1: TStatusBar;
    cds_work: TClientDataSet;
    od_db_update: TOpenDialog;
    m_upd_db: TMemo;
    procedure n_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure n_aboutClick(Sender: TObject);
    procedure tbt_UpdateSqlClick(Sender: TObject);
    procedure tbt_UpdateDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fr_main_upd: Tfr_main_upd;

implementation

{$R *.DFM}

procedure Tfr_main_upd.n_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_main_upd.FormCreate(Sender: TObject);
begin
  DecimalSeparator:='.';
  THOUSANDSEPARATOR:=' ';
  DateSeparator:='.';
  conn:=false;
  try
    If StartDM Then Begin
      If CreatBridge=0 Then conn:=true;
    end
    Else MessageDlg('Непреодолимая ошибка!', mtError, [mbOk], 0);
  except
  end;
end;

procedure Tfr_main_upd.FormActivate(Sender: TObject);
begin
  If not conn Then Close;
  StatusBar1.Panels.Items[0].Text:='Версия: '+vers+' a';
end;

procedure Tfr_main_upd.n_aboutClick(Sender: TObject);
begin
  AboutShow(vers);
end;

procedure Tfr_main_upd.tbt_UpdateSqlClick(Sender: TObject);
begin
  If (FilenameEdit1.FileName<>'')and(FilenameEdit1.FileName<>'*.cds') Then Begin
     If not FileExists(FilenameEdit1.FileName) Then Begin
        MessageDlg('Файл не найден! Проверте правильность пути.', mtError, [mbOk], 0);
        FilenameEdit1.SetFocus;
        Exit;
     end;
     cds_work.LoadFromFile(FilenameEdit1.FileName);
     try
       DM.UpdateSQL(cds_work.Data);
     finally
       cds_work.Active:=false;
     end;
  end;
end;

procedure Tfr_main_upd.tbt_UpdateDBClick(Sender: TObject);
var
  filname : string;
begin
  If od_db_update.Execute Then Begin
     filname:=od_db_update.FileName;
     m_upd_db.Lines.Clear;
     m_upd_db.Lines.LoadFromFile(filname);
     If DM.UpdateDB(m_upd_db.Lines.Text)=0 Then
     MessageDlg('Обновление БД произведено удачно!', mtInformation, [mbOk], 0);
  end;
end;

end.
