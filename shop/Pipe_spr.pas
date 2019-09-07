unit Pipe_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ToolEdit, CurrEdit, RXDBCtrl, Mask, DBCtrls,
  Db, DBClient, RXCtrls, Grids, DBGrids;

type
  Tfr_pipe_edit = class(TForm)
    Panel1: TPanel;
    pn_shapka: TPanel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    cds_pipe: TClientDataSet;
    ds_pipe: TDataSource;
    Label2: TLabel;
    ed_name: TDBEdit;
    Label3: TLabel;
    Label1: TLabel;
    ed_len: TRxDBCalcEdit;
    ed_thick: TRxDBCalcEdit;
    ed_cof: TRxDBCalcEdit;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ed_tip: TDBLookupComboBox;
    cds_tip: TClientDataSet;
    ds_tip: TDataSource;
    Label9: TLabel;
    ed_year: TRxDBCalcEdit;
    ed_d: TDBLookupComboBox;
    ds_diametr: TDataSource;
    cds_diametr: TClientDataSet;
    RxLabel2: TRxLabel;
    lb_place: TLabel;
    rg_tp_catch: TRadioGroup;
    cds_obj: TClientDataSet;
    ds_obj: TDataSource;
    gr_obj: TDBGrid;
    ed_dir: TDBEdit;
    cds_deposit: TClientDataSet;
    cds_shop: TClientDataSet;
    ds_deposit: TDataSource;
    ds_shop: TDataSource;
    Label5: TLabel;
    ed_deposit: TDBLookupComboBox;
    Label10: TLabel;
    ed_shop: TDBLookupComboBox;
    Label11: TLabel;
    Label12: TLabel;
    lb_shoroh: TRxLabel;
    ed_shoroh: TRxDBCalcEdit;
    RxLabel1: TRxLabel;
    Label13: TLabel;
    ed_gidrod: TRxDBComboEdit;
    Label14: TLabel;
    lb_gidrad: TRxLabel;
    RxLabel4: TRxLabel;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure ed_dirChange(Sender: TObject);
    procedure rg_tp_catchClick(Sender: TObject);
    procedure cds_pipeAfterOpen(DataSet: TDataSet);
    procedure cds_pipeBeforeClose(DataSet: TDataSet);
    procedure ed_gidrodButtonClick(Sender: TObject);
    procedure ds_pipeDataChange(Sender: TObject; Field: TField);
  private
    rostshor : real;
    gidrotemp : real;
    isedit : boolean;
    kkvo : integer;
    function CalcGidrod : real;
    { Private declarations }
  public
    { Public declarations }
  end;

Function PipeToDB(var id_pipe : integer; uu1, uu2, n_plan, id_obj : integer; uz : variant;cm : boolean) : variant;


var
  fr_pipe_edit: Tfr_pipe_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id : integer;
  rr,uuz : variant;
  is_new,bg : boolean;
  u1,u2,n_p,obj_id : integer;
  can_all_modify : boolean;

Function PipeToDB(var  id_pipe : integer; uu1, uu2, n_plan, id_obj : integer; uz : variant;cm : boolean) : variant;
Begin
  id:=id_pipe;
  rr:=Null;
  u1:=uu1;
  u2:=uu2;
  n_p:=n_plan;
  uuz:=uz;
  obj_id:=id_obj;
  can_all_modify:=cm;
  try
     try
       fr_pipe_edit:=Tfr_pipe_edit.Create(Application);
       fr_pipe_edit.ShowModal;
     finally
       id_pipe:=id;
       Result:=rr;
       fr_pipe_edit.Free;
     end
  except
  end;
end;

procedure Tfr_pipe_edit.bt_exitClick(Sender: TObject);
begin
  If (cds_pipe.State = dsEdit)or(cds_pipe.State = dsInsert) Then cds_pipe.Cancel;
  Close;
end;

procedure Tfr_pipe_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
 id_spr : integer;
 trtr : boolean;
