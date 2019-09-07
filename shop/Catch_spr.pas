unit Catch_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ToolEdit, CurrEdit, RXDBCtrl, Mask, DBCtrls,
  Db, DBClient, Grids, DBGrids;

type
  Tfr_catch_edit = class(TForm)
    Panel1: TPanel;
    pn_shapka: TPanel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    cds_obj: TClientDataSet;
    ds_obj: TDataSource;
    ds_catch: TDataSource;
    lb_place: TLabel;
    Label2: TLabel;
    ed_name: TDBEdit;
    Label3: TLabel;
    ed_d: TRxDBCalcEdit;
    Label1: TLabel;
    ed_open: TRxDBCalcEdit;
    Label4: TLabel;
    ed_setting: TDBEdit;
    ch_open: TCheckBox;
    ch_close: TCheckBox;
    rg_tp_catch: TRadioGroup;
    gr_obj: TDBGrid;
    cds_catch: TClientDataSet;
    cds_deposit: TClientDataSet;
    ds_deposit: TDataSource;
    cds_shop: TClientDataSet;
    ds_shop: TDataSource;
    Label5: TLabel;
    ed_deposit: TDBLookupComboBox;
    Label6: TLabel;
    ed_shop: TDBLookupComboBox;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure ch_closeClick(Sender: TObject);
    procedure ch_openClick(Sender: TObject);
    procedure rg_tp_catchClick(Sender: TObject);
    procedure ed_openExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function CatchToDB(var id_catch, closed : integer; uu1,uu2,n_plan,id_obj : integer;cm : boolean) : variant;


var
  fr_catch_edit: Tfr_catch_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id,id_spr : integer;
  rr : variant;
  is_new,creat_state : boolean;
  n_p,cl,u1,u2,obj_id : integer;
  can_all_modify : boolean;

Function CatchToDB(var  id_catch, closed : integer; uu1,uu2,n_plan,id_obj : integer;cm : boolean) : variant;
Begin
  id:=id_catch;
  id_spr:=-1;
  rr:=Null;
  u1:=uu1;
  u2:=uu2;
  n_p:=n_plan;
  cl:=0;
  creat_state:=true;
  obj_id:=id_obj;
  can_all_modify:=cm;
  try
     try
       fr_catch_edit:=Tfr_catch_edit.Create(Application);
       fr_catch_edit.ShowModal;
     finally
       id_catch:=id;
       Result:=rr;
       closed:=cl;
       fr_catch_edit.Free;
     end
  except
  end;
end;

procedure Tfr_catch_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_catch.State = dsEdit)or(cds_catch.State = dsInsert) Then cds_catch.Cancel;
  Close;
end;

procedure Tfr_catch_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
 trtr : boolean;
