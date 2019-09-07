unit VPP_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ToolEdit, CurrEdit, RXDBCtrl, Mask, DBCtrls,
  Db, DBClient;

type
  Tfr_vpp_edit = class(TForm)
    Panel1: TPanel;
    pn_shapka: TPanel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    cds_shop: TClientDataSet;
    cds_ns: TClientDataSet;
    ds_shop: TDataSource;
    ds_ns: TDataSource;
    lb_place: TLabel;
    ed_place: TDBLookupComboBox;
    Label2: TLabel;
    ed_name: TDBEdit;
    Label3: TLabel;
    ed_nomer: TRxDBCalcEdit;
    Label1: TLabel;
    ed_water: TDBLookupComboBox;
    cds_water: TClientDataSet;
    cds_waterid: TIntegerField;
    cds_waterName: TStringField;
    ds_water: TDataSource;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function VPPToDB(var id_vpp : integer; x, y, le, n_plan, id_spr : integer) : variant;

var
  fr_vpp_edit: Tfr_vpp_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id : integer;
  rr : variant;
  is_new : boolean;
  ux,uy,ll,n_p,sp : integer;

Function VPPToDB(var id_vpp : integer; x, y, le, n_plan, id_spr : integer) : variant;
Begin
  id:=id_vpp;
  rr:=Null;
  ux:=x;
  uy:=y;
  ll:=le;
  n_p:=n_plan;
  sp:=id_spr;
  try
     try
       fr_vpp_edit:=Tfr_vpp_edit.Create(Application);
       fr_vpp_edit.ShowModal;
     finally
       id_vpp:=id;
       Result:=rr;
       fr_vpp_edit.Free;
     end
  except
  end;
end;

procedure Tfr_vpp_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_ns.State = dsEdit)or(cds_ns.State = dsInsert) Then cds_ns.Cancel;
  Close;
end;

procedure Tfr_vpp_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin
  cds_water.InsertRecord([0,'Пресная']);
  cds_water.InsertRecord([2,'Артезианская']);
  cds_water.InsertRecord([3,'Подтоварная']);
  par:=VarArrayCreate([0, 2], varVariant);
  CASE n_p of
       0,2 : par[0]:=25;
       1,3 : par[0]:=181;
         4 : par[0]:=24;
  end;
  par[1]:=null;
  par[2]:=null;
  cod_err:=16;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_shop.Data:=pp;
  CASE n_p of
       0,2 : par[0]:=26;
       1,3 : par[0]:=27;
         4 : par[0]:=74;
  end;
  par[1]:=VarArrayOf(['vpp']);
  par[2]:=VarArrayOf([id]);
  cod_err:=17;
  If (n_p=1)or(n_p=3) Then Begin
     ed_water.DataSource:=nil;
     ed_nomer.DataSource:=nil;
  end;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_ns.Data:=pp;
  If cds_ns.RecordCount>0 Then Begin
     is_new:=false;
     cds_ns.Edit;
  end
  Else Begin
    cds_ns.Insert;
    is_new:=true;
  end;
  CASE n_p of
  0,2 : pn_shapka.Caption:=pn_shapka.Caption+' КНС';
  1,3 : Begin
         pn_shapka.Caption:=pn_shapka.Caption+' Куста скважин';
         lb_place.Caption:='Куст :';
         ed_water.Enabled:=false;
         ed_nomer.Enabled:=false;
         ed_place.DataField:='kust_id';
        end;
    4 : Begin
         pn_shapka.Caption:=pn_shapka.Caption+' НС';
         lb_place.Caption:='НС :';
         ed_place.DataField:='ns_id';
        end;
  end;
  ed_place.DataSource:=ds_ns;
end;

procedure Tfr_vpp_edit.bt_okClick(Sender: TObject);
var
 par,pp : variant;
 ii : integer;
begin
  //If (cds_kns.State = dsEdit)or(cds_kns.State = dsInsert) Then cds_kns.Post;
  par:=VarArrayCreate([0, 2], varVariant);
  try
  If is_new Then Begin //Inseert
     CASE n_p of
     0,2 : Begin
            par[0]:=29;
            par[1]:=VarArrayOf(['kns','name','nom','wt','ug','x','y','len']); //имена
            par[2]:=VarArrayOf([cds_ns.FieldByName('kns_id').AsInteger, //значения
                                cds_ns.FieldByName('name').AsString,
                                cds_ns.FieldByName('nomer').AsInteger,
                                cds_ns.FieldByName('water').AsInteger,
                                0,ux,uy,ll]);
           end;
     1,3 : Begin
            par[0]:=30;
            par[1]:=VarArrayOf(['kust','name','ug','x','y','len']); //имена
            par[2]:=VarArrayOf([cds_ns.FieldByName('kust_id').AsInteger, //значения
                                cds_ns.FieldByName('name').AsString,0,ux,uy,ll]);
           end;
       4 : Begin
            par[0]:=100;
            par[1]:=VarArrayOf(['ns','name','nom','wt','ug','x','y','len']); //имена
            par[2]:=VarArrayOf([cds_ns.FieldByName('ns_id').AsInteger, //значения
                                cds_ns.FieldByName('name').AsString,
                                cds_ns.FieldByName('nomer').AsInteger,
                                cds_ns.FieldByName('water').AsInteger,
                                0,ux,uy,ll]);
           end;
     end;
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
     rr:=VarArrayCreate([0, 1], varVariant);
     if (n_p=2)or(n_p=0) Then rr:=VarArrayCreate([0, 3], varVariant);
     For ii:=0 to 1 Do rr[ii]:=par[2][ii];
     if (n_p=2)or(n_p=0) Then For ii:=2 to 3 Do rr[ii]:=par[2][ii];
  end
  Else If not VarIsNull(cds_ns.Delta) Then Begin //Update
     CASE n_p of
     0,2 : Begin
            par[0]:=60;
            par[1]:=VarArrayOf(['vpp','kns','name','nom','wt']); //имена
            par[2]:=VarArrayOf([id,cds_ns.FieldByName('kns_id').AsInteger, //значения
                                cds_ns.FieldByName('name').AsString,
                                cds_ns.FieldByName('nomer').AsInteger,
                                cds_ns.FieldByName('water').AsInteger]);
           end;
     1,3 : Begin
            par[0]:=61;
            par[1]:=VarArrayOf(['vpp','kust','name']); //имена
            par[2]:=VarArrayOf([id,cds_ns.FieldByName('kust_id').AsInteger, //значения
                                cds_ns.FieldByName('name').AsString]);
           end;
       4 : Begin
            par[0]:=101;
            par[1]:=VarArrayOf(['vpp','ns','name','nom','wt']); //имена
            par[2]:=VarArrayOf([id,cds_ns.FieldByName('ns_id').AsInteger, //значения
                                cds_ns.FieldByName('name').AsString,
                                cds_ns.FieldByName('nomer').AsInteger,
                                cds_ns.FieldByName('water').AsInteger]);
           end;
     end;
     cod_err:=33;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     DM.ComTrans;
     rr:=VarArrayCreate([0, 1], varVariant);
     if (n_p=2)or(n_p=0) Then rr:=VarArrayCreate([0, 3], varVariant);
     For ii:=1 to 2 Do rr[ii-1]:=par[2][ii];
     if (n_p=2)or(n_p=0) Then For ii:=3 to 4 Do rr[ii-1]:=par[2][ii];
  end;
  except
  end;
  Close;
end;

end.
