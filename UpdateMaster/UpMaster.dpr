program UpMaster;

uses
  Forms,
  MainMaster in 'MainMaster.pas' {fr_main_upd},
  PSWrd in 'PSWrd.pas' {PasswordDlg},
  PPD_DM in 'PPD_DM.pas' {DM: TDataModule},
  Splash in 'Splash.pas' {fr_splash},
  About in '..\uiforms\About.pas' {fr_about};

{$R *.RES}

begin
  Application.Initialize;
  fr_splash:= Tfr_splash.Create(nil);
  try
    fr_splash.Show;
    fr_splash.Update;
    Application.ProcessMessages;
  Application.Title := 'Мастер UPDATE ППД.';
  Application.CreateForm(Tfr_main_upd, fr_main_upd);
  Application.CreateForm(Tfr_about, fr_about);
  finally
     fr_splash.Free;
  end;
  try
  Application.Run;
  except
  end;
end.
