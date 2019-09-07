unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, ExtCtrls, jpeg, StdCtrls;

type
  Tfr_splash = class(TForm)
    Panel1: TPanel;
    lName: TRxLabel;
    lVer: TRxLabel;
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fr_splash: Tfr_splash;

implementation

{$R *.DFM}

uses ppd_dm;

procedure Tfr_splash.FormCreate(Sender: TObject);
var
  loc_InfoBufSize : integer;
  loc_InfoBuf     : PChar;
  loc_VerBufSize  : integer;
  loc_VerBuf      : PChar;
  FLangID         :string;
  FExeName        :string;
begin
  FExeName:=Application.ExeName;
  FLangID:='041904E3';
  loc_InfoBufSize := GetFileVersionInfoSize(PChar(FExeName),DWORD(loc_InfoBufSize));
  if loc_InfoBufSize > 0 then
  begin
    loc_InfoBuf := AllocMem(loc_InfoBufSize);
    GetFileVersionInfo(PChar(FExeName),0,loc_InfoBufSize,loc_InfoBuf);

    VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\FileVersion'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));
    lVer.Caption := 'Версия '+loc_VerBuf;
    vers:=lVer.Caption;

    VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\ProductName'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));
    lName.Caption := loc_VerBuf;

    FreeMem(loc_InfoBuf, loc_InfoBufSize);
  end;
end;

end.
