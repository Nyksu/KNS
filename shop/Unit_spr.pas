unit Unit_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, RXCtrls, ToolEdit, CurrEdit, RXDBCtrl, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls;

type
  Tfr_unit_edit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    Label1: TLabel;
    ed_balans: TCheckBox;
    Label2: TLabel;
    ed_name: TDBEdit;
    ed_hight: TRxDBCalcEdit;
    ed_pressure: TRxDBCalcEdit;
    lb_pressure: TLabel;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    cds_unit: TClientDataSet;
    ds_unit: TDataSource;
    procedure bt_exitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ed_balansClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function UnitToDB(var id_uz : integer; xx,yy,pln : integer) : variant;

var
  fr_unit_edit: Tfr_unit_edit;

implementation

{$R *.DFM}

uses ppd_dm;

var
  id : integer;
  rr : variant;
  is_new : boolean;
  x,y,pl : integer;

Function UnitToDB(var id_uz : integer; xx,yy,pln : integer) : variant;
Begin
  id:=id_uz;
  x:=xx;
  y:=yy;
  rr:=Null;
  pl:=pln;
  try
    try
      fr_unit_edit:=Tfr_unit_edit.Create(Application);
      fr_unit_edit.ShowModal;
    finally
      Result:=rr;
      id_uz:=id;
      fr_unit_edit.Free;
    end;
  except
  end;
end;


procedure Tfr_unit_edit.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_unit_edit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure Tfr_unit_edit.ed_balansClick(Sender: TObject);
begin
  If ed_balans.Checked Then Begin
     lb_pressure.Enabled:=true;
     ed_pressure.Enabled:=true;
     cds_unit.FieldByName('is_balans').AsInteger:=1;
  end
  Else Begin
     lb_pressure.Enabled:=false;
     ed_pressure.Enabled:=false;
     cds_unit.FieldByName('is_balans').AsInteger:=0;
  end;
end;

procedure Tfr_unit_edit.FormCreate(Sender: TObject);
var
 par,pp : variant;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=111;
  par[1]:=VarArrayOf(['u']);
  par[2]:=VarArrayOf([id]);
  cod_err:=210;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_unit.Data:=pp;
  If cds_unit.RecordCount=0 Then Begin
     par[0]:=112;
     par[1]:=VarArrayOf(['x','y','pl']);
     par[2]:=VarArrayOf([x,y,pl]);
     cod_err:=211;
     pp:=DM.GetTehData(par);
     If VarIsNull(pp) Then is_new:=true
     Else Begin
       id:=pp;
       cds_unit.Active:=false;
       FormCreate(Sender);
       Exit;
     end;
  end
  Else is_new:=false;
  If is_new Then Begin
    cds_unit.Insert;
    cds_unit.FieldByName('is_balans').AsInteger:=0;
  end
  Else Begin
     cds_unit.Edit;
     If cds_unit.FieldByName('is_balans').AsInteger=1 Then Begin
       lb_pressure.Enabled:=true;
       ed_pressure.Enabled:=true;
       ed_balans.Checked:=true;
     end;
  end;
end;

procedure Tfr_unit_edit.bt_okClick(Sender: TObject);
var
 par,pp : variant;
 ii : integer;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  If is_new Then Begin
     par[0]:=38;
     par[1]:=VarArrayOf(['name','pres','bal','hi','x','y','pl']); //имена
     par[2]:=VarArrayOf([cds_unit.FieldByName('name').AsString,
                         cds_unit.FieldByName('pressure').AsFloat,
                         cds_unit.FieldByName('is_balans').AsInteger,
                         cds_unit.FieldByName('hight').AsFloat,x,y,pl]);
     cod_err:=212;
     pp:=DM.GetTehData(par);
     If VarIsNull(pp) Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     id:=pp;
     rr:=VarArrayCreate([0, 3], varVariant);
     For ii:=0 to 3 Do rr[ii]:=par[2][ii];
  end
  Else Begin
     par[0]:=113;
     par[1]:=VarArrayOf(['name','pres','bal','hi','u']); //имена
     par[2]:=VarArrayOf([cds_unit.FieldByName('name').AsString,
                         cds_unit.FieldByName('pressure').AsFloat,
                         cds_unit.FieldByName('is_balans').AsInteger,
                         cds_unit.FieldByName('hight').AsFloat,id]);
     cod_err:=213;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
        Close;
        Exit;
     end;
     rr:=VarArrayCreate([0, 3], varVariant);
     For ii:=0 to 3 Do rr[ii]:=par[2][ii];
  end;
  Close;
end;

end.