begin
  If not can_all_modify Then Begin
     rg_tp_catch.Enabled:=false;
     gr_obj.Enabled:=false;
  end;
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
  //¬ыбираем задвижку
  par[0]:=37;
  par[1]:=VarArrayOf(['catch']);
  par[2]:=VarArrayOf([id]);
  cod_err:=17;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_catch.Data:=pp;
  If cds_catch.RecordCount>0 Then Begin
     is_new:=false;
     par[0]:=25;
     if not VarIsNull(cds_catch.FieldByName('kns_id').Value) Then id_spr:=cds_catch.FieldByName('kns_id').Value;
     if not VarIsNull(cds_catch.FieldByName('ns_id').Value) Then Begin
        par[0]:=24;
        id_spr:=cds_catch.FieldByName('ns_id').Value;
        lb_place.Caption:='Ќ— :';
        rg_tp_catch.ItemIndex:=1;
     end;
     if not VarIsNull(cds_catch.FieldByName('kust_id').Value) Then Begin
        par[0]:=181{28};
        id_spr:=cds_catch.FieldByName('kust_id').Value;
        lb_place.Caption:=' уст :';
        rg_tp_catch.ItemIndex:=2;
     end;
     par[1]:=null;
     par[2]:=null;
     cod_err:=16;
     pp:=DM.GetData(par);
     If VarIsNull(pp) Then Exit;
     cds_obj.Data:=pp;
     trtr:=cds_obj.Locate('id',VarArrayOf([id_spr]),[loCaseInsensitive]);
     If not trtr Then Begin
        cds_obj.First;
        While (not cds_obj.EOF)or(cds_obj.FieldByName('id').AsInteger<>id_spr)
               Do cds_obj.Next;
     end;
     cds_catch.Edit;
  end
  Else Begin
    If not can_all_modify Then Begin
       bt_ok.Enabled:=false;
       cds_obj.Active:=false;
       cds_catch.Active:=false;
       Exit;
    end;
    cds_catch.Insert;
    is_new:=true;
    CASE n_p of
       0,1 : Begin
              par[0]:=25;
              par[1]:=null;
              par[2]:=null;
             end;
         2 : Begin
              par:=VarArrayCreate([0,3],varVariant);
              par[0]:=19;
              par[1]:=VarArrayOf(['KNS']);
              par[2]:=VarArrayOf([obj_id]);
              par[3]:=VarArrayOf(['com']);
              rg_tp_catch.Enabled:=false;
             end;
         3 : Begin
              par[0]:=78;
              par[1]:=VarArrayOf(['kust']);
              par[2]:=VarArrayOf([obj_id]);
              rg_tp_catch.ItemIndex:=2;
              rg_tp_catch.Enabled:=false;
              lb_place.Caption:=' уст :';
             end;
         4 : Begin
              par:=VarArrayCreate([0,3],varVariant);
              par[0]:=22;
              par[1]:=VarArrayOf(['NS']);
              par[2]:=VarArrayOf([obj_id]);
              par[3]:=VarArrayOf(['com']);
              rg_tp_catch.ItemIndex:=1;
              rg_tp_catch.Enabled:=false;
              lb_place.Caption:='Ќ— :';
             end;
    end;
    cod_err:=16;
    pp:=DM.GetData(par);
    If VarIsNull(pp) Then Exit;
    cds_obj.Data:=pp;
  end;
  creat_state:=false;
end;

procedure Tfr_catch_edit.bt_okClick(Sender: TObject);
var
 par,pp,p1,p2,p3 : variant;
 ii : integer;
