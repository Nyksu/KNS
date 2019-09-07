unit shop_ch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons;

type
  Tfr_openshop = class(TForm)
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    cds_shop: TClientDataSet;
    ds_shop: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure bt_exitClick(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function GetOpenShop : integer;

var
  fr_openshop: Tfr_openshop;

implementation

{$R *.DFM}

uses ppd_dm;

var shop_id : integer;

Function GetOpenShop : integer;
Begin
  shop_id:=-100;
  try
     try
       fr_openshop:=Tfr_openshop.Create(Application);
       fr_openshop.ShowModal;
     finally
       Result:=shop_id;
       fr_openshop.Free;
     end
  except
  end;
end;


procedure Tfr_openshop.FormCreate(Sender: TObject);
var
 res, par : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=1;//номер Ёс уЁл
   par[1]:=null; //имена
   par[2]:=null; //значени€
   cod_err:=1;
   res:=DM.GetData(par);
   If VarIsNull(res) Then Exit;
   cds_shop.Data:=res;
end;

procedure Tfr_openshop.bt_exitClick(Sender: TObject);
begin
   Close;
end;

procedure Tfr_openshop.bt_okClick(Sender: TObject);
begin
  if cds_shop.Active Then shop_id:=cds_shop.FieldByName('id').AsInteger;
  Close;
end;

end.
