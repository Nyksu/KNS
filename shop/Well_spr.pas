unit Well_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, Mask, DBCtrls, ToolEdit,
  CurrEdit, RXDBCtrl, Db, DBClient, RXCtrls, well_plast_spr;

type
  Tfr_well_edit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    ed_name: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    gr_plast_par: TDBGrid;
    bt_add_plast: TBitBtn;
    bt_del_plast: TBitBtn;
    bt_edit_plast: TBitBtn;
    cds_plast_par: TClientDataSet;
    cds_well: TClientDataSet;
    ed_d_pump: TRxDBCalcEdit;
    ed_diametr: TRxDBCalcEdit;
    ed_state: TDBLookupComboBox;
    cds_state: TClientDataSet;
    dc_well: TDataSource;
    ds_state: TDataSource;
    ds_plast_par: TDataSource;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    RxLabel2: TRxLabel;
    RxLabel1: TRxLabel;
    Bevel1: TBevel;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bt_okClick(Sender: TObject);
    procedure bt_add_plastClick(Sender: TObject);
    procedure bt_edit_plastClick(Sender: TObject);
    procedure bt_del_plastClick(Sender: TObject);
  private
    Procedure SetPlastProperty;
    { Private declarations }
  public
    { Public declarations }
  end;

Function WellToDB(var id_Well : integer; x, y, spr : integer;cm : boolean) : variant;

var
  fr_well_edit: Tfr_well_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id,id_spr : integer;
  rr : variant;
  is_new : boolean;
  xx,yy : integer;
  can_all_modify : boolean;

Function WellToDB(var id_Well : integer; x, y, spr : integer;cm : boolean) : variant;
Begin
  id:=id_Well;
  rr:=Null;
  xx:=x;
  yy:=y;
  id_spr:=spr;
  can_all_modify:=cm;
  try
     try
       fr_well_edit:=Tfr_well_edit.Create(Application);
       fr_well_edit.ShowModal;
     finally
       id_well:=id;
       Result:=rr;
       fr_well_edit.Free;
     end
  except
  end;
end;

procedure Tfr_well_edit.bt_exitClick(Sender: TObject);
begin
  If DM.StateDB<1 Then DM.BackTrans;
  Close;
end;

procedure Tfr_well_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=95;
  par[1]:=null;
  par[2]:=null;
  cod_err:=100;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_state.data:=pp;
  par[0]:=94;
  par[1]:=VarArrayOf(['well']);
  par[2]:=VarArrayOf([id]);
  cod_err:=101;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  If can_all_modify Then ed_name.Enabled:=true;
  cds_well.data:=pp;
  If cds_well.RecordCount>0 Then Begin //Изменение
     is_new:=false;
     cds_well.Edit;
     If can_all_modify Then Begin
       bt_add_plast.Enabled:=true;
       bt_del_plast.Enabled:=true;
       bt_edit_plast.Enabled:=true;
     end;
     SetPlastProperty;
  end
  Else If can_all_modify Then Begin  //Добавление
     is_new:=true;
     cds_well.Insert;
  end Else Begin
      cds_state.Active:=false;
      bt_ok.Enabled:=false;
  end;
  //SetPlastProperty;
end;

Procedure Tfr_well_edit.SetPlastProperty;
var
 par,pp : variant;
Begin
  cds_plast_par.Active:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=96;
  par[1]:=VarArrayOf(['well']);
  par[2]:=VarArrayOf([id]);
  cod_err:=102;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_plast_par.data:=pp;
end;

procedure Tfr_well_edit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (cds_well.State = dsEdit)or(cds_well.State = dsInsert) Then cds_well.Cancel;
  Action:=caFree;
end;

procedure Tfr_well_edit.bt_okClick(Sender: TObject);
var
 par,pp,p1,p2,p3 : variant;
 ii, id_b, id_e : integer;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  try
   If DM.StateDB<1 Then DM.StartTrans;
   If is_new Then Begin //Inseert
      par[0]:=97;
      par[1]:=VarArrayOf(['kust','state','nomer','depth','d','d_p','x','y']);
      par[2]:=VarArrayOf([id_spr,cds_well.FieldByName('FOUND_STATE_ID').AsInteger,
                          cds_well.FieldByName('nomer').AsString,
                          0,cds_well.FieldByName('d_shtucer').AsFloat,
                          cds_well.FieldByName('day_pump').AsFloat,xx,yy]);
      cod_err:=103;
      pp:=DM.RunSQL(par);
      If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
      end;
      id:=DM.GetLastID;
      rr:=VarArrayCreate([0, 5], varVariant);
      For ii:=0 to 4 Do rr[ii]:=par[2][ii+1];
      rr[5]:=cds_state.FieldByName('name').AsString;
   end
   Else Begin //Update
      par[0]:=98;
      par[1]:=VarArrayOf(['well','state','nomer','depth','d','d_p']);
      par[2]:=VarArrayOf([id,cds_well.FieldByName('FOUND_STATE_ID').AsInteger,
                          cds_well.FieldByName('nomer').AsString,
                          0,cds_well.FieldByName('d_shtucer').AsFloat,
                          cds_well.FieldByName('day_pump').AsFloat]);
      cod_err:=104;
      pp:=DM.RunSQL(par);
      If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
      end;
      rr:=VarArrayCreate([0, 5], varVariant);
      For ii:=0 to 4 Do rr[ii]:=par[2][ii+1];
      rr[5]:=cds_state.FieldByName('name').AsString;
   end;
   DM.ComTrans;
  except
   If DM.StateDB>=0 Then DM.BackTrans;
  end;
  Close;
end;

procedure Tfr_well_edit.bt_add_plastClick(Sender: TObject);
begin
  If WellPars(-1, id) Then SetPlastProperty;
end;

procedure Tfr_well_edit.bt_edit_plastClick(Sender: TObject);
begin
  If cds_plast_par.RecordCount > 0 Then
    If WellPars(cds_plast_par.FieldByName('id').AsInteger, id) Then
       SetPlastProperty;
end;

procedure Tfr_well_edit.bt_del_plastClick(Sender: TObject); 
var
 par,pp : variant;
begin
  If cds_plast_par.RecordCount > 0 Then
  if MessageDlg('Вы действительно хотите удалить выделенный параметр?',
    mtWarning, [mbYes, mbNo], 0) = mrYes then
  Begin
    If DM.StateDB<1 Then DM.StartTrans;
    par:=VarArrayCreate([0, 2], varVariant);
    par[0]:=108;
    par[1]:=VarArrayOf(['well']);
    par[2]:=VarArrayOf([cds_plast_par.FieldByName('id').AsInteger]);
    cod_err:=105;
    pp:=DM.RunSQL(par);
    If pp<>0 Then Begin
        Exit;
    end;
    SetPlastProperty;
  end;
end;

end.
