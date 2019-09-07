program PPD_draw;

uses
  Forms,
  PPD_main in 'PPD_main.pas' {fr_main},
  PPD_DM in 'PPD_DM.pas' {DM: TDataModule},
  Splash in 'Splash.pas' {fr_splash},
  PSWrd in 'PSWrd.pas' {PasswordDlg},
  spr_id in 'spr_id.pas' {fr_spr},
  KNS_spr in 'KNS_spr.pas' {fr_kns_edit},
  NS_spr in 'NS_spr.pas' {fr_ns_edit},
  VPP_spr in 'VPP_spr.pas' {fr_vpp_edit},
  VRP_spr in 'VRP_spr.pas' {fr_vrp_edit},
  Catch_spr in 'Catch_spr.pas' {fr_catch_edit},
  Pipe_spr in 'Pipe_spr.pas' {fr_pipe_edit},
  Kust_spr in 'Kust_spr.pas' {fr_kust_edit},
  Ask_chislo in '..\uiforms\Ask_chislo.pas' {fr_get_chislo},
  Pump_spr in 'Pump_spr.pas' {fr_pump_edit},
  Well_spr in 'Well_spr.pas' {fr_well_edit},
  well_plast_spr in 'well_plast_spr.pas' {fr_plast_edit},
  Unit_spr in 'Unit_spr.pas' {fr_unit_edit},
  Pump_plan in 'Pump_plan.pas' {fr_pump_plan},
  Ask_Integer in '..\uiforms\Ask_Integer.pas' {fr_get_int},
  Pump_Exel in 'Pump_Exel.pas' {fr_pump_exel},
  res_explorer in 'res_explorer.pas' {fr_res},
  Unit_press in 'Unit_press.pas' {fr_units_press},
  About in '..\uiforms\About.pas' {fr_about},
  quick_res in 'quick_res.pas' {fr_quick_result},
  ResList in '..\uiforms\ResList.pas' {fr_lstresult},
  findrule in 'findrule.pas' {fr_find},
  ColorChange in '..\uiforms\ColorChange.pas' {fr_getColor},
  pipe_speed_color in 'pipe_speed_color.pas' {fr_spd_pipe_color},
  ch_plan_work in 'ch_plan_work.pas' {fr_change_plan_work},
  prn_dlg in 'prn_dlg.pas' {fr_print_dlg},
  open_maps in 'open_maps.pas' {fr_open_maps},
  Get_str in '..\uiforms\Get_str.pas' {fr_get_str},
  pipe_select in 'pipe_select.pas' {fr_pipe_select},
  legenda in 'legenda.pas' {fr_legend},
  well_present in 'well_present.pas' {fr_present_well},
  unitpressbycatch in '..\server\unitpressbycatch.pas' {fr_unit_press_by_catch},
  URAS in 'URAS.pas' {fr_t_ras},
  shop_ch in '..\adm\shop_ch.pas' {fr_openshop},
  deposit_ch in 'deposit_ch.pas' {fr_deposit},
  Ask_dlg in '..\uiforms\Ask_dlg.pas' {fr_dialog},
  pipe_d_spr in 'pipe_d_spr.pas' {fr_pipe_d},
  users in 'users.pas' {fr_users},
  pumpt_spr in 'pumpt_spr.pas' {fr_pumpt_spr};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  fr_splash:= Tfr_splash.Create(nil);
  fr_splash.Show;
  fr_splash.Update;
  Application.ProcessMessages;
  Application.Title := 'оод draw studio.';
  Application.CreateForm(Tfr_main, fr_main);
  Application.CreateForm(Tfr_about, fr_about);
  Application.CreateForm(Tfr_quick_result, fr_quick_result);
  Application.CreateForm(Tfr_lstresult, fr_lstresult);
  Application.CreateForm(Tfr_find, fr_find);
  Application.CreateForm(Tfr_getColor, fr_getColor);
  Application.CreateForm(Tfr_spd_pipe_color, fr_spd_pipe_color);
  Application.CreateForm(Tfr_t_ras, fr_t_ras);
  Application.CreateForm(Tfr_pumpt_spr, fr_pumpt_spr);
  try
  Application.Run;
  except
  end;
end.