begin
  rostshor:=0;
  gidrotemp:=0;
  id_spr:=0;
  lb_gidrad.Caption:='0';
  If can_all_modify Then Begin
     rg_tp_catch.Enabled:=true;
     gr_obj.Enabled:=true;
     ed_tip.Enabled:=true;
  end;
  bg:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  //Загружаем переменные
  pp:=VarArrayOf(['ROSTSHOROH','GIDRDTEMP']);
  par[0]:=186;
  par[1]:=VarArrayOf(['!cyear']);
  par[2]:=VarArrayOf(['2003']);
  pp:=DM.GetTehDataNams(par,pp);
  If not VarIsNull(pp) Then Begin
     rostshor:=pp[0];
     gidrotemp:=pp[1];
  end;
  //Выбираем Цех
  par[0]:=1;//номер ЭсКуЭл
  par[1]:=null; //имена
  par[2]:=null; //значения
  cod_err:=4;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_shop.Data:=pp;
  //Выбираем месторождение
  par[0]:=6;//номер ЭсКуЭл
  par[1]:=null; //имена
  par[2]:=null; //значения
  cod_err:=4;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_deposit.Data:=pp;
  // Диаметр
  par[1]:=null;
  par[2]:=null;
  par[0]:=73;
  cod_err:=118;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_diametr.Data:=pp;
  //Тип
  par[0]:=43;
  par[1]:=VarArrayOf(['plan']);
  par[2]:=VarArrayOf([n_p]);
  cod_err:=119;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_tip.Data:=pp;
  // Водоводы
  par[0]:=44; 
  par[1]:=VarArrayOf(['pipe']);
  par[2]:=VarArrayOf([id]);
  cod_err:=120;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_pipe.Data:=pp;
  If cds_pipe.RecordCount>0 Then Begin
     is_new:=false;
     lb_gidrad.Caption:=FloatToStr(CalcGidrod);
     par[0]:=25;
     if not VarIsNull(cds_pipe.FieldByName('kns_id').Value) Then
            id_spr:=cds_pipe.FieldByName('kns_id').Value;
     if not VarIsNull(cds_pipe.FieldByName('ns_id').Value) Then Begin
        par[0]:=24;
        id_spr:=cds_pipe.FieldByName('ns_id').Value;
        lb_place.Caption:='НС :';
        rg_tp_catch.ItemIndex:=1;
     end;
     if not VarIsNull(cds_pipe.FieldByName('kust_id').Value) Then Begin
        par[0]:=181{28};
        id_spr:=cds_pipe.FieldByName('kust_id').Value;
        lb_place.Caption:='Куст :';
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
     cds_pipe.Edit;
  end
  Else Begin
    If not can_all_modify Then Begin
     cds_obj.Active:=false;
     cds_tip.Active:=false;
     cds_diametr.Active:=false;
     bt_ok.Enabled:=false;
     Exit;
    end;
    cds_pipe.Insert;
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
              lb_place.Caption:='Куст :';
             end;
         4 : Begin
              par:=VarArrayCreate([0,3],varVariant);
              par[0]:=22;
              par[1]:=VarArrayOf(['NS']);
              par[2]:=VarArrayOf([obj_id]);
              par[3]:=VarArrayOf(['com']);
              rg_tp_catch.ItemIndex:=1;
              rg_tp_catch.Enabled:=false;
              lb_place.Caption:='НС :';
             end;
    end;
    cod_err:=16;
    pp:=DM.GetData(par);
    If VarIsNull(pp) Then Exit;
    cds_obj.Data:=pp;
  end;
  bg:=true;
  isedit:=false;
end;

procedure Tfr_pipe_edit.bt_okClick(Sender: TObject);
var
 par,pp,prr,p1,p2,p3 : variant;
 ii, {id_b, id_e,} id_d,obb,jj : integer;
 gd : real;
 sss : string;