begin
  //If (cds_kns.State = dsEdit)or(cds_kns.State = dsInsert) Then cds_kns.Post;
  If ed_open.value=0 Then cl:=2 Else
     if ed_open.value=100 Then cl:=0 Else cl:=1;
  par:=VarArrayCreate([0, 2], varVariant);
  try
  If is_new Then Begin //Inseert
     par[0]:=39;
     par[1]:=VarArrayOf(['name','set','st','d','open','shem','u1','u2','ot','oi','shp','dep']); //имена
     par[2]:=VarArrayOf([cds_catch.FieldByName('name').AsString,
             cds_catch.FieldByName('setting').AsString,
             cl,cds_catch.FieldByName('diametr').AsFloat,
             cds_catch.FieldByName('bolt_open').AsFloat,
             n_p,u1,u2,rg_tp_catch.ItemIndex,cds_obj.FieldByName('id').AsInteger,
             cds_shop.FieldByName('id').AsInteger,
             cds_deposit.FieldByName('id').AsInteger]);
     cod_err:=31;
     pp:=DM.GetTehData(par);
     If VarIsNull(pp) Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     id:=pp;
     rr:=VarArrayCreate([0, 8], varVariant);
     For ii:=0 to 4 Do rr[ii]:=par[2][ii];
     rr[5]:=rg_tp_catch.ItemIndex;
     rr[6]:=cds_obj.FieldByName('id').AsInteger;
     rr[7]:=cds_shop.FieldByName('id').AsInteger;
     rr[8]:=cds_deposit.FieldByName('id').AsInteger;
  end
  ELSE If not VarIsNull(cds_catch.Delta) Then Begin //Update
     par[0]:=59;
     par[1]:=VarArrayOf(['catch','name','set','st','d','open','shp','dep']); //имена
     par[2]:=VarArrayOf([id, //значени€
             cds_catch.FieldByName('name').AsString,
             cds_catch.FieldByName('setting').AsString,
             cl,cds_catch.FieldByName('diametr').AsFloat,
             cds_catch.FieldByName('bolt_open').AsFloat,
             cds_shop.FieldByName('id').AsInteger,
             cds_deposit.FieldByName('id').AsInteger]);
     cod_err:=30;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     rr:=VarArrayCreate([0, 8], varVariant);
     For ii:=1 to 5 Do rr[ii-1]:=par[2][ii];
     rr[5]:=rg_tp_catch.ItemIndex;
     rr[6]:=cds_obj.FieldByName('id').AsInteger;
     rr[7]:=cds_shop.FieldByName('id').AsInteger;
     rr[8]:=cds_deposit.FieldByName('id').AsInteger;
  end;
  If (not is_new)and(id_spr<>cds_obj.FieldByName('id').AsInteger) Then Begin
     id_spr:=cds_obj.FieldByName('id').AsInteger;
     p1:=null;
     p2:=null;
     p3:=null;
     CASE rg_tp_catch.ItemIndex of
        0 : p1:=id_spr;
        1 : p2:=id_spr;
        2 : p3:=id_spr;
     end;
     par[0]:=72;
     par[1]:=VarArrayOf(['kns','ns','kust','obj']); //имена
     par[2]:=VarArrayOf([p1,p2,p3,cds_catch.FieldByName('obj_id').AsInteger]); //значени€
     cod_err:=32;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     If VarIsNull(rr) Then Begin
        rr:=VarArrayCreate([0, 8], varVariant);
        rr[0]:=cds_catch.FieldByName('name').AsString;
        rr[1]:=cds_catch.FieldByName('setting').AsString;
        rr[2]:=cl;
        rr[3]:=cds_catch.FieldByName('diametr').AsFloat;
        rr[4]:=cds_catch.FieldByName('bolt_open').AsFloat;
        rr[5]:=rg_tp_catch.ItemIndex;
        rr[6]:=id_spr;
        rr[7]:=cds_shop.FieldByName('id').AsInteger;
        rr[8]:=cds_deposit.FieldByName('id').AsInteger;
     end
     Else Begin 
        rr[5]:=rg_tp_catch.ItemIndex;
        rr[6]:=id_spr;
     end
  end;
  except
  end;
  Close;
end;

procedure Tfr_catch_edit.ch_closeClick(Sender: TObject);
begin
   If creat_state Then Exit;
   If ch_close.Checked Then Begin
      ch_open.Checked:=false;
      cds_catch.FieldByName('bolt_open').AsFloat:=0;
   end;
end;

procedure Tfr_catch_edit.ch_openClick(Sender: TObject);
begin
   If creat_state Then Exit;
   If ch_open.Checked Then Begin
     ch_close.Checked:=false;
     cds_catch.FieldByName('bolt_open').AsFloat:=100;
   end;
end;

procedure Tfr_catch_edit.rg_tp_catchClick(Sender: TObject);
var
 par,pp : variant;
begin
  If n_p>1 Then Exit;
  par:=VarArrayCreate([0, 2], varVariant);
  cds_obj.Active:=false;
  CASE rg_tp_catch.ItemIndex Of
     0 : Begin
           par[0]:=25;
           lb_place.Caption:='KЌ— :';
         end;
     1 : Begin
           par[0]:=24;
           lb_place.Caption:='Ќ— :';
         end;
     2 : Begin
           par[0]:=181{28};
           lb_place.Caption:='Kуст :';
         end;
  end;
  par[1]:=null;
  par[2]:=null;
  cod_err:=19;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit; 
  // ≈сли ID будут не уникальными в разных таблицах, то необходимо в этом месте
  // id_spr:=-1;
  cds_obj.Data:=pp;
end;

procedure Tfr_catch_edit.ed_openExit(Sender: TObject);
begin
  If creat_state Then Exit;
  If cds_catch.FieldByName('bolt_open').AsFloat>0 Then ch_close.Checked:=false
  Else ch_close.Checked:=true;
  If cds_catch.FieldByName('bolt_open').AsFloat<100 Then ch_open.Checked:=false
  Else ch_open.Checked:=true;
end;

end.
