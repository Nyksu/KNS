unit Kust_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DBCtrls, Mask, ToolEdit, CurrEdit, RXDBCtrl,
  Db, DBClient;

type
  Tfr_kust_edit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    lb_place: TLabel;
    cds_kns: TClientDataSet;
    ds_kns: TDataSource;
    ed_kns: TDBLookupComboBox;
    Label3: TLabel;
    ed_nomer: TRxDBCalcEdit;
    cds_kust: TClientDataSet;
    ds_kust: TDataSource;
    ed_prefix: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    ed_shop: TDBLookupComboBox;
    ed_deposit: TDBLookupComboBox;
    cds_shop: TClientDataSet;
    cds_deposit: TClientDataSet;
    ds_shop: TDataSource;
    ds_deposit: TDataSource;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function KustToDB(var id_kust : integer; tx, ty, bx, by : integer) : variant;

var
  fr_kust_edit: Tfr_kust_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id : integer;
  rr : variant;
  is_new : boolean;
  ux,uy,b_x,b_y : integer;

Function KustToDB(var id_kust : integer; tx, ty, bx, by : integer) : variant;
Begin
  id:=id_kust;
  rr:=Null;
  ux:=tx;
  uy:=ty;
  b_x:=bx;
  b_y:=by;
  try
     try
       fr_kust_edit:=Tfr_kust_edit.Create(Application);
       fr_kust_edit.ShowModal;
     finally
       id_kust:=id;
       Result:=rr;
       fr_kust_edit.Free;
     end
  except
  end;
end;

procedure Tfr_kust_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_kust.State = dsEdit)or(cds_kust.State = dsInsert) Then cds_kust.Cancel;
  Close;
end;

procedure Tfr_kust_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  //¬ыбираем ÷ех
  par[0]:=1;//номер Ёс уЁл
  par[1]:=null; //имена
  par[2]:=null; //значени€
  cod_err:=4;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_shop.Data:=pp;
  //¬ыбираем месторождение
  par[0]:=6;//номер Ёс уЁл
  par[1]:=null; //имена
  par[2]:=null; //значени€
  cod_err:=4;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_deposit.Data:=pp;
  //¬ыбираем  Ќ—
  par[0]:=25;//номер Ёс уЁл
  par[1]:=null; //имена
  par[2]:=null; //значени€
  cod_err:=4;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_kns.Data:=pp;
  par[0]:=78;//номер Ёс уЁл
  par[1]:=VarArrayOf(['kust']); //имена
  par[2]:=VarArrayOf([id]); //значени€
  cod_err:=3;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_kust.Data:=pp;
  If cds_kust.RecordCount>0 Then Begin
     is_new:=false;
     cds_kust.Edit;
  end
  Else Begin
    cds_kust.Insert;
    is_new:=true;
  end;
end;

procedure Tfr_kust_edit.bt_okClick(Sender: TObject);
var
 par,pp : variant;
 ii : integer;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  try
   If is_new Then Begin
    par[0]:=79;//номер Ёс уЁл
    par[1]:=VarArrayOf(['nomer','kns','lnam','shop','dep','ux','uy','bx','by']); //имена
    par[2]:=VarArrayOf([cds_kust.FieldByName('nomer').AsInteger,
                        cds_kust.FieldByName('kns_id').AsInteger,
                        cds_kust.FieldByName('lastname').AsString,
                        cds_kust.FieldByName('shop_id').AsString,
                        cds_kust.FieldByName('deposit_id').AsString,
                        ux,uy,b_x,b_y]); //значени€
    cod_err:=32;
    DM.StartTrans;
    pp:=DM.RunSQL(par);
    If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
    end;
    DM.ComTrans;
    id:=DM.GetLastID;
    rr:=VarArrayCreate([0, 4], varVariant);
    rr[0]:=cds_kust.FieldByName('nomer').AsInteger;
    rr[1]:=cds_kust.FieldByName('kns_id').AsInteger;
    rr[2]:=cds_kust.FieldByName('lastname').AsString;
    rr[3]:=cds_kust.FieldByName('shop_id').AsString;
    rr[4]:=cds_kust.FieldByName('deposit_id').AsString;
   end
   Else If not VarIsNull(cds_kust.Delta) Then Begin
    par[0]:=80;//номер Ёс уЁл
    par[1]:=VarArrayOf(['nomer','kns','lnam','kust','shop','dep']); //имена
    par[2]:=VarArrayOf([cds_kust.FieldByName('nomer').AsInteger,
                        cds_kust.FieldByName('kns_id').AsInteger,
                        cds_kust.FieldByName('lastname').AsString,id,
                        cds_kust.FieldByName('shop_id').AsString,
                        cds_kust.FieldByName('deposit_id').AsString]); //значени€
    cod_err:=32;
    DM.StartTrans;
    pp:=DM.RunSQL(par);
    If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
    end;
    DM.ComTrans;
    rr:=VarArrayCreate([0, 4], varVariant);
    rr[0]:=cds_kust.FieldByName('nomer').AsInteger;
    rr[1]:=cds_kust.FieldByName('kns_id').AsInteger;
    rr[2]:=cds_kust.FieldByName('lastname').AsString;
    rr[3]:=cds_kust.FieldByName('shop_id').AsString;
    rr[4]:=cds_kust.FieldByName('deposit_id').AsString;
   end;
  except
  end;
  Close;
end;

end.
