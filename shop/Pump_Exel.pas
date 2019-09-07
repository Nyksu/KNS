unit Pump_Exel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBClient, Grids, DBGrids, ComCtrls, ExtCtrls,
  ImgList, Ask_Integer, ComObj, spr_id;

type
  Tfr_pump_exel = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    tree_pump: TTreeView;
    cds_ns: TClientDataSet;
    cds_pump: TClientDataSet;
    ImageList1: TImageList;
    bt_exit: TBitBtn;
    cds_wrk: TClientDataSet;
    bt_exp_to_excel: TBitBtn;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tree_pumpDblClick(Sender: TObject);
  private
    xl : variant;
    sheet : variant;
    procedure OpenExel(fn : string;sh : integer);
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure DoPumpCalcToExel;

var
  fr_pump_exel: Tfr_pump_exel;

implementation

uses ppd_dm;

{$R *.DFM}

Type
PPumpOpt = ^TPumpOpt;
TPumpOpt = record
  ID : Integer;
  Tip : Integer;
  Name : string;
  SName : string;
  TName : string;
  StName : string;
end;

Var
na_name : string;
na_id : integer;

Procedure DoPumpCalcToExel;
Begin
  na_id:=-1;
  na_name:='';
  try
     try
       fr_pump_exel:=Tfr_pump_exel.Create(Application);
       fr_pump_exel.ShowModal;
     finally
       fr_pump_exel.Free;
     end
  except
  end;
end;

procedure Tfr_pump_exel.bt_exitClick(Sender: TObject);
var
  ii,cc : integer;
  p : pointer;
begin
  cc:=tree_pump.Items.Count;
  For ii:=0 To cc-1 Do Begin
      p:=tree_pump.Items.Item[ii].Data;
      tree_pump.Items.Item[ii].Data:=nil;
      FreeMem(p);
  end;
  Close;
end;

procedure Tfr_pump_exel.FormCreate(Sender: TObject);
var
  par,pp : variant;
  hadr : pointer;
  Popt : PPumpOpt;
  nam,k : string;
  kd,ii : integer;
  nn : TTreeNode;
begin
  par:=VarArrayCreate([0, 2], varVariant);
  For ii:=0 To 1 Do Begin
    If ii=1 Then Begin
       par[0]:=116;
       par[1]:=VarArrayOf(['st']);
       par[2]:=VarArrayOf([0]);
    end
    Else Begin
      par[0]:=24;
      par[1]:=null;
      par[2]:=null;
    end;
    cod_err:=16;
    pp:=DM.GetData(par);
    If VarIsNull(pp) Then Exit;
    cds_ns.Data:=pp;
    While not cds_ns.Eof Do Begin
      New(Popt);
      Popt^.ID:=cds_ns.FieldByName('id').AsInteger;
      kd:=Popt^.ID;
      If ii=1 Then Popt^.Tip:=1 Else Popt^.Tip:=2;
      Popt^.Name:=cds_ns.FieldByName('name').AsString;
      nam:=Popt^.Name;
      Popt^.SName:='';
      Popt^.TName:='';
      Popt^.StName:='';
      hadr:=tree_pump.Items.AddObject(nil,nam,Popt);
      If ii=1 Then k:='kns_id' Else k:='ns_id';
      par[0]:=86;
      par[1]:=VarArrayOf(['!k','obj']);
      par[2]:=VarArrayOf([k,kd]);
      cod_err:=17;
      pp:=DM.GetData(par);
      If not VarIsNull(pp) Then Begin
        cds_pump.Data:=pp;
        While not cds_pump.Eof Do Begin
          New(Popt);
          Popt^.ID:=cds_pump.FieldByName('id').AsInteger;
          Popt^.Tip:=5;
          Popt^.Name:=cds_pump.FieldByName('name').AsString;
          Popt^.SName:=nam;
          Popt^.TName:=cds_pump.FieldByName('tname').AsString;
          Case cds_pump.FieldByName('state').AsInteger of
             0 : Popt^.StName:='В работе';
             1 : Popt^.StName:='В резерве';
             2 : Popt^.StName:='В ремонте';
          end;
          nn:=tree_pump.Items.AddChildObject(hadr,Popt^.Name,Popt);
          nn.ImageIndex:=1;
          nn.SelectedIndex:=1;
          cds_pump.Next;
        end;
      end;
      cds_ns.Next;
    end;
  end;
end;

procedure Tfr_pump_exel.OpenExel(fn : string;sh : integer);
Begin
  //Открываем Exel
   xl:=CreateOleObject('Excel.Application');
   xl.visible:=true;
   xl.application.workbooks.open(fn);
   sheet:=xl.application.workbooks[1].worksheets[sh];
end;

procedure Tfr_pump_exel.tree_pumpDblClick(Sender: TObject);
var
  res : variant;
  ppp : Pointer;
  tp,id,ii,cf,cx,cy : integer;
  xnam : string;
begin
  ppp:=tree_pump.Selected.Data;
  tp:=PPumpOpt(ppp)^.Tip;
  id:=PPumpOpt(ppp)^.ID;
  Case tp of
  1,2 : Begin
          res:=DM.GetKnsForExel(id);
          If VarIsNull(res) Then Exit;
          cds_wrk.Data:=res;
          If cds_wrk.RecordCount>0 Then Begin
             xnam:=DM.XL_path+DM.XL_Kns;
             OpenExel(xnam,1);
             cy:=2;  // номер начальной строки
             cf:=cds_wrk.FieldCount;
             While not cds_wrk.EOF Do Begin
               For ii:=0 To cf-1 Do
                   sheet.cells[cy,ii+2]:=cds_wrk.Fields.Fields[ii].Value;
               Inc(cy);
               cds_wrk.Next;
             end;
          end;
        end;
    5 : Begin
          res:=DM.GetAgrForExel(id);
          If VarIsNull(res) Then Exit;
          cds_wrk.Data:=res;
          If cds_wrk.RecordCount>0 Then Begin
             xnam:=DM.XL_path+DM.XL_Pump;
             OpenExel(xnam,1);
             cy:=2;  // номер начальной строки
             cf:=cds_wrk.FieldCount;
             While not cds_wrk.EOF Do Begin
               For ii:=0 To cf-1 Do
                   sheet.cells[cy,ii+2]:=cds_wrk.Fields.Fields[ii].Value;
               Inc(cy);
               cds_wrk.Next;
             end;
          end;
        end;
  end;
end;

end.
