unit pump_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Db, DBClient, Get_str, Ask_dlg,
  StrUtils, Ask_chislo;

type
  Tfr_pump_spr = class(TForm)
    cds_pump_type: TClientDataSet;
    ds_pump_type: TDataSource;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    bt_add: TBitBtn;
    bt_del: TBitBtn;
    bt_exit: TBitBtn;
    bt_edit: TBitBtn;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cds_pump_typeAfterOpen(DataSet: TDataSet);
    procedure cds_pump_typeAfterClose(DataSet: TDataSet);
    procedure bt_delClick(Sender: TObject);
    procedure bt_addClick(Sender: TObject);
    procedure bt_editClick(Sender: TObject);
  private
    procedure OpenSPR;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure PumpsType;


var
  fr_pump_spr: Tfr_pump_spr;

implementation

uses ppd_dm;

{$R *.DFM}

Procedure PumpsType;
Begin
  try
     try
       fr_pump_spr:=Tfr_pump_spr.Create(Application);
       fr_pump_spr.ShowModal;
     finally
       fr_pump_spr.Free;
     end
  except
  end;
end;

procedure Tfr_pump_spr.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_pump_spr.FormCreate(Sender: TObject);
begin
   OpenSPR;
end;

procedure Tfr_pump_spr.OpenSPR;
var
 res, par : variant;
Begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=14;//номер Ёс уЁл
   par[1]:=null; //имена
   par[2]:=null; //значени€
   cod_err:=17;
   res:=DM.GetData(par);
   If VarIsNull(res) Then Exit;
   cds_pump_type.Data:=res;
end;

procedure Tfr_pump_spr.cds_pump_typeAfterOpen(DataSet: TDataSet);
begin
  If cds_pump_type.RecordCount>0 Then Begin
     bt_del.Enabled:=true;
     bt_edit.Enabled:=true;
  end;
  bt_add.Enabled:=true;
end;

procedure Tfr_pump_spr.cds_pump_typeAfterClose(DataSet: TDataSet);
begin
     bt_del.Enabled:=false;
     bt_edit.Enabled:=false;
     bt_add.Enabled:=false;
end;

procedure Tfr_pump_spr.bt_delClick(Sender: TObject);
var
  res, par : variant;
begin
    if (cds_pump_type.Active)and(cds_pump_type.RecordCount>0)Then
     if Get_Answer('”даление типа насосного агрегата','¬ы действительно хотите удалить текущий тип?',false) Then Begin
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=15;//номер Ёс уЁл
      par[1]:=VarArrayOf(['pt']); //имена
      par[2]:=VarArrayOf([cds_pump_type.FieldByName('id').AsInteger]); //значени€
      cod_err:=18;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_pump_type.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
    end;
end;

procedure Tfr_pump_spr.bt_addClick(Sender: TObject);
var
  ss : string;
  res, par : variant;
  w_count, tid : integer;
begin
   ss:=Get_Str_Par('ƒобавление типа насосного агрегата'{Okno},'¬ведите наименование типа'{Shapka},''{Koment},'');
   If ss<>'' Then Begin
      w_count:=Round(Ask_real('“ип насосного агрегата','¬ведите число колес',1));
      If w_count<=0 Then Begin
        Exit;
      end;
      DelBSpace(ss);
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=16;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name']); //имена
      par[2]:=VarArrayOf([ss]); //значени€
      cod_err:=19;
      res:=DM.GetTehData(par);
      If not VarIsNull(res) Then
         If res>0 Then Begin
            MessageDlg('“ип агрегата с таким наименованием уже существует!!', mtError, [mbOk], 0);
            Exit;
         end;
      par[0]:=203;
      par[1]:=VarArrayOf(['!tbl']);
      par[2]:=VarArrayOf(['pump_type']);
      res:=DM.GetTehData(par);
      If VarIsNull(res) Then Begin
         MessageDlg('ќшибка получени€ следующего ID дл€ типа Ќј!!', mtError, [mbOk], 0);
         Exit;
      end;
      tid:=res;
      par[0]:=17;//номер Ёс уЁл
      par[1]:=VarArrayOf(['pid','name','wc']); //имена
      par[2]:=VarArrayOf([tid,ss,w_count]); //значени€
      cod_err:=20;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_pump_type.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
   end;
end;

procedure Tfr_pump_spr.bt_editClick(Sender: TObject);
var
  ss : string;
  res, par : variant;
  w_count : integer;
begin
   ss:=Get_Str_Par('–едактирование типа насосного агрегата'{Okno},'¬ведите новое наименование типа'{Shapka},''{Koment},cds_pump_type.FieldByName('name').AsString);
   If ss<>'' Then Begin
      w_count:=Round(Ask_real('“ип насосного агрегата','¬ведите число колес',cds_pump_type.FieldByName('wheel_count').AsInteger));
      If w_count<=0 Then Begin
        Exit;
      end;
      DelBSpace(ss);
      par:=VarArrayCreate([0, 2], varVariant);
      par[0]:=16;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name']); //имена
      par[2]:=VarArrayOf([ss]); //значени€
      cod_err:=21;
      res:=DM.GetTehData(par);
      If not VarIsNull(res) Then
         If res[0]>0 Then Begin
            MessageDlg('“ип агрегата с таким наименованием уже существует!!', mtError, [mbOk], 0);
            Exit;
         end;
      par[0]:=18;//номер Ёс уЁл
      par[1]:=VarArrayOf(['name','wc','wc_id']); //имена
      par[2]:=VarArrayOf([ss,w_count,cds_pump_type.FieldByName('id').AsInteger]); //значени€
      cod_err:=22;
      DM.StartTrans;
      res:=DM.RunSQL(par);
      If res=0 Then Begin
        DM.ComTrans;
        cds_pump_type.Active:=false;
        OpenSPR;
      end
      Else DM.BackTrans;
   end;
end;

end.
