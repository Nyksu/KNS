unit shop_ch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, Get_str, Ask_dlg,
  StrUtils;

type
  Tfr_openshop = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    cds_shop: TClientDataSet;
    ds_shop: TDataSource;
    bt_add_shop: TBitBtn;
    bt_del_shop: TBitBtn;
    bt_exit: TBitBtn;
    bt_edit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cds_shopAfterOpen(DataSet: TDataSet);
    procedure cds_shopAfterClose(DataSet: TDataSet);
    procedure bt_exitClick(Sender: TObject);
    procedure bt_add_shopClick(Sender: TObject);
    procedure bt_del_shopClick(Sender: TObject);
    procedure bt_editClick(Sender: TObject);
  private
    procedure OpenSPR;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure Shops;

var
  fr_openshop: Tfr_openshop;

implementation

{$R *.DFM}

uses ppd_dm;


Procedure Shops;
Begin
  try
     try
       fr_openshop:=Tfr_openshop.Create(Application);
       fr_openshop.ShowModal;
     finally
       fr_openshop.Free;
     end
  except
  end;
end;


procedure Tfr_openshop.FormCreate(Sender: TObject);
Begin
   OpenSPR;
end;

procedure Tfr_openshop.OpenSPR;
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

procedure Tfr_openshop.cds_shopAfterOpen(DataSet: TDataSet);
begin
  bt_add_shop.Enabled:=true;
  bt_del_shop.Enabled:=(cds_shop.RecordCount>0);
  bt_edit.Enabled:=bt_del_shop.Enabled;
end;

procedure Tfr_openshop.cds_shopAfterClose(DataSet: TDataSet);
begin
  bt_del_shop.Enabled:=false;
  bt_add_shop.Enabled:=false;
  bt_edit.Enabled:=false;
end;

procedure Tfr_openshop.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_openshop.bt_add_shopClick(Sender: TObject);
var
  ss : string;
  res, par : variant;
begin
   ss:=Get_Str_Par('ƒобавление цеха'{Okno},'¬ведите им€ нового цеха'{Shapka},''{Koment},'');
   If ss<>'' Then Begin
      DelBSpace(ss);
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=3;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name']); //имена
      par[2]:=VarArrayOf([ss]); //значени€
      cod_err:=2;
      res:=DM.GetTehData(par);
      If not VarIsNull(res) Then
         If res[0]>0 Then Begin
            MessageDlg('÷ех с таким наименованием уже существует!!', mtError, [mbOk], 0);
            Exit;
         end;
      par[0]:=2;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name']); //имена
      par[2]:=VarArrayOf([ss]); //значени€
      cod_err:=3;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_shop.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
   end;
end;

procedure Tfr_openshop.bt_del_shopClick(Sender: TObject);
var
  res, par : variant;
begin
    if (cds_shop.Active)and(cds_shop.RecordCount>0)Then
     if Get_Answer('”даление цеха','¬ы действительно хотите удалить цех?',false) Then Begin
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=4;//номер Ёс уЁл
      par[1]:=VarArrayOf(['shop']); //имена
      par[2]:=VarArrayOf([cds_shop.FieldByName('id').AsInteger]); //значени€
      cod_err:=4;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_shop.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
    end;
end;

procedure Tfr_openshop.bt_editClick(Sender: TObject);
var
  ss,s1 : string;
  res, par : variant;
begin
  if (cds_shop.Active)and(cds_shop.RecordCount>0)Then Begin
      ss:=cds_shop.FieldByName('name').AsString;
      s1:=Get_Str_Par('»зменение наименовани€ цеха'{Okno},'¬ведите новое им€ цеха'{Shapka},''{Koment},ss);
      DelBSpace(s1);
      if ss='' Then Exit;
      If ss=s1 Then Exit;
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=3;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name']); //имена
      par[2]:=VarArrayOf([s1]); //значени€
      cod_err:=5;
      res:=DM.GetTehData(par);
      If not VarIsNull(res) Then
         If res>0 Then Begin
            MessageDlg('÷ех с таким наименованием уже существует!!', mtError, [mbOk], 0);
            Exit;
         end;
      par[0]:=5;//номер Ёс уЁл
      par[1]:=VarArrayOf(['shop','name']); //имена
      par[2]:=VarArrayOf([cds_shop.FieldByName('id').AsInteger,s1]); //значени€
      cod_err:=6;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_shop.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
  end;
end;

end.
