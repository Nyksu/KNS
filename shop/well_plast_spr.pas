unit well_plast_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, CurrEdit, RXDBCtrl, DBCtrls, ExtCtrls,
  Db, DBClient, RXCtrls;

type
  Tfr_plast_edit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    ed_plast: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ed_pressure: TRxDBCalcEdit;
    ed_kaccept: TRxDBCalcEdit;
    ed_accept: TRxDBCalcEdit;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    cds_plast: TClientDataSet;
    cds_well_par: TClientDataSet;
    ds_plast: TDataSource;
    ds_well_par: TDataSource;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    RxLabel3: TRxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bt_okClick(Sender: TObject);
    procedure bt_exitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function WellPars(p_id, w_id : integer) : boolean;

var
  fr_plast_edit : Tfr_plast_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
id,id_spr : integer;
is_new,re : boolean;


Function WellPars(p_id, w_id : integer) : boolean;
Begin
  id:=p_id;
  Result:=false;
  id_spr:=w_id;
  re:=false;
  try
     try
       fr_plast_edit:=Tfr_plast_edit.Create(Application);
       fr_plast_edit.ShowModal;
     finally
       Result:=re;
       fr_plast_edit.Free;
     end
  except
  end;
end;

procedure Tfr_plast_edit.FormCreate(Sender: TObject); 
var
 par,pp : variant;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=105;
  par[1]:=null;
  par[2]:=null;
  cod_err:=111;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_plast.data:=pp;
  par[0]:=104;
  par[1]:=VarArrayOf(['par']);
  par[2]:=VarArrayOf([id]);
  cod_err:=110;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_well_par.data:=pp;
  If cds_well_par.RecordCount>0 Then Begin //Изменение
     is_new:=false;
     cds_well_par.Edit;
  end
  Else Begin  //Добавление
     is_new:=true;
     cds_well_par.Insert;
  end;
end;

procedure Tfr_plast_edit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cds_well_par.Active:=false;
  cds_plast.Active:=false;
  Action:=caFree;
end;

procedure Tfr_plast_edit.bt_okClick(Sender: TObject); 
var
 par,pp : variant;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  try
    If is_new Then Begin //Inseert
      DM.StartTrans;
      par[0]:=106;
      par[1]:=VarArrayOf(['well','k','a','pres','plast']);
      par[2]:=VarArrayOf([id_spr,cds_well_par.FieldByName('k_accept').AsFloat,
                          cds_well_par.FieldByName('accept').AsFloat,
                          cds_well_par.FieldByName('pressure').AsFloat,
                          cds_well_par.FieldByName('plast_id').AsInteger]);
      cod_err:=112;
      pp:=DM.RunSQL(par);
      If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
      end;
    end
    Else Begin
      DM.StartTrans;
      par[0]:=107;
      par[1]:=VarArrayOf(['well','k','a','pres','plast']);
      par[2]:=VarArrayOf([id,cds_well_par.FieldByName('k_accept').AsFloat,
                          cds_well_par.FieldByName('accept').AsFloat,
                          cds_well_par.FieldByName('pressure').AsFloat,
                          cds_well_par.FieldByName('plast_id').AsInteger]);
      cod_err:=113;
      pp:=DM.RunSQL(par);
      If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
      end;
    end;
    DM.ComTrans;
    re:=true;
  except
  end;
  Close;
end;

procedure Tfr_plast_edit.bt_exitClick(Sender: TObject);
begin
  Close;
end;

end.
