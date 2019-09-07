unit NS_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBCtrls, DBClient, Mask, RXCtrls, ToolEdit,
  CurrEdit, RXDBCtrl, Buttons;

type
  Tfr_ns_edit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    cds_ns: TClientDataSet;
    ds_ns: TDataSource;
    ed_name: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    ed_day_debet: TRxDBCalcEdit;
    RxLabel1: TRxLabel;
    ed_loss_pres: TRxDBCalcEdit;
    Label6: TLabel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    cds_shop: TClientDataSet;
    ds_shop: TDataSource;
    Label1: TLabel;
    ed_shop: TDBLookupComboBox;
    RxLabel5: TRxLabel;
    cds_deposit: TClientDataSet;
    ds_deposit: TDataSource;
    ed_deposit: TDBLookupComboBox;
    Label7: TLabel;
    procedure bt_exitClick(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function NSToDB(var id_ns : integer; tx, ty, bx, by : integer;cm : boolean) : variant;

var
  fr_ns_edit: Tfr_ns_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id : integer;
  rr : variant;
  is_new : boolean;
  ux,uy,b_x,b_y : integer;
  can_all_modify : boolean;


Function NSToDB(var id_ns : integer; tx, ty, bx, by : integer;cm : boolean) : variant;
Begin
  id:=id_ns;
  rr:=Null;
  ux:=tx;
  uy:=ty;
  b_x:=bx;
  b_y:=by; 
  can_all_modify:=cm;
  try
     try
       fr_ns_edit:=Tfr_ns_edit.Create(Application);
       fr_ns_edit.ShowModal;
     finally
       id_ns:=id;
       Result:=rr;
       fr_ns_edit.Free;
     end
  except
  end;
end;

procedure Tfr_ns_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_ns.State = dsEdit)or(cds_ns.State = dsInsert) Then cds_ns.Cancel;
  Close;
end;

procedure Tfr_ns_edit.bt_okClick(Sender: TObject);
var
 par,pp : variant;
 ii : integer;
begin
  //If (cds_kns.State = dsEdit)or(cds_kns.State = dsInsert) Then cds_kns.Post;
  par:=VarArrayCreate([0, 2], varVariant);
  try
  If (is_new) and (not VarIsNull(cds_ns.Delta)) Then Begin //Inseert
     par[0]:=21;
     par[1]:=VarArrayOf(['shop', 'name', 'l_pres', 'd_d', 'ux', 'uy', 'bx', 'by', 'dep']); //имена
     par[2]:=VarArrayOf([cds_ns.FieldByName('shop_id').AsInteger, //значени€
             cds_ns.FieldByName('name').AsString,
             cds_ns.FieldByName('loss_pressure').AsFloat,
             cds_ns.FieldByName('days_debet').AsFloat,
             ux,uy,b_x,b_y,cds_ns.FieldByName('deposit_id').AsInteger]);
     cod_err:=8;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
     end;
     DM.ComTrans;
     id:=DM.GetLastID;
     rr:=VarArrayCreate([0, 4], varVariant);
     For ii:=0 to 3 Do rr[ii]:=par[2][ii];
     rr[4]:=cds_ns.FieldByName('deposit_id').AsInteger;
  end
  Else If not VarIsNull(cds_ns.Delta) Then Begin //Update
     par[0]:=58;
     par[1]:=VarArrayOf(['ns','shop', 'name', 'l_pres', 'd_d', 'dep'{, 'ux', 'uy', 'bx', 'by'}]); //имена
     par[2]:=VarArrayOf([id,cds_ns.FieldByName('shop_id').AsInteger, //значени€
             cds_ns.FieldByName('name').AsString,
             cds_ns.FieldByName('loss_pressure').AsFloat,
             cds_ns.FieldByName('days_debet').AsFloat,
             cds_ns.FieldByName('deposit_id').AsInteger{,ux,uy,b_x,b_y}]);
     cod_err:=5;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
     end;
     DM.ComTrans;     
     rr:=VarArrayCreate([0, 4], varVariant);
     For ii:=0 to 4 Do rr[ii]:=par[2][ii+1];
  end;
  except
  end;
  Close;
end;

procedure Tfr_ns_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin 
  If can_all_modify Then ed_name.Enabled:=true;
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
  cod_err:=6;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_shop.Data:=pp;
  par[0]:=22;//номер Ёс уЁл
  par[1]:=VarArrayOf(['NS']); //имена
  par[2]:=VarArrayOf([id]); //значени€
  cod_err:=7;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_ns.Data:=pp;
  If cds_ns.RecordCount>0 Then Begin
     is_new:=false;
     cds_ns.Edit;
  end
  Else If can_all_modify Then Begin
    cds_ns.Insert;
    is_new:=true;
  end
  Else Begin
    cds_shop.Active:=false;
    cds_ns.Active:=false;
    bt_ok.Enabled:=false;
  end;
end;

end.
