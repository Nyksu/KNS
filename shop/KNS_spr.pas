unit KNS_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBCtrls, DBClient, Mask, RXCtrls, ToolEdit,
  CurrEdit, RXDBCtrl, Buttons;

type
  Tfr_kns_edit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    rg_kns_stok: TRadioGroup;
    cds_shop: TClientDataSet;
    cds_kns: TClientDataSet;
    ed_shop: TDBLookupComboBox;
    ds_shop: TDataSource;
    ds_kns: TDataSource;
    Label1: TLabel;
    ed_name: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    ed_day_debet: TRxDBCalcEdit;
    RxLabel1: TRxLabel;
    Label4: TLabel;
    ed_stok_pres: TRxDBCalcEdit;
    RxLabel2: TRxLabel;
    ed_d_stok: TRxDBCalcEdit;
    ed_loss_pres: TRxDBCalcEdit;
    Label5: TLabel;
    Label6: TLabel;
    RxLabel4: TRxLabel;
    RxLabel5: TRxLabel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    RxLabel6: TRxLabel;
    cds_deposit: TClientDataSet;
    ds_deposit: TDataSource;
    Label7: TLabel;
    ed_deposit: TDBLookupComboBox;
    DBText1: TDBText;
    RxLabel3: TRxLabel;
    Label8: TLabel;
    procedure rg_kns_stokClick(Sender: TObject);
    procedure bt_exitClick(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Procedure SetEnable;
    { Private declarations }
  public
    { Public declarations }
  end;

Function KNSToDB(var id_kns : integer; tx, ty, bx, by : integer;cm : boolean) : variant;

var
  fr_kns_edit: Tfr_kns_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id : integer;
  rr : variant;
  is_new : boolean;
  ux,uy,b_x,b_y : integer;
  can_all_modify : boolean;


Function KNSToDB(var id_kns : integer; tx, ty, bx, by : integer;cm : boolean) : variant;
Begin
  id:=id_kns;
  rr:=Null;
  ux:=tx;
  uy:=ty;
  b_x:=bx;
  b_y:=by;
  can_all_modify:=cm;
  try
     try
       fr_kns_edit:=Tfr_kns_edit.Create(Application);
       fr_kns_edit.ShowModal;
     finally
       id_kns:=id;
       Result:=rr;
       fr_kns_edit.Free;
     end
  except
  end;
end;

Procedure Tfr_kns_edit.SetEnable;
Begin
   If rg_kns_stok.ItemIndex=0 Then Begin
      ed_stok_pres.Enabled:=false;
      ed_d_stok.Enabled:=false;
      ed_loss_pres.Enabled:=true;
   end
   Else Begin
      ed_stok_pres.Enabled:=true;
      ed_d_stok.Enabled:=true;
      ed_loss_pres.Enabled:=false;
   end;
end;

procedure Tfr_kns_edit.rg_kns_stokClick(Sender: TObject);
begin
   SetEnable;
   If rg_kns_stok.ItemIndex=0 Then Begin
      cds_kns.FieldByName('is_stok').AsInteger:=0;
   end
   Else Begin
      cds_kns.FieldByName('is_stok').AsInteger:=1;
   end;
end;

procedure Tfr_kns_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_kns.State = dsEdit)or(cds_kns.State = dsInsert) Then cds_kns.Cancel;
  Close;
end;

procedure Tfr_kns_edit.bt_okClick(Sender: TObject);
var
 par,pp : variant;
 ii : integer;
begin
  //If (cds_kns.State = dsEdit)or(cds_kns.State = dsInsert) Then cds_kns.Post;
  par:=VarArrayCreate([0, 2], varVariant);
  try
  If (is_new) and (not VarIsNull(cds_kns.Delta)) Then Begin //Inseert
     par[0]:=20;
     par[1]:=VarArrayOf(['shop', 'name', 'l_pres', 'd_d', 's_p', 'd_s', 'i_s', 'ux', 'uy', 'bx', 'by', 'dep']); //имена
     par[2]:=VarArrayOf([cds_kns.FieldByName('shop_id').AsInteger, //значени€
             cds_kns.FieldByName('name').AsString,
             cds_kns.FieldByName('loss_pressure').AsFloat,
             cds_kns.FieldByName('days_debet').AsFloat,
             cds_kns.FieldByName('stok_pressure').AsFloat,
             cds_kns.FieldByName('d_stok').AsFloat,
             rg_kns_stok.ItemIndex,ux,uy,b_x,b_y,
             cds_kns.FieldByName('deposit_id').AsInteger]);
     cod_err:=5;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
     end;
     DM.ComTrans;
     id:=DM.GetLastID;
     rr:=VarArrayCreate([0, 7], varVariant);
     For ii:=0 to 6 Do rr[ii]:=par[2][ii];
     rr[7]:=cds_kns.FieldByName('deposit_id').AsInteger;
  end
  Else If not VarIsNull(cds_kns.Delta) Then Begin //Update
     par[0]:=49;
     par[1]:=VarArrayOf(['kns','shop', 'name', 'l_pres', 'd_d', 's_p', 'd_s', 'i_s','dep'{, 'ux', 'uy', 'bx', 'by'}]); //имена
     par[2]:=VarArrayOf([id,cds_kns.FieldByName('shop_id').AsInteger, //значени€
             cds_kns.FieldByName('name').AsString,
             cds_kns.FieldByName('loss_pressure').AsFloat,
             cds_kns.FieldByName('days_debet').AsFloat,
             cds_kns.FieldByName('stok_pressure').AsFloat,
             cds_kns.FieldByName('d_stok').AsFloat,
             rg_kns_stok.ItemIndex,
             cds_kns.FieldByName('deposit_id').AsInteger{,ux,uy,b_x,b_y}]);
     cod_err:=5;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
     end;
     DM.ComTrans;     
     rr:=VarArrayCreate([0, 7], varVariant);
     For ii:=0 to 6 Do rr[ii]:=par[2][ii+1];
     rr[7]:=cds_kns.FieldByName('deposit_id').AsInteger;
  end;
  except
  end;
  Close;
end;

procedure Tfr_kns_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin
  If can_all_modify Then Begin
     ed_name.Enabled:=true;
     rg_kns_stok.Enabled:=true;
  end;
  par:=VarArrayCreate([0, 2], varVariant);
  //¬ыбираем месторождение
  par[0]:=6;//номер Ёс уЁл
  par[1]:=null; //имена
  par[2]:=null; //значени€
  cod_err:=4;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_deposit.Data:=pp;
  //¬ыбираем цех
  par[0]:=1;//номер Ёс уЁл
  par[1]:=null; //имена
  par[2]:=null; //значени€
  cod_err:=4;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_shop.Data:=pp;
  par[0]:=19;//номер Ёс уЁл
  par[1]:=VarArrayOf(['KNS']); //имена
  par[2]:=VarArrayOf([id]); //значени€
  cod_err:=3;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_kns.Data:=pp;
  If cds_kns.RecordCount>0 Then Begin
     SetEnable;
     is_new:=false;
     cds_kns.Edit;
     rg_kns_stok.ItemIndex:=cds_kns.FieldByName('is_stok').AsInteger;
  end
  Else If can_all_modify Then Begin
    cds_kns.Insert;
    is_new:=true;
    cds_kns.FieldByName('is_stok').AsInteger:=0;
  end
  Else Begin
    bt_ok.Enabled:=false;
    cds_shop.Active:=false;
    cds_kns.Active:=false;
  end;
end;

end.
