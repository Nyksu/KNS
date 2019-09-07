unit Pump_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ToolEdit, CurrEdit, RXDBCtrl, Mask, DBCtrls,
  Db, DBClient, Grids, DBGrids, RXCtrls, RxLookup;

type
  Tfr_pump_edit = class(TForm)
    Panel1: TPanel;
    pn_shapka: TPanel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    cds_pump: TClientDataSet;
    ds_pump: TDataSource;
    Label3: TLabel;
    ed_wheel: TRxDBCalcEdit;
    Label1: TLabel;
    ed_name: TDBEdit;
    cds_type: TClientDataSet;
    ds_type: TDataSource;
    Label2: TLabel;
    Label5: TLabel;
    rg_state: TRadioGroup;
    rg_regim: TRadioGroup;
    ed_flow: TRxDBCalcEdit;
    ed_workflow: TRxDBCalcEdit;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    Label4: TLabel;
    ed_pressure: TRxDBCalcEdit;
    Label6: TLabel;
    RxLabel3: TRxLabel;
    bt_getspr: TButton;
    ed_type: TRxDBLookupCombo;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure rg_stateClick(Sender: TObject);
    procedure rg_regimClick(Sender: TObject);
    procedure bt_getsprClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function PumpToDB(var id_Pump : integer; uu1, uu2, n_plan, spr : integer;cm : boolean) : variant;


var
  fr_pump_edit: Tfr_pump_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id,id_spr : integer;
  rr : variant;
  is_new : boolean;
  u1,u2,n_p : integer;
  can_all_modify : boolean;

Function PumpToDB(var  id_Pump : integer; uu1, uu2, n_plan, spr : integer;cm : boolean) : variant;
Begin
  id:=id_Pump;
  rr:=Null;
  u1:=uu1;
  u2:=uu2;
  id_spr:=spr;
  n_p:=n_plan;
  can_all_modify:=cm;
  try
     try
       fr_pump_edit:=Tfr_pump_edit.Create(Application);
       fr_pump_edit.ShowModal;
     finally
       id_pump:=id;
       Result:=rr;
       fr_pump_edit.Free;
     end
  except
  end;
end;

procedure Tfr_pump_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_pump.State = dsEdit)or(cds_pump.State = dsInsert) Then cds_pump.Cancel;
  Close;
end;

procedure Tfr_pump_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=14;
  par[1]:=null;
  par[2]:=null;
  cod_err:=16;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_type.Data:=pp;
  par[0]:=83;
  par[1]:=VarArrayOf(['pump']);
  par[2]:=VarArrayOf([id]);
  cod_err:=17;
  If can_all_modify Then ed_name.Enabled:=true;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_pump.Data:=pp;
  If cds_pump.RecordCount>0 Then Begin
     is_new:=false;
     cds_pump.Edit;
     rg_state.ItemIndex:=cds_pump.FieldByName('state').AsInteger;
     rg_regim.ItemIndex:=cds_pump.FieldByName('regim').AsInteger;
  end
  Else If can_all_modify Then Begin
    cds_pump.Insert;
    cds_pump.FieldByName('state').AsInteger:=0;
    cds_pump.FieldByName('regim').AsInteger:=0;
    CASE n_p of
       2 : cds_pump.FieldByName('kns_id').AsInteger:=id_spr;
       4 : cds_pump.FieldByName('ns_id').AsInteger:=id_spr;
    end;
    is_new:=true;
  end
  Else Begin
    cds_pump.Active:=false;
    cds_type.Active:=false;
    bt_ok.Enabled:=false;
  end;
end;

procedure Tfr_pump_edit.bt_okClick(Sender: TObject);
var
 par,pp,p1,p2,p3 : variant;
 ii, id_b, id_e : integer;
 kk : string;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  try
  If is_new Then Begin //Inseert
     CASE n_p of
       2 : kk:='kns_id';
       4 : kk:='ns_id';
     end;
     par[0]:=84;
     par[1]:=VarArrayOf(['obj','type','pres','state','u1','u2','wc','fw','wfw','name','regim','!k']); //имена
     par[2]:=VarArrayOf([cds_pump.FieldByName(kk).Value,
             cds_pump.FieldByName('pump_type_id').AsInteger,
             cds_pump.FieldByName('pressure').AsFloat,
             rg_state.ItemIndex,u1,u2,
             cds_pump.FieldByName('wheel_count').AsInteger,
             cds_pump.FieldByName('flow').AsInteger,
             cds_pump.FieldByName('workflow').AsFloat,
             cds_pump.FieldByName('name').AsString,
             rg_regim.ItemIndex,kk]);
     cod_err:=31;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     id:=DM.GetLastID;
     rr:=VarArrayCreate([0, 9], varVariant);
     For ii:=0 to 3 Do rr[ii]:=par[2][ii];
     For ii:=6 to 10 Do rr[ii-2]:=par[2][ii];
     rr[9]:=cds_type.FieldByName('name').AsString;
  end
  ELSE If not VarIsNull(cds_pump.Delta) Then Begin //Update
     par[0]:=85;
     par[1]:=VarArrayOf(['type','pres','state','wc','fw','wfw','name','regim','pump']); //имена
     par[2]:=VarArrayOf([cds_pump.FieldByName('pump_type_id').AsInteger,
             cds_pump.FieldByName('pressure').AsFloat,
             rg_state.ItemIndex,
             cds_pump.FieldByName('wheel_count').AsInteger,
             cds_pump.FieldByName('flow').AsInteger,
             cds_pump.FieldByName('workflow').AsFloat,
             cds_pump.FieldByName('name').AsString,
             rg_regim.ItemIndex,id]);
     cod_err:=30;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     rr:=VarArrayCreate([0, 9], varVariant);
     CASE n_p of
       2 : rr[0]:=cds_pump.FieldByName('kns_id').Value;
       4 : rr[0]:=cds_pump.FieldByName('ns_id').Value;
     end;
     For ii:=1 to 8 Do rr[ii]:=par[2][ii-1];
     rr[9]:=cds_type.FieldByName('name').AsString;
  end;
  except
  end;
  Close;
end;

procedure Tfr_pump_edit.rg_stateClick(Sender: TObject);
begin
  cds_pump.FieldByName('state').AsInteger:=rg_state.ItemIndex;
  If rg_state.ItemIndex>0 Then rg_regim.Enabled:=false
  Else rg_regim.Enabled:=true;
end;

procedure Tfr_pump_edit.rg_regimClick(Sender: TObject);
begin
  cds_pump.FieldByName('regim').AsInteger:=rg_regim.ItemIndex;
end;

procedure Tfr_pump_edit.bt_getsprClick(Sender: TObject);
begin
  cds_pump.FieldByName('wheel_count').AsInteger:=cds_type.FieldByName('wheel_count').AsInteger;
end;

end.
