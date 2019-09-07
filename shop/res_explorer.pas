unit res_explorer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ComCtrls, ExtCtrls, Buttons, ImgList, Db, DBClient,
  RXCtrls, Menus, well_plast_spr, Well_spr, Pump_spr, Catch_spr, Pipe_spr,
  KNS_spr, NS_spr, Objs, DTypes;

type
  Tfr_res = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    gr_params: TStringGrid;
    Panel4: TPanel;
    lb_period: TListBox;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    tr_elems: TTreeView;
    Panel8: TPanel;
    Panel9: TPanel;
    lb_about: TListBox;
    bt_exit: TBitBtn;
    ImageList1: TImageList;
    cds_ns: TClientDataSet;
    cds_elems: TClientDataSet;
    cds_wrk: TClientDataSet;
    lb_calc: TRxLabel;
    Bevel1: TBevel;
    cds_wrk2: TClientDataSet;
    pm_elements: TPopupMenu;
    n_plast_add: TMenuItem;
    n_plast_edit: TMenuItem;
    n_plast_del: TMenuItem;
    n_well_edit: TMenuItem;
    n_pump_edit: TMenuItem;
    n_catch_edit: TMenuItem;
    n_pipe_edit: TMenuItem;
    n_stok_edit: TMenuItem;
    n_kns_edit: TMenuItem;
    n_ns_edit: TMenuItem;
    mm_per_about: TMemo;
    n_goto_elem: TMenuItem;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tr_elemsChange(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lb_periodClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure n_plast_addClick(Sender: TObject);
    procedure tr_elemsDeletion(Sender: TObject; Node: TTreeNode);
    procedure n_plast_editClick(Sender: TObject);
    procedure n_plast_delClick(Sender: TObject);
    procedure n_well_editClick(Sender: TObject);
    procedure n_pump_editClick(Sender: TObject);
    procedure n_catch_editClick(Sender: TObject);
    procedure n_pipe_editClick(Sender: TObject);
    procedure n_stok_editClick(Sender: TObject);
    procedure n_kns_editClick(Sender: TObject);
    procedure n_ns_editClick(Sender: TObject);
    procedure tr_elemsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure n_goto_elemClick(Sender: TObject);
  private
    tid : integer;
    ttip : integer;
    riteelem : boolean;
    Function FindObjectTag(id : integer) : Pointer;
    Procedure GoToObj;
    procedure ClearFields;
    Procedure CachToTree(upname:string;upadr:pointer;uptip,upid:integer);
    Procedure PipeToTree(upname:string;upadr:pointer;uptip,upid:integer);
    Procedure WellToTree(upname:string;upadr:pointer;upid:integer);
    Procedure PlastToTree(upname:string;upadr:pointer;upid:integer);
    procedure SetResToGrid(par : variant);
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure ShowResExplorer;

var
  fr_res: Tfr_res;

implementation

uses ppd_main,ppd_dm;

{$R *.DFM}

Type
PPumpOpt = ^TPumpOpt;
TPumpOpt = record
  ID : Integer;
  Tip : Integer;
  H_ID : integer;
  ID2 : integer;
  Vl : real;
  Name : string;
  SName : string;
  TName : string;
  StName : string;
end;

Var
na_name : string;
na_id : integer;

Procedure ShowResExplorer;
Begin
  na_id:=-1;
  na_name:='';
  try
     try
       fr_res:=Tfr_res.Create(Application);
       fr_res.ShowModal;
     finally
       fr_res.Free;
     end
  except
  end;
end;

procedure Tfr_res.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_res.FormCreate(Sender: TObject);
var
  par,pp : variant;
  hadr,madr,nadr,ladr : pointer;
  Popt : PPumpOpt;
  nam,k,ss : string;
  kd,ii : integer;
  nn : TTreeNode;
begin
  gr_params.Cells[0,0]:='Параметр';
  gr_params.Cells[1,0]:='Значение';
  gr_params.Cells[2,0]:='Ед. изм.';
  riteelem:=false;
  tid:=-1;
  ttip:=-1;
  If isCalcOk Then lb_calc.Caption:='Расчет модели выполнен';
  ss:=DM.GetPeriodList;
  If ss<>'' Then lb_period.Items.Text:=ss;
  par:=VarArrayCreate([0, 2], varVariant);
  For ii:=0 To 2 Do Begin
    CASE ii of
      0 : Begin
           par[0]:=24;
           par[1]:=null;
           par[2]:=null;
          end;
      1 : Begin
           par[0]:=116;
           par[1]:=VarArrayOf(['st']);
           par[2]:=VarArrayOf([0]);
          end;
      2 : Begin
           par[0]:=116;
           par[1]:=VarArrayOf(['st']);
           par[2]:=VarArrayOf([1]);
          end;
    end;
    cod_err:=16;
    pp:=DM.GetData(par);
    If VarIsNull(pp) Then Exit;
    cds_ns.Data:=pp;
    While not cds_ns.Eof Do Begin
      New(Popt);
      Popt^.ID:=cds_ns.FieldByName('id').AsInteger;
      kd:=Popt^.ID;
      CASE ii of
         0 : Popt^.Tip:=2;
         1 : Popt^.Tip:=1;
         2 : Popt^.Tip:=3;
      end;
      Popt^.Name:=cds_ns.FieldByName('name').AsString;
      nam:=Popt^.Name;
      If ii=2 Then Begin
         Popt^.SName:='Значение стока = '+cds_ns.FieldByName('days_debet').AsString+' куб.м/сут';
         Popt^.TName:='Давление стока = '+cds_ns.FieldByName('stok_pressure').AsString+' МПа';
         Popt^.StName:='';
      end
      Else Begin
         Popt^.SName:='';
         Popt^.TName:='';
         Popt^.StName:='';
      end;
      hadr:=tr_elems.Items.AddObject(nil,nam,Popt);
      nn:=hadr;
      If ii=2 Then Begin
         nn.ImageIndex:=7;
         nn.SelectedIndex:=7;
      end
      Else Begin
         nn.ImageIndex:=0;
         nn.SelectedIndex:=0;
      end;
      // Насосы
      If ii<2 Then Begin
      madr:=tr_elems.Items.AddChildObject(hadr,'Насосные агрегаты',nil);
      nn:=madr;
      nn.ImageIndex:=1;
      nn.SelectedIndex:=1;
      If ii>0 Then k:='kns_id' Else k:='ns_id';
      par[0]:=86;
      par[1]:=VarArrayOf(['!k','obj']);
      par[2]:=VarArrayOf([k,kd]);
      cod_err:=17;
      pp:=DM.GetData(par);
      If not VarIsNull(pp) Then Begin
        cds_elems.Data:=pp;
        While not cds_elems.Eof Do Begin
          New(Popt);
          Popt^.ID:=cds_elems.FieldByName('id').AsInteger;
          Popt^.H_ID:=kd;
          Popt^.ID2:=4-2*ii;
          Popt^.Tip:=5;
          Popt^.Name:=cds_elems.FieldByName('name').AsString;
          Popt^.SName:=nam;
          Popt^.TName:='Тип НА: '+cds_elems.FieldByName('tname').AsString;
          Case cds_elems.FieldByName('state').AsInteger of
             0 : Popt^.StName:='В работе';
             1 : Popt^.StName:='В резерве';
             2 : Popt^.StName:='В ремонте';
          end;
          nn:=tr_elems.Items.AddChildObject(madr,Popt^.Name,Popt);
          nn.ImageIndex:=1;
          nn.SelectedIndex:=1;
          cds_elems.Next;
        end;
      end;
      end;
      // Задвижки
      madr:=tr_elems.Items.AddChildObject(hadr,'Задвижки',nil);
      nn:=madr;
      nn.ImageIndex:=5;
      nn.SelectedIndex:=5;
      CachToTree(nam,madr,ii,kd);

      // Водоводы
      madr:=tr_elems.Items.AddChildObject(hadr,'Водоводы',nil);
      nn:=madr;
      nn.ImageIndex:=3;
      nn.SelectedIndex:=3;
      PipeToTree(nam,madr,ii,kd);

      If ii=1 Then Begin
      // Кусты скважин
        madr:=tr_elems.Items.AddChildObject(hadr,'Кусты скважин',nil);
        nn:=madr;
        nn.ImageIndex:=6;
        nn.SelectedIndex:=6;
        par[0]:=130;
        par[1]:=VarArrayOf(['kns']);
        par[2]:=VarArrayOf([kd]);
        cod_err:=17;
        pp:=DM.GetData(par);
        If not VarIsNull(pp) Then Begin
          cds_wrk.Data:=pp;
          While not cds_wrk.Eof Do Begin
            New(Popt);
            Popt^.ID:=cds_wrk.FieldByName('id').AsInteger;
            Popt^.Tip:=9;
            Popt^.Name:=cds_wrk.FieldByName('name').AsString;
            Popt^.SName:=nam;
            Popt^.TName:=cds_wrk.FieldByName('shopname').AsString;
            Popt^.StName:=cds_wrk.FieldByName('depname').AsString;
            nadr:=tr_elems.Items.AddChildObject(madr,'К. № '+Popt^.Name,Popt);
            nn:=nadr;
            nn.ImageIndex:=6;
            nn.SelectedIndex:=6;

            // Задвижки
            ladr:=tr_elems.Items.AddChildObject(nadr,'Задвижки',nil);
            nn:=ladr;
            nn.ImageIndex:=5;
            nn.SelectedIndex:=5;
            CachToTree(Popt^.Name,ladr,3,Popt^.ID);

            // Водоводы
            ladr:=tr_elems.Items.AddChildObject(nadr,'Водоводы',nil);
            nn:=ladr;
            nn.ImageIndex:=3;
            nn.SelectedIndex:=3;
            PipeToTree(Popt^.Name,ladr,3,Popt^.ID);

            // Скважины
            ladr:=tr_elems.Items.AddChildObject(nadr,'Скважины',nil);
            nn:=ladr;
            nn.ImageIndex:=4;
            nn.SelectedIndex:=4;
            WellToTree(Popt^.Name,ladr,Popt^.ID);

            cds_wrk.Next;
          end;
        end;
      end;

      cds_ns.Next;
    end;
  end;
end;

Procedure Tfr_res.CachToTree(upname:string;upadr:pointer;uptip,upid:integer);
var
 par,pp : variant;
 Popt : PPumpOpt;
 nn : TTreeNode;
 k : string;
Begin
  CASE uptip of
    0 : k:='ns';
  1,2 : k:='kns';
    3 : k:='kust';
  end;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=128;
  par[1]:=VarArrayOf(['!k','spr']);
  par[2]:=VarArrayOf([k,upid]);
  cod_err:=17;
  pp:=DM.GetData(par);
  If not VarIsNull(pp) Then Begin
     cds_elems.Data:=pp;
     While not cds_elems.Eof Do Begin
          New(Popt);
          Popt^.ID:=cds_elems.FieldByName('id').AsInteger;
          Popt^.H_ID:=upid;
          Popt^.ID2:=cds_elems.FieldByName('shem_id').AsInteger;
          Popt^.Tip:=10;
          Popt^.Name:=cds_elems.FieldByName('name').AsString;
          Popt^.SName:=upname;
          Popt^.TName:='Диаметр = '+cds_elems.FieldByName('diametr').AsString+' мм';
          Popt^.StName:='Открытa на '+cds_elems.FieldByName('bolt_open').AsString+' %';
          nn:=tr_elems.Items.AddChildObject(upadr,Popt^.Name,Popt);
          nn.ImageIndex:=5;
          nn.SelectedIndex:=5;
          cds_elems.Next;
     end;
  end;
end;

Procedure Tfr_res.WellToTree(upname:string;upadr:pointer;upid:integer);
var
 par,pp : variant;
 Popt,Popt1 : PPumpOpt;
 nn : TTreeNode;
 adr1,adr2 : pointer;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=91;
  par[1]:=VarArrayOf(['kust']);
  par[2]:=VarArrayOf([upid]);
  cod_err:=17;
  pp:=DM.GetData(par);
  If not VarIsNull(pp) Then Begin
     cds_elems.Data:=pp;
     While not cds_elems.Eof Do Begin
          New(Popt);
          Popt^.ID:=cds_elems.FieldByName('id').AsInteger;
          Popt^.H_ID:=upid;
          Popt^.Tip:=8;
          Popt^.Vl:=cds_elems.FieldByName('DAY_PUMP').AsFloat;
          Popt^.Name:='Скв. № '+cds_elems.FieldByName('nomer').AsString;
          Popt^.SName:='Куст : '+upname;
          Popt^.TName:='Диаметр штуцера = '+cds_elems.FieldByName('d_shtucer').AsString+' мм';
          Popt^.StName:=cds_elems.FieldByName('name').AsString;
          adr1:=tr_elems.Items.AddChildObject(upadr,Popt^.Name,Popt);
          nn:=adr1;
          nn.ImageIndex:=4;
          nn.SelectedIndex:=4;
          New(Popt1);
          Popt1^.Tip:=14;
          Popt1^.ID:=-1;
          Popt1^.H_ID:=Popt^.ID;
          Popt1^.Name:='';
          Popt1^.SName:=cds_elems.FieldByName('nomer').AsString;
          Popt1^.TName:='';
          Popt1^.StName:='';
          adr2:=tr_elems.Items.AddChildObject(adr1,'Пласты',Popt1);
          nn:=adr2;
          nn.ImageIndex:=8;
          nn.SelectedIndex:=8;
          PlastToTree(cds_elems.FieldByName('nomer').AsString,adr2,Popt^.ID);
          cds_elems.Next;
     end;
  end;
end;

Procedure Tfr_res.PlastToTree(upname:string;upadr:pointer;upid:integer);
var
 par,pp : variant;
 Popt : PPumpOpt;
 nn : TTreeNode;
 adr1 : pointer;
Begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=96;
  par[1]:=VarArrayOf(['well']);
  par[2]:=VarArrayOf([upid]);
  cod_err:=17;
  pp:=DM.GetData(par);
  If not VarIsNull(pp) Then Begin
     cds_wrk2.Data:=pp;
     While not cds_wrk2.Eof Do Begin
          New(Popt);
          Popt^.ID:=cds_wrk2.FieldByName('Plast_id').AsInteger;
          Popt^.ID2:=cds_wrk2.FieldByName('id').AsInteger;
          Popt^.Tip:=15;
          Popt^.Vl:=cds_wrk2.FieldByName('k_accept').AsFloat;
          Popt^.H_ID:=upid;
          Popt^.Name:='Пласт '+cds_wrk2.FieldByName('name').AsString;
          Popt^.SName:='Скважина : '+upname;
          Popt^.TName:='Приемистость = '+cds_wrk2.FieldByName('ACCEPT').AsString+' куб.м/сут.';
          Popt^.StName:='при Руст '+cds_wrk2.FieldByName('pressure').AsString+' МПа';
          adr1:=tr_elems.Items.AddChildObject(upadr,Popt^.Name,Popt);
          nn:=adr1;
          nn.ImageIndex:=8;
          nn.SelectedIndex:=8;
          cds_wrk2.Next;
     end;
  end;
end;

Procedure Tfr_res.PipeToTree(upname:string;upadr:pointer;uptip,upid:integer);
var
 par,pp : variant;
 Popt : PPumpOpt;
 nn : TTreeNode;
 k : string;
Begin
  CASE uptip of
    0 : k:='ns';
  1,2 : k:='kns';
    3 : k:='kust';
  end;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=129;
  par[1]:=VarArrayOf(['!k','spr']);
  par[2]:=VarArrayOf([k,upid]);
  cod_err:=17;
  pp:=DM.GetData(par);
  If not VarIsNull(pp) Then Begin
     cds_elems.Data:=pp;
     While not cds_elems.Eof Do Begin
          New(Popt);
          Popt^.ID:=cds_elems.FieldByName('id').AsInteger;
          Popt^.H_ID:=upid;
          Popt^.ID2:=cds_elems.FieldByName('shem_id').AsInteger;
          Popt^.Tip:=4;
          Popt^.Name:=cds_elems.FieldByName('name').AsString+' ('+cds_elems.FieldByName('build_year').AsString+'г.)';
          Popt^.SName:=upname;
          Popt^.TName:='Диаметр = '+cds_elems.FieldByName('diametr').AsString+' мм; Толщина стенки = '+cds_elems.FieldByName('thick').AsString+' мм';
          Popt^.StName:='Длина '+cds_elems.FieldByName('len').AsString+' м; Направление : '+cds_elems.FieldByName('dirname').AsString;
          nn:=tr_elems.Items.AddChildObject(upadr,cds_elems.FieldByName('name').AsString,Popt);
          nn.ImageIndex:=3;
          nn.SelectedIndex:=3;
          cds_elems.Next;
     end;
  end;
end;

procedure Tfr_res.ClearFields;
var
  ii,rc : integer;
Begin
  rc:=gr_params.RowCount;
  For ii:=1 To rc Do Begin
     gr_params.Cells[0,ii]:='';
     gr_params.Cells[1,ii]:='';
     gr_params.Cells[2,ii]:='';
  end;
  lb_about.Clear;
end;

procedure Tfr_res.tr_elemsChange(Sender: TObject; Node: TTreeNode);
var
  ppp : pointer;
  tp,id,pr : integer;
  rr : Variant;
begin
  ppp:=Node.Data;
  ClearFields;
  If ppp=nil Then Exit;
  tp:=PPumpOpt(ppp)^.Tip;
  id:=PPumpOpt(ppp)^.ID;
  tid:=id;
  ttip:=tp;
  riteelem:=false;
  If (tp>0)and(id>0)and(lb_period.ItemIndex>=0) Then Begin
    pr:=StrToInt(lb_period.Items.Strings[lb_period.ItemIndex]);
    If tp>12 Then DM.SetVr1(PPumpOpt(ppp)^.H_ID);
    rr:=DM.GetResElements(id, tp, pr);
    SetResToGrid(rr);
  end;
  CASE tp of
      1 : Begin
            lb_about.Items.Add('Кустовая насосная станция:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
      2 : Begin
            lb_about.Items.Add('Насосная станция:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
      3 : Begin
            lb_about.Items.Add('Сток :');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add(PPumpOpt(ppp)^.SName);
            lb_about.Items.Add(PPumpOpt(ppp)^.TName);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
      4 : Begin
            lb_about.Items.Add(PPumpOpt(ppp)^.SName);
            lb_about.Items.Add('Водовод:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add(PPumpOpt(ppp)^.TName);
            lb_about.Items.Add(PPumpOpt(ppp)^.StName);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
      5 : Begin
            lb_about.Items.Add(PPumpOpt(ppp)^.SName);
            lb_about.Items.Add('Насосный агрегат:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add(PPumpOpt(ppp)^.TName);
            lb_about.Items.Add(PPumpOpt(ppp)^.StName);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
      8 : Begin
            lb_about.Items.Add(PPumpOpt(ppp)^.SName);
            //lb_about.Items.Add('Скважина:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add(PPumpOpt(ppp)^.TName);
            lb_about.Items.Add('Задание по закачке: '+FloatToStr(PPumpOpt(ppp)^.Vl)+' куб.м/сут.');
            lb_about.Items.Add(PPumpOpt(ppp)^.StName);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
      9 : Begin
            lb_about.Items.Add('Куст скважин:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add('Цех: '+PPumpOpt(ppp)^.TName);
            lb_about.Items.Add('Месторождение: '+PPumpOpt(ppp)^.StName);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
     10 : Begin
            lb_about.Items.Add(PPumpOpt(ppp)^.SName);
            lb_about.Items.Add('Задвижка:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add(PPumpOpt(ppp)^.TName);
            lb_about.Items.Add(PPumpOpt(ppp)^.StName);
            lb_about.Items.Add('ID = '+IntToStr(id));
            riteelem:=true;
          end;
     15 : Begin
            lb_about.Items.Add(PPumpOpt(ppp)^.SName);
            //lb_about.Items.Add('Пласт:');
            lb_about.Items.Add(PPumpOpt(ppp)^.Name);
            lb_about.Items.Add(PPumpOpt(ppp)^.TName);
            lb_about.Items.Add(PPumpOpt(ppp)^.StName);
            lb_about.Items.Add('К пр = '+FloatToStr(PPumpOpt(ppp)^.Vl)+' куб.м/сут./МПа');
          end;
          Else Exit;
  end;
end;

procedure Tfr_res.SetResToGrid(par : variant);
var
 rc,ii : integer;
Begin
  If VarIsNull(par) Then Exit;
  rc:=VarArrayHighBound(par,1);
  For ii:=0 To rc Do If not VarIsNull(par[ii]) Then Begin
     gr_params.Cells[0,ii+1]:=par[ii][0];
     gr_params.Cells[1,ii+1]:=par[ii][1];
     gr_params.Cells[2,ii+1]:=par[ii][2];
  end;
end;

procedure Tfr_res.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ii,cc : integer;
  p : pointer;
begin
  cc:=tr_elems.Items.Count;
  For ii:=0 To cc-1 Do Begin
      p:=tr_elems.Items.Item[ii].Data;
      tr_elems.Items.Item[ii].Data:=nil;
      If p<>nil Then FreeMem(p);
  end;
end;

procedure Tfr_res.lb_periodClick(Sender: TObject);
begin
  tr_elemsChange(Sender,tr_elems.Selected);
  mm_per_about.Text:='';
  mm_per_about.text:=DM.GetAboutPeriod(StrToInt(lb_period.Items.Strings[lb_period.ItemIndex]));
end;

procedure Tfr_res.FormShow(Sender: TObject);
begin
  tr_elems.Selected:=tr_elems.Items.Item[0];
  lb_period.SetFocus;
end;

procedure Tfr_res.n_plast_addClick(Sender: TObject);
var
  ppp,upadr : pointer;
  w_id : integer;
  rrb : boolean;
begin
  ppp:=tr_elems.Selected.Data;
  upadr:=tr_elems.Selected;
  If ppp=nil Then Exit;
  w_id:=PPumpOpt(ppp)^.H_ID;
  rrb:=WellPars(-1,w_id);
  If rrb Then Begin
     tr_elems.Selected.DeleteChildren;
     PlastToTree(PPumpOpt(ppp)^.SName,upadr,w_id);
  end;
end;

procedure Tfr_res.tr_elemsDeletion(Sender: TObject; Node: TTreeNode);
var
  ppp : pointer;
begin
   ppp:=Node.Data;
   If ppp=nil Then Exit;
   Node.Data:=nil;
   FreeMem(ppp);
end;

procedure Tfr_res.n_plast_editClick(Sender: TObject);
var
  ppp,p_p,upadr : pointer;
  w_id,id : integer;
  rrb : boolean;
begin
  ppp:=tr_elems.Selected.Data;
  upadr:=tr_elems.Selected.Parent;
  p_p:=tr_elems.Selected.Parent.Data;
  If ppp=nil Then Exit;
  If p_p=nil Then Exit;
  w_id:=PPumpOpt(ppp)^.H_ID;
  id:=PPumpOpt(ppp)^.ID2;
  rrb:=WellPars(id,w_id);
  If rrb Then Begin
     tr_elems.Selected.Parent.DeleteChildren;
     PlastToTree(PPumpOpt(p_p)^.SName,upadr,w_id);
  end;
end;

procedure Tfr_res.n_plast_delClick(Sender: TObject);
var
 par,pp : variant;
 ppp : pointer;
 id : integer;
begin
  ppp:=tr_elems.Selected.Data;
  If ppp=nil Then Exit;
  id:=PPumpOpt(ppp)^.ID2;
  if MessageDlg('Вы действительно хотите удалить пласт из закачки?',
    mtWarning, [mbYes, mbNo], 0) = mrYes then
  Begin
    DM.StartTrans;
    par:=VarArrayCreate([0, 2], varVariant);
    par[0]:=108;
    par[1]:=VarArrayOf(['well']);
    par[2]:=VarArrayOf([id]);
    cod_err:=105;
    pp:=DM.RunSQL(par);
    If pp<>0 Then Begin
        DM.BackTrans;
        Exit;
    end;
    DM.ComTrans;
    tr_elems.Selected.Delete;
  end;
end;

procedure Tfr_res.n_well_editClick(Sender: TObject);
var
  ppp : pointer;
  w_id,id : integer;
  rrb : variant;
begin
  ppp:=tr_elems.Selected.Data;
  If ppp=nil Then Exit;
  w_id:=PPumpOpt(ppp)^.ID;
  id:=PPumpOpt(ppp)^.H_ID;
  rrb:=WellToDB(w_id, -1, -1, id,false);
  If not VarIsNull(rrb) Then Begin
     PPumpOpt(ppp)^.TName:='Диаметр штуцера = '+FloatToStr(rrb[3])+' мм';
     PPumpOpt(ppp)^.StName:=rrb[5];
     PPumpOpt(ppp)^.Vl:=rrb[4];
  end;
end;

procedure Tfr_res.n_pump_editClick(Sender: TObject);
var
  ppp : pointer;
  p_id,id,pl : integer;
  rrb : variant;
begin
  ppp:=tr_elems.Selected.Data;
  If ppp=nil Then Exit;
  p_id:=PPumpOpt(ppp)^.ID;
  id:=PPumpOpt(ppp)^.H_ID;
  pl:=PPumpOpt(ppp)^.ID2;
  rrb:=PumpToDB(p_id,1,2,pl,id,false);
  If not VarIsNull(rrb) Then Begin
     PPumpOpt(ppp)^.TName:='Тип НА: '+rrb[9];
     Case rrb[3] of
        0 : PPumpOpt(ppp)^.StName:='В работе';
        1 : PPumpOpt(ppp)^.StName:='В резерве';
        2 : PPumpOpt(ppp)^.StName:='В ремонте';
     end;
  end;
end;

procedure Tfr_res.n_catch_editClick(Sender: TObject);
var
  ppp : pointer;
  c_id,id,pl,c_s : integer;
  rrb : variant;
begin
  ppp:=tr_elems.Selected.Data;
  c_s:=0;
  If ppp=nil Then Exit;
  c_id:=PPumpOpt(ppp)^.ID;
  id:=PPumpOpt(ppp)^.H_ID;
  pl:=PPumpOpt(ppp)^.ID2;
  rrb:=CatchToDB(c_id,c_s,1,2,pl,id,false);
  If not VarIsNull(rrb) Then Begin
     PPumpOpt(ppp)^.Name:=rrb[0];
     PPumpOpt(ppp)^.TName:='Диаметр = '+FloatToStr(rrb[3])+' мм';
     PPumpOpt(ppp)^.StName:='Открытa на '+FloatToStr(rrb[4])+' %';
     tr_elems.Selected.Text:=PPumpOpt(ppp)^.Name;
  end;
end;

procedure Tfr_res.n_pipe_editClick(Sender: TObject);
var
  ppp : pointer;
  p_id,id,pl : integer;
  rrb : variant;
begin
  ppp:=tr_elems.Selected.Data;
  If ppp=nil Then Exit;
  p_id:=PPumpOpt(ppp)^.ID;
  id:=PPumpOpt(ppp)^.H_ID;
  pl:=PPumpOpt(ppp)^.ID2;
  rrb:=PipeToDB(p_id, 1, 2, pl, id, null, false);
  If not VarIsNull(rrb) Then Begin
     PPumpOpt(ppp)^.Name:=rrb[2]+' ('+IntToStr(rrb[6])+'г.)';
     PPumpOpt(ppp)^.TName:='Диаметр = '+IntToStr(rrb[4])+' мм; Толщина стенки = '+FloatToStr(rrb[5])+' мм';
     PPumpOpt(ppp)^.StName:='Длина '+FloatToStr(rrb[3])+' м; Направление : '+rrb[9];
     tr_elems.Selected.Text:=PPumpOpt(ppp)^.Name;
  end;
end;

procedure Tfr_res.n_stok_editClick(Sender: TObject);
var
  ppp : pointer;
  s_id : integer;
  rrb : variant;
begin
  ppp:=tr_elems.Selected.Data;
  If ppp=nil Then Exit;
  s_id:=PPumpOpt(ppp)^.ID;
  rrb:=KNSToDB(s_id, 0, 0, 0, 0, false);
  If not VarIsNull(rrb) Then Begin
     PPumpOpt(ppp)^.SName:='Значение стока = '+FloatToStr(rrb[3])+' куб.м/сут';
     PPumpOpt(ppp)^.TName:='Давление стока = '+FloatToStr(rrb[4])+' МПа';
  end;
end;

procedure Tfr_res.n_kns_editClick(Sender: TObject);
var
  ppp : pointer;
  k_id : integer;
  rrb : variant;
begin
  ppp:=tr_elems.Selected.Data;
  If ppp=nil Then Exit;
  k_id:=PPumpOpt(ppp)^.ID;
  rrb:=KNSToDB(k_id, 0, 0, 0, 0, false);
end;

procedure Tfr_res.n_ns_editClick(Sender: TObject);
var
  ppp : pointer;
  n_id : integer;
  rrb : variant;
begin
  ppp:=tr_elems.Selected.Data;
  If ppp=nil Then Exit;
  n_id:=PPumpOpt(ppp)^.ID;
  rrb:=NSToDB(n_id, 0, 0, 0, 0, false);
end;

procedure Tfr_res.tr_elemsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ppp : pointer;
  tp,id,pr : integer;
  rr : Variant;
begin
  If Button=mbRight Then Begin
     ppp:=tr_elems.Selected.Data;
     If ppp=nil Then Exit;
     tp:=PPumpOpt(ppp)^.Tip;
     n_plast_add.Visible:=false;
     n_plast_edit.Visible:=false;
     n_plast_del.Visible:=false;
     n_well_edit.Visible:=false;
     n_pump_edit.Visible:=false;
     n_catch_edit.Visible:=false;
     n_pipe_edit.Visible:=false;
     n_stok_edit.Visible:=false;
     n_kns_edit.Visible:=false;
     n_ns_edit.Visible:=false;
     n_goto_elem.Visible:=true;
     CASE tp Of
        14 : Begin
               n_plast_add.Visible:=true;
               pm_elements.Popup(x,y+40);
               n_goto_elem.Visible:=false;
             end;
        15 : Begin
               n_plast_edit.Visible:=true;
               n_plast_del.Visible:=true;
               pm_elements.Popup(x,y+40);
               n_goto_elem.Visible:=false;
             end;
        8  : Begin
               n_well_edit.Visible:=true;
               pm_elements.Popup(x,y+40);
             end;
        5  : Begin
               n_pump_edit.Visible:=true;
               pm_elements.Popup(x,y+40);
             end;
        10 : Begin
               n_catch_edit.Visible:=true;
               pm_elements.Popup(x,y+40);
             end;
        4  : Begin
               n_pipe_edit.Visible:=true;
               pm_elements.Popup(x,y+40);
             end;
        3  : Begin
               n_stok_edit.Visible:=true;
               pm_elements.Popup(x,y+40);
             end;
        1  : Begin
               n_kns_edit.Visible:=true;
               pm_elements.Popup(x,y+40);
             end;
        2  : Begin
               n_ns_edit.Visible:=true;
               pm_elements.Popup(x,y+40);
             end;
             Else Begin
             end;
     end;
  end;
end;

function Tfr_res.FindObjectTag(id : integer) : Pointer;
var
  ii : integer;
Begin
  Result:=nil;
  fr_main.fieldmain.SelectAll;
  For ii:=0 To fr_main.fieldmain.Selection.Count-1 Do
      If Tmyobject(fr_main.fieldmain.Selection.Items[ii]).tag=id Then Begin
         Result:=fr_main.fieldmain.Selection.Items[ii];
         fr_main.fieldmain.DeSelectAll;
         Exit;
      end;
  fr_main.fieldmain.DeSelectAll;
end;

procedure Tfr_res.GoToObj;
var
 ob : Pointer;
Begin
  ob:=FindObjectTag(tid);
  If ob=nil Then Begin
     MessageDlg('Объект не найден!', mtWarning ,[mbOk], 0);
     Exit;
  end
  Else Begin
    fr_main.fieldmain.SetSelected(ob);
    fr_main.fieldmain.AddToSelection(ob,smSingle);
  end;
  Application.ProcessMessages;
end;

procedure Tfr_res.n_goto_elemClick(Sender: TObject);
var
 id : integer;
 pp,par : variant;
begin
  par:=VarArrayCreate([0,2],varVariant);
  If (tid>0)and(riteelem) Then Begin
     Case ttip of
      1 : Begin //KNS
            If (fr_main.map_type>1) Then Begin
               fr_main.bt_s1Click(Sender);
            end;
            GoToObj;
          end;
      2 : Begin  //NS
            If (fr_main.map_type>0) Then Begin
               fr_main.bt_s1Click(Sender);
            end;
            GoToObj;
          end;
      3 : Begin //Stok
            If (fr_main.map_type>1) Then Begin
               fr_main.bt_s1Click(Sender);
            end;
            GoToObj;
          end;
      4 : Begin //Pipe
            par[0]:=44;
            par[1]:=VarArrayOf(['pipe']);
            par[2]:=VarArrayOf([tid]);
            cod_err:=414;
            pp:=VarArrayOf(['NS_ID','KNS_ID','KUST_ID','SHEM_ID']);
            pp:=DM.GetTehDataNams(par,pp);
            If VarIsNull(pp) Then Exit;
            If (not VarIsNull(pp[0]))and(pp[3]=4) Then Begin
               id:=pp[0];
               fr_main.set_ns_map(id);
            end;
            If (not VarIsNull(pp[1]))and(pp[3]=2) Then Begin
               id:=pp[1];
               fr_main.set_kns_map(id);
            end;
            If (not VarIsNull(pp[2]))and(pp[3]=3) Then Begin
               id:=pp[2];
               fr_main.set_kust_map(id);
            end;
            if (pp[3]=1)and(fr_main.map_type<>1) Then fr_main.bt_s2Click(Sender);
            if (pp[3]=0)and(fr_main.map_type<>0) Then fr_main.bt_s1Click(Sender);
            GoToObj;
          end;
      5 : Begin //Pump
            par[0]:=83;
            par[1]:=VarArrayOf(['pump']);
            par[2]:=VarArrayOf([tid]);
            cod_err:=413;
            pp:=DM.GetTehData(par);
            If VarIsNull(pp) Then Exit;
            If VarIsNull(pp[1]) Then Begin
               id:=pp[2];
               fr_main.set_ns_map(id);
            end
            Else Begin
               id:=pp[1];
               fr_main.set_kns_map(id);
            end;
            GoToObj;
          end;
      8 : Begin //Well
            par[0]:=94;
            par[1]:=VarArrayOf(['well']);
            par[2]:=VarArrayOf([tid]);
            cod_err:=412;
            pp:=DM.GetTehData(par);
            If VarIsNull(pp) Then Exit;
            id:=pp[1];
            fr_main.set_kust_map(id);
            GoToObj;
          end;
      9 : Begin //Kust
            If (fr_main.map_type<>1) Then Begin
               fr_main.bt_s2Click(Sender);
            end;
            GoToObj;
          end;
     10 : Begin //Catch
            par[0]:=37;
            par[1]:=VarArrayOf(['catch']);
            par[2]:=VarArrayOf([tid]);
            cod_err:=415;
            pp:=VarArrayOf(['NS_ID','KNS_ID','KUST_ID','SHEM_ID']);
            pp:=DM.GetTehDataNams(par,pp);
            If VarIsNull(pp) Then Exit;
            If (not VarIsNull(pp[0]))and(pp[3]=4) Then Begin
               id:=pp[0];
               fr_main.set_ns_map(id);
            end;
            If (not VarIsNull(pp[1]))and(pp[3]=2) Then Begin
               id:=pp[1];
               fr_main.set_kns_map(id);
            end;
            If (not VarIsNull(pp[2]))and(pp[3]=3) Then Begin
               id:=pp[2];
               fr_main.set_kust_map(id);
            end;
            if (pp[3]=1)and(fr_main.map_type<>1) Then fr_main.bt_s2Click(Sender);
            if (pp[3]=0)and(fr_main.map_type<>0) Then fr_main.bt_s1Click(Sender);
            GoToObj;
          end;
     end;
  end;
end;

end.