begin
  //If (cds_kns.State = dsEdit)or(cds_kns.State = dsInsert) Then cds_kns.Post;
  gd:=0;
  par:=VarArrayCreate([0, 2], varVariant);
  try
  If is_new Then Begin //Inseert
     par[0]:=45;
     par[1]:=VarArrayOf(['name']);
     par[2]:=VarArrayOf([cds_pipe.FieldByName('directname').AsString]);
     cod_err:=123;
     pp:=DM.GetTehData(par);
     If VarIsNull(pp) Then Begin
        DM.BackTrans;
        Exit;
     end;
     id_d:=pp;
     par[0]:=75;
     par[1]:=VarArrayOf(['kns','ns','kust']);
     CASE n_p of
       0,1 : CASE rg_tp_catch.ItemIndex of
                0 : par[2]:=VarArrayOf([cds_obj.FieldByName('id').AsInteger,null,null]);
                1 : par[2]:=VarArrayOf([null,cds_obj.FieldByName('id').AsInteger,null]);
                2 : par[2]:=VarArrayOf([null,null,cds_obj.FieldByName('id').AsInteger]);
             end;
         2 : par[2]:=VarArrayOf([iidd,null,null]);
         3 : par[2]:=VarArrayOf([null,null,iidd]);
         4 : par[2]:=VarArrayOf([null,iidd,null]);
     end;
     cod_err:=124;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     If not VarIsNull(cds_pipe.FieldByName('gidrod').Value) Then gd:=cds_pipe.FieldByName('gidrod').AsFloat;
     obb:=DM.GetLastID;
     par[0]:=46;
     par[1]:=VarArrayOf(['dir','tip','name','len','d','t','year','k','u1','u2','ob','shp','dep','sh','gd']); //имена
     par[2]:=VarArrayOf([id_d, cds_pipe.FieldByName('pipe_type_id').AsInteger,//значения
             cds_pipe.FieldByName('name').AsString,
             cds_pipe.FieldByName('len').AsFloat,
             cds_pipe.FieldByName('pipe_d_id').AsInteger,
             cds_pipe.FieldByName('thick').AsFloat,
             cds_pipe.FieldByName('build_year').AsInteger,
             cds_pipe.FieldByName('k_lock_res').AsInteger,
             u1,u2,obb,
             cds_shop.FieldByName('id').AsInteger,
             cds_deposit.FieldByName('id').AsInteger,
             cds_pipe.FieldByName('shoroh').AsFloat,gd]);
     cod_err:=125;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     prr:=par;
     id:=DM.GetLastID;
     rr:=VarArrayCreate([0, 11], varVariant);
     For ii:=0 to 3 Do rr[ii]:=prr[2][ii];
     rr[4]:=ed_d.text;
     For ii:=5 to 7 Do rr[ii]:=prr[2][ii];
     rr[8]:=cds_diametr.FieldByName('color').AsInteger;
     rr[9]:=cds_pipe.FieldByName('directname').AsString;
     rr[10]:=cds_shop.FieldByName('id').AsInteger;
     rr[11]:=cds_deposit.FieldByName('id').AsInteger;
  end
  Else Begin
   If isedit Then Begin //Update
     par[0]:=45;
     par[1]:=VarArrayOf(['name']);
     par[2]:=VarArrayOf([cds_pipe.FieldByName('directname').AsString]);
     cod_err:=126;
     pp:=DM.GetTehData(par);
     If VarIsNull(pp) Then Begin
        DM.BackTrans;
        Exit;
     end;
     id_d:=pp;
     If not VarIsNull(cds_pipe.FieldByName('gidrod').Value) Then gd:=cds_pipe.FieldByName('gidrod').AsFloat;
     par[0]:=47;
     par[1]:=VarArrayOf(['pipe','dir','tip','name','len','d','t','year','k','shp','dep','sh','gd']); //имена
     par[2]:=VarArrayOf([id,id_d, cds_pipe.FieldByName('pipe_type_id').AsInteger,//значения
             cds_pipe.FieldByName('name').AsString,
             cds_pipe.FieldByName('len').AsFloat,
             cds_pipe.FieldByName('pipe_d_id').AsInteger,
             cds_pipe.FieldByName('thick').AsFloat,
             cds_pipe.FieldByName('build_year').AsInteger,
             cds_pipe.FieldByName('k_lock_res').AsInteger,
             cds_shop.FieldByName('id').AsInteger,
             cds_deposit.FieldByName('id').AsInteger,
             cds_pipe.FieldByName('shoroh').AsFloat,gd]);
     cod_err:=127;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     rr:=VarArrayCreate([0, 11], varVariant);
     For ii:=1 to 8 Do rr[ii-1]:=par[2][ii];
     rr[4]:=ed_d.text;
     rr[8]:=cds_diametr.FieldByName('color').AsInteger;
     rr[9]:=cds_pipe.FieldByName('directname').AsString;
     rr[10]:=cds_shop.FieldByName('id').AsInteger;
     rr[11]:=cds_deposit.FieldByName('id').AsInteger;
     obb:=cds_obj.FieldByName('id').AsInteger;
     p1:=null;
     p2:=null;
     p3:=null;
     CASE rg_tp_catch.ItemIndex of
        0 : p1:=obb;
        1 : p2:=obb;
        2 : p3:=obb;
     end;
     par[0]:=72;
     par[1]:=VarArrayOf(['kns','ns','kust','obj']); //имена
     par[2]:=VarArrayOf([p1,p2,p3,cds_pipe.FieldByName('obj_id').AsInteger]); //значения
     cod_err:=32;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     If not VarIsNull(uuz) Then Begin
        par[0]:=53;
        par[1]:=VarArrayOf(['pipe','x','y']); //имена
        cod_err:=128;
        For ii:=0 To VarArrayHighBound(uuz[0],1) Do Begin
            par[2]:=VarArrayOf([id,uuz[0][ii],uuz[1][ii]]);
            DM.RunSQL(par);
        end;
     end;
    end;
  end;
  except
  end;
  Close;
