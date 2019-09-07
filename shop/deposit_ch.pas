unit deposit_ch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Db, DBClient, Get_str, Ask_dlg,
  StrUtils;

type
  Tfr_deposit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    bt_add_shop: TBitBtn;
    bt_del_shop: TBitBtn;
    bt_exit: TBitBtn;
    bt_edit: TBitBtn;
    ds_dep: TDataSource;
    cds_dep: TClientDataSet;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cds_depAfterOpen(DataSet: TDataSet);
    procedure cds_depAfterClose(DataSet: TDataSet);
    procedure bt_add_shopClick(Sender: TObject);
    procedure bt_del_shopClick(Sender: TObject);
  private
    procedure OpenSPR;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure Deposits;

var
  fr_deposit: Tfr_deposit;

implementation

{$R *.DFM}

uses ppd_dm;


Procedure Deposits;
Begin
  try
     try
       fr_deposit:=Tfr_deposit.Create(Application);
       fr_deposit.ShowModal;
     finally
       fr_deposit.Free;
     end
  except
  end;
end;


procedure Tfr_deposit.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_deposit.FormCreate(Sender: TObject);
begin
   OpenSPR;
end;

procedure Tfr_deposit.OpenSPR;
var
 res, par : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=6;//номер Ёс уЁл
   par[1]:=null; //имена
   par[2]:=null; //значени€
   cod_err:=7;
   res:=DM.GetData(par);
   If VarIsNull(res) Then Exit;
   cds_dep.Data:=res;
end;

procedure Tfr_deposit.cds_depAfterOpen(DataSet: TDataSet);
begin
  bt_add_shop.Enabled:=true;
  bt_del_shop.Enabled:=(cds_dep.RecordCount>0);
  bt_edit.Enabled:=bt_del_shop.Enabled;
end;

procedure Tfr_deposit.cds_depAfterClose(DataSet: TDataSet);
begin
  bt_del_shop.Enabled:=false;
  bt_add_shop.Enabled:=false;
  bt_edit.Enabled:=false;
end;

procedure Tfr_deposit.bt_add_shopClick(Sender: TObject);
var
  ss : string;
  res, par : variant;
begin
   ss:=Get_Str_Par('ƒобавление месторождени€'{Okno},'¬ведите им€ нового месторождени€'{Shapka},''{Koment},'');
   If ss<>'' Then Begin
      DelBSpace(ss);
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=7;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name']); //имена
      par[2]:=VarArrayOf([ss]); //значени€
      cod_err:=8;
      res:=DM.GetTehData(par);
      If not VarIsNull(res) Then
         If res[0]>0 Then Begin
            MessageDlg('ћесторождение с таким наименованием уже существует!!', mtError, [mbOk], 0);
            Exit;
         end;
      par[0]:=8;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name']); //имена
      par[2]:=VarArrayOf([ss]); //значени€
      cod_err:=9;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_dep.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
   end;
end;

procedure Tfr_deposit.bt_del_shopClick(Sender: TObject);
var
  res, par : variant;
begin
    if (cds_dep.Active)and(cds_dep.RecordCount>0)Then
     if Get_Answer('”даление месторождени€','¬ы действительно хотите удалить месторождение?',false) Then Begin
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=9;//номер Ёс уЁл
      par[1]:=VarArrayOf(['dep']); //имена
      par[2]:=VarArrayOf([cds_dep.FieldByName('id').AsInteger]); //значени€
      cod_err:=10;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_dep.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
    end;
end;

end.
