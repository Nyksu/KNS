unit VRP_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ToolEdit, CurrEdit, RXDBCtrl, Mask, DBCtrls,
  Db, DBClient;

type
  Tfr_vrp_edit = class(TForm)
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

Function VRPToDB(var id_vrp : integer; x, y, le, n_plan, id_spr : integer) : variant;

var
  fr_vrp_edit: Tfr_vrp_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id : integer;
  rr : variant;
  is_new : boolean;
  ux,uy,ll,n_p,sp : integer;

Function VRPToDB(var id_vrp : integer; x, y, le, n_plan, id_spr : integer) : variant;
Begin
  id:=id_vrp;
  rr:=Null;
  ux:=x;
  uy:=y;
  ll:=le;
  n_p:=n_plan;
  sp:=id_spr;
  try
     try
       fr_vrp_edit:=Tfr_vrp_edit.Create(Application);
       fr_vrp_edit.ShowModal;
     finally
       id_vrp:=id;
       Result:=rr;
       fr_vrp_edit.Free;
     end
  except
  end;
end;

procedure Tfr_vrp_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_ns.State = dsEdit)or(cds_ns.State = dsInsert) Then cds_ns.Cancel;
  Close;
end;

procedure Tfr_vrp_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin
  cds_water.InsertRecord([0,'Пресная']);
  cds_water.InsertRecord([2,'Артезианская']);
  cds_water.InsertRecord([3,'Подтоварная']);
  par:=VarArrayCreate([0, 3], varVariant);
  If n_p=0 Then par[0]:=24 Else par[0]:=25;
  par[1]:=null;
  par[2]:=null;
  par[3]:=null;
  cod_err:=16;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_shop.Data:=pp;
  If n_p=0 Then par[0]:=32 Else par[0]:=33;
  If sp>=0 Then Begin
     par[1]:=VarArrayOf(['vrp','spr']);
     par[2]:=VarArrayOf([id,sp]);
     par[3]:=VarArrayOf(['com']);
  end
  Else Begin
     par[1]:=VarArrayOf(['vrp']);
     par[2]:=VarArrayOf([id]);
  end;
  cod_err:=17;
  If n_p>0 Then ed_water.DataSource:=nil;
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
  If n_p=0 Then pn_shapka.Caption:=pn_shapka.Caption+' НС'
  Else Begin
     pn_shapka.Caption:=pn_shapka.Caption+' КНС';
     lb_place.Caption:='КНС :';
     ed_water.Enabled:=false;
     ed_place.DataField:='kns_id';
  end;
  ed_place.DataSource:=ds_ns;
end;

procedure Tfr_vrp_edit.bt_okClick(Sender: TObject);
var
 par,pp : variant;
 ii : integer;
begin
  //If (cds_kns.State = dsEdit)or(cds_kns.State = dsInsert) Then cds_kns.Post;
  par:=VarArrayCreate([0, 2], varVariant);
  try
  If is_new Then Begin //Inseert
     CASE n_p of
     4,0 : Begin
             par[0]:=34;
             par[1]:=VarArrayOf(['ns','name','nom','wt','ug','x','y','len']); //имена
             par[2]:=VarArrayOf([cds_ns.FieldByName('ns_id').AsInteger, //значения
                              cds_ns.FieldByName('name').AsString,
                              cds_ns.FieldByName('nomer').AsInteger,
                              cds_ns.FieldByName('water').AsInteger,
                              0,ux,uy,ll]);
           end;
     1,2 : Begin
             par[0]:=35;
             par[1]:=VarArrayOf(['kns','name','nom','ug','x','y','len']); //имена
             par[2]:=VarArrayOf([cds_ns.FieldByName('kns_id').AsInteger, //значения
                                 cds_ns.FieldByName('name').AsString,
                                 cds_ns.FieldByName('nomer').AsInteger,
                                 0,ux,uy,ll]);
           end;
     end;
     cod_err:=34;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     DM.ComTrans;
     id:=DM.GetLastID;
     rr:=VarArrayCreate([0, 3], varVariant);
     For ii:=0 to 3 Do rr[ii]:=par[2][ii];
  end
  Else If not VarIsNull(cds_ns.Delta) Then Begin //Update
     if (n_p=0)or(n_p=4) Then Begin
       par[0]:=62;
       par[1]:=VarArrayOf(['vrp','ns','name','nom','wt']); //имена
       par[2]:=VarArrayOf([id,cds_ns.FieldByName('ns_id').AsInteger, //значения
             cds_ns.FieldByName('name').AsString,
             cds_ns.FieldByName('nomer').AsInteger,
             cds_ns.FieldByName('water').AsInteger]);
     end
     Else Begin
       par[0]:=63;
       par[1]:=VarArrayOf(['vrp','kns','name','nom']); //имена
       par[2]:=VarArrayOf([id,cds_ns.FieldByName('kns_id').AsInteger, //значения
             cds_ns.FieldByName('name').AsString,
             cds_ns.FieldByName('nomer').AsInteger]);
     end;
     cod_err:=35;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     DM.ComTrans;
     rr:=VarArrayCreate([0, 3], varVariant);
     For ii:=1 to 3 Do rr[ii-1]:=par[2][ii];
     if (n_p=0)or(n_p=4) Then rr[3]:=par[2][4] Else rr[3]:=null;
  end;
  except
  end;
  Close;
end;

end.