end;

procedure Tfr_pipe_edit.ed_dirChange(Sender: TObject);
begin
   If bg Then cds_pipe.FieldByName('directname').Value:=ed_dir.text;
end;

procedure Tfr_pipe_edit.rg_tp_catchClick(Sender: TObject);
var
 par,pp : variant;
begin
  If n_p>1 Then Exit;
  par:=VarArrayCreate([0, 2], varVariant);
  cds_obj.Active:=false;
  CASE rg_tp_catch.ItemIndex Of
     0 : Begin
           par[0]:=25;
           lb_place.Caption:='KНС :';
         end;
     1 : Begin
           par[0]:=24;
           lb_place.Caption:='НС :';
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
  cds_obj.Data:=pp;
end;

procedure Tfr_pipe_edit.cds_pipeAfterOpen(DataSet: TDataSet);
var
  sh : real;
  se : integer;
begin
  // темп роста шероховатости rostshor = 0.35
  sh:=0.006;
  If cds_pipe.RecordCount>0 Then Begin
     se:=Year_calc-cds_pipe.FieldByName('build_year').AsInteger;
     If (se>1)and(se<=5) Then sh:=sh+se*rostshor;
     If se>5 Then sh:=sh+5*rostshor+(se-5)*rostshor*1.3;
  end;
  lb_shoroh.Caption:=FloatToStr(sh);
end;

procedure Tfr_pipe_edit.cds_pipeBeforeClose(DataSet: TDataSet);
begin
  lb_shoroh.Caption:='';
end;

procedure Tfr_pipe_edit.ed_gidrodButtonClick(Sender: TObject);
begin
  //cds_pipe.FieldByName('GIDROD').AsFloat:=CalcGidrod;
  lb_gidrad.Caption:=FloatToStr(CalcGidrod);
end;

function Tfr_pipe_edit.CalcGidrod : real;
Begin
  //If is_new and (ed_year.Value)
  Result:=cds_diametr.FieldByName('DIAMETR').AsInteger-2*ed_thick.Value;
  Result:=Result-(DM.GetCalcYear-ed_year.Value)*gidrotemp;
end;

procedure Tfr_pipe_edit.ds_pipeDataChange(Sender: TObject; Field: TField);
begin
  If cds_pipe.State=dsEdit Then Begin
     isedit:=true;
  end;
end;

end.
