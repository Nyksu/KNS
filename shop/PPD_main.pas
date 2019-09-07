unit PPD_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PPD_DM, PSWrd, Menus, ComCtrls, ActnList, ImgList, ExtCtrls, ToolWin,
  spr_id, Objs, StdCtrls, Buttons, Actors, RXCtrls, RXSpin, dtypes, styles,
  KNS_spr, NS_spr, VPP_spr, VRP_spr, Catch_spr, Pipe_spr, Kust_spr, Ask_Integer,
  Pump_spr, Well_spr, Unit_spr, DView, Pump_plan, Pump_Exel, res_explorer,
  Unit_press, About, quick_res, ComObj, StrUtils, ResList, findrule, ColorChange,
  ch_plan_work, prn_dlg, open_maps, Get_str, pipe_select, legenda, well_present,
  Ask_chislo, unitpressbycatch, URAS, shop_ch, deposit_ch, pipe_d_spr, Splash,
  users, pumpt_spr;

type
  Tfr_main = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    n_open: TMenuItem;
    N3: TMenuItem;
    n_exit: TMenuItem;
    n_reconnect: TMenuItem;
    N2: TMenuItem;
    n_review: TMenuItem;
    n_save: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    StatusBar1: TStatusBar;
    CoolBar1: TCoolBar;
    Panel1: TPanel;
    iLib: TStyleLibrary;
    iEdit: TEditActor;
    iSquare: TAddSquareActor;
    iLine: TAddLineActor;
    Panel2: TPanel;
    ToolBar3: TToolBar;
    bt_s1: TToolButton;
    bt_s2: TToolButton;
    bt_s3: TToolButton;
    bt_s4: TToolButton;
    tb_tools: TToolBar;
    bt_Edit: TToolButton;
    bt_KNS: TToolButton;
    bt_NS: TToolButton;
    bt_pipe_lp: TToolButton;
    bt_pump: TToolButton;
    bt_vpp: TToolButton;
    bt_vrp: TToolButton;
    bt_well: TToolButton;
    bt_kust: TToolButton;
    bt_catch: TToolButton;
    bt_zoom_in: TToolButton;
    iml_tools: TImageList;
    iml_operations: TImageList;
    ac_operations: TActionList;
    ed_zoom: TRxSpinEdit;
    RxLabel1: TRxLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    scrolField: TScrollBox;
    FieldMain: Tdiagram;
    mn_elems: TPopupMenu;
    n_delete_element: TMenuItem;
    n_edit_atr: TMenuItem;
    iZoom: TZoomActor;
    bt_unit: TToolButton;
    bt_s5: TToolButton;
    n_deselect: TMenuItem;
    bt_draw: TToolButton;
    n_calc_basik: TMenuItem;
    Panel3: TPanel;
    Priview: TOverview;
    n_add_unit_to_result: TMenuItem;
    Splitter1: TSplitter;
    N4: TMenuItem;
    N5: TMenuItem;
    n_about: TMenuItem;
    Panel4: TPanel;
    Splitter2: TSplitter;
    ch_show_preview: TCheckBox;
    ls_elems_properties: TListBox;
    n_unit_free_del: TMenuItem;
    N9: TMenuItem;
    n_Agr_to_Exel: TMenuItem;
    n_explorer: TMenuItem;
    n_press_units: TMenuItem;
    n_qres: TMenuItem;
    n_pump_plan: TMenuItem;
    op_file_dlg: TOpenDialog;
    n_prot_well_excel: TMenuItem;
    n_update_well_from_excel: TMenuItem;
    Panel5: TPanel;
    bt_doit: TButton;
    n_find: TMenuItem;
    tmr_find: TTimer;
    ch_can_move: TCheckBox;
    Panel6: TPanel;
    N10: TMenuItem;
    N11: TMenuItem;
    n_pipe_d_show: TMenuItem;
    n_pipe_tr_show: TMenuItem;
    n_pipe_v_show: TMenuItem;
    n_set_plan_work: TMenuItem;
    n_print: TMenuItem;
    n_new_map: TMenuItem;
    n_map_name: TMenuItem;
    n_map_coment: TMenuItem;
    N12: TMenuItem;
    n_pipe_select: TMenuItem;
    n_add_pipe_to_select: TMenuItem;
    n_go_to_kust: TMenuItem;
    N13: TMenuItem;
    n_legend: TMenuItem;
    n_well_present: TMenuItem;
    n_set_catch_press: TMenuItem;
    n_calc_catch: TMenuItem;
    n_set_unit_memory: TMenuItem;
    n_adaptation: TMenuItem;
    n_go_to_ns: TMenuItem;
    n_go_to_kns: TMenuItem;
    n_t_ras: TMenuItem;
    n_shops: TMenuItem;
    n_deposits: TMenuItem;
    N15: TMenuItem;
    n_pipes_d: TMenuItem;
    N17: TMenuItem;
    n_users: TMenuItem;
    n_svodka: TMenuItem;
    n_pump_spr: TMenuItem;
    n_calcyear: TMenuItem;
    bt_ed_el: TBitBtn;
    bt_del_el: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure n_exitClick(Sender: TObject);
    procedure ac_square_typeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bt_EditClick(Sender: TObject);
    procedure bt_KNSClick(Sender: TObject);
    procedure bt_NSClick(Sender: TObject);
    procedure bt_pipe_lpClick(Sender: TObject);
    procedure bt_pumpClick(Sender: TObject);
    procedure bt_vppClick(Sender: TObject);
    procedure bt_vrpClick(Sender: TObject);
    procedure bt_wellClick(Sender: TObject);
    procedure bt_kustClick(Sender: TObject);
    procedure bt_catchClick(Sender: TObject);
    procedure bt_zoom_inClick(Sender: TObject);
    procedure bt_s1Click(Sender: TObject);
    procedure bt_s2Click(Sender: TObject);
    procedure bt_s3Click(Sender: TObject);
    procedure bt_s4Click(Sender: TObject);
    function iSquareCreateVertex(Sender: TObject;
      P: TLongPoint): TCustomVertex;
    function iLineCreateEdge(Sender: TObject; Source, Target: TMyObject;
      StartP, EndP: TLongPoint): TCustomEdge;
    procedure ed_zoomChange(Sender: TObject);
    procedure FieldMainScaleChange(Mode: TScaleChange;
      var NewScale: Integer);
    procedure iZoomClick(Sender: TObject);
    procedure iZoomRightClick(Sender: TObject);
    procedure n_delete_elementClick(Sender: TObject);
    procedure iEditRightClick(Sender: TObject);
    procedure n_edit_atrClick(Sender: TObject);
    function is_modified : boolean;
    procedure bt_unitClick(Sender: TObject);
    procedure bt_s5Click(Sender: TObject);
    procedure n_deselectClick(Sender: TObject);
    procedure bt_drawClick(Sender: TObject);
    procedure n_calc_basikClick(Sender: TObject);
    procedure n_pump_planClick(Sender: TObject);
    procedure n_Agr_to_ExelClick(Sender: TObject);
    procedure n_explorerClick(Sender: TObject);
    procedure n_add_unit_to_resultClick(Sender: TObject);
    procedure n_press_unitsClick(Sender: TObject);
    procedure ch_show_previewClick(Sender: TObject);
    procedure n_saveClick(Sender: TObject);
    procedure n_reviewClick(Sender: TObject);
    procedure n_aboutClick(Sender: TObject);
    procedure iEditClick(Sender: TObject);
    procedure n_qresClick(Sender: TObject);
    procedure n_unit_free_delClick(Sender: TObject);
    procedure n_prot_well_excelClick(Sender: TObject);
    procedure n_update_well_from_excelClick(Sender: TObject);
    procedure tmr_findTimer(Sender: TObject);
    procedure bt_doitClick(Sender: TObject);
    procedure ch_can_moveClick(Sender: TObject);
    procedure n_findClick(Sender: TObject);
    procedure n_pipe_tr_showClick(Sender: TObject);
    procedure n_pipe_v_showClick(Sender: TObject);
    procedure n_pipe_d_showClick(Sender: TObject);
    procedure n_set_plan_workClick(Sender: TObject);
    procedure n_printClick(Sender: TObject);
    procedure n_openClick(Sender: TObject);
    procedure n_new_mapClick(Sender: TObject);
    procedure n_map_nameClick(Sender: TObject);
    procedure n_map_comentClick(Sender: TObject);
    procedure n_pipe_selectClick(Sender: TObject);
    procedure n_add_pipe_to_selectClick(Sender: TObject);
    procedure n_go_to_kustClick(Sender: TObject);
    procedure n_legendClick(Sender: TObject);
    procedure scrolFieldMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure n_well_presentClick(Sender: TObject);
    procedure n_set_catch_pressClick(Sender: TObject);
    procedure n_set_unit_memoryClick(Sender: TObject);
    procedure n_calc_catchClick(Sender: TObject);
    procedure n_adaptationClick(Sender: TObject);
    procedure n_go_to_nsClick(Sender: TObject);
    procedure n_go_to_knsClick(Sender: TObject);
    procedure n_t_rasClick(Sender: TObject);
    procedure n_shopsClick(Sender: TObject);
    procedure n_depositsClick(Sender: TObject);
    procedure n_pipes_dClick(Sender: TObject);
    procedure n_svodkaClick(Sender: TObject);
    procedure n_usersClick(Sender: TObject);
    procedure n_pump_sprClick(Sender: TObject);
    procedure n_calcyearClick(Sender: TObject);
  private
    ActiveToolId : integer;
    FieldW : integer;
    FieldH : integer;
    can_change_zoom : integer;
    xl : variant;
    sheet : variant;
    id_tek_uz : integer;
    Procedure ActivatePlan;
    Procedure ActivatePlan0;
    Procedure ActivatePlan1;
    Procedure ActivatePlan2;
    Procedure ActivatePlan3;
    Procedure ActivatePlan4;
    Procedure ReSizePlan;
    Procedure SaveSchem;
    Procedure DelAll;
    Function ShowMap : boolean;
    Function ShowPlan : boolean;
    Function ShowMap1 : boolean;
    Function ShowPlan1 : boolean;
    Function ShowMap2 : boolean;
    Function ShowPlan2 : boolean;
    Function ShowMap3 : boolean;
    Function ShowPlan3 : boolean;
    Function ShowMap4 : boolean;
    Function ShowPlan4 : boolean;
    Function ShowMap5 : boolean;
    Function ShowPlan5 : boolean;
    Procedure TextToPlan(txt : string;fnsize,fncolor,fndir,x,y,width,hight : integer);
    Function NS_name (name : string) : TDcdataitem;
    Function NS_drow : Tdcdrawitem;
    Function KNS_drow(is_stok : integer) : Tdcdrawitem;
    Function KNS_name(name : string; is_stok : integer) : TDcdataitem;
    Function Well_drow : Tdcdrawitem;
    Function VPP_drow : TDcdataitem;
    Function VPP_nam(name : string;x,y : integer) : TDcdataitem;
    Function Uz_nam(name : string) : TDcdataitem;
    Function VRP_drow : TDcdataitem;
    Function Kust_name(name : string) : TDcdataitem;
    Function Kust_drow : Tdcdrawitem;
    Function Draw_drow(idx : integer) : TDcdrawitem;
    Procedure DelSelectedTipe(tipe,sqln,ern : integer; namepar : string);
    Function ShowKNS : Boolean;
    Function ShowNS : Boolean;
    Function ShowKust : Boolean;
    Function ShowWell(id : integer) : Boolean;
    Function ShowVRP(id : integer) : Boolean;
    Function ShowVPP(id : integer) : Boolean;
    Function ShowCatch(id : integer) : Boolean;
    Function ShowPump(id : integer) : Boolean;
    Function ShowPipe(id : integer) : Boolean;
    Function ConnectUnitToObj(ob : TMyObject;P: TLongPoint; pl : integer) : integer;
    Procedure ConnectUnitToVPP(id,uz : integer);
    Procedure ConnectUnitToVRP(id,uz : integer);
    Procedure ConnectUnitToWell(id,uz : integer);
    Function SetUnit(ob : TMyObject;P: TLongPoint) : TMyObject;
    Function SetUsel(ob : TMyObject;P: TLongPoint;id : integer;unam : string) : TMyObject;
    Function ShowUsel(P: TLongPoint;id : integer; ow : TMyObject;unam : string) : TMyObject;
    Function GetUselFromHandle(ob:TMyObject):TMyObject;
    Function GetUselIdFromHandle(ob:TMyObject):Integer;
    Function ChangeLineElementsDbUsels(u1,u2,ii:integer;tbn:string) : integer;
    Procedure SetUnitsPlan;
    Procedure ClearUnits;
    Procedure set_id_plan(tp,id : integer);
    Procedure WellFromExcel(updat : boolean);
    Function SetStateWell(well,state : integer; nomer : string; depth,d,d_p : real) : integer;
    Procedure SetPropUnitsPlan;
    Function GetUnitProp(id : integer) : variant;
    Procedure SetPipeDLegend;
    { Private declarations }
  public
    map_type : integer;
    procedure set_kust_map(id : integer);
    Function FindUselXY(P : TLongPoint) : TMyObject;
    procedure set_ns_map(id : integer);
    procedure set_kns_map(id : integer);
    Procedure ClearToolBtn(lin : integer);
    { Public declarations }
  end;

var
  fr_main: Tfr_main;
  bbb:Tround;

implementation

uses pipe_speed_color;

{$R *.DFM}


procedure Tfr_main.FormCreate(Sender: TObject);
var
  id : integer;
  par,pp,nms : variant;
begin
  DecimalSeparator:='.';
  THOUSANDSEPARATOR:=' ';
  DateSeparator:='.';
  conn:=false;
  isCalcOk:=false;
  try
    If StartDM Then Begin
      If CreatBridge=0 Then conn:=true;
    end
    Else MessageDlg('Непреодолимая ошибка!', mtError, [mbOk], 0);
  except
  end;
  Application.ProcessMessages;
  fr_main.Caption:=fr_main.Caption+' '+vers;
  map_type:=0;
  can_change_zoom:=0;
  ActiveToolId:=0;
  id_tek_uz:=0;
  If conn Then Begin
    CreateLegend;
    ActivatePlan;
    ShowPlan;
    bt_Edit.Down:=true;
    FieldMain.Actor:=iEdit;
    Priview.DiagramBox:=FieldMain;
    Priview.Enabled:=True;
    Priview.ScaleBy(5,15);
    Priview.MinZoom:=1;
    Priview.MaxZoom:=100;
    Priview.Active:=true;
    id:=DM.GetMapID;
    par:=VarArrayCreate([0, 2], varVariant);
    par[0]:=179;
    par[1]:=VarArrayOf(['mp']); //имена
    par[2]:=VarArrayOf([id]); //значения
    nms:=VarArrayOf(['name']);
    pp:=DM.GetTehDataNams(par,nms);
    //FieldMain.BasicWidth:=4000;
    //FieldMain.BasicHeight:=3000;
    if VarIsNull(pp) Then fr_main.StatusBar1.Panels[2].Text:='Базовая схема'
    Else fr_main.StatusBar1.Panels[2].Text:=pp[0];
  end;
  fr_splash.Close;
end;

Procedure Tfr_main.ReSizePlan;
var
  mmw,mmh : integer;
Begin
  //FieldMain.BasicWidth:=FieldW;
  //FieldMain.BasicHeight:=FieldH;

  mmw:=Round(FieldW*FieldMain.ScaleFactor);
  mmh:=Round(Fieldh*FieldMain.ScaleFactor);
  if FieldMain.ScaleFactor<0.5 Then FieldMain.ShowPrinterPage:=true;
  if FieldMain.ScaleFactor>0.5 Then FieldMain.ShowPrinterPage:=false;
  if FieldMain.ScaleFactor<0.5 Then FieldMain.ShowGrid:=false;
  if FieldMain.ScaleFactor>0.5 Then FieldMain.ShowGrid:=true;
  if mmw<640 Then mmw:=640;
  if mmh<480 Then mmh:=480;
  scrolField.HorzScrollBar.Range:=mmw;
  scrolField.VertScrollBar.Range:=mmh;
  scrolField.Realign;
end;

procedure Tfr_main.FormActivate(Sender: TObject);
begin
  If not conn Then Close;
end;

procedure Tfr_main.n_exitClick(Sender: TObject);
begin
  Close;
end;

Procedure Tfr_main.ActivatePlan;
begin
   CASE map_type of
     0 : ActivatePlan0;
     1 : ActivatePlan1;
     2 : ActivatePlan2;
     3 : ActivatePlan3;
     4 : ActivatePlan4;
   end;
   ReSizePlan;
   DM.GetBaseUnits;
end;

Procedure Tfr_main.ActivatePlan0;
var
 par,pp : variant;
 mx,my : integer;
