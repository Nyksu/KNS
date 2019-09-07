unit Pump_plan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBClient, Grids, DBGrids, ComCtrls, ExtCtrls,
  ImgList, Ask_Integer, spr_id;

type
  Tfr_pump_plan = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    tree_pump: TTreeView;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    cds_plan: TClientDataSet;
    bt_exit: TBitBtn;
    bt_add: TBitBtn;
    bt_del: TBitBtn;
    ds_plan: TDataSource;
    ed_property: TListBox;
    Label1: TLabel;
    cds_ns: TClientDataSet;
    cds_pump: TClientDataSet;
    ImageList1: TImageList;
    Panel5: TPanel;
    Splitter1: TSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    ed_events_about: TMemo;
    cds_workplan: TClientDataSet;
    ds_workplan: TDataSource;
    DBGrid2: TDBGrid;
    procedure bt_exitClick(Sender: TObject);
    procedure tree_pumpChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure bt_addClick(Sender: TObject);
    procedure bt_delClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds_workplanDataChange(Sender: TObject; Field: TField);
  private
    procedure ShowPlan(n_id : integer);
    procedure CreateWorkList;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure DoPumpPlan;

var
  fr_pump_plan: Tfr_pump_plan;

implementation

uses ppd_dm;

{$R *.DFM}

Type
PPumpOpt = ^TPumpOpt;
TPumpOpt = record
  ID : Integer;
  Tip : Integer;
  Name : string;
  SName : string;
  TName : string;
  StName : string;
end;

Var
na_name : string;
na_id : integer;

Procedure DoPumpPlan;
Begin
  na_id:=-1;
  na_name:='';
  try
     try
       fr_pump_plan:=Tfr_pump_plan.Create(Application);
       if num_plan_work>0 Then fr_pump_plan.ShowModal
       Else MessageDlg('Не выбран план работы!', mtError, [mbOk], 0);
     finally
       fr_pump_plan.Free;
     end
  except
  end;
end;

procedure Tfr_pump_plan.bt_exitClick(Sender: TObject);
var
  ii,cc : integer;
  p : pointer;
begin
  cc:=tree_pump.Items.Count;
  For ii:=0 To cc-1 Do Begin
      p:=tree_pump.Items.Item[ii].Data;
      tree_pump.Items.Item[ii].Data:=nil;
      FreeMem(p);
  end;
  Close;
end;

procedure Tfr_pump_plan.ShowPlan(n_id : integer);
var
 par,pp : variant;
Begin
   cds_plan.Active:=false;
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=123;
   par[1]:=VarArrayOf(['pump','wp']);
   par[2]:=VarArrayOf([n_id,num_plan_work]);
   cod_err:=16;
   pp:=DM.GetData(par);
   If VarIsNull(pp) Then Exit;
   cds_plan.Data:=pp;
end;

procedure Tfr_pump_plan.tree_pumpChange(Sender: TObject; Node: TTreeNode);
Var
  tp : integer;
begin
   ed_property.Clear;
   tp:=PPumpOpt(node.Data)^.Tip;
   ShowPlan(PPumpOpt(node.Data)^.ID);
   Case tp of
      1 : Begin
            ed_property.Items.Add('Кустовая насосная станция:');
            ed_property.Items.Add(PPumpOpt(node.Data)^.Name);
            na_name:='';
            na_id:=-1;
          end;
      2 : Begin
            ed_property.Items.Add('Насосная станция:');
            ed_property.Items.Add(PPumpOpt(node.Data)^.Name);
            na_name:='';
            na_id:=-1;
          end;
      5 : Begin
            ed_property.Items.Add(PPumpOpt(node.Data)^.SName);
            ed_property.Items.Add('Насосный агрегат:');
            ed_property.Items.Add(PPumpOpt(node.Data)^.Name);
            ed_property.Items.Add(PPumpOpt(node.Data)^.TName);
            ed_property.Items.Add(PPumpOpt(node.Data)^.StName);
            na_id:=PPumpOpt(node.Data)^.ID;
            na_name:=PPumpOpt(node.Data)^.SName+' : '+PPumpOpt(node.Data)^.Name;
          end;
   end;
end;

