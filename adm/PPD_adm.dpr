program PPD_adm;

uses
  Forms,
  PPD_main in 'PPD_main.pas' {fr_main},
  PPD_DM in 'PPD_DM.pas' {DM: TDataModule},
  Splash in 'Splash.pas' {fr_splash},
  PSWrd in 'PSWrd.pas' {PasswordDlg},
  shop_ch in 'shop_ch.pas' {fr_openshop},
  spr_id in '..\center\spr_id.pas' {fr_spr},
  Get_str in '..\uiforms\Get_str.pas' {fr_get_str},
  Ask_dlg in '..\uiforms\Ask_dlg.pas' {fr_dialog},
  deposit_ch in '..\center\deposit_ch.pas' {fr_deposit},
  dep_shop in 'dep_shop.pas' {fr_shop_dep},
  pump_spr in 'pump_spr.pas' {fr_pump_spr},
  Ask_chislo in '..\uiforms\Ask_chislo.pas' {fr_get_chislo},
  ResList in '..\uiforms\ResList.pas' {fr_lstresult};

{$R *.RES}

begin
  Application.Initialize;
  fr_splash:= Tfr_splash.Create(nil);
  try
    fr_splash.Show;
    fr_splash.Update;
    Application.ProcessMessages;
  Application.Title := 'Администратор. ППД Про.';
  Application.CreateForm(Tfr_main, fr_main);
  Application.CreateForm(Tfr_get_chislo, fr_get_chislo);
  Application.CreateForm(Tfr_lstresult, fr_lstresult);
  finally
     fr_splash.Free;
  end;
  try
  Application.Run;
  except
  end;
end.
