unit dep_shop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Db, DBClient;

type
  Tfr_shop_dep = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bt_close: TBitBtn;
    gr_shop_dep: TDBGrid;
    gr_dep: TDBGrid;
    gr_shop: TDBGrid;
    bt_connect: TBitBtn;
    bt_del: TBitBtn;
    cds_shop: TClientDataSet;
    cds_dep: TClientDataSet;
    cds_dep_shop: TClientDataSet;
    ds_shop: TDataSource;
    ds_dep: TDataSource;
    ds_dep_shop: TDataSource;
    procedure bt_closeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cds_dep_shopAfterOpen(DataSet: TDataSet);
    procedure cds_dep_shopAfterClose(DataSet: TDataSet);
    procedure bt_connectClick(Sender: TObject);
    procedure bt_delClick(Sender: TObject);
  private
    procedure OpenSPR;
    procedure OpenConnection;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure DP_SH;

var
  fr_shop_dep: Tfr_shop_dep;

implementation

uses ppd_dm;

{$R *.DFM}

Procedure DP_SH;
Begin
  try
     try
       fr_shop_dep:=Tfr_shop_dep.Create(Application);
       fr_shop_dep.ShowModal;
     finally
       fr_shop_dep.Free;
     end
  except
  end;
end;

procedure Tfr_shop_dep.bt_closeClick(Sender: TObject);
begin
   Close;
end;

procedure Tfr_shop_dep.FormCreate(Sender: TObject);
begin
  OpenSPR;
end;

procedure Tfr_shop_dep.OpenSPR;
var
 res, par : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=1;//номер Ёс уЁл
   par[1]:=null; //имена
   par[2]:=null; //значени€
   cod_err:=11;
   res:=DM.GetData(par);
   If VarIsNull(res) Then Exit;
   cds_shop.Data:=res;
   par[0]:=6;//номер Ёс уЁл
   cod_err:=12;
   res:=DM.GetData(par);
   If VarIsNull(res) Then Exit;
   cds_dep.Data:=res;
   OpenConnection;
   If (cds_shop.RecordCount>0) and (cds_dep.RecordCount>0) Then
       bt_connect.Enabled:=true;
end;

procedure Tfr_shop_dep.OpenConnection;
var
 res, par : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=10;//номер Ёс уЁл
   par[1]:=null; //имена
   par[2]:=null; //значени€
   cod_err:=13;
   res:=DM.GetData(par);
   If VarIsNull(res) Then Exit;
   cds_dep_shop.Data:=res;
end;

procedure Tfr_shop_dep.cds_dep_shopAfterOpen(DataSet: TDataSet);
begin
  If cds_dep_shop.RecordCount>0 Then bt_del.Enabled:=true;
end;

procedure Tfr_shop_dep.cds_dep_shopAfterClose(DataSet: TDataSet);
begin
  bt_del.Enabled:=false;
end;

procedure Tfr_shop_dep.bt_connectClick(Sender: TObject);
var
 res, par : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=12;//номер Ёс уЁл
   par[1]:=VarArrayOf(['dp', 'sh']); //имена
   par[2]:=VarArrayOf([cds_dep.FieldByName('id').AsInteger,
                       cds_shop.FieldByName('id').AsInteger]); //значени€
   cod_err:=14;
   res:=DM.GetTehData(par);
   If res[0]>0 Then Begin
         MessageDlg('“ака€ св€зь уже существует!!', mtError, [mbOk], 0);
         Exit;
   end;
   par[0]:=11;//номер Ёс уЁл
   cod_err:=15;
   DM.StartTrans;
   res:=DM.RunSQL(par);
   If res=0 Then Begin
      DM.ComTrans;
      cds_dep_shop.Active:=false;
      OpenConnection;
   end
   Else DM.BackTrans;
end;

procedure Tfr_shop_dep.bt_delClick(Sender: TObject);
var
 res, par : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=13;//номер Ёс уЁл
   par[1]:=VarArrayOf(['dp', 'sh']); //имена
   par[2]:=VarArrayOf([cds_dep_shop.FieldByName('dep_id').AsInteger,
                       cds_dep_shop.FieldByName('shop_id').AsInteger]); //значени€
   cod_err:=16;
   DM.StartTrans;
   res:=DM.RunSQL(par);
   If res=0 Then Begin
      DM.ComTrans;
      cds_dep_shop.Active:=false;
      OpenConnection;
   end
   Else DM.BackTrans;
end;

end.