procedure Tfr_pump_plan.FormCreate(Sender: TObject);
var
  par,pp : variant;
  hadr : pointer;
  Popt : PPumpOpt;
  nam,k : string;
  kd,ii : integer;
  nn : TTreeNode;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  For ii:=0 To 1 Do Begin
    If ii=1 Then Begin
       par[0]:=116;
       par[1]:=VarArrayOf(['st']);
       par[2]:=VarArrayOf([0]);
    end
    Else Begin
      par[0]:=24;
      par[1]:=null;
      par[2]:=null;
    end;
    cod_err:=16;
    pp:=DM.GetData(par);
    If VarIsNull(pp) Then Exit;
    cds_ns.Data:=pp;
    While not cds_ns.Eof Do Begin
      New(Popt);
      Popt^.ID:=cds_ns.FieldByName('id').AsInteger;
      kd:=Popt^.ID;
      If ii=1 Then Popt^.Tip:=1 Else Popt^.Tip:=2;
      Popt^.Name:=cds_ns.FieldByName('name').AsString;
      nam:=Popt^.Name;
      Popt^.SName:='';
      Popt^.TName:='';
      Popt^.StName:='';
      hadr:=tree_pump.Items.AddObject(nil,nam,Popt);
      If ii=1 Then k:='kns_id' Else k:='ns_id';
      par[0]:=86;
      par[1]:=VarArrayOf(['!k','obj']);
      par[2]:=VarArrayOf([k,kd]);
      cod_err:=17;
      pp:=DM.GetData(par);
      If not VarIsNull(pp) Then Begin
        cds_pump.Data:=pp;
        While not cds_pump.Eof Do Begin
          New(Popt);
          Popt^.ID:=cds_pump.FieldByName('id').AsInteger;
          Popt^.Tip:=5;
          Popt^.Name:=cds_pump.FieldByName('name').AsString;
          Popt^.SName:=nam;
          Popt^.TName:=cds_pump.FieldByName('tname').AsString;
          Case cds_pump.FieldByName('state').AsInteger of
             0 : Popt^.StName:='В работе';
             1 : Popt^.StName:='В резерве';
             2 : Popt^.StName:='В ремонте';
          end;
          nn:=tree_pump.Items.AddChildObject(hadr,Popt^.Name,Popt);
          nn.ImageIndex:=1;
          nn.SelectedIndex:=1;
          cds_pump.Next;
        end;
      end;
      cds_ns.Next;
    end;
  end;
end;

procedure Tfr_pump_plan.bt_addClick(Sender: TObject);
var
  ch,mi,st : integer;
  par,pp,p1 : variant;
begin
  If na_name='' Then Exit;
  ch:=Ask_Int('Час события','Введите час'+#13+'начала события',0,23,0);
  if ch<0 Then Exit;
  mi:=Ask_Int('Минуты','Уточните время'+#13+'события до минут'+#13+IntToStr(ch)+' часов ?? минут.',0,59,0);
  if mi<0 Then Exit;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=124;
  par[1]:=null;
  par[2]:=null;
  p1:=VarArrayOf(['Состояние насосного агрегата -->'+na_name,'Выберите состояние агрегата на '+IntToStr(ch)+'час. '+IntToStr(mi)+'мин.']);
  st:=GetIdSpr(p1,par);
  if st<0 Then Exit;
  par[0]:=125;
  par[1]:=VarArrayOf(['pump','st','h','m','wp']);
  par[2]:=VarArrayOf([na_id,st,ch,mi,num_plan_work]);
  cod_err:=31;
  DM.StartTrans;
  pp:=DM.RunSQL(par);
  If pp<>0 Then Begin
     DM.BackTrans;
     Exit;
  end;
  DM.ComTrans;
  ShowPlan(na_id);
  CreateWorkList;
end;

procedure Tfr_pump_plan.bt_delClick(Sender: TObject);
var
  ch,mi,st : integer;
  par,pp : variant;
begin
  if cds_plan.EOF Then Exit;
  if MessageDlg('Вы действительно хотите удалить выделенное событие?!!',
     mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=126;
  par[1]:=VarArrayOf(['pump','h','m']);
  par[2]:=VarArrayOf([na_id,cds_plan.FieldByName('hours').AsInteger,cds_plan.FieldByName('minutes').AsInteger]);
  cod_err:=32;
  DM.StartTrans;
  pp:=DM.RunSQL(par);
  If pp<>0 Then Begin
     DM.BackTrans;
     Exit;
  end;
  DM.ComTrans;
  ShowPlan(na_id);
  CreateWorkList;
end;

procedure Tfr_pump_plan.FormShow(Sender: TObject);
begin
  fr_pump_plan.Caption:='План работы насосных агрегатов: '+DM.GetNameSetWorkPlan;
  CreateWorkList;
end;

procedure Tfr_pump_plan.CreateWorkList;
var
  par,pp : variant;
Begin
   cds_workplan.Active:=false;
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=150;
   par[1]:=VarArrayOf(['wp','dt']);
   par[2]:=VarArrayOf([num_plan_work,daystart]);
   cod_err:=320;
   pp:=DM.GetData(par);
   If not VarIsNull(pp) Then Begin
      cds_workplan.data:=pp;
   end;
end;

procedure Tfr_pump_plan.ds_workplanDataChange(Sender: TObject;
  Field: TField);
var
  par,pp : variant;
  id : integer;
  nm : string;
begin
  ed_events_about.Lines.Clear;
  If cds_workplan.Active Then Begin
     If cds_workplan.RecordCount>0 Then Begin
        nm:=DM.GetKnsNsName(cds_workplan.FieldByName('KNS_ID').Value,cds_workplan.FieldByName('NS_ID').Value);
        if nm='' Then Exit;
        ed_events_about.Lines.Add('Насосная станция : '+nm);
        ed_events_about.Lines.Add('НА : '+cds_workplan.FieldByName('NAME').AsString);
        ed_events_about.Lines.Add(cds_workplan.FieldByName('TYPENAM').AsString);
        ed_events_about.Lines.Add('Переведен в состояние: "'+cds_workplan.FieldByName('STATNAME').AsString+'"');
     end;
  end;
end;

end.