begin
   par:=VarArrayCreate([0, 2], varVariant);
   mx:=1000;
   my:=1000;
   par[0]:=23;//номер ЭсКуЭл
   par[1]:=VarArrayOf(['!x','!K','VAL']); //имена
   par[2]:=VarArrayOf(['b_x','kns',mx]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['b_x','ns',mx]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['b_y','kns',my]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   par[2]:=VarArrayOf(['b_y','ns',my]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   FieldW:=mx+400;  //Стартовая ширина поля
   FieldH:=my+400;  //Стартовая высота поля
end;

Procedure Tfr_main.ActivatePlan1;
var
 par,pp : variant;
 mx,my : integer;
begin
   par:=VarArrayCreate([0, 2], varVariant);
   mx:=1000;
   my:=1000;
   par[0]:=23;//номер ЭсКуЭл
   par[1]:=VarArrayOf(['!x','!K','VAL']); //имена
   par[2]:=VarArrayOf(['b_x','kns',mx]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['b_x','kust',mx]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['b_y','kns',my]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   par[2]:=VarArrayOf(['b_y','kust',my]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   FieldW:=mx+400;  //Стартовая ширина поля
   FieldH:=my+400;  //Стартовая высота поля
end;

Procedure Tfr_main.ActivatePlan2;
var
 par,pp : variant;
 mx,my : integer;
begin
   par:=VarArrayCreate([0, 3], varVariant);
   mx:=1000;
   my:=1000;
   par[0]:=23;//номер ЭсКуЭл
   par[1]:=VarArrayOf(['!x','!K','VAL','obj','!f']); //имена
   par[2]:=VarArrayOf(['x','vpp',mx,iidd,'kns']); //значения
   par[3]:=VarArrayOf(['com']);
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['x','vrp',mx,iidd,'kns']); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['y','vpp',my,iidd,'kns']); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   par[2]:=VarArrayOf(['y','vrp',my,iidd,'kns']); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   FieldW:=mx+500;  //Стартовая ширина поля
   FieldH:=my+400;  //Стартовая высота поля
end;

Procedure Tfr_main.ActivatePlan3;
var
 par,pp : variant;
 mx,my : integer;
begin
   par:=VarArrayCreate([0, 3], varVariant);
   mx:=1000;
   my:=1000;
   par[0]:=102;//номер ЭсКуЭл
   par[1]:=VarArrayOf(['!x','!K','VAL','kust']); //имена
   par[2]:=VarArrayOf(['x','vpp_kust',mx,iidd]); //значения
   par[3]:=VarArrayOf(['com']);
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['x','well',mx,iidd]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['y','vpp_kust',my,iidd]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   par[2]:=VarArrayOf(['y','well',my,iidd]); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   FieldW:=mx+400;  //Стартовая ширина поля
   FieldH:=my+450;  //Стартовая высота поля
end;

Procedure Tfr_main.ActivatePlan4;
var
 par,pp : variant;
 mx,my : integer;
begin
   par:=VarArrayCreate([0, 3], varVariant);
   mx:=1000;
   my:=1000;
   par[0]:=23;//номер ЭсКуЭл
   par[1]:=VarArrayOf(['!x','!K','VAL','obj','!f']); //имена
   par[2]:=VarArrayOf(['x','vpp_ns',mx,iidd,'ns']); //значения
   par[3]:=VarArrayOf(['com']);
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['x','ns_vrp',mx,iidd,'ns']); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then mx:=pp;
   par[2]:=VarArrayOf(['y','vpp_ns',my,iidd,'ns']); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   par[2]:=VarArrayOf(['y','ns_vrp',my,iidd,'ns']); //значения
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then my:=pp;
   FieldW:=mx+500;  //Стартовая ширина поля
   FieldH:=my+400;  //Стартовая высота поля
end;

procedure Tfr_main.ac_square_typeExecute(Sender: TObject);
var i:integer;
begin

end;

Procedure Tfr_main.DelAll;
Begin
  FieldMain.DeSelectAll;
  FieldMain.SelectAll;
  FieldMain.DeleteSelectedObjects(dcProgram);
end;

function Tfr_main.is_modified : boolean;
var
  ii, cc : integer;
  ob : Tmyobject;
Begin
  Result:=false;
  FieldMain.DeSelectAll;
  FieldMain.SelectAll;
  cc:=FieldMain.Selection.Count;
  For ii:=0 To cc-1 Do Begin
      ob:=FieldMain.Selection.Items[ii];
      Result:=Result or ob.Modified;
  end;
  FieldMain.DeSelectAll;
end;

Procedure Tfr_main.SaveSchem;
var
  ii, i, cc, cu, tip, idd, u1, u2, cx, cy : integer;
  ob,oob : Tmyobject;
  tl : TLine;
  adj : TAdjacent;
  ts : TSquare;
  ismod : boolean;
  p,p1,p2 : TLongPoint;
  hd : Tmyhandle;
  par,pp,pr : variant;
  k : string;
  b1 : Tround;
Begin
  ismod:=is_modified;
  FieldMain.SelectAll;
  cc:=FieldMain.Selection.Count;
  If (cc>0)and(ismod) Then Begin
     if MessageDlg('Объекты были перемещены. Сохранить перемещение в базу?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes then Begin
          par:=VarArrayCreate([0, 2], varVariant);
          For ii:=0 To cc-1 Do Begin
            ob:=FieldMain.Selection.Items[ii];
            if ob.Modified Then
            if ob is TLine Then Begin
               ob.Modified:=false;
               tl:=FieldMain.Selection.Items[ii];
               tip:=tl.IdType;
               idd:=tl.tag;
               u1:=-1;
               u2:=-1;
               hd:=tl.Handles.First;
               p.x:=hd.X;
               p.y:=hd.y;
               i:=0;
               oob:=hd.Connections.Items[0];
               While (oob.IdType<>12)and(i<hd.Connections.Count-1) Do Begin
                 Inc(i);
                 oob:=hd.Connections.Items[i];
               end;
               If oob.IdType=12 Then u1:=oob.Tag;
               hd:=tl.Handles.Last;
               p1.x:=hd.X;
               p1.y:=hd.y;
               i:=0;
               oob:=hd.Connections.Items[0];
               While (oob.IdType<>12)and(i<hd.Connections.Count-1) Do Begin
                 Inc(i);
                 oob:=hd.Connections.Items[i];
               end;
               If oob.IdType=12 Then u2:=oob.Tag;
               CASE tip of
                5,10 : Begin
                        If tip=10 Then Begin
                          i:=89;
                          k:='catch';
                        end
                        Else Begin
                          i:=90;
                          k:='pump';
                        end;
                        adj:=tl.TextBox.First;
                        cx:=adj.X;
                        cy:=adj.Y;
                        DM.StartTrans;
                        par[0]:=211;
                        par[1]:=VarArrayOf(['cx','cy','idd','!tb']);
                        par[2]:=VarArrayOf([cx,cy,idd,k]);
                        cod_err:=27;
                        pp:=DM.RunSQL(par);
                        If pp<>0 Then DM.BackTrans;
                        par[0]:=i;
                        par[1]:=VarArrayOf([k]);
                        par[2]:=VarArrayOf([idd]);
                        pr:=DM.GetTehData(par);
                        If (u1>0) and (u2>0) Then
                         if (u1<>pr[0])or(u2<>pr[1]) Then Begin
                           DM.StartTrans;
                           par[0]:=51;
                           par[1]:=VarArrayOf(['!tab','ob','u1','u2']);
                           par[2]:=VarArrayOf([k,idd,u1,u2]);
                           pp:=DM.RSQL(par);
                           If pp<>0 Then DM.BackTrans
                           Else DM.ComTrans;
                         end;
                       end;
                   4 : Begin
                        cu:=tl.Handles.Count-2;
                        par[0]:=87;
                        par[1]:=VarArrayOf(['pipe']);
                        par[2]:=VarArrayOf([idd]);
                        pr:=DM.GetTehData(par);
                        If (u1>0) and (u2>0) Then
                         if (u1<>pr[0])or(u2<>pr[1]) Then Begin
                           DM.StartTrans;
                           par[0]:=51;
                           par[1]:=VarArrayOf(['!tab','ob','u1','u2']);
                           par[2]:=VarArrayOf(['pipe',idd,u1,u2]);
                           pp:=DM.RSQL(par);
                           If pp<>0 Then Begin
                             DM.BackTrans;
                             Exit;
                           end
                           Else DM.ComTrans;
                         end;
                         adj:=tl.TextBox.First;
                         cx:=adj.X;
                         cy:=adj.Y;
                         DM.StartTrans;
                         par[0]:=210;
                         par[1]:=VarArrayOf(['cx','cy','pip']);
                         par[2]:=VarArrayOf([cx,cy,idd]);
                         cod_err:=26;
                         pp:=DM.RunSQL(par);
                         If pp<>0 Then DM.BackTrans;
                         If cu>0 Then Begin
                             DM.StartTrans;
                             par[0]:=52;
                             par[1]:=VarArrayOf(['pipe']);
                             par[2]:=VarArrayOf([idd]);
                             cod_err:=21;
                             DM.RunSQL(par);
                             For i:=1 To cu Do Begin
                              hd:=tl.Handles[i];
                              p2.x:=hd.X;
                              p2.y:=hd.Y;
                              par[0]:=53;
                              par[1]:=VarArrayOf(['pipe','x','y']);
                              par[2]:=VarArrayOf([idd,p2.x,p2.y]);
                              cod_err:=22;
                              pp:=DM.RunSQL(par);
                              If pp<>0 Then Begin
                                 DM.BackTrans;
                                 Exit;
                              end;
                             end;
                             DM.ComTrans;
                           end;
                       end;
               end;
            end
            Else if ob is TSquare Then Begin
               ob.Modified:=false;
               ts:=FieldMain.Selection.Items[ii];
               tip:=ts.IdType;
               idd:=ts.tag;
               If tip<>12 Then Begin
                 p.x:=ts.Left;
                 p.y:=ts.top;
                 p1.x:=ts.Right;
                 p1.y:=ts.Bottom;
               end;
               k:='';
               CASE tip of
                  1,2 : Begin //НС или КНС
                          DM.StartTrans;
                          If tip=1 Then k:='K';
                          par[0]:=56;
                          par[1]:=VarArrayOf(['!K','ux','uy','bx','by','kod']);
                          par[2]:=VarArrayOf([k,p.x,p.y,p1.x,p1.y,idd]);
                          cod_err:=23;
                          pp:=DM.RunSQL(par);
                          If pp<>0 Then DM.BackTrans
                          Else DM.ComTrans;
                        end;
                  6,7 : Begin //ВПП или ВРП
                          DM.StartTrans;
                          CASE map_type of
                               0 : If tip=7 Then k:='NS_VRP' Else k:='VPP';
                               2 : If tip=7 Then k:='VRP' Else k:='VPP';
                             1,3 : If tip=7 Then k:='VRP' Else k:='VPP_Kust';
                               4 : If tip=7 Then k:='NS_VRP' Else k:='VPP_NS';
                          end;
                          par[0]:=57;
                          par[1]:=VarArrayOf(['!table','x','y','len','kod']);
                          i:=Round(ABS(p.y-p1.y));
                          par[2]:=VarArrayOf([k,p.x,p.y,i,idd]);
                          cod_err:=24;
                          pp:=DM.RunSQL(par);
                          If pp<>0 Then DM.BackTrans
                          Else DM.ComTrans;
                        end;
                    9 : Begin
                          DM.StartTrans;
                          par[0]:=81;
                          par[1]:=VarArrayOf(['ux','uy','bx','by','kust']);
                          par[2]:=VarArrayOf([p.x,p.y,p1.x,p1.y,idd]);
                          cod_err:=28;
                          pp:=DM.RunSQL(par);
                          If pp<>0 Then DM.BackTrans
                          Else DM.ComTrans;
                        end;
                    8 : Begin
                          DM.StartTrans;
                          par[0]:=103;
                          par[1]:=VarArrayOf(['x','y','well']);
                          par[2]:=VarArrayOf([p.x,p.y,idd]);
                          cod_err:=29;
                          pp:=DM.RunSQL(par);
                          If pp<>0 Then DM.BackTrans
                          Else DM.ComTrans;
                        end;
                   12 : Begin
                          b1:=Tround(ob);
                          hd:=b1.Handles.Items[0];
                          p.x:=hd.x;
                          p.y:=hd.y;
                          DM.StartTrans;
                          par[0]:=88;
                          par[1]:=VarArrayOf(['x','y','unit']);
                          par[2]:=VarArrayOf([p.x,p.y,idd]);
                          pp:=DM.RSQL(par);
                          If pp<>0 Then DM.BackTrans
                          Else DM.ComTrans;
                        end;
               end;
            end;
         end;
         //+++++++++ Зачистка узлов
         //ClearUnits;
         //+++++++++
       end;
  end;
end;

procedure Tfr_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSchem;
  DelAll;
  CloseDM;
  Action:=caFree;
end;

Procedure Tfr_main.ClearToolBtn(lin : integer);
Begin
  Case lin of
  1 : Begin
    bt_Edit.Down:=false;
    bt_KNS.Down:=false;
    bt_NS.Down:=false;
    bt_pipe_lp.Down:=false;
    bt_pump.Down:=false;
    bt_vpp.Down:=false;
    bt_vrp.Down:=false;
    bt_well.Down:=false;
    bt_kust.Down:=false;
    bt_catch.Down:=false;
    bt_zoom_in.Down:=false;
    bt_unit.Down:=false;
    bt_draw.Down:=false;
    end;
  2 : Begin
    bt_s1.Down:=false;
    bt_s2.Down:=false;
    bt_s3.Down:=false;
    bt_s4.Down:=false;
    bt_s5.Down:=false;
    end;
  end;
end;

procedure Tfr_main.bt_EditClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_Edit.Down:=true;
  ActiveToolId:=0;
  FieldMain.Actor:=iEdit;
end;

procedure Tfr_main.bt_KNSClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_KNS.Down:=true;
  ActiveToolId:=1;
  FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_NSClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_NS.Down:=true;
  ActiveToolId:=2;
  FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_pipe_lpClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_pipe_lp.Down:=true;
  ActiveToolId:=4;
  FieldMain.Actor:=iLine;
end;

procedure Tfr_main.bt_pumpClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_pump.Down:=true;
  ActiveToolId:=5;
  //FieldMain.Actor:=iSquare;
  FieldMain.Actor:=iLine;
end;

procedure Tfr_main.bt_vppClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_vpp.Down:=true;
  ActiveToolId:=6;
  FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_vrpClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_vrp.Down:=true;
  ActiveToolId:=7;
  FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_wellClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_well.Down:=true;
  ActiveToolId:=8;
  FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_kustClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_kust.Down:=true;
  ActiveToolId:=9;
  FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_catchClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_catch.Down:=true;
  ActiveToolId:=10;
  FieldMain.Actor:=iLine;
end;

procedure Tfr_main.bt_zoom_inClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_zoom_in.Down:=true;
  ActiveToolId:=11;
  FieldMain.Actor:=iZoom;
end;

procedure Tfr_main.bt_unitClick(Sender: TObject);
begin
  ClearToolBtn(1);
  bt_unit.Down:=true;
  ActiveToolId:=12;
  FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_drawClick(Sender: TObject);
begin
  Exit;
  //ClearToolBtn(1);
  //bt_draw.Down:=true;
  //ActiveToolId:=13;
  //FieldMain.Actor:=iSquare;
end;

procedure Tfr_main.bt_s1Click(Sender: TObject);
begin
  If not bt_s1.Down Then Begin
    ClearToolBtn(2);
    bt_s1.Down:=true;
    SaveSchem;
    DelAll;
    map_type:=0;
    iidd:=null;
    ActivatePlan;
    ShowPlan;
  end;
end;

procedure Tfr_main.bt_s2Click(Sender: TObject);
begin
  If not bt_s2.Down Then Begin
    ClearToolBtn(2);
    bt_s2.Down:=true;
    SaveSchem;
    DelAll;
    map_type:=1;
    iidd:=null;
    ActivatePlan;
    ShowPlan;
  end;
end;

procedure Tfr_main.bt_s3Click(Sender: TObject);
var
  cc : integer;
  ob : TMyObject;
begin
  cc:=FieldMain.Selection.Count;
  If cc=1 Then Begin
    ob:=FieldMain.Selection.Items[0];
    If ob.IdType=1 Then Begin
       set_kns_map(ob.Tag);
       //iidd:=ob.Tag;
       //ClearToolBtn(2);
       //bt_s3.Down:=true;
       //SaveSchem;
       //DelAll;
       //map_type:=2;
       //ActivatePlan;
       //ShowPlan;
    end;
  end;
end;

procedure Tfr_main.bt_s4Click(Sender: TObject);
var
  cc : integer;
  ob : TMyObject;
begin
  cc:=FieldMain.Selection.Count;
  If cc=1 Then Begin
    ob:=FieldMain.Selection.Items[0];
    If ob.IdType=9 Then Begin
       set_kust_map(ob.Tag);
       //iidd:=ob.Tag;
       //ClearToolBtn(2);
       //bt_s4.Down:=true;
       //SaveSchem;
       //DelAll;
       //map_type:=3;
       //ActivatePlan;
       //ShowPlan;
    end;
  end;
end;

procedure Tfr_main.bt_s5Click(Sender: TObject);
var
  cc : integer;
  ob : TMyObject;
begin
  cc:=FieldMain.Selection.Count;
  If cc=1 Then Begin
    ob:=FieldMain.Selection.Items[0];
    If ob.IdType=2 Then Begin
       set_ns_map(ob.Tag);
       //iidd:=ob.Tag;
       //ClearToolBtn(2);
       //bt_s5.Down:=true;
       //SaveSchem;
       //DelAll;
       //map_type:=4;
       //ActivatePlan;
       //ShowPlan;
    end;
  end;
end;

Procedure Tfr_main.set_id_plan(tp,id : integer);
Begin
   iidd:=id;
   ClearToolBtn(2);
   CASE tp of
      4 : bt_s5.Down:=true;
      3 : bt_s4.Down:=true;
      2 : bt_s3.Down:=true;
   end;
   SaveSchem;
   DelAll;
   map_type:=tp;
   ActivatePlan;
   ShowPlan;
end;

procedure Tfr_main.set_ns_map(id : integer);
Begin
   set_id_plan(4,id);
end;

procedure Tfr_main.set_kns_map(id : integer);
Begin
   set_id_plan(2,id);
end;

procedure Tfr_main.set_kust_map(id : integer);
Begin
   set_id_plan(3,id);
end;

Function Tfr_main.ShowMap : boolean;
var
res : boolean;
Begin
  Result:=false;
  Case map_type of
    0 : res:=ShowMap1;
    1 : res:=ShowMap2;
    2 : res:=ShowMap3;
    3 : res:=ShowMap4;
    4 : res:=ShowMap5;
  end;
  If res Then res:=ShowPlan;
  Result:=res;
end;

Procedure Tfr_main.SetPipeDLegend;
var
  par,pp : variant;
  col,dd : integer;
  str : string;
Begin
  // описание цветов соответствующих диаметру водовода.
  par:=VarArrayCreate([0, 2], varVariant);
  par[1]:=null;
  par[2]:=null;
  par[0]:=73;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
     dd:=DM.cds_tmp.FieldByName('DIAMETR').AsInteger;
     col:=DM.cds_tmp.FieldByName('COLOR').AsInteger;
     str:='Диаметр водовода: '+IntToStr(dd)+' мм';
     fr_legend.AddItem(col,str);
     DM.cds_tmp.Next;
  end;
  DM.cds_tmp.Active:=false;
end;

Function Tfr_main.ShowPlan : boolean;
var
res : boolean;
Begin
  Result:=false;
  If FieldMain.CanMove Then Begin
     DM.SetEditMap;
     FieldMain.CanMove:=false;
  end;
  If fr_legend.Visible Then fr_legend.Hide;
  fr_legend.ClearList;
  FieldMain.CanMove:=false;
  ch_can_move.Checked:=false;
  Case map_type of
    0 : res:=ShowPlan1;
    1 : res:=ShowPlan2;
    2 : res:=ShowPlan3;
    3 : res:=ShowPlan4;
    4 : res:=ShowPlan5;
  end;
  Result:=res;
  //SetPropUnitsPlan;
  ls_elems_properties.Clear;
  FieldMain.Update;
  SetPipeDLegend;
//  Priview.Active:=false;
//  Priview.Active:=true;
end;

Function Tfr_main.ShowMap1 : boolean;
Begin

end;

Function Tfr_main.ShowPlan1 : boolean;
var
 par,pp : variant;
 qw : TSquare;
 lll : TLine;
 p,p1,p2 : TLongPoint;
 ad1, ad2 : TMyObject;
 b1 : Tround;
 kz,i : integer;
 MyHandle : TMyHandle ;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  Result:=false;
  //НС
  If not ShowNS Then Exit;
  //КНС
  If not ShowKNS Then Exit;
  //ВРП
  If not ShowVRP(-1) Then Exit;
  //ВПП
  If not ShowVPP(-1) Then Exit;
  //Задвижки
  If not ShowCatch(-1) Then Exit;
  //Водоводы
  If not ShowPipe(-1) Then Exit;
  //+++++++++++
  FieldMain.Repaint;
  Result:=true;
end;

Function Tfr_main.ShowMap2 : boolean;
Begin
end;

Function Tfr_main.ShowPlan2 : boolean;
Begin
  // Высоконапорная схема
  Result:=false;
  //КНС
  If not ShowKNS Then Exit;
  //ВРП
  If not ShowVRP(-1) Then Exit;
  //ВПП
  If not ShowVPP(-1) Then Exit;
  // Куст Скважин
  If not ShowKust Then Exit;
  //Задвижки
  If not ShowCatch(-1) Then Exit;
  // Водоводы
  If not ShowPipe(-1) Then Exit;
  //+++++++++++
  FieldMain.Repaint;
  Result:=true;
end;

Function Tfr_main.ShowMap3 : boolean;
Begin

end;

Procedure Tfr_main.TextToPlan(txt : string;fnsize,fncolor,fndir,x,y,width,hight : integer);
var
    qq : TSquare;
    di : TDcdataitem;
    p : TLongPoint;
Begin 
  p.x:=x;
  p.y:=y;
  qq:=Tsquare.create(p,'',iLib,width,hight);
  di:=TDcdataitem.create;
  di.brush.style:=bsClear;
  di.coordmode:=cmvalue;
  di.HorzAlign:=haboth;
  di.VertAlign:=vaboth;
  di.Data:=txt;
  CASE fndir of
    0 : di.Alignment:=taCenter;
    1 : di.Alignment:=taLeftJustify;
    2 : di.Alignment:=taRightJustify;
  end;
  di.Font.Color:=fncolor;
  di.Font.size:=fnsize;
  qq.style.DataItems.add(di);
  FieldMain.AddObject(qq,dcProgram);
end;

Function Tfr_main.ShowPlan3 : boolean;
var
    x,y,width,hight : integer;
    nam : string;
    par,pp : variant;
Begin
// Схема КНС
  Result:=false;
  //КНС
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=19;
  par[1]:=VarArrayOf(['KNS']);
  par[2]:=VarArrayOf([iidd]);
  pp:=DM.GetTehData(par);
  If VarIsNull(pp) Then Exit;
  nam:=pp[1];
  x:=pp[7]-20;
  y:=pp[8]-40;
  width:=Round(ABS(pp[9]-pp[7]))+40;
  hight:=30;
  TextToPlan(nam,18,clBlue,0,x,y,width,hight);
  //ВРП
  If not ShowVRP(iidd) Then Exit;
  //ВПП
  If not ShowVPP(iidd) Then Exit;
  //Задвижки
  If not ShowCatch(iidd) Then Exit;
  //Насосы
  If not ShowPump(iidd) Then Exit;
  // Водоводы
  If not ShowPipe(iidd) Then Exit;
  //+++++++++++
  FieldMain.Repaint;
  Result:=true;
end;

Function Tfr_main.ShowMap4 : boolean;
Begin
end;

Function Tfr_main.ShowPlan4 : boolean;
var
    x,y,width,hight : integer;
    nam : string;
    par,pp : variant;
Begin
// Кусты скважин
  Result:=false;
  //Куст
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=78;
  par[1]:=VarArrayOf(['kust']);
  par[2]:=VarArrayOf([iidd]);
  pp:=DM.GetTehData(par);
  If VarIsNull(pp) Then Exit;
  nam:='Куст № '+pp[2];
  x:=pp[4]-60;
  y:=pp[5]-40;
  width:=Round(ABS(pp[6]-pp[4]))+120;
  hight:=30;
  TextToPlan(nam,18,clGreen,0,x,y,width,hight);
  //ВПП
  If not ShowVPP(iidd) Then Exit;
  //Скважины
  If not ShowWell(iidd) Then Exit;
  //Задвижки
  If not ShowCatch(iidd) Then Exit;
  // Водоводы
  If not ShowPipe(iidd) Then Exit;
  //+++++++++++
  FieldMain.Repaint;
  Result:=true;
end;

Function Tfr_main.ShowMap5 : boolean;
Begin

end;

Function Tfr_main.ShowPlan5 : boolean;
var
    x,y,width,hight : integer;
    nam : string;
    par,pp : variant;
Begin
  // Схема НС
  Result:=false;
  //НС
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=22;
  par[1]:=VarArrayOf(['NS']);
  par[2]:=VarArrayOf([iidd]);
  pp:=DM.GetTehData(par);
  If VarIsNull(pp) Then Exit;
  nam:=pp[1];
  x:=pp[4]-20;
  y:=pp[5]-40;
  width:=Round(ABS(pp[6]-pp[4]))+40;
  hight:=30;
  TextToPlan(nam,18,clNavy,0,x,y,width,hight);
  //ВРП
  If not ShowVRP(iidd) Then Exit;
  //ВПП
  If not ShowVPP(iidd) Then Exit;
  //Задвижки
  If not ShowCatch(iidd) Then Exit;
  //Насосы
  If not ShowPump(iidd) Then Exit;
  // Водоводы
  If not ShowPipe(iidd) Then Exit;
  //+++++++++++
  FieldMain.Repaint;
  Result:=true;
end;

function Tfr_main.iSquareCreateVertex(Sender: TObject;P: TLongPoint): TCustomVertex;
var
    qq : TSquare;
    re : Variant;
    l,t,r,b, idd, nn, pl : integer;
    pp : TMyObject;
    b1 : Tround;
begin
   if not ch_can_move.Checked Then Begin
      Result:=nil;
      Exit;
   end;
   Case ActiveToolId  Of
        1,2 : result:=Tsquare.create(p,'',iLib,160,220);
        6,7 : result:=Tsquare.create(p,'',iLib,10,150);
        9   : result:=Tsquare.create(p,'',iLib,60,150);
        12  : result:=nil;
        8   : result:=Tsquare.create(p,'',iLib,30,30);
        Else result:=Tsquare.create(p,'',iLib);
   end;
   If ActiveToolId<>12 Then Begin
     result.IdType:=ActiveToolId;
     if Result.Left>(FieldW-150) Then FieldW:=Result.Left+150;
     if Result.Top>(FieldH-150) Then FieldW:=Result.Top+150;
   end;
   Case ActiveToolId  Of
        1 : if (map_type<>0)and(map_type<>1) Then Begin
              Result.Free;
              Result:=nil
            end
            Else Begin
              result.IdType:=ActiveToolId;
              l:=Result.Left;
              t:=Result.Top;
              r:=Result.Right;
              b:=Result.Bottom;
              idd:=-1;
              re:=KNSToDB(idd, l, t, r, b,true);
              If VarIsNull(re) Then Begin
                Result.Free;
                Result:=nil
              end
              Else Begin
                result.Tag:=idd;
                result.Properties:=re;
                Tsquare(result).style.DataItems.add(KNS_drow(re[6]));
                Tsquare(result).style.DataItems.add(KNS_name(re[1],re[6]));
              end;
            end;
        2 : if map_type<>0 Then Begin
              Result.Free;
              Result:=nil
            end
            Else Begin
              result.IdType:=ActiveToolId;
              l:=Result.Left;
              t:=Result.Top;
              r:=Result.Right;
              b:=Result.Bottom;
              idd:=-1;
              re:=NSToDB(idd, l, t, r, b, true);
              If VarIsNull(re) Then Begin
                Result.Free;
                Result:=nil
              end
              Else Begin
                result.Tag:=idd;
                result.Properties:=re;
                Tsquare(result).style.DataItems.add(NS_drow);
                Tsquare(result).style.DataItems.add(NS_name(re[1]));
              end;
            end;
        6 : Begin
              result.IdType:=ActiveToolId;
              l:=Result.Left;
              t:=Result.Top;
              r:=Result.Right;
              b:=Result.Bottom;
              idd:=-1;
              re:=VPPToDB(idd,l,t,Round(Abs(t-b)),map_type,-1);
              If VarIsNull(re) Then Begin
                Result.Free;
                Result:=nil
              end
              Else Begin
                result.Tag:=idd;
                result.Properties:=re;
                Tsquare(result).style.DataItems.add(VPP_drow);
                Tsquare(result).style.DataItems.add(VPP_nam(re[1],20,5));
              end;
            end;
        7 : if (map_type=3) Then Begin
              Result.Free;
              Result:=nil
            end
            Else Begin
              result.IdType:=ActiveToolId;
              l:=Result.Left;
              t:=Result.Top;
              r:=Result.Right;
              b:=Result.Bottom;
              idd:=-1;
              re:=VRPToDB(idd,l,t,Round(Abs(t-b)),map_type,-1);
              If VarIsNull(re) Then Begin
                Result.Free;
                Result:=nil
              end
              Else Begin
                result.Tag:=idd;
                result.Properties:=re;
                Tsquare(result).style.DataItems.add(VRP_drow);
                Tsquare(result).style.DataItems.add(VPP_nam(re[1],20,5));
              end;
            end;
        8 : if (map_type<>3) Then Begin
              Result.Free;
              Result:=nil
            end
            Else Begin
              result.IdType:=ActiveToolId;
              l:=Result.Left;
              t:=Result.Top;
              idd:=-1;
              re:=WellToDB(idd,l,t,iidd,true);
              If VarIsNull(re) Then Begin
                Result.Free;
                Result:=nil
              end
              Else Begin
                result.Tag:=idd;
                result.Properties:=re;
                Tsquare(result).style.DataItems.add(Well_drow);
                Tsquare(result).style.DataItems.add(VPP_nam(re[1],-20,-20));
              end;
            end;
        9 : if (map_type<>1) Then Begin
              Result.Free;
              Result:=nil
            end
            Else Begin
              result.IdType:=ActiveToolId;
              l:=Result.Left;
              t:=Result.Top;
              r:=Result.Right;
              b:=Result.Bottom;
              idd:=-1;
              re:=KustToDB(idd, l, t, r, b);
              If VarIsNull(re) Then Begin
                Result.Free;
                Result:=nil
              end
              Else Begin
                result.Tag:=idd;
                result.Properties:=re;
                Tsquare(result).style.DataItems.add(Kust_drow);
                Tsquare(result).style.DataItems.add(Kust_name('К №'+IntToStr(re[0])+re[2]));
              end;
            end;
        12 : Begin
               pp:=FieldMain.FindObject(p);
               If pp is TLine Then Exit;
               idd:=-1;
               DM.StartTrans;
               If map_type<2 Then pl:=map_type Else pl:=iidd;
               re:=UnitToDB(idd,p.x,p.y,pl);
               If not VarisNull(re) Then Begin
                 If DM.StateDB=0 Then Exit;
                 b1:=Tround(ShowUsel(p,idd,nil,re[0]));
                 //If pp is TSquare Then pp.Connections.add(b1.Handles[0]);
                 b1.Properties:=re;
                 DM.ComTrans;
               end
               Else DM.BackTrans;
             end;
        13 : Begin
               result.IdType:=ActiveToolId;
               nn:=0;//Ask_Integer('Номер примитива','Введите число от 0 до 5',0);
               Tsquare(result).style.DataItems.add(Draw_drow(nn));
             end;
   end;
end;

Function Tfr_main.NS_drow : Tdcdrawitem;
Begin
    Result:=Tdcdrawitem.create;
    Result.brush.style:=bsSolid;
    Result.pen.color:=clblack;
    Result.pen.style:=psdash;
    Result.pen.Width:=1;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    Result.Shape:=diRectangle;
    Result.Brush.Color:=clWhite;
end;

Function Tfr_main.NS_name(name : string) : TDcdataitem;
Begin
    Result:=TDcdataitem.create;
    Result.brush.style:=bsClear;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    Result.Data:=name;
    Result.Alignment:=tacenter;
    Result.Font.Color:=clNavy;
    Result.Font.size:=18;
end;

Function Tfr_main.KNS_drow(is_stok : integer) : Tdcdrawitem;
Begin
    Result:=Tdcdrawitem.create;
    Result.brush.style:=bsSolid;
    Result.pen.color:=clblack;
    Result.pen.style:=psSolid;
    Result.pen.Width:=1;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    If is_stok=0 Then {КНС}Result.brush.Color:=clAqua
    Else {Сток}Result.brush.Color:=clTeal;
    Result.Shape:=diRectangle;
end;

Function Tfr_main.KNS_name(name : string; is_stok : integer) : TDcdataitem;
Begin
    Result:=TDcdataitem.create;
    Result.brush.style:=bsClear;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    Result.Data:=name;
    Result.Alignment:=tacenter;
    If is_stok=0 Then {КНС}Result.Font.Color:=clblack
    Else {Сток}Result.Font.Color:=clWhite;
    Result.Font.size:=24;
end;

Function Tfr_main.Kust_name(name : string) : TDcdataitem;
Begin
    Result:=TDcdataitem.create;
    Result.brush.style:=bsClear;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    Result.Data:=name;
    Result.Height:=-2;
    Result.Alignment:=tacenter;
    Result.Font.Color:=clNavy;
    Result.Font.size:=12;
    Result.Font.Style:=[fsBold];
end;

Function Tfr_main.Kust_drow : Tdcdrawitem;
Begin
    Result:=Tdcdrawitem.create;
    Result.brush.style:=bsSolid;
    //Result.brush.style:=bsBDiagonal;
    //Result.brush.style:=bsDiagCross;
    Result.pen.color:=clGreen;
    //Result.pen.color:=clNavy;
    Result.pen.style:=psSolid;
    Result.pen.Width:=1;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    Result.Shape:=diRectangle;
    //Result.Brush.Color:=clWhite;
    //Result.Brush.Color:=clGreen;
    Result.Brush.Color:=8912800;
end;

Function Tfr_main.VPP_drow : TDcdataitem;
Begin
    Result:=TDcdataitem.create;
    Result.brush.style:=bsSolid;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    Result.Brush.Color:=clGray;
    Result.Data:='';
    Result.Alignment:=taLeftJustify;
    Result.Font.Color:=clYellow;
    Result.Font.size:=16;
end;

Function Tfr_main.VPP_nam(name : string;x,y : integer) : TDcdataitem;
Begin
    Result:=TDcdataitem.create;
    Result.brush.style:=bsClear;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=hanone;
    Result.VertAlign:=vanone;
    Result.Left:=x;
    Result.Top:=y;
    Result.Width:=90;
    Result.Height:=20;
    Result.Data:=name;
    Result.Alignment:=taLeftJustify;
    Result.Font.Color:=clNavy;
    Result.Font.Height:=15;
    //Result.Font.size:=9;
end;

Function Tfr_main.Uz_nam(name : string) : TDcdataitem;
Begin
    Result:=TDcdataitem.create;
    Result.brush.style:=bsClear;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=hanone;
    Result.VertAlign:=vanone;
    Result.Left:=-15;
    Result.Top:=-13;
    Result.Width:=90;
    Result.Height:=15;
    Result.Data:=name;
    Result.Alignment:=taLeftJustify;
    Result.Font.Color:=clRed;
    Result.Font.Height:=12;
    //Result.Font.size:=9;
end;

Function Tfr_main.VRP_drow : TDcdataitem;
Begin
    Result:=TDcdataitem.create;
    Result.brush.style:=bsSolid;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    Result.Brush.Color:=clBlue;
    Result.Data:='';
    Result.Alignment:=taLeftJustify;
    Result.Font.Color:=clblack;
    Result.Font.size:=16;
end;

Function Tfr_main.Well_drow : Tdcdrawitem;
Begin
    Result:=Tdcdrawitem.create;
    Result.Shape:=diEllipse;
    //Result.Brush.color:=clgreen;
    Result.Brush.color:=clBlue;
    Result.brush.style:=bsSolid;
    Result.pen.color:=clblack;
    Result.pen.style:=psdash;
    Result.pen.Width:=1;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
end;

Function Tfr_main.Draw_drow(idx : integer) : Tdcdrawitem;
Begin
    Result:=Tdcdrawitem.create;
    Result.brush.style:=bsClear;
    Result.pen.color:=clblack;
    Result.pen.style:=psdash;
    Result.pen.Width:=2;
    Result.coordmode:=cmvalue;
    Result.HorzAlign:=haboth;
    Result.VertAlign:=vaboth;
    //Result.Brush.Color:=clBlue;
    CASE idx of
      0 : Result.Shape:=diRoundRect;
      1 : Result.Shape:=diRectangle;
      2 : Result.Shape:=diEllipse;
      3 : Result.Shape:=diDiamond;
      4 : Result.Shape:=diLine;
      5 : Result.Shape:=diCustom;
    end;
end;

Function Tfr_main.FindUselXY(P : TLongPoint) : TMyObject;
var
  ii,vcount : integer;
  RO, O : TMyObject;
Begin
  Result:=nil;
  vcount:=FieldMain.Vertices.Count;
  For ii:=0 To vcount-1 Do Begin
      O := FieldMain.Vertices.Items[ii] ;
      RO := O.HitAt(P);
      if (RO <> nil)and((RO.ObjectType=otHandle)or(RO.ObjectType=otRound)) then begin
            Result := RO ;
            Exit;
            Break;
      end;
  end;
end;

Function Tfr_main.GetUselFromHandle(ob:TMyObject):TMyObject;
var
  hd : TMyHandle;
  bb : TMyObject;
  co, ii : integer;
Begin
  Result:=nil;
  try
    If ob.ObjectType=otHandle Then Begin
      hd:=TMyHandle(ob);
      co:=hd.Connections.Count;
      ii:=0;
      bb:=hd.Connections.Items[0];
      While ((co-1)>=ii)and(bb.IdType<>12) Do Begin
        Inc(ii);
        bb:=hd.Connections.Items[ii];
      end;
      If bb.IdType=12 Then Result:=bb;
     end; 
  except
  end;
end;

Function Tfr_main.GetUselIdFromHandle(ob:TMyObject):Integer;
var
  bb : TMyObject;
Begin
  Result:=-1;
  bb:=nil;
  bb:=GetUselFromHandle(ob);
  If bb<>nil Then Result:=bb.Tag;
end;

Function Tfr_main.SetUnit(ob : TMyObject;P: TLongPoint) : TMyObject;
var
   u1,ii,co,pl : integer;
   po : Tlongpoint;
   b1 : Tround;
   re : variant;
   hd : TMyHandle;
   bb : TMyObject;
Begin
  Result:=nil;
  u1:=-1;
  If ob.IdType=0 Then Begin
   bb:=GetUselFromHandle(ob);
   If bb<>nil Then Begin
       Result:=SetUnit(bb,p);
       Exit;
   end;
  end;

  CASE ob.IdType of
       12 : Begin
              Result:=Tround(ob).Handles[0];
            end;
    6,7,8 : Begin
              If map_type<2 Then pl:=map_type Else pl:=iidd;
              re:=UnitToDB(u1,p.x,p.y,pl);
              If DM.StateDB=0 Then Exit;
              If VarIsNull(re) Then Exit;
              b1:=Tround(ShowUsel(p,u1,ob,re[0]));
              b1.Properties:=re;
              u1:=ConnectUnitToObj(ob,p,pl);
              If u1>0 Then Begin
                 ob.Connections.add(b1.Handles[0]);
                 Result:=b1.Handles[0];
              end
              Else Exit;
            end;
       else Exit;
  end;
end;

Function Tfr_main.ChangeLineElementsDbUsels(u1,u2,ii:integer;tbn:string) : integer;
var
   par,pp : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=51;
   par[1]:=VarArrayOf(['u1','u2','ob','!tab']);
   par[2]:=VarArrayOf([u1,u2,ii,tbn]);
   pp:=DM.RSQL(par);
   Result:=pp;
end;

function Tfr_main.iLineCreateEdge(Sender: TObject; Source,
  Target: TMyObject; StartP, EndP: TLongPoint): TCustomEdge;
var
   re,par,pp : variant;
   idd,c_s,u1,u2,obj_id : integer;
   ad : TAdjacent;
   p:Tlongpoint;
   ss,tt : TMyObject;
   b1,b2 : Tround;
   adj : TAdjacent;
begin
  Result:=nil;
  if not ch_can_move.Checked Then Exit;
  ss:=Source;
  tt:=Target;
  If map_type>1 Then obj_id:=iidd Else obj_id:=-1;
  Case ActiveToolId of
     10 : Begin
            idd:=-1;
            try
            DM.StartTrans;
            u1:=GetUselIdFromHandle(Source);
            If u1<0 Then u1:=bu1;
            u2:=GetUselIdFromHandle(Target);
            If u2<0 Then u2:=bu2;
            re:=CatchToDB(idd,c_s,u1,u2,map_type,obj_id,true);
            If VarIsNull(re) Then DM.BackTrans
            Else If DM.StateDB=1 Then Begin
                ss:=SetUnit(ss,startp);
                If ss=nil Then Begin
                   DM.BackTrans;
                   Exit;
                end;
                tt:=SetUnit(tt,endp);
                If tt=nil Then Begin
                   DM.BackTrans;
                   Exit;
                end;
                If (u1=bu1) or (u2=bu2) Then Begin
                   If u1=bu1 Then u1:=GetUselIdFromHandle(ss);
                   If u2=bu2 Then u2:=GetUselIdFromHandle(tt);
                   pp:=ChangeLineElementsDbUsels(u1,u2,idd,'catch');
                   If pp<>0 Then Begin
                     DM.BackTrans;
                     Exit;
                   end;
                end;
                result:=TLine.Create(ss,tt,startp,endp,'',iLib);
                Tline(result).TypeItem:=TpChange;
                Tline(result).IdType:=ActiveToolId;
                result.Tag:=idd;
                Case c_s of
                  0 :  Tline(result).ChangeState:=stNone;
                  1 :  Tline(result).ChangeState:=stLeft;
                  2 :  Tline(result).ChangeState:=stBoth;
                end;
                result.Properties:=re;
                If (re[0]=' ')or(re[0]='ЗД') Then Tline(result).Style.Data := ''
                Else Tline(result).Style.Data := re[0]; {IntToStr(idd)}
                Tline(result).Style.TextBoxFont.Height:=15;
                adj:=Tline(result).TextBox.First;
                adj.Y:=adj.Y-30;
                adj.X:=adj.X+30;
                adj.MinScale:=0.6;
                Tline(result).Style.Visible := true;
                DM.ComTrans;
            end;
            except
              DM.BackTrans;
            end;
          end;
     4  : Begin
            //Tmyhandle(result.Handles[1]).handletype:=htedgeTargetfree;
            idd:=-1;
            try
            DM.StartTrans;
            u1:=GetUselIdFromHandle(Source);
            If u1<0 Then u1:=bu1;
            u2:=GetUselIdFromHandle(Target);
            If u2<0 Then u2:=bu2;
            re:=PipeToDB(idd, u1, u2, map_type, obj_id, null,true);
            If VarIsNull(re) Then DM.BackTrans
            Else If DM.StateDB=1 Then Begin
                ss:=SetUnit(ss,startp);
                If ss=nil Then Begin
                   DM.BackTrans;
                   Exit;
                end;
                tt:=SetUnit(tt,endp);
                If tt=nil Then Begin
                   DM.BackTrans;
                   Exit;
                end;
                If (u1=bu1) or (u2=bu2) Then Begin
                   If u1=bu1 Then u1:=GetUselIdFromHandle(ss);
                   If u2=bu2 Then u2:=GetUselIdFromHandle(tt);
                   pp:=ChangeLineElementsDbUsels(u1,u2,idd,'pipe');
                   If pp<>0 Then Begin
                     DM.BackTrans;
                     Exit;
                   end;
                end;
                result:=TLine.Create(ss,tt,startp,endp,'',iLib);
                Tline(result).IdType:=ActiveToolId;
                result.Tag:=idd;
                result.Properties:=re;
                Tline(result).Style.Pen.Color:=re[8];
                Tline(result).Style.Pen.Width:=2;
                If (re[2]=' ')or(re[2]='ВВ') Then Tline(result).Style.Data := ''
                Else Tline(result).Style.Data := re[2]; {IntToStr(idd)}
                Tline(result).Style.TextBoxFont.Height:=15;
                adj:=Tline(result).TextBox.First;
                adj.Y:=adj.Y-20;
                adj.X:=adj.X+40;
                adj.MinScale:=0.6;
                tline(result).Style.Visible := true;
                DM.ComTrans;
                {ad:=Tadjacent.create(result,p);
                ad.Text:='RRRRR';
                Tline(result).textbox.add(ad);}

            end;
            except
              DM.BackTrans;
            end;
          end;
     5  : If (map_type=2)or(map_type=4) Then Begin
            idd:=-1;
            try
            DM.StartTrans;
            u1:=GetUselIdFromHandle(Source);
            If u1<0 Then u1:=bu1;
            u2:=GetUselIdFromHandle(Target);
            If u2<0 Then u2:=bu2;
            re:=PumpToDB(idd,u1,u2,map_type,obj_id,true);
            If VarIsNull(re) Then DM.BackTrans
            Else If DM.StateDB=1 Then Begin
                ss:=SetUnit(ss,startp);
                If ss=nil Then Begin
                   DM.BackTrans;
                   Exit;
                end;
                tt:=SetUnit(tt,endp);
                If tt=nil Then Begin
                   DM.BackTrans;
                   Exit;
                end;
                If (u1=bu1) or (u2=bu2) Then Begin
                   If u1=bu1 Then u1:=GetUselIdFromHandle(ss);
                   If u2=bu2 Then u2:=GetUselIdFromHandle(tt);
                   pp:=ChangeLineElementsDbUsels(u1,u2,idd,'pump');
                   If pp<>0 Then Begin
                     DM.BackTrans;
                     Exit;
                   end;
                end;
                result:=TLine.Create(ss,tt,startp,endp,'',iLib);
                Tline(result).TypeItem:=TpFigure;
                Tline(result).IdType:=ActiveToolId;
                result.Properties:=re;
                result.Tag:=idd;
                Tline(result).Style.Data := re[7]; {IntToStr(idd)}
                Tline(result).Style.TextBoxFont.Height:=15;
                adj:=Tline(result).TextBox.First;
                adj.Y:=adj.Y-20;
                adj.X:=adj.X+40;
                adj.MinScale:=0.6;
                Tline(result).Style.Visible := true;
                Case re[3] of
                   0 :  Tline(result).Style.Pen.Color:=clBlack;
                   1 :  Tline(result).Style.Pen.Color:=clBlue;
                   2 :  Tline(result).Style.Pen.Color:=clRed;
                end;
                DM.ComTrans;
            end;
            except
              DM.BackTrans;
            end;
          end;
  end;
end;

procedure Tfr_main.ed_zoomChange(Sender: TObject);
begin
   FieldMain.scale:=round(ed_zoom.value);
end;

procedure Tfr_main.FieldMainScaleChange(Mode: TScaleChange;
  var NewScale: Integer);
begin
  If NewScale<1 Then NewScale:=1;
  If NewScale>160 Then NewScale:=160;
  scrolField.HorzScrollBar.Range:=Round(FieldW*NewScale/100);
  scrolField.VertScrollBar.Range:=Round(FieldH*NewScale/100);
  if NewScale<50 Then FieldMain.ShowPrinterPage:=true;
  if NewScale>50 Then FieldMain.ShowPrinterPage:=false;
  if NewScale<50 Then FieldMain.ShowGrid:=false;
  if NewScale>50 Then FieldMain.ShowGrid:=true;
  if can_change_zoom=1 Then ed_zoom.Value:=NewScale;
  can_change_zoom:=0;
end;

procedure Tfr_main.iZoomClick(Sender: TObject);
begin
  can_change_zoom:=1;
end;

procedure Tfr_main.iZoomRightClick(Sender: TObject);
begin
  can_change_zoom:=1;
end;

Procedure Tfr_main.DelSelectedTipe(tipe, sqln, ern : integer; namepar : string);
var
  ii, cc, idd, tip : integer;
  ob : TMyObject;
  par,pp,dd : variant;
Begin
    par:=VarArrayCreate([0, 2], varVariant);
    cc:=FieldMain.Selection.Count;
    If cc>0 Then Begin
      dd:=VarArrayCreate([0, cc], varVariant);
      For ii:=0 To cc-1 Do Begin
        ob:=FieldMain.Selection.Items[ii];
        tip:=ob.IdType;
        idd:=ob.Tag;
        dd[ii]:=null;
        If (tip=tipe) Then Begin
           par[0]:=sqln;
           par[1]:=VarArrayOf([namepar]);
           par[2]:=VarArrayOf([idd]);
           cod_err:=ern;
           DM.StartTrans;
           pp:=DM.RunSQL(par);
           If pp<>0 Then DM.BackTrans
           Else Begin
             dd[ii]:=ii;
             DM.ComTrans;
           end;
        end;
      end;
      For ii:=cc-1 DownTo 0 Do
          If dd[ii]=ii Then
             FieldMain.DeleteObject(FieldMain.Selection.Items[ii],dcProgram);
    end;
end;

procedure Tfr_main.n_delete_elementClick(Sender: TObject);
var
  ii, cc, tip, idd : integer;
  ob : TMyObject;
  par,pp,dd : variant;
begin
  cc:=FieldMain.Selection.Count;
  If MessageDlg('Удалить выделенные элементы?', mtWarning, [mbYes, mbNo], 0) = mrYes Then Begin
    FieldMain.ImmediateRedraw:=true;
    // Удаляем водоводы
    DelSelectedTipe(4, 64, 40, 'pipe');
    // Удаляем задвижки
    DelSelectedTipe(10, 65, 42, 'catch');
    // Удаляем насосы
    DelSelectedTipe(5, 93, 41, 'pump');
    // Удаляем скважины
    DelSelectedTipe(8, 99, 50, 'well');
    // Удаляем ВПП
    CASE map_type of
      0,2 : DelSelectedTipe(6, 66, 43, 'vpp');
      1,3 : DelSelectedTipe(6, 67, 44, 'vpp');
        4 : DelSelectedTipe(6, 74, 52, 'vpp');
    end;
    // Удаляем ВРП
    CASE map_type of
      0,4 : DelSelectedTipe(7, 68, 45, 'vrp');
      1,2 : DelSelectedTipe(7, 69, 46, 'vrp');
    end;
    // Удаляем узлы
    DelSelectedTipe(12, 118, 51, 'u');
    // Удаляем кусты скважин
    DelSelectedTipe(9, 82, 49, 'kust');
    // Удаляем КНС (Стоки)
    DelSelectedTipe(1, 70, 47, 'kns');
    // Удаляем НС
    DelSelectedTipe(2, 71, 48, 'ns');
    //удаляем остальное
    //FieldMain.DeleteSelectedObjects(dcProgram);
    bt_ed_el.Enabled:=false;
    bt_del_el.Enabled:=false;
  end;
  FieldMain.Repaint;
end;

procedure Tfr_main.iEditRightClick(Sender: TObject);
var
  mm : TMouse;
  ss : TSquare;
  cc,ii : integer;
  ob : TMyObject;
begin
  n_add_unit_to_result.Visible:=false;
  n_add_pipe_to_select.Visible:=false;
  n_set_catch_press.Visible:=false;
  n_set_unit_memory.Visible:=false;
  cc:=FieldMain.Selection.Count;
  If cc=1 Then Begin
     ob:=FieldMain.Selection.Items[0];
     If ob.IdType=12 Then Begin
        n_add_unit_to_result.Visible:=true;
        n_set_unit_memory.Visible:=true;
     end;
     If ob.IdType=4 Then n_add_pipe_to_select.Visible:=true;
     If (id_tek_uz>0) and (ob.IdType=10) Then n_set_catch_press.Visible:=true;
  end;
  mm:=TMouse.Create;
  mn_elems.Popup(mm.CursorPos.x,mm.CursorPos.y);
  mm.free;
  (sender as teditactor).mode := amMultiSelect;
end;

procedure Tfr_main.n_edit_atrClick(Sender: TObject);
var
  ii, cc, tip, idd, c_s, obj_id, co, pl : integer;
  ob,bb : TMyObject;
  hd : Tmyhandle;
  sq : TSquare;
  tl : TLine;
  rd : Tround;
  re,uu,u1 : variant;
  p, p1 : TLongPoint;
begin
  cc:=FieldMain.Selection.Count;
  If cc>1 Then Begin
     MessageDlg('Операция не возможна! Выделено более одного объекта!',mtWarning, [mbOk], 0);
     Exit;
  end
  Else If cc=0 Then Begin
     MessageDlg('Операция не возможна! Не выделено ни одного объекта!',mtWarning, [mbOk], 0);
     Exit;
  end;
  ob:=FieldMain.Selection.Items[0];
  If map_type>1 Then obj_id:=iidd Else obj_id:=-1;
  tip:=ob.IdType;
  idd:=ob.Tag;
  Case tip of
    1 : Begin //КНС
          sq:=FieldMain.Selection.Items[0];
          re:=KNSToDB(idd, sq.Left, sq.Top, sq.Right, sq.Bottom, true);
          If VarIsNull(re) Then Exit
          Else ob.Properties:=re;
          If re[6]=0 Then {КНС}TDCDrawItem(sq.Style.DataItems.Items[0]).brush.Color:=clAqua
          Else {Сток}TDCDrawItem(sq.Style.DataItems.Items[0]).brush.Color:=clTeal;
          TDCDataItem(sq.Style.DataItems.Items[1]).Data:=re[1];
        end;
    2 : Begin  //НС
          sq:=FieldMain.Selection.Items[0];
          re:=NSToDB(idd, sq.Left, sq.Top, sq.Right, sq.Bottom, true);
          If VarIsNull(re) Then Exit
          Else ob.Properties:=re;
          TDCDataItem(sq.Style.DataItems.Items[1]).Data:=re[1];
        end;
    6 : Begin  // ВПП
          sq:=FieldMain.Selection.Items[0];
          re:=VPPToDB(idd, sq.Left, sq.Top, Round(Abs(sq.Top-sq.Bottom)),map_type,obj_id);
          If VarIsNull(re) Then Exit;
          ob.Properties:=re;
          TDCDataItem(sq.Style.DataItems.Items[1]).Data:=re[1];
        end;
    7 : Begin  // ВРП
          sq:=FieldMain.Selection.Items[0];
          re:=VRPToDB(idd, sq.Left, sq.Top, Round(Abs(sq.Top-sq.Bottom)),map_type,obj_id);
          If VarIsNull(re) Then Exit;
          ob.Properties:=re;
          TDCDataItem(sq.Style.DataItems.Items[1]).Data:=re[1];
        end;
    8 : Begin // скважинa
          sq:=FieldMain.Selection.Items[0];
          re:=WellToDB(idd, sq.Left, sq.Top, iidd,true);
          If VarIsNull(re) Then Exit;
          ob.Properties:=re;
          TDCDataItem(sq.Style.DataItems.Items[1]).Data:=re[1];
        end;
    9 : Begin // Куст скважин
          sq:=FieldMain.Selection.Items[0];
          re:=KustToDB(idd, sq.Left, sq.Top, sq.Right, sq.Bottom);
          If VarIsNull(re) Then Exit
          Else ob.Properties:=re;
          TDCDataItem(sq.Style.DataItems.Items[1]).Data:='К №'+IntToStr(re[0])++re[2];
        end;
   12 : Begin // Узел
          rd:=FieldMain.Selection.Items[0];
          hd:=rd.Handles.Items[0];
          DM.StartTrans;
          If map_type<2 Then pl:=map_type Else pl:=iidd;
          re:=UnitToDB(idd,hd.X,hd.y,pl);
          If VarIsNull(re) Then Begin
             DM.BackTrans;
             Exit;
          end;
          ob.Properties:=re;
          If rd.Style.DataItems.Count=0 Then rd.style.DataItems.add(Uz_nam(re[0]))
          Else TDCDataItem(rd.Style.DataItems.Items[0]).Data:=re[0];
          DM.ComTrans;
        end;
    0 : If ob.ObjectType=otHandle Then Begin
           hd:=TMyHandle(ob);
           co:=hd.Connections.Count;
           ii:=0;
           bb:=hd.Connections.Items[0];
           While ((co-1)>=ii)and(bb.IdType<>12) Do Begin
               Inc(ii);
               bb:=hd.Connections.Items[ii];
           end;
           If bb.IdType=12 Then Begin
              idd:=bb.tag;
              rd:=TRound(bb);
              DM.StartTrans;
              If map_type<2 Then pl:=map_type Else pl:=iidd;
              re:=UnitToDB(idd,hd.X,hd.y,pl);
              If VarIsNull(re) Then Begin
                 DM.BackTrans;
                 Exit;
              end;
              ob.Properties:=re;
              If rd.Style.DataItems.Count=0 Then rd.style.DataItems.add(Uz_nam(re[0]))
              Else TDCDataItem(rd.Style.DataItems.Items[0]).Data:=re[0];
              DM.ComTrans;
           end;
        end;
    4 : Begin // Водовод НД
          tl:=FieldMain.Selection.Items[0];
          c_s:=tl.Handles.Count;
          uu:=null;
          If c_s>2 Then Begin
             uu:=VarArrayCreate([0,1], varVariant);
             u1:=VarArrayCreate([0,c_s-2], varVariant);
             For ii:=1 To c_s-1 Do Begin
               hd:=tl.Handles[ii];
               u1[ii-1]:=hd.X;
             end;
             uu[0]:=u1;
             For ii:=1 To c_s-1 Do Begin
               hd:=tl.Handles[ii];
               u1[ii-1]:=hd.Y;
             end;
             uu[1]:=u1;
          end;
          DM.StartTrans;
          re:=PipeToDB(idd, 1, 2, map_type, obj_id, uu, true);
          If VarIsNull(re) Then Begin
            DM.BackTrans;
            Exit;
          end;
          tl.Properties:=re;
          If (re[2]=' ')or(re[2]='ВВ') Then tl.Style.Data := ''
          Else tl.Style.Data := re[2];
          tl.Style.Pen.Color:=re[8];
          DM.ComTrans;
        end;
   10 : Begin // Задвижка
          tl:=FieldMain.Selection.Items[0];
          DM.StartTrans;
          re:=CatchToDB(idd,c_s,1,2,map_type,obj_id,true);
          If VarIsNull(re) Then Begin
            DM.BackTrans;
            Exit;
          end;
          Case c_s of
            0 :  tl.ChangeState:=stNone;
            1 :  tl.ChangeState:=stLeft;
            2 :  tl.ChangeState:=stBoth;
          end;
          tl.Properties:=re;
          If (re[0]=' ')or(re[0]='ЗД') Then tl.Style.Data := ''
          Else tl.Style.Data := re[0];
          DM.ComTrans;
        end;
    5 : Begin // Насос
          tl:=FieldMain.Selection.Items[0];
          DM.StartTrans;
          re:=PumpToDB(idd,1,2,map_type,obj_id,true);
          If VarIsNull(re) Then Begin
            DM.BackTrans;
            Exit;
          end;
          tl.Style.Data := re[7];
          Case re[3] of
             0 :  tl.Style.Pen.Color:=clBlack;
             1 :  tl.Style.Pen.Color:=clBlue;
             2 :  tl.Style.Pen.Color:=clRed;
          end;
          tl.Properties:=re;
          DM.ComTrans;
        end;
  end;
  FieldMain.Repaint;
end;

Function Tfr_main.ShowVPP(id : integer) : Boolean;
Var
 par,pp : variant;
 p,p1 : TLongPoint;
 qw : TSquare;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par[1]:=null; //имена
  par[2]:=null; //значения
  CASE map_type of
     0 : Begin
           par[0]:=31;
         end;
     1 : Begin
           par[0]:=42;
         end;
     2 : Begin
           par:=VarArrayCreate([0, 3], varVariant);
           par[0]:=31;
           par[1]:=VararrayOf(['spr']); //имена
           par[2]:=VararrayOf([id]); //значения
           par[3]:=VararrayOf(['com']);
         end;
     3 : Begin
           par:=VarArrayCreate([0, 3], varVariant);
           par[0]:=42;
           par[1]:=VararrayOf(['spr']); //имена
           par[2]:=VararrayOf([id]); //значения
           par[3]:=VararrayOf(['com']);
         end;
     4 : Begin
           par[0]:=92;
           par[1]:=VararrayOf(['ns']); //имена
           par[2]:=VararrayOf([id]);
         end;
  end;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Begin
     Exit;
  end;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    //iSquare.InsertComponent();
    p.X:=DM.cds_tmp.FieldByName('x').AsInteger;
    p.Y:=DM.cds_tmp.FieldByName('y').AsInteger;
    qw:=TSquare.Create(p,'',iLib,10,DM.cds_tmp.FieldByName('len').AsInteger);
    qw.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    qw.IdType:=6;
    Tsquare(qw).style.DataItems.add(VPP_drow);
    Tsquare(qw).style.DataItems.add(VPP_nam(DM.cds_tmp.FieldByName('name').AsString,20,5));
    FieldMain.AddObject(qw,dcProgram);
    DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowVRP(id : integer) : Boolean;
Var
 par,pp : variant;
 p,p1 : TLongPoint;
 qw : TSquare;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par[1]:=null; //имена
  par[2]:=null; //значения
  CASE map_type of
     0 : Begin
           par[0]:=36;
         end;
     1 : Begin
           par[0]:=41;
         end;
     2 : Begin
           par:=VarArrayCreate([0, 3], varVariant);
           par[0]:=41;
           par[1]:=VararrayOf(['spr']); //имена
           par[2]:=VararrayOf([id]); //значения
           par[3]:=VararrayOf(['com']);
         end;
     3 : Begin
           Result:=true;
           Exit;
         end;
     4 : Begin
           par:=VarArrayCreate([0, 3], varVariant);
           par[0]:=36;
           par[1]:=VararrayOf(['spr']); //имена
           par[2]:=VararrayOf([id]); //значения
           par[3]:=VararrayOf(['com']);
         end;
  end;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Begin
     Exit;
  end;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    //iSquare.InsertComponent();
    p.X:=DM.cds_tmp.FieldByName('x').AsInteger;
    p.Y:=DM.cds_tmp.FieldByName('y').AsInteger;
    qw:=TSquare.Create(p,'',iLib,10,DM.cds_tmp.FieldByName('len').AsInteger);
    qw.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    qw.IdType:=7;
    qw.MinScale:=0;
    Tsquare(qw).style.DataItems.add(VRP_drow);
    Tsquare(qw).style.DataItems.add(VPP_nam(DM.cds_tmp.FieldByName('name').AsString,20,5));
    FieldMain.AddObject(qw,dcProgram);
    DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowKNS : Boolean;
Var
 par,pp,prr : variant;
 p,p1 : TLongPoint;
 qw : TSquare;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par[0]:=25;
  par[1]:=null; //имена
  par[2]:=null; //значения
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Begin
     Exit;
  end;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    //iSquare.InsertComponent();
    p.X:=DM.cds_tmp.FieldByName('up_x').AsInteger;
    p.Y:=DM.cds_tmp.FieldByName('up_y').AsInteger;
    p1.x:=Round(ABS(p.X-DM.cds_tmp.FieldByName('b_x').AsInteger));
    p1.y:=Round(ABS(p.y-DM.cds_tmp.FieldByName('b_y').AsInteger));
    qw:=TSquare.Create(p,'',iLib,p1.x,p1.y);
    qw.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    qw.IdType:=1;
    prr:=VarArrayCreate([0, 7], varVariant);
    prr[0]:=DM.cds_tmp.FieldByName('shop_id').AsInteger;
    prr[1]:=DM.cds_tmp.FieldByName('name').AsString;
    prr[2]:=DM.cds_tmp.FieldByName('loss_pressure').AsFloat;
    prr[3]:=DM.cds_tmp.FieldByName('days_debet').AsFloat;
    prr[4]:=DM.cds_tmp.FieldByName('stok_pressure').AsFloat;
    prr[5]:=DM.cds_tmp.FieldByName('d_stok').AsFloat;
    prr[6]:=DM.cds_tmp.FieldByName('is_stok').AsInteger;
    prr[7]:=DM.cds_tmp.FieldByName('deposit_id').AsInteger;
    qw.Properties:=prr;
    Tsquare(qw).style.DataItems.add(KNS_drow(DM.cds_tmp.FieldByName('is_stok').AsInteger));
    Tsquare(qw).style.DataItems.add(KNS_name(DM.cds_tmp.FieldByName('name').AsString,DM.cds_tmp.FieldByName('is_stok').AsInteger));
    qw.Hint:='КНС';
    FieldMain.AddObject(qw,dcProgram);
    DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowNS : Boolean;
Var
 par,pp,prr : variant;
 p,p1 : TLongPoint;
 qw : TSquare;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par[0]:=24;
  par[1]:=null; //имена
  par[2]:=null; //значения
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Begin
     Exit;
  end;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    //iSquare.InsertComponent();
    p.X:=DM.cds_tmp.FieldByName('up_x').AsInteger;
    p.Y:=DM.cds_tmp.FieldByName('up_y').AsInteger;
    p1.x:=Round(ABS(p.X-DM.cds_tmp.FieldByName('b_x').AsInteger));
    p1.y:=Round(ABS(p.y-DM.cds_tmp.FieldByName('b_y').AsInteger));
    qw:=TSquare.Create(p,'',iLib,p1.x,p1.y);
    qw.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    qw.IdType:=2;
    prr:=VarArrayCreate([0, 4], varVariant);
    prr[0]:=DM.cds_tmp.FieldByName('shop_id').Asinteger;
    prr[1]:=DM.cds_tmp.FieldByName('name').AsString;
    prr[2]:=DM.cds_tmp.FieldByName('loss_pressure').Asfloat;
    prr[3]:=DM.cds_tmp.FieldByName('days_debet').AsFloat;
    prr[4]:=DM.cds_tmp.FieldByName('deposit_id').AsInteger;
    qw.Properties:=prr;
    Tsquare(qw).style.DataItems.add(NS_drow);
    Tsquare(qw).style.DataItems.add(NS_name(DM.cds_tmp.FieldByName('Name').AsString));
    qw.Hint:='НС';
    FieldMain.AddObject(qw,dcProgram);
    DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowKust : Boolean;
Var
 par,pp,prr : variant;
 p,p1 : TLongPoint;
 qw : TSquare;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par[0]:=28;
  par[1]:=null; //имена
  par[2]:=null; //значения
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Begin
     Exit;
  end;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    //iSquare.InsertComponent();
    p.X:=DM.cds_tmp.FieldByName('up_x').AsInteger;
    p.Y:=DM.cds_tmp.FieldByName('up_y').AsInteger;
    p1.x:=Round(ABS(p.X-DM.cds_tmp.FieldByName('b_x').AsInteger));
    p1.y:=Round(ABS(p.y-DM.cds_tmp.FieldByName('b_y').AsInteger));
    qw:=TSquare.Create(p,'',iLib,p1.x,p1.y);
    qw.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    qw.IdType:=9;
    prr:=VarArrayCreate([0, 4], varVariant);
    prr[0]:=DM.cds_tmp.FieldByName('nomer').AsInteger;
    prr[1]:=DM.cds_tmp.FieldByName('kns_id').AsInteger;
    prr[2]:=DM.cds_tmp.FieldByName('lastname').AsString;
    prr[3]:=DM.cds_tmp.FieldByName('shop_id').AsString;
    prr[4]:=DM.cds_tmp.FieldByName('deposit_id').AsString;
    qw.Properties:=prr;
    Tsquare(qw).style.DataItems.add(Kust_drow);
    Tsquare(qw).style.DataItems.add(Kust_name('К №'+DM.cds_tmp.FieldByName('name').AsString));
    FieldMain.AddObject(qw,dcProgram);
    DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowWell(id : integer) : Boolean;
Var
 par,pp,prr : variant;
 p,p1 : TLongPoint;
 qw : TSquare;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par[0]:=91;
  par[1]:=VarArrayOf(['kust']); //имена
  par[2]:=VarArrayOf([id]); //значения
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Begin
     Exit;
  end;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    //iSquare.InsertComponent();
    p.X:=DM.cds_tmp.FieldByName('x').AsInteger;
    p.Y:=DM.cds_tmp.FieldByName('y').AsInteger;
    p1.x:=30;
    p1.y:=30;
    qw:=TSquare.Create(p,'',iLib,p1.x,p1.y);
    qw.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    qw.IdType:=8;
    prr:=VarArrayCreate([0, 5], varVariant);
    prr[0]:=DM.cds_tmp.FieldByName('found_state_id').AsInteger;
    prr[1]:=DM.cds_tmp.FieldByName('nomer').AsString;
    prr[2]:=0;
    prr[3]:=DM.cds_tmp.FieldByName('d_shtucer').AsFloat;
    prr[4]:=DM.cds_tmp.FieldByName('day_pump').AsString;
    prr[5]:=DM.cds_tmp.FieldByName('name').AsString;
    qw.Properties:=prr;
    Tsquare(qw).style.DataItems.add(Well_drow);
    Tsquare(qw).style.DataItems.add(VPP_nam('Скв. №'+DM.cds_tmp.FieldByName('nomer').AsString,-20,-20));
    FieldMain.AddObject(qw,dcProgram);
    DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowCatch(id : integer) : Boolean;
Var
 par,pp,prr,cx,cy : variant;
 p,p1,p2 : TLongPoint;
 lll : TLine;
 ad1, ad2 : TMyObject;
 b1 : Tround;
 adj : TAdjacent;
 nm,un1,un2 : string;
 ttp : integer;
label ICanTBeliveIt;
Begin
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par:=VarArrayCreate([0, 3], varVariant);
  par[0]:=40;
  par[3]:=null;
  If map_type>1 Then Begin
     par[3]:=VarArrayOf(['com']);
     par[1]:=VarArrayOf(['shem','spr','!k']); //имена
  end
  Else Begin
     par[1]:=VarArrayOf(['shem']); //имена
     par[2]:=VarArrayOf([map_type]); //значения
  end;
  CASE map_type of
    2 : Begin
          par[2]:=VarArrayOf([map_type,id,'kns']); //значения
        end;
    3 : Begin
          par[2]:=VarArrayOf([map_type,id,'kust']); //значения
        end;
    4 : Begin
          par[2]:=VarArrayOf([map_type,id,'ns']); //значения
        end;
  end;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    p.X:=DM.cds_tmp.FieldByName('bx').AsInteger;
    p.y:=DM.cds_tmp.FieldByName('b_y').AsInteger;
    p1.X:=DM.cds_tmp.FieldByName('ex').AsInteger;
    p1.y:=DM.cds_tmp.FieldByName('ey').AsInteger;
    un1:=DM.cds_tmp.FieldByName('un1').AsString;
    un2:=DM.cds_tmp.FieldByName('un2').AsString;
    ad1:=FieldMain.FindObject(p);
    ad1:=SetUsel(ad1,p,DM.cds_tmp.FieldByName('connect_unit_id1').AsInteger,un1);
    if ad1=nil Then Begin
       ad1:=FindUselXY(p);
       ad1:=SetUsel(ad1,p,DM.cds_tmp.FieldByName('connect_unit_id1').AsInteger,un1);
       if ad1=nil Then GoTo ICanTBeliveIt;
    end;
    ad2:=FieldMain.FindObject(p1);
    ad2:=SetUsel(ad2,p1,DM.cds_tmp.FieldByName('connect_unit_id2').AsInteger,un2);
    if ad2=nil Then Begin
       ad2:=FindUselXY(p1);
       ad2:=SetUsel(ad2,p1,DM.cds_tmp.FieldByName('connect_unit_id2').AsInteger,un2);
       if ad2=nil Then GoTo ICanTBeliveIt;
    end;
    lll:=TLine.Create(ad1,ad2,p,p1,'',iLib);
    lll.IdType:=10;
    Tline(lll).TypeItem:=TpChange;
    lll.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    Case DM.cds_tmp.FieldByName('state').AsInteger of
        0 :  Tline(lll).ChangeState:=stNone;
        1 :  Tline(lll).ChangeState:=stLeft;
        2 :  Tline(lll).ChangeState:=stBoth;
    end;
    ttp:=-1;
    If not VarIsNull(DM.cds_tmp.FieldByName('kns_id').Value) Then ttp:=0;
    If not VarIsNull(DM.cds_tmp.FieldByName('kust_id').Value) Then ttp:=2;
    If not VarIsNull(DM.cds_tmp.FieldByName('ns_id').Value) Then ttp:=1;
    nm:=DM.cds_tmp.FieldByName('name').AsString;
    prr:=VarArrayCreate([0, 8], varVariant);
    prr[0]:=DM.cds_tmp.FieldByName('name').AsString;
    prr[1]:=DM.cds_tmp.FieldByName('setting').AsString;
    prr[2]:=DM.cds_tmp.FieldByName('state').AsInteger;
    prr[3]:=DM.cds_tmp.FieldByName('diametr').AsFloat;
    prr[4]:=DM.cds_tmp.FieldByName('bolt_open').AsFloat;
    prr[5]:=ttp;
    Case ttp of
      0 : prr[6]:=DM.cds_tmp.FieldByName('kns_id').Value;
      1 : prr[6]:=DM.cds_tmp.FieldByName('kust_id').Value;
      2 : prr[6]:=DM.cds_tmp.FieldByName('ns_id').Value;
    end;
    prr[7]:=DM.cds_tmp.FieldByName('shop_id').AsInteger;
    prr[8]:=DM.cds_tmp.FieldByName('deposit_id').AsInteger;
    lll.Properties:=prr;
    If (nm='ЗД')or(nm=' ') Then lll.Style.Data := ''
    Else Begin
       lll.Style.Data:=nm;
       lll.Style.TextBoxFont.Height:=15;
       adj:=lll.TextBox.First;
       cx:=DM.cds_tmp.FieldByName('cx').Value;
       cy:=DM.cds_tmp.FieldByName('cy').Value;
       If VarIsNull(cx) or VarIsNull(cy) Then Begin
          adj.Y:=adj.Y-30;
          adj.X:=adj.X+30;
       end
       Else Begin
          adj.Y:=Integer(cy);
          adj.X:=Integer(cx);
       end;
       adj.MinScale:=0.6;
       lll.Style.Visible := true;
    end;
    FieldMain.AddObject(lll,dcProgram);
ICanTBeliveIt : DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowUsel(P: TLongPoint;id : integer; ow : TMyObject;unam : string) : TMyObject;
var
   b1 : Tround;
   nam : string;
Begin
  //po.x:=p.x{-8};
  //po.y:=p.y{-8};
  b1:=Tround.create(p,'SmallR',iLib,ow,10,10);
  bbb:=b1;
  b1.radius:=8;
  b1.IdType:=12;
  b1.Tag:=id;
  //nam:=DM.GetUnitName(id);
  nam:=unam;
  //If nam='' Then nam:='id('+IntToStr(id)+')';
  If nam<>'' Then b1.style.DataItems.add(Uz_nam(nam));
  FieldMain.AddObject(b1,dcProgram);
  Result:=b1;
end;

Function Tfr_main.SetUsel(ob : TMyObject;P: TLongPoint;id : integer;Unam : string) : TMyObject;
var
   po : Tlongpoint;
   b1 : Tround;
   hd : TMyHandle;
   co,ii : integer;
   bb : TMyObject;
Begin
  Result:=nil;
  If ob=nil Then Begin
     b1:=Tround(ShowUsel(p,id,nil,unam));
     Result:=b1.Handles[0];
     Exit;
  end;

  If ob.IdType=0 Then Begin
   bb:=GetUselFromHandle(ob);
   If bb<>nil  Then Begin
       Result:=SetUsel(bb,p,id,unam);
       Exit;
    end;
  end;

  CASE ob.IdType of
       12 : Begin
              Result:=Tround(ob).Handles[0];
            end;
    6,7,8 : Begin
              b1:=Tround(ShowUsel(p,id,ob,unam));
              ob.Connections.add(b1.Handles[0]);
              Result:=b1.Handles[0];
            end;
       else Exit;
  end;
end;

Function Tfr_main.ShowPipe(id : integer) : Boolean;
Var
 par,pp,prr,cx,cy : variant;
 p,p1,p2 : TLongPoint;
 lll : TLine;
 ad1, ad2 : TMyObject;
 b1 : Tround;
 kz : integer;
 MyHandle : TmyHandle;
 adj : TAdjacent;
 nm,un1,un2 : string;
label ICanTBeliveIt;
Begin
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  If map_type<2 Then Begin
            par[0]:=48;
            par[1]:=VarArrayOf(['plan']); //имена
            par[2]:=VarArrayOf([map_type]); //значения
  end
  Else Begin
    par[0]:=77;
    par[1]:=VarArrayOf(['plan','!k','spr']); //имена
    CASE map_type of
      2 : par[2]:=VarArrayOf([map_type,'kns',id]); //значения
      3 : par[2]:=VarArrayOf([map_type,'kust',id]); //значения
      4 : par[2]:=VarArrayOf([map_type,'ns',id]); //значения
    end;
  end;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    p.X:=DM.cds_tmp.FieldByName('bx').AsInteger;
    p.y:=DM.cds_tmp.FieldByName('b_y').AsInteger;
    p1.X:=DM.cds_tmp.FieldByName('ex').AsInteger;
    p1.y:=DM.cds_tmp.FieldByName('ey').AsInteger;
    un1:=DM.cds_tmp.FieldByName('un1').AsString;
    un2:=DM.cds_tmp.FieldByName('un2').AsString;
    ad1:=FieldMain.FindObject(p);
    ad1:=SetUsel(ad1,p,DM.cds_tmp.FieldByName('connect_unit_id1').AsInteger,un1);
    if ad1=nil Then Begin
       ad1:=FindUselXY(p);
       ad1:=SetUsel(ad1,p,DM.cds_tmp.FieldByName('connect_unit_id1').AsInteger,un1);
       if ad1=nil Then GoTo ICanTBeliveIt;
    end;

    ad2:=FieldMain.FindObject(p1);
    ad2:=SetUsel(ad2,p1,DM.cds_tmp.FieldByName('connect_unit_id2').AsInteger,un2);
    if ad2=nil Then Begin
       ad2:=FindUselXY(p1);
       ad2:=SetUsel(ad2,p1,DM.cds_tmp.FieldByName('connect_unit_id2').AsInteger,un2);
       if ad2=nil Then GoTo ICanTBeliveIt;
    end;

    lll:=TLine.Create(ad1,ad2,p,p1,'',iLib);
    lll.IdType:=4;
    lll.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    lll.Style.Pen.Color:=DM.cds_tmp.FieldByName('color').AsInteger;
    prr:=VarArrayCreate([0, 11], varVariant);
    prr[0]:=DM.cds_tmp.FieldByName('direction_id').AsInteger;
    prr[1]:=DM.cds_tmp.FieldByName('pipe_type_id').AsInteger;
    prr[2]:=DM.cds_tmp.FieldByName('name').AsString;
    prr[3]:=DM.cds_tmp.FieldByName('len').AsFloat;
    prr[4]:=DM.cds_tmp.FieldByName('diametr').AsInteger;
    prr[5]:=DM.cds_tmp.FieldByName('thick').AsFloat;
    prr[6]:=DM.cds_tmp.FieldByName('build_year').AsInteger;
    prr[7]:=DM.cds_tmp.FieldByName('k_lock_res').AsInteger;
    prr[8]:=DM.cds_tmp.FieldByName('color').AsInteger;
    prr[9]:=DM.cds_tmp.FieldByName('directname').AsString;
    prr[10]:=DM.cds_tmp.FieldByName('shop_id').AsInteger;
    prr[11]:=DM.cds_tmp.FieldByName('deposit_id').AsInteger;
    lll.Properties:=prr;
    // Count break points
    kz:=DM.cds_tmp.FieldByName('kz').AsInteger;
    If kz>0 Then Begin
       par[0]:=55;
       par[1]:=VarArrayOf(['pipe']); //имена
       par[2]:=VarArrayOf([lll.Tag]); //значения
       DM.cds_work.Data:=DM.GetData(par);
       While not DM.cds_work.EOF Do Begin
          p1.X:=DM.cds_work.FieldByName('x').AsInteger;
          p1.Y:=DM.cds_work.FieldByName('y').AsInteger;
          MyHandle:=TmyHandle.create(lll,p1,htEdge);
          lll.Handles.insert(lll.Handles.Count-1,MyHandle);
          DM.cds_work.next;
       end;
    end;
    nm:=DM.cds_tmp.FieldByName('name').AsString;
    If (nm='ВВ')or(nm=' ') Then lll.Style.Data := ''
    Else Begin
         lll.Style.Data:=nm;
         lll.Style.TextBoxFont.Height:=15;
         adj:=lll.TextBox.First;
         cx:=DM.cds_tmp.FieldByName('cx').Value;
         cy:=DM.cds_tmp.FieldByName('cy').Value;
         If VarIsNull(cx) or VarIsNull(cy) Then Begin
          adj.Y:=adj.Y-30;
          adj.X:=adj.X+40;
         end
         Else Begin
          adj.Y:=Integer(cy);
          adj.X:=Integer(cx);
         end;
         adj.MinScale:=0.6;
         adj.EdgeHandle.Moveby(dcpoint(1,1));
         lll.Style.Visible := true;
    end;
    lll.Style.Pen.Width:=2;
    FieldMain.AddObject(lll,dcProgram);
ICanTBeliveIt :  DM.cds_tmp.Next;
  end;
  Result:=true;
end;

Function Tfr_main.ShowPump(id : integer) : Boolean;
Var
 par,pp,cx,cy,prr : variant;
 p,p1,p2 : TLongPoint;
 lll : TLine;
 ad1, ad2 : TMyObject;
 b1 : Tround;
 adj : TAdjacent;
 un1,un2 : string;
label ICanTBeliveIt;
Begin
  Result:=false;
  If DM.cds_tmp.Active Then DM.cds_tmp.Active:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=86;
  par[1]:=VarArrayOf(['obj','!k']); //имена
  CASE map_type of
    2 : par[2]:=VarArrayOf([id,'kns_id']); //значения
    4 : par[2]:=VarArrayOf([id,'ns_id']); //значения
  end;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
    p.X:=DM.cds_tmp.FieldByName('b_x').AsInteger;
    p.y:=DM.cds_tmp.FieldByName('b_y').AsInteger;
    p1.X:=DM.cds_tmp.FieldByName('x').AsInteger;
    p1.y:=DM.cds_tmp.FieldByName('y').AsInteger;
    un1:=DM.cds_tmp.FieldByName('un1').AsString;
    un2:=DM.cds_tmp.FieldByName('un2').AsString;
    ad1:=FieldMain.FindObject(p);
    ad1:=SetUsel(ad1,p,DM.cds_tmp.FieldByName('connect_unit_id1').AsInteger,un1);
    if ad1=nil Then Begin
       ad1:=FindUselXY(p);
       ad1:=SetUsel(ad1,p,DM.cds_tmp.FieldByName('connect_unit_id1').AsInteger,un1);
       if ad1=nil Then GoTo ICanTBeliveIt;
    end;
    ad2:=FieldMain.FindObject(p1);
    ad2:=SetUsel(ad2,p1,DM.cds_tmp.FieldByName('connect_unit_id2').AsInteger,un2);
    if ad2=nil Then Begin
       ad2:=FindUselXY(p1);
       ad2:=SetUsel(ad2,p1,DM.cds_tmp.FieldByName('connect_unit_id2').AsInteger,un2);
       if ad2=nil Then GoTo ICanTBeliveIt;
    end;
    lll:=TLine.Create(ad1,ad2,p,p1,'',iLib);
    lll.IdType:=5;
    Tline(lll).TypeItem:=TpFigure;
    lll.Tag:=DM.cds_tmp.FieldByName('id').AsInteger;
    Case DM.cds_tmp.FieldByName('state').AsInteger of
        0 :  lll.Style.Pen.Color:=clBlack;
        1 :  lll.Style.Pen.Color:=clBlue;
        2 :  lll.Style.Pen.Color:=clRed;
    end;
    lll.Style.Data := DM.cds_tmp.FieldByName('name').AsString;
    //lll.Style.Data := DM.cds_tmp.FieldByName('id').AsString;
    prr:=VarArrayCreate([0, 9], varVariant);
    If not VarIsNull(DM.cds_tmp.FieldByName('kns_id').Value) Then
       prr[0]:=DM.cds_tmp.FieldByName('kns_id').AsInteger
    Else prr[0]:=DM.cds_tmp.FieldByName('ns_id').AsInteger;

    prr[1]:=DM.cds_tmp.FieldByName('pump_type_id').AsInteger;
    prr[7]:=DM.cds_tmp.FieldByName('name').AsString;
    prr[2]:=DM.cds_tmp.FieldByName('pressure').AsFloat;
    prr[3]:=DM.cds_tmp.FieldByName('state').AsInteger;
    prr[4]:=DM.cds_tmp.FieldByName('wheel_count').AsInteger;
    prr[5]:=DM.cds_tmp.FieldByName('flow').AsInteger;
    prr[6]:=DM.cds_tmp.FieldByName('workflow').AsFloat;
    prr[8]:=DM.cds_tmp.FieldByName('regim').AsInteger;
    prr[9]:=DM.cds_tmp.FieldByName('tname').AsString;
    lll.Properties:=prr;
    
    lll.Style.TextBoxFont.Height:=15;
    adj:=lll.TextBox.First;
    cx:=DM.cds_tmp.FieldByName('cx').Value;
    cy:=DM.cds_tmp.FieldByName('cy').Value;
    If VarIsNull(cx) or VarIsNull(cy) Then Begin
       adj.Y:=adj.Y-20;
       adj.X:=adj.X+40;
    end
    Else Begin
      adj.Y:=Integer(cy);
      adj.X:=Integer(cx);
    end;
    adj.MinScale:=0.6;
    lll.Style.Visible := true;
    FieldMain.AddObject(lll,dcProgram);
ICanTBeliveIt : DM.cds_tmp.Next;
  end;
  Result:=true;
end;

procedure Tfr_main.n_deselectClick(Sender: TObject);
begin
  FieldMain.DeSelectAll;
end;

Function Tfr_main.ConnectUnitToObj(ob : TMyObject;P: TLongPoint;pl : integer) : integer;
var
  obj_id,uz : integer;
  par,pp : variant;
Begin
   Result:=-1;
   obj_id:=ob.Tag;
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=112;
   par[1]:=VarArrayOf(['x','y','pl']); //имена
   par[2]:=VarArrayOf([p.x,p.y,pl]);
   pp:=DM.GetTehData(par);
   If not VarIsNull(pp) Then Begin
    uz:=pp;
    Result:=uz;
    Case ob.IdType of
       6 : ConnectUnitToVPP(obj_id,uz);
       7 : ConnectUnitToVRP(obj_id,uz);
       8 : ConnectUnitToWell(obj_id,uz);
    end;
   end;
end;

Procedure Tfr_main.ConnectUnitToVPP(id,uz : integer);
var
  par,pp : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=110;
  par[1]:=VarArrayOf(['u','obj','!tab','!field']);
  CASE map_type of
     0,2 : Begin //КНС
             par[2]:=VarArrayOf([uz,id,'vpp_unit','vpp_id']);
           end;
     1,3 : Begin //Куст
             par[2]:=VarArrayOf([uz,id,'kust_unit','vpp_kust_id']);
           end;
       4 : Begin //НС
             par[2]:=VarArrayOf([uz,id,'vpp_ns_unit','vpp_ns_id']);
           end;
  end;
   cod_err:=202;
   pp:=DM.RunSQL(par);
   If pp<>0 Then Begin
      DM.BackTrans;
      Exit;
   end;
end;

Procedure Tfr_main.ConnectUnitToVRP(id,uz : integer);
var
  par,pp : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=110;
  par[1]:=VarArrayOf(['u','obj','!tab','!field']);
  CASE map_type of
     0,4 : Begin //НС
             par[2]:=VarArrayOf([uz,id,'ns_unit','ns_vrp_id']);
           end;
     1,2 : Begin //КНС
             par[2]:=VarArrayOf([uz,id,'vrp_unit','vrp_id']);
           end;
  end;
   cod_err:=201;
   pp:=DM.RunSQL(par);
   If pp<>0 Then Begin
      DM.BackTrans;
      Exit;
   end;
end;

Procedure Tfr_main.ConnectUnitToWell(id,uz : integer);
var
  par,pp : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=110;
   par[1]:=VarArrayOf(['u','obj','!tab','!field']); //имена
   par[2]:=VarArrayOf([uz,id,'well_unit','well_id']);
   cod_err:=200;
   pp:=DM.RunSQL(par);
   If pp<>0 Then Begin
      DM.BackTrans;
      Exit;
   end;
end;

procedure Tfr_main.n_calc_basikClick(Sender: TObject);
var
 rre : boolean;
begin
  StatusBar1.Panels.Items[1].Text:='Идет расчет модели';
  rre:=DM.DoCalc;
  If rre Then Begin
      ShowMessage('Расчеты произведены!');
      StatusBar1.Panels.Items[1].Text:='Расчет модели выполнен';
      isCalcOk:=true;
  end
  Else Begin
      isCalcOk:=false;
      StatusBar1.Panels.Items[1].Text:='Расчет модели не проводился';
  end;

  //diagram2.Vertices;
  //diagram2.Edges;

end;

procedure Tfr_main.n_pump_planClick(Sender: TObject);
begin
  DoPumpPlan;
end;

procedure Tfr_main.n_Agr_to_ExelClick(Sender: TObject);
begin
  If isCalcOk Then DoPumpCalcToExel
  Else ShowMessage('Сначала необходимо выполнить расчет модели!');
end;

procedure Tfr_main.n_explorerClick(Sender: TObject);
begin
  ShowResExplorer;
end;

procedure Tfr_main.n_add_unit_to_resultClick(Sender: TObject);
var
  ob : TMyObject;
  ids : string;
begin
  ob:=FieldMain.Selection.Items[0];
  If ob.Tag<=0 Then Exit;
  ids:=IntToStr(ob.Tag);
  If ob.IdType=12 Then ChengingUnits.Add(ids);
end;

procedure Tfr_main.n_press_unitsClick(Sender: TObject);
begin
  If isCalcOk Then ShowUnitsPress
  Else ShowMessage('Сначала необходимо выполнить расчет модели!');
end;

procedure Tfr_main.ch_show_previewClick(Sender: TObject);
begin
  Priview.Active:=ch_show_preview.Checked;
  If not Priview.Active Then Priview.Hide
  Else Priview.Show;
end;

Procedure Tfr_main.SetPropUnitsPlan;
var
  par,pp,rrr : variant;
  id,cc,ii : integer;
Begin
  FieldMain.SelectAll;
  par:=VarArrayCreate([0, 2], varVariant);
  rrr:=VarArrayCreate([0, 3], varVariant);
  try
    cc:=FieldMain.Selection.Count;
    For ii:=0 To cc-1 Do
    If TMyObject(FieldMain.Selection.Items[ii]).IdType=12 Then Begin
       id:=TMyObject(FieldMain.Selection.Items[ii]).Tag;
       par[0]:=111;
       par[1]:=VarArrayOf(['u']);
       par[2]:=VarArrayOf([id]);
       DM.cds_tmp.Active:=false;
       pp:=DM.GetData(par);
       If not VarIsNull(pp) Then Begin
          DM.cds_tmp.Data:=pp;
          If DM.cds_tmp.RecordCount>0 Then Begin
             rrr[0]:=DM.cds_tmp.FieldByName('NAME').Value;
             rrr[1]:=DM.cds_tmp.FieldByName('PRESSURE').Value;
             rrr[2]:=DM.cds_tmp.FieldByName('IS_BALANS').Value;
             rrr[3]:=DM.cds_tmp.FieldByName('HIGHT').Value;
             TMyObject(FieldMain.Selection.Items[ii]).Properties:=rrr;
          end;
          DM.cds_tmp.Active:=false;
       end;
    end;
  finally
    FieldMain.DeSelectAll;
  end;
end;

Function Tfr_main.GetUnitProp(id : integer) : variant;
var
  par,pp,rrr : variant;
Begin
  Result:=null;
  par:=VarArrayCreate([0, 2], varVariant);
  rrr:=VarArrayCreate([0, 3], varVariant);
  par[0]:=111;
  par[1]:=VarArrayOf(['u']);
  par[2]:=VarArrayOf([id]);
  DM.cds_tmp.Active:=false;
  pp:=DM.GetData(par);
  If not VarIsNull(pp) Then Begin
     DM.cds_tmp.Data:=pp;
     If DM.cds_tmp.RecordCount>0 Then Begin
        rrr[0]:=DM.cds_tmp.FieldByName('NAME').Value;
        rrr[1]:=DM.cds_tmp.FieldByName('PRESSURE').Value;
        rrr[2]:=DM.cds_tmp.FieldByName('IS_BALANS').Value;
        rrr[3]:=DM.cds_tmp.FieldByName('HIGHT').Value;
        Result:=rrr;
     end;
     DM.cds_tmp.Active:=false;
  end;
end;

Procedure Tfr_main.SetUnitsPlan;
var
  par,pp : variant;
  pl,id,cc,ii : integer;
begin
  FieldMain.SelectAll;
  try
    If map_type<2 Then pl:=map_type Else pl:=iidd;
    par:=VarArrayCreate([0, 2], varVariant);
    par[0]:=132;
    par[1]:=VarArrayOf(['uz','pl']); //имена
    DM.StartTrans;
    cc:=FieldMain.Selection.Count;
    For ii:=0 To cc-1 Do
    If TMyObject(FieldMain.Selection.Items[ii]).IdType=12 Then Begin
      id:=TMyObject(FieldMain.Selection.Items[ii]).Tag;
      par[2]:=VarArrayOf([id,pl]);
      cod_err:=200;
      pp:=DM.RunSQL(par);
      If pp<>0 Then Begin
        DM.BackTrans;
        Break;
      end;
    end;
    DM.ComTrans;
  finally
    FieldMain.DeSelectAll;
  end;
end;

Procedure Tfr_main.ClearUnits;
var
  par,pp : variant;
  rr : integer;
Begin
  // тут вставить секрет
  par:=VarArrayCreate([0, 3], varVariant);
  par[3]:=VarArrayOf(['com']);
  par[0]:=134;
  par[1]:=null;
  par[2]:=null;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  DM.cds_tmp.data:=pp;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=118;
  par[1]:=VarArrayOf(['u']);
  While not DM.cds_tmp.EOF Do Begin
     par[2]:=VarArrayOf([DM.cds_tmp.FieldByName('id').AsInteger]);
     DM.StartTrans;
     try
       rr:=DM.RSQL(par);
       If rr=0 Then DM.ComTrans
       Else DM.BackTrans;
     except
       DM.BackTrans;
     end;
     DM.cds_tmp.Next;
  end;
end;

procedure Tfr_main.n_saveClick(Sender: TObject);
begin
  SaveSchem;
  FieldMain.DeSelectAll;
end;

procedure Tfr_main.n_reviewClick(Sender: TObject);
begin
  CASE map_type of
       0 : Begin
             bt_s1.Down:=false;
             bt_s1Click(Sender);
           end;
       1 : Begin
             bt_s2.Down:=false;
             bt_s2Click(Sender);
           end;
       2 : Begin
             //bt_s3.Down:=false;
             //bt_s3Click(Sender);
             set_kns_map(iidd);
           end;
       3 : Begin
             //bt_s4.Down:=false;
             //bt_s4Click(Sender);
             set_kust_map(iidd);
           end;
       4 : Begin
             //bt_s5.Down:=false;
             //bt_s4Click(Sender);
             set_ns_map(iidd);
           end;
  end;
end;

procedure Tfr_main.n_aboutClick(Sender: TObject);
begin
  AboutShow(vers);
end;

procedure Tfr_main.iEditClick(Sender: TObject);
var
  cc,id,tp,rr : integer;
  prr : variant;
  str : string;
begin
  cc:=FieldMain.Selection.Count;
  ls_elems_properties.Clear;
  bt_ed_el.Enabled:=false;
  bt_del_el.Enabled:=false;
  If cc=1 Then Begin
     tp:=TMyObject(FieldMain.Selection.Items[0]).IdType;
     id:=TMyObject(FieldMain.Selection.Items[0]).Tag;
     prr:=TMyObject(FieldMain.Selection.Items[0]).Properties;
     If tp=1 Then Begin
        If (VarIsNull(prr))or(VarIsEmpty(prr)) Then Exit;
        If prr[6]=1 Then tp:=3;
     end;
     bt_ed_el.Enabled:=true;
     bt_del_el.Enabled:=true;
     fr_quick_result.ShowElRes(id,tp);
     If VarIsNull(prr) Then Exit;
     CASE tp of
          4 : Begin
                If VarArrayHighBound(prr,1)<11 Then Exit;
                ls_elems_properties.Items.Add('УЧАСТОК водовода:');
                ls_elems_properties.Items.Add('Длина '+FloatToStr(prr[3])+' м');
                ls_elems_properties.Items.Add('Толщина стенки '+FloatToStr(prr[5])+' мм');
                ls_elems_properties.Items.Add('Диаметр '+IntToStr(prr[4])+' мм');
                ls_elems_properties.Items.Add('Год строительства '+IntToStr(prr[6]));
                ls_elems_properties.Items.Add('К сопротивления '+IntToStr(prr[7]));
                If (prr[9]<>'')and(prr[9]<>' ')and(not VarIsNull(prr[9])) Then ls_elems_properties.Items.Add('Водовод: '+prr[9])
                Else ls_elems_properties.Items.Add('');
                str:=DM.GetShopName(prr[10]);
                ls_elems_properties.Items.Add(str);
                str:=DM.GetDepositName(prr[11]);
                ls_elems_properties.Items.Add('Месторождение: '+str);
                ls_elems_properties.Items.Add('ID '+IntToStr(id));
              end;
          5 : Begin
                ls_elems_properties.Items.Add('Насосный агрегат:');
                ls_elems_properties.Items.Add(' ');
                If VarArrayHighBound(prr,1)<9 Then Begin
                   ls_elems_properties.Items.Add('ID '+IntToStr(id));
                   Exit;
                end;
                ls_elems_properties.Items.Add(prr[9]);
                rr:=prr[3];
                CASE rr of
                  0 : ls_elems_properties.Items.Add('Сосотяние: в работе');
                  1 : ls_elems_properties.Items.Add('Сосотяние: в простое');
                  2 : ls_elems_properties.Items.Add('Сосотяние: в ремонте');
                end;
                rr:=prr[8];
                CASE rr of
                  0 : ls_elems_properties.Items.Add('Режим: на задвижку');
                  1 : ls_elems_properties.Items.Add('Режим: заданное давление');
                  2 : ls_elems_properties.Items.Add('Режим: заданная производительность');
                end;
                ls_elems_properties.Items.Add('Зд. давление '+FloatToStr(prr[2])+' атм');
                ls_elems_properties.Items.Add('Зд. произв. '+FloatToStr(prr[6])+' куб.м/ч');
                ls_elems_properties.Items.Add('Снижение пр. '+FloatToStr(prr[5])+' %');
                ls_elems_properties.Items.Add('ID '+IntToStr(id));
              end;
          8 : Begin
                If VarArrayHighBound(prr,1)<5 Then Exit;
                ls_elems_properties.Items.Add('Скважина:');
                ls_elems_properties.Items.Add('№ '+prr[1]);
                ls_elems_properties.Items.Add('Состояние по фонду:');
                ls_elems_properties.Items.Add(' '+prr[5]);
                ls_elems_properties.Items.Add('Штуцер '+FloatToStr(prr[3])+' мм.');
                ls_elems_properties.Items.Add('Суточное задание '+FloatToStr(prr[4])+' куб.м/сут.');
                ls_elems_properties.Items.Add('ID '+IntToStr(id));
              end;
          9 : Begin
                If VarArrayHighBound(prr,1)<4 Then Exit;
                ls_elems_properties.Items.Add('КУСТ скважин:');
                ls_elems_properties.Items.Add('№ '+String(prr[0])+' '+prr[2]);
                str:=DM.GetShopName(prr[3]);
                ls_elems_properties.Items.Add(str);
                str:=DM.GetDepositName(prr[4]);
                ls_elems_properties.Items.Add('Месторождение: '+str);
                str:=DM.GetKnsNsName(prr[1],null);
                ls_elems_properties.Items.Add(str);
                ls_elems_properties.Items.Add('ID '+IntToStr(id));
              end;
         10 : Begin
                If VarArrayHighBound(prr,1)<8 Then Exit;
                ls_elems_properties.Items.Add('ЗАДВИЖКА:');
                ls_elems_properties.Items.Add('Диаметр '+FloatToStr(prr[3])+' мм');
                ls_elems_properties.Items.Add('% открытия '+FloatToStr(prr[4]));
                If prr[1]<>'' Then ls_elems_properties.Items.Add('Назначение: '+prr[1])
                Else ls_elems_properties.Items.Add('');
                str:=DM.GetShopName(prr[7]);
                ls_elems_properties.Items.Add(str);
                str:=DM.GetDepositName(prr[8]);
                ls_elems_properties.Items.Add('Месторождение: '+str);
                ls_elems_properties.Items.Add('ID '+IntToStr(id));
              end;
         12 : Begin
                if (VarIsNull(prr))or(VarIsEmpty(prr)) Then Begin
                   prr:=GetUnitProp(id);
                   TMyObject(FieldMain.Selection.Items[0]).Properties:=prr;
                end;
                ls_elems_properties.Items.Add('УЗЕЛ:');
                If VarIsNull(prr[0]) Then prr[0]:='';
                ls_elems_properties.Items.Add(prr[0]);
                If prr[2]=1 Then ls_elems_properties.Items.Add('Давления в узле: '+String(prr[1])+' МПа');
                If prr[3]>0 Then ls_elems_properties.Items.Add('Высота узла: '+String(prr[3])+' м');
                ls_elems_properties.Items.Add('ID '+IntToStr(id));
              end;
     end;
  end
  Else If cc>1 Then bt_del_el.Enabled:=true;
end;

procedure Tfr_main.n_qresClick(Sender: TObject);
begin
  If not IsShow Then If isCalcOk Then ShowQRes;
end;

procedure Tfr_main.n_unit_free_delClick(Sender: TObject);
begin
  ClearUnits;
end;

Function Tfr_main.SetStateWell(well,state : integer; nomer : string; depth,d,d_p : real) : integer;
var
  par : variant;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=98;
  par[1]:=VarArrayOf(['state','nomer','depth','d','d_p','well']);
  par[2]:=VarArrayOf([state,nomer,depth,d,d_p,well]);
  Result:=DM.RSQL(par);
end;

Procedure Tfr_main.WellFromExcel(updat : boolean);
var
  exfn,ss,welln,mest,str,kname,pnam : string;
  ii,i2,le,ercount,stt : integer;
  par,pp,sl : variant;
  kpr,pr,pres : real;
  yep : boolean;
Begin
  exfn:='';
  mest:='';
  ercount:=0;
  kname:='';
  If op_file_dlg.Execute Then Begin
     exfn:=op_file_dlg.FileName;
     xl:=CreateOleObject('Excel.Application');
     xl.visible:=false;
     xl.application.workbooks.open(exfn);
     sheet:=xl.application.workbooks[1].worksheets[1];
     ii:=12;
     If updat Then InicResList('Загрузка параметров.','работа со скважинами')
     Else InicResList('Сверка данных','по скважинам');
     ss:=sheet.cells[12,1];
     fr_lstresult.AddErrorStr('Найденные ошибки:');
     While (ii<1000)and(ss<>'end') Do
      If ss<>'' Then Begin
         CASE ss[1] of
           '1','2','3','4','5','6','7','8','9','0' : Begin
              welln:=DelRSpace(ss);
              par:=VarArrayCreate([0, 2], varVariant);
              par[0]:=135;
              par[1]:=VarArrayOf(['!nom']);
              par[2]:=VarArrayOf([#39+welln+#39]);
              pp:=DM.GetData(par);
              If VarIsNull(pp) Then Exit;
              DM.cds_tmp.data:=pp;
              If DM.cds_tmp.RecordCount>0 Then Begin
                 yep:=false;
                 While (not DM.cds_tmp.Eof)and(not yep) Do Begin
                    If kname=DM.cds_tmp.FieldByName('BUSH').AsString Then yep:=true;
                    if not yep Then DM.cds_tmp.Next;
                 end;
                 If not yep Then Begin
                    // Нет в кусте скважины (в базе)
                    Inc(ercount);
                    str:='- Скважина '+welln+' не в том кусте! В файле: '+kname+' , а в базе: ';
                    DM.cds_tmp.first;
                    While not DM.cds_tmp.Eof Do Begin
                      str:=str+DM.cds_tmp.FieldByName('BUSH').AsString+', ';
                      DM.cds_tmp.Next;
                    end;
                    fr_lstresult.AddStr(str);
                    fr_lstresult.AddErrorStr(str);
                 end
                 Else Begin
                    // Скважина в кусте!
                    pnam:=string(sheet.cells[ii,2]);
                    fr_lstresult.AddStr('+ Скважина '+welln+' Найдена!');
                    If updat Then Begin
                       // Корректируем параметры скважины
                       stt:=Integer(sheet.cells[ii,29]);
                       DM.StartTrans;
                       If SetStateWell(DM.cds_tmp.FieldByName('ID').AsInteger,stt,welln,DM.cds_tmp.FieldByName('depth').AsFloat,real(sheet.cells[ii,6]),real(sheet.cells[ii,25]))<>0 Then Begin
                          Inc(ercount);
                          fr_lstresult.AddStr('Ошибка обновления скважины '+welln+' Куст: '+kname);
                          fr_lstresult.AddErrorStr('Ошибка обновления скважины '+welln+' Куст: '+kname);
                          DM.BackTrans;
                       end
                       Else Begin
                         DM.ComTrans;
                         fr_lstresult.AddStr('+ Состояние скважины '+welln+' обновлено!');
                       end;
                    end;
                    if (pnam='В целом') Then Begin
                       i2:=1;
                       While (string(sheet.cells[ii+i2,1])='')and(i2<10) Do Begin
                         // Перебираем слои
                         pnam:=string(sheet.cells[ii+i2,2]);
                         par[0]:=136;
                         par[1]:=VarArrayOf(['well','pnam']);
                         par[2]:=VarArrayOf([DM.cds_tmp.FieldByName('ID').AsInteger,pnam]);
                         pp:=DM.GetTehData(par);
                         If VarIsNull(pp) Then Begin
                           fr_lstresult.AddStr('- Пласт '+pnam+' для скважины '+welln+' не найден!');
                           fr_lstresult.AddErrorStr('- Пласт '+pnam+' для скважины '+welln+' не найден!');
                           Inc(ercount);
                         end
                         Else Begin
                           fr_lstresult.AddStr('+ Пласт '+pnam+' для скважины '+welln+' найден!');
                           pr:=real(sheet.cells[ii+i2,20]);
                           kpr:=real(sheet.cells[ii+i2,8])*9.82;
                           if (stt=1)and(pr=0) Then Begin
                              Inc(ercount);
                              fr_lstresult.AddStr('Ошибка! Нулевая приемистость скважины : '+welln+' Куст: '+kname);
                              fr_lstresult.AddErrorStr('Ошибка! Нулевая приемистость скважины : '+welln+' Куст: '+kname);
                           end;
                           If updat Then Begin
                              // Корректируем параметры пласта скважины
                              DM.StartTrans;
                              if (stt=1)and(pr=0) Then Begin
                                 stt:=2;
                                 kpr:=0;
                                 if SetStateWell(DM.cds_tmp.FieldByName('ID').AsInteger,stt,welln,DM.cds_tmp.FieldByName('depth').AsFloat,real(sheet.cells[ii,6]),real(sheet.cells[ii,25]))=0 Then
                                    fr_lstresult.AddStr(' Переводим скважину '+welln+' в ПРОСТОЙ!')
                                 Else Begin
                                      fr_lstresult.AddStr('- Не удалось перевести скважину '+welln+' в ПРОСТОЙ!');
                                      fr_lstresult.AddErrorStr('- Не удалось перевести скважину '+welln+' в ПРОСТОЙ!');
                                 end;
                              end;
                              if pr=0 Then pr:=149.9;
                              pres:=real(sheet.cells[ii+i2,22])/9.82;
                              par[0]:=107;
                              par[1]:=VarArrayOf(['k','a','pres','plast','well']);
                              par[2]:=VarArrayOf([kpr,pr,pres,pp[5],pp[0]]);
                              if DM.RSQL(par)<>0 Then Begin
                                 Inc(ercount);
                                 fr_lstresult.AddStr('- Ошибка обновления параметров пласта '+pnam+' для скважины '+welln+' !');
                                 fr_lstresult.AddErrorStr('- Ошибка обновления параметров пласта '+pnam+' для скважины '+welln+' !');
                              end
                              Else fr_lstresult.AddStr(' Параметры пласта '+pnam+' для скважины '+welln+' обновлены!');
                              DM.ComTrans;
                           end;
                         end;
                         Inc(i2);
                       end;
                    end
                    Else Begin
                       par[0]:=136;
                       par[1]:=VarArrayOf(['well','pnam']);
                       par[2]:=VarArrayOf([DM.cds_tmp.FieldByName('ID').AsInteger,pnam]);
                       pp:=DM.GetTehData(par);
                       If VarIsNull(pp) Then Begin
                          fr_lstresult.AddStr('- Пласт '+pnam+' для скважины '+welln+' не найден!');
                          fr_lstresult.AddErrorStr('- Пласт '+pnam+' для скважины '+welln+' не найден!');
                          Inc(ercount);
                       end
                       Else Begin
                          fr_lstresult.AddStr('+ Пласт '+pnam+' для скважины '+welln+' найден!');
                          try
                            pr:=real(sheet.cells[ii,20]);
                          except
                            pr:=0;
                          end;
                          kpr:=real(sheet.cells[ii,8])*9.82;
                          if (stt=1)and(pr=0) Then Begin
                              Inc(ercount);
                              fr_lstresult.AddStr('Ошибка! Нулевая приемистость скважины : '+welln+' Куст: '+kname);
                              fr_lstresult.AddErrorStr('Ошибка! Нулевая приемистость скважины : '+welln+' Куст: '+kname);
                          end;
                          If updat Then Begin
                              // Корректируем параметры пласта скважины
                              DM.StartTrans;
                              if (stt=1)and(pr=0) Then Begin
                                 stt:=2;
                                 kpr:=0;
                                 if SetStateWell(DM.cds_tmp.FieldByName('ID').AsInteger,stt,welln,DM.cds_tmp.FieldByName('depth').AsFloat,real(sheet.cells[ii,6]),real(sheet.cells[ii,25]))=0 Then
                                    fr_lstresult.AddStr(' Переводим скважину '+welln+' в ПРОСТОЙ!')
                                 Else Begin
                                    fr_lstresult.AddStr('- Не удалось перевести скважину '+welln+' в ПРОСТОЙ!');
                                    fr_lstresult.AddErrorStr('- Не удалось перевести скважину '+welln+' в ПРОСТОЙ!');
                                 end;
                              end;
                              if pr=0 Then pr:=149.9;
                              pres:=real(sheet.cells[ii,22])/9.82;
                              par[0]:=107;
                              par[1]:=VarArrayOf(['k','a','pres','plast','well']);
                              par[2]:=VarArrayOf([kpr,pr,pres,pp[5],pp[0]]);
                              if DM.RSQL(par)<>0 Then Begin
                                 Inc(ercount);
                                 fr_lstresult.AddStr('- Ошибка обновления параметров пласта '+pnam+' для скважины '+welln+' !');
                                 fr_lstresult.AddErrorStr('- Ошибка обновления параметров пласта '+pnam+' для скважины '+welln+' !');
                              end
                              Else fr_lstresult.AddStr(' Параметры пласта '+pnam+' для скважины '+welln+' обновлены!');
                              DM.ComTrans;
                           end;
                       end;
                    end;
                 end;
              end
              Else Begin
                 fr_lstresult.AddStr('- Скважина '+welln+' не найдена!');
                 fr_lstresult.AddErrorStr('- Скважина '+welln+' не найдена!');
                 Inc(ercount);
              end;
              DM.cds_tmp.Active:=false;
           end;
           Else Begin
             If Pos('Месторождение : ',ss)=1 Then Begin
                mest:=ss;
                Delete(mest,1,16);
                fr_lstresult.AddStr('+ '+ss);
             end;
             If Pos('КУСТ :',ss)=1 Then Begin
                kname:=ss;
                Delete(kname,1,6);
                kname:=DelRSpace(kname);
                fr_lstresult.AddStr('+ '+ss);
             end;
             If Pos('КНС :',ss)=1 Then fr_lstresult.AddStr('+ '+ss);
           end;
         end;
         Inc(ii);
         ss:=sheet.cells[ii,1];
         Application.ProcessMessages;
      end
      Else Begin
        Inc(ii);
        ss:=sheet.cells[ii,1];
      end;
     ShowMessage('Пройдено '+IntToStr(ii)+' строк! Ошибок : '+IntToStr(ercount));
     xl.visible:=true;
     xl.application.workbooks.Close;
     xl.application.Quit;
     xl.Quit;
  end;
end;

procedure Tfr_main.n_prot_well_excelClick(Sender: TObject);
begin
  WellFromExcel(false);
end;

procedure Tfr_main.n_update_well_from_excelClick(Sender: TObject);
begin
  WellFromExcel(true);
end;

procedure Tfr_main.tmr_findTimer(Sender: TObject);
begin
  If findList.Count>0 Then Begin
    Tmyobject(findList.Items[itemsShow]).visible := not Tmyobject(findList.Items[itemsShow]).visible;
    FieldMain.Repaint;
  end
  Else Begin
     tmr_find.enabled:=false;
  end;
end;

procedure Tfr_main.bt_doitClick(Sender: TObject);
var
  ii : integer;
  ob : Tmyobject;
  tpel : string;
begin
  // покажем что у нас выделино
  {If FieldMain.Selection.Count >0 Then Begin
     InicResList('Выделенные элементы схемы.','Список элементов.');
     fr_lstresult.AddStr('Выделино '+IntToStr(FieldMain.Selection.Count)+' элементов');
     For ii:=0 To FieldMain.Selection.Count-1 Do Begin
         ob:=FieldMain.Selection.Items[ii];
         If ob.Tag>0 Then Begin
           CASE ob.IdType of
                1 : tpel:='КНС';
                2 : tpel:='НС';
                4 : tpel:='водовод';
                5 : tpel:='НА';
                6 : tpel:='ВПП';
                7 : tpel:='ВРП';
                8 : tpel:='скважина';
                9 : tpel:='куст скважин';
               10 : tpel:='задвижка';
               12 : tpel:='узел';
           end;
           fr_lstresult.AddStr(IntToStr(ii)+') - Тип элемента '+IntToStr(ob.IdType)+'('+tpel+'), ID элемента '+IntToStr(ob.Tag));
         end;
     end;
  end; }

  // TESTS

  //DM.SetCalcYear (2000);
  ii:=DM.GetCalcYear;
  ShowMessage(IntToStr(ii));

end;

procedure Tfr_main.ch_can_moveClick(Sender: TObject);
begin
  If ch_can_move.Checked Then Begin
     if DM.SetEditMap=0 Then FieldMain.CanMove:=true
     Else MessageDlg('Схема занята на редактирование другим пользователем!', mtError,[mbOk], 0)
  end
  Else If FieldMain.CanMove Then Begin
     DM.SetEditMap;
     FieldMain.CanMove:=false;
  end;
end;

procedure Tfr_main.n_findClick(Sender: TObject);
begin
  ShowFindElementDlg;
end;

procedure Tfr_main.n_pipe_tr_showClick(Sender: TObject);
var
  pipe_count,ii,idd,clr,per : integer;
  ob : TMyObject;
  tip : integer;
  prop : variant;
  lll : TLine;
  pl : TStringList;
begin
  If isCalcOk Then Begin
    If fr_legend.Visible Then fr_legend.Hide;
    pipe_count:=FieldMain.Edges.Count;
    fr_legend.ClearList;
    fr_legend.AddItem(0,'Нет потока');
    fr_legend.AddItem(7995392,'Ламинарное');
    fr_legend.AddItem(65280,'Гладкое');
    fr_legend.AddItem(8026624,'Шероховатое');
    fr_legend.AddItem(255,'Вполне шероховатое');
    if pipe_count>0 Then Begin
      pl:=TStringList.Create;
      pl.Text:=DM.GetPeriodList;
      per:=Ask_Int('Период','Введите номер периода',1,pl.Count,1);
      pl.free;
      if per<1 Then Exit;
      screen.Cursor:=crHourGlass;
      try
      For ii:=0 To pipe_count-1 Do Begin
         ob:=FieldMain.Edges.Items[ii];
         tip:=ob.IdType;
         idd:=ob.Tag;
         If tip=4 Then Begin
            prop:=DM.GetResElementAll(idd, 4, 1);
            if not VarIsNull(prop) Then Begin
              clr:=StrToInt(prop[16]);
              CASE clr of
                0 : TLine(ob).Style.Pen.Color:=0;//Черный
                1 : TLine(ob).Style.Pen.Color:=7995392; //Синий
                2 : TLine(ob).Style.Pen.Color:=65280; //Зеленый
                3 : TLine(ob).Style.Pen.Color:=8026624; //Желтый
                4 : TLine(ob).Style.Pen.Color:=255; //Красный
              end;
              FieldMain.Repaint;
            end;
         end;
      end;
      finally
      screen.Cursor:=crDefault;
      end;
    end;
  end
  Else MessageDlg('Расчет не производился!', mtError,[mbOk], 0);
end;

procedure Tfr_main.n_pipe_v_showClick(Sender: TObject);
var
  pipe_count,ii,idd,per,i2 : integer;
  ob : TMyObject;
  tip : integer;
  prop,rs : variant;
  lll : TLine;
  clr : real;
  pl : TStringList;
begin
   If isCalcOk Then Begin
      If fr_legend.Visible Then fr_legend.Hide;
      pipe_count:=FieldMain.Edges.Count;
      fr_legend.ClearList;
      pl:=TStringList.Create;
      pl.Text:=DM.GetPeriodList;
      per:=Ask_Int('Период','Введите номер периода',1,pl.Count,1);
      pl.free;
      if per<1 Then Exit;
      rs:=fr_spd_pipe_color.GetSpeedColor(per);
      if VarIsNull(rs) Then Exit;
      fr_legend.AddItem(0,'V < '+FloatToStr(rs[1][0])+' м/с');
      fr_legend.AddItem(rs[1][1],'V >= '+FloatToStr(rs[1][0])+' м/с и V < '+FloatToStr(rs[2][0])+' м/с');
      fr_legend.AddItem(rs[2][1],'V >= '+FloatToStr(rs[2][0])+' м/с и V < '+FloatToStr(rs[3][0])+' м/с');
      fr_legend.AddItem(rs[3][1],'V >= '+FloatToStr(rs[3][0])+' м/с');
    if pipe_count>0 Then Begin
      screen.Cursor:=crHourGlass;
      try
      For ii:=0 To pipe_count-1 Do Begin
         ob:=FieldMain.Edges.Items[ii];
         tip:=ob.IdType;
         idd:=ob.Tag;
         If tip=4 Then Begin
            prop:=DM.GetResElementAll(idd, 4, 1);
            If not VarIsNull(prop) Then Begin
              clr:=StrToFloat(prop[5]);
              clr:=Abs(clr);
              for i2:=0 To 3 Do if clr>=rs[i2][0] Then TLine(ob).Style.Pen.Color:=rs[i2][1];
              FieldMain.Repaint;
            end;
         end;
      end;
      finally
      screen.Cursor:=crDefault;
      end;
    end;
   end
   Else MessageDlg('Расчет не производился!', mtError,[mbOk], 0);
end;

procedure Tfr_main.n_pipe_d_showClick(Sender: TObject);
var
  pipe_count,ii,idd,clr : integer;
  ob : TMyObject;
  tip : integer;
  prop : variant;
  lll : TLine;
begin
  If fr_legend.Visible Then fr_legend.Hide;
  pipe_count:=FieldMain.Edges.Count;
  if pipe_count>0 Then Begin
     For ii:=0 To pipe_count-1 Do Begin
         ob:=FieldMain.Edges.Items[ii];
         tip:=ob.IdType;
         idd:=ob.Tag;
         If tip=4 Then Begin
            prop:=ob.Properties;
            clr:=prop[8];
            TLine(ob).Style.Pen.Color:=clr;
            FieldMain.Repaint;
         end;
     end;
  end;
  fr_legend.ClearList;
  SetPipeDLegend;
end;

procedure Tfr_main.n_set_plan_workClick(Sender: TObject);
var
  tmp_plan : integer;
begin
  tmp_plan:=num_plan_work;
  SetWorkPlan;
  if tmp_plan<>num_plan_work Then Begin
     isCalcOk:=false;
     StatusBar1.Panels.Items[1].Text:='Расчет модели не проводился';
  end;
end;

procedure Tfr_main.n_printClick(Sender: TObject);
begin
  ShPrnDlg;
end;

procedure Tfr_main.n_openClick(Sender: TObject);
begin
  OpenShem;
end;

procedure Tfr_main.n_new_mapClick(Sender: TObject);
var
  name,coment : string;
  newid,rs : integer;
  str : string;
  pp, par : variant;
begin
//  Exit;
  If not DM.IsBaseMap Then Begin
     MessageDlg('Для создания новой схемы необходимо открыть базовую (основную) схему!', mtInformation, [mbOk], 0);
     Exit;
  end;
  ShowMessage('Копируем основную схему!');
  newid:=DM.GETNextID;
  str:=IntToStr(newid);
  name:=Get_Str_Par('Создание схемы','Имя схемы:','Введите название новой схемы','Новая схема '+str);
  if name='' Then Begin
     MessageDlg('Создание схемы отменино!', mtInformation, [mbOk], 0);
     Exit;
  end;
  coment:=Get_Str_Par('Создание схемы','Коментарий к схеме:','Введите коментарий к новой схеме','');
  // Создаем запись новой схемы
  if MessageDlg('Продолжить создание новой схемы: '+name+' ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
     MessageDlg('Создание схемы отменино!', mtInformation, [mbOk], 0);
     Exit;
  end;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=153;
  par[1]:=VarArrayOf(['mp','st','nam','com']); //имена
  par[2]:=VarArrayOf([newid,0,name,coment]); //значения
  cod_err:=333;
  DM.StartTrans;
  rs:=DM.RunSQL(par);
  if rs<>0 Then Begin
     MessageDlg('Схема не создана!!', mtError, [mbOk], 0);
     DM.BackTrans;
     Exit;
  end;
  DM.ComTrans;
  try
    Screen.Cursor:=crHourGlass;
    rs:=DM.CopyShem(newid);
  finally
    Screen.Cursor:=crDefault;
  end;
  if rs<>0 Then Begin
     str:='Схема не создана!!';
     CASE rs of
       -1 : str:=str+' Нет временной БД.';
       -2 : str:=str+' Такой код схемы уже задействован.';
       -3 : str:=str+' Не активирована базовая схема.';
        1 : str:=str+' Нет прав на операцию.';
       -4 : str:=str+' не открыта схема.';
        2 : str:=str+' Неудача.';
        3 : str:=str+' Ok.';
     end;
     MessageDlg(str, mtError, [mbOk], 0);
     // Удаление созданной записи
     par[0]:=175;
     par[1]:=VarArrayOf(['mp']); //имена
     par[2]:=VarArrayOf([newid]); //значения
     cod_err:=334;
     DM.StartTrans;
     rs:=DM.RunSQL(par);
     if rs<>0 Then Begin
        DM.BackTrans;
        Exit;
     end;
     DM.ComTrans;
     Exit;
  end;
  ShowMessage('Новая схема создана!');
end;

procedure Tfr_main.n_map_nameClick(Sender: TObject);
var
  name,str : string;
  par : variant;
  rs,id : integer;
begin
  If DM.IsBaseMap Then Begin
     MessageDlg('Запрещено изменять имя базовой схемы!!', mtError, [mbOk], 0);
     Exit;
  end;
  id:=DM.GetMapID;
  name:=fr_main.StatusBar1.Panels[2].Text;
  str:=Get_Str_Par('Изменение имени схемы','Имя Схемы:','',name);
  str:=DelRSpace(str);
  if str='' Then Exit;
  if str=name Then Exit;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=177;
  par[1]:=VarArrayOf(['mp','nam']); //имена
  par[2]:=VarArrayOf([id,str]); //значения
  cod_err:=335;
  DM.StartTrans;
  rs:=DM.RunSQL(par);
  if rs<>0 Then Begin
     DM.BackTrans;
     Exit;
  end;
  DM.ComTrans;
  fr_main.StatusBar1.Panels[2].Text:=str;
end;

procedure Tfr_main.n_map_comentClick(Sender: TObject);
var
  com,str,name : string;
  par,pp,nms : variant;
  rs,id : integer;
begin
  id:=DM.GetMapID;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=179;
  par[1]:=VarArrayOf(['mp']); //имена
  par[2]:=VarArrayOf([id]); //значения
  cod_err:=336;
  nms:=VarArrayOf(['name','coment']);
  pp:=DM.GetTehDataNams(par,nms);
  if VarIsNull(pp) Then Exit;
  name:=pp[0];
  If VarIsNull(pp[1]) Then com:='' Else com:=pp[1];
  str:=Get_Str_Par('Коментарии к схеме',name,'Здесь Вы можете изменить коментарии.',com);
  str:=DelRSpace(str);
  if str='' Then Exit;
  if str=com Then Exit;
  par[0]:=178;
  par[1]:=VarArrayOf(['mp','com']); //имена
  par[2]:=VarArrayOf([id,str]); //значения
  cod_err:=337;
  DM.StartTrans;
  rs:=DM.RunSQL(par);
  if rs<>0 Then Begin
     DM.BackTrans;
     Exit;
  end;
  DM.ComTrans;
end;

procedure Tfr_main.n_pipe_selectClick(Sender: TObject);
begin
  SelectorPipe;
end;

procedure Tfr_main.n_add_pipe_to_selectClick(Sender: TObject);
var
  ob : TMyObject;
  ids : string;
  ii : integer;
begin
  ob:=FieldMain.Selection.Items[0];
  If ob.Tag<=0 Then Exit;
  ids:=IntToStr(ob.Tag);
  If ob.IdType=4 Then
     If not ChangingPipes.Find(ids,ii) Then ChangingPipes.Add(ids);
end;

procedure Tfr_main.n_go_to_kustClick(Sender: TObject);
var
  par,pp : variant;
  kid : integer;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=181;
  par[1]:=null;
  par[2]:=null;
  pp:=VarArrayOf(['Переход к элементам кустов скважин.','Выберите куст скважин из списка:']);
  kid:=GetIdSpr(pp,par);
  if kid>0 Then Begin
     set_kust_map(kid);
     If fieldmain.Vertices.Count>0 Then
        fieldmain.SetSelected(fieldmain.Vertices.First);
  end;
end;

procedure Tfr_main.n_legendClick(Sender: TObject);
begin
  fr_legend.Show;
end;

procedure Tfr_main.scrolFieldMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  //If Shift=ssShift Then scrolField.ScrollBy(WheelDelta,0)
  //Else scrolField.ScrollBy(0,WheelDelta);
end;

procedure Tfr_main.n_well_presentClick(Sender: TObject);
begin
  LetsTestWellPresent;
end;

procedure Tfr_main.n_set_catch_pressClick(Sender: TObject);
var
  ob : TMyObject;
  uid,ii : integer;
  pres : real;
  str : string;
begin
  // Установить давление в узле управляя задвижкой
  n_set_catch_press.Visible:=false;
  ob:=FieldMain.Selection.Items[0];
  If ob.IdType=10 Then Begin
     uid:=id_tek_uz;
     id_tek_uz:=0;
     pres:=Ask_real('Установить давление','Введите значение'+#13+'давления в узле (МПа)',0);
     If pres<0 Then Begin
        MessageDlg('Установка давления в узле отменено!', mtInformation, [mbOk], 0);
        Exit;
     end;
     str:='установить давление '+FloatToStr(pres)+' МПа в узле '+IntToStr(uid)+' задвижкой '+IntToStr(ob.Tag);

     ii:=CUPL.Add(str,ob.Tag,uid,pres);

     MessageDlg('Добавлено в реестр: '+str+' (запись № '+IntToStr(ii)+')', mtInformation, [mbOk], 0);
  end;
end;

procedure Tfr_main.n_set_unit_memoryClick(Sender: TObject);
var
  ob : TMyObject;
begin
  n_set_unit_memory.Visible:=false;
  ob:=FieldMain.Selection.Items[0];
  If ob.IdType=12 Then id_tek_uz:=ob.Tag;

end;

procedure Tfr_main.n_calc_catchClick(Sender: TObject);
begin
  StartCUPLcalc;
end;

procedure Tfr_main.n_adaptationClick(Sender: TObject);
var
  par, pp : variant;
  dinviaz, rotshor,gidgadtmp,nebalans : real;
  rr : integer;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  //Загружаем переменные
  pp:=VarArrayOf(['DINVIAZKOST','ROSTSHOROH','GIDRDTEMP','MINNEBALANSUNIT']);
  par[0]:=186;
  par[1]:=VarArrayOf(['!cyear']);
  par[2]:=VarArrayOf(['2003']);
  pp:=DM.GetTehDataNams(par,pp);
  If not VarIsNull(pp) Then Begin
     dinviaz:=pp[0];
     rotshor:=pp[1];
     gidgadtmp:=pp[2];
     nebalans:=pp[3];
  end;
  dinviaz:=Ask_real('Значение параметра','Динамическая вязкость'+#13+'воды (сСт)',dinviaz);
  rotshor:=Ask_real('Значение параметра','Темп роста'+#13+'шероховатости (мм/год)',rotshor);
  gidgadtmp:=Ask_real('Значение параметра','Темп уменьшения'+#13+'гидр. диам. (мм/год)',gidgadtmp);
  nebalans:=Ask_real('Значение параметра','Минимальный'+#13+'небаланс узла (м3/сут)',nebalans);
  par[0]:=192;
  par[1]:=VarArrayOf(['dv','rs','gdd','nbl']);
  par[2]:=VarArrayOf([dinviaz,rotshor,gidgadtmp,nebalans]);
  DM.StartTrans;
  rr:=DM.RunSQL(par);
  If rr=0 Then DM.ComTrans Else DM.BackTrans;
end;

procedure Tfr_main.n_go_to_nsClick(Sender: TObject); 
var
  par,pp : variant;
  kid : integer;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=24;
  par[1]:=null;
  par[2]:=null;
  pp:=VarArrayOf(['Переход к элементам НС.','Выберите насосную станцию из списка:']);
  kid:=GetIdSpr(pp,par);
  if kid>0 Then Begin
     set_ns_map(kid);
     If fieldmain.Vertices.Count>0 Then
        fieldmain.SetSelected(fieldmain.Vertices.First);
  end;
end;

procedure Tfr_main.n_go_to_knsClick(Sender: TObject);
var
  par,pp : variant;
  kid : integer;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=25;
  par[1]:=null;
  par[2]:=null;
  pp:=VarArrayOf(['Переход к элементам КНС.','Выберите КНС из списка:']);
  kid:=GetIdSpr(pp,par);
  if kid>0 Then Begin
     set_kns_map(kid);
     If fieldmain.Vertices.Count>0 Then
        fieldmain.SetSelected(fieldmain.Vertices.First);
  end;
end;

procedure Tfr_main.n_t_rasClick(Sender: TObject);
begin
  If isCalcOk Then fr_t_ras.ShowUnitsRas
  Else ShowMessage('Сначала необходимо выполнить расчет модели!');
end;

procedure Tfr_main.n_shopsClick(Sender: TObject);
begin
  Shops;
end;

procedure Tfr_main.n_depositsClick(Sender: TObject);
begin
  Deposits;
end;

procedure Tfr_main.n_pipes_dClick(Sender: TObject);
begin
  If StartDPipe Then n_reviewClick(Sender);
end;

procedure Tfr_main.n_svodkaClick(Sender: TObject);
var
  fn : string;
  cy,cx,ii,s1kns,id : integer;
  par,pp : variant;
begin
  //If not isCalcOk Then Begin
  //   ShowMessage('Сначала необходимо выполнить расчет модели!');
  //   Exit;
  //end;
  xl:=CreateOleObject('Excel.Application');
  xl.visible:=true;
  fn:=DM.XL_path+DM.XL_Svoda;
  xl.application.workbooks.open(fn);
  sheet:=xl.application.workbooks[1].worksheets[1];
  cy:=5;  // номер начальной строки
  // Заливаем КНС
  DM.cds_tmp.active:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=193;
  par[1]:=null;
  par[2]:=null;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  DM.cds_tmp.data:=pp;
  While not DM.cds_tmp.Eof Do Begin
     sheet.cells[cy,1]:=DM.cds_tmp.FieldByName('NAME').AsString;
     sheet.cells[cy,2]:=DM.cds_tmp.FieldByName('KVO').Value;
     id:=DM.cds_tmp.FieldByName('ID').AsInteger;
     
     DM.cds_tmp.next;
     Inc(cy);
  end;
  s1kns:=cy-1;
  sheet.cells[cy,2]:='=SUM(B5:B'+IntToStr(s1kns)+')';
  
  DM.cds_tmp.active:=false;
end;

procedure Tfr_main.n_usersClick(Sender: TObject);
begin
  ShowUsers;
end;

procedure Tfr_main.n_pump_sprClick(Sender: TObject);
begin
  PumpsType;
end;

procedure Tfr_main.n_calcyearClick(Sender: TObject);
var
  yy : integer;
  Year, Month, Day : word;
begin
  DecodeDate(date,Year, Month, Day);
  yy:=DM.GetCalcYear;
  yy:=Ask_Int('Расчетный год','введите год расчета',yy,Year+10,Year);
  If yy<0 Then Begin
     MessageDlg('Установка отменена!', mtInformation, [mbOk], 0);
     Exit;
  end;
  DM.SetCalcYear(yy);
end;

end.

