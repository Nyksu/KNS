program PPD_center;

uses
  Forms,
  PPD_main in 'PPD_main.pas' {fr_main},
  PPD_DM in 'PPD_DM.pas' {DM: TDataModule},
  Splash in 'Splash.pas' {fr_splash},
  PSWrd in 'PSWrd.pas' {PasswordDlg},
  shop_ch in 'shop_ch.pas' {fr_openshop},
  spr_id in 'spr_id.pas' {fr_spr};

{$R *.RES}

begin
  Application.Initialize;
  fr_splash:= Tfr_splash.Create(nil);
  try
    fr_splash.Show;
    fr_splash.Update;
    Application.ProcessMessages;
  Application.Title := 'Дизайнер. ППД Про.';
  Application.CreateForm(Tfr_main, fr_main);
  finally
     fr_splash.Free;
  end;
  try
  Application.Run;
  except
  end;
end.
