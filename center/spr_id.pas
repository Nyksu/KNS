unit spr_id;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls;

type
  Tfr_spr = class(TForm)
    Panel1: TPanel;
    pn_shp: TPanel;
    gr_spr: TDBGrid;
    bt_ok: TBitBtn;
    bt_exit: TBitBtn;
    ds_spr: TDataSource;
    cds_spr: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure bt_exitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function GetIdSpr(p,par : variant) : integer;

var
  fr_spr: Tfr_spr;

implementation

{$R *.DFM}

uses ppd_dm;

var
id : integer;
pr,pp : variant;

Function GetIdSpr(p,par : variant) : integer;
Begin
  id:=-1000;
  pr:=par;
  pp:=p;
  try
     try
       fr_spr:=Tfr_spr.Create(Application);
       fr_spr.Caption:=pp[0];
       fr_spr.ShowModal;
     finally
       Result:=id;
       fr_spr.Free;
     end
  except
  end;
end;

procedure Tfr_spr.FormCreate(Sender: TObject);
var
 res : variant;
Begin
   cod_err:=2;
   res:=DM.GetData(pr);
   If VarIsNull(res) Then Exit;
   cds_spr.Data:=res;
   pn_shp.caption:=pp[1];
end;

procedure Tfr_spr.bt_okClick(Sender: TObject);
begin
  if cds_spr.Active Then id:=cds_spr.FieldByName('id').AsInteger;
  Close;
end;

procedure Tfr_spr.bt_exitClick(Sender: TObject);
begin
  Close;
end;

end.
