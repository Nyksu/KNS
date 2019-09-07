unit pipe_select;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, DBClient, StdCtrls, Buttons, Grids, DBGrids, DBCtrls,
  RXSpin, ComCtrls, Mask, ToolEdit, CurrEdit, ComObj;

type
  Tfr_pipe_select = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    DBGrid1: TDBGrid;
    bt_del_rec: TBitBtn;
    bt_select_to_excel: TBitBtn;
    ds_select: TDataSource;
    cds_select: TClientDataSet;
    cds_kns: TClientDataSet;
    cds_ns: TClientDataSet;
    cds_kust: TClientDataSet;
    ds_kns: TDataSource;
    ds_ns: TDataSource;
    ds_kust: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ch_year_to: TCheckBox;
    ch_year_from: TCheckBox;
    ch_d_to: TCheckBox;
    ch_d_from: TCheckBox;
    ch_shop: TCheckBox;
    ch_deposit: TCheckBox;
    ed_d_from: TDBLookupComboBox;
    ed_shop: TDBLookupComboBox;
    ed_deposit: TDBLookupComboBox;
    rg_obj: TRadioGroup;
    ed_kust: TDBLookupComboBox;
    ed_ns: TDBLookupComboBox;
    ed_kns: TDBLookupComboBox;
    TabSheet2: TTabSheet;
    ed_d_to: TDBLookupComboBox;
    ed_year_from: TRxSpinEdit;
    ed_year_to: TRxSpinEdit;
    cds_deposit: TClientDataSet;
    cds_shop: TClientDataSet;
    cds_d_from: TClientDataSet;
    cds_d_to: TClientDataSet;
    ds_deposit: TDataSource;
    ds_shop: TDataSource;
    ds_d_from: TDataSource;
    ds_d_to: TDataSource;
    Panel7: TPanel;
    bt_exit: TBitBtn;
    BitBtn1: TBitBtn;
    ch_calc_select: TCheckBox;
    ed_speed_from: TRxCalcEdit;
    ch_speed_from: TCheckBox;
    ed_speed_to: TRxCalcEdit;
    ch_speed_to: TCheckBox;
    ch_reg_flow: TCheckBox;
    ed_reg_flow: TRxSpinEdit;
    bt_add_manual: TBitBtn;
    cds_tmp: TClientDataSet;
    bt_del_manual_select: TButton;
    ed_period: TComboBox;
    Label1: TLabel;
    procedure bt_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rg_objClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cds_selectAfterOpen(DataSet: TDataSet);
    procedure cds_selectAfterClose(DataSet: TDataSet);
    procedure bt_del_recClick(Sender: TObject);
    procedure bt_add_manualClick(Sender: TObject);
    procedure bt_del_manual_selectClick(Sender: TObject);
    procedure bt_select_to_excelClick(Sender: TObject);
    procedure ch_calc_selectClick(Sender: TObject);
    procedure cds_selectAfterInsert(DataSet: TDataSet);
  private
    xl : variant;
    sheet : variant;
    filtr : TStringList;
    Function Init : boolean;
    procedure ResetChecks;
    procedure ResetHostInfo;
    function IsRightSpr : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure SelectorPipe;

var
  fr_pipe_select: Tfr_pipe_select;
  pcpc : variant;

implementation

uses ppd_dm, PPD_main;

{$R *.DFM}

Procedure SelectorPipe;
Begin
  try
     try
       fr_pipe_select:=Tfr_pipe_select.Create(Application);
       fr_pipe_select.filtr:=TStringList.Create;
       fr_pipe_select.ShowModal;
     finally
       fr_pipe_select.filtr.free;
       fr_pipe_select.Free;
     end
  except
  end;
end;

procedure Tfr_pipe_select.ResetChecks;
var
 par,pp : variant;
Begin
  ch_deposit.Checked:=false;
  ch_shop.Checked:=false;
  ch_d_from.Checked:=false;
  ch_d_to.Checked:=false;
  ch_year_from.Checked:=false;
  ch_year_to.Checked:=false;
  ResetHostInfo;
  rg_obj.ItemIndex:=0;
  ed_kns.Enabled:=true;
  ed_year_from.Value:=2000;
  ed_year_to.Value:=2002;
  ch_calc_select.Checked:=false;
  ch_speed_from.Checked:=false;
  ch_speed_to.Checked:=false;
  ch_reg_flow.Checked:=false;
  ed_speed_from.Value:=0;
  ed_speed_to.Value:=0;
  ed_reg_flow.Value:=0;
  If isCalcOk Then ch_calc_select.Enabled:=true Else ch_calc_select.Enabled:=false; 
end;

procedure Tfr_pipe_select.ResetHostInfo;
Begin
  ed_kns.Enabled:=false;
  ed_ns.Enabled:=false;
  ed_kust.Enabled:=false;
end;

Function Tfr_pipe_select.Init : boolean;
var
 par,pp : variant;
Begin
  Result:=false;
  pcpc:=null;
  cds_select.Active:=false;
  cds_kns.Active:=false;
  cds_ns.Active:=false;
  cds_kust.Active:=false;
  cds_deposit.Active:=false;
  cds_shop.Active:=false;
  cds_d_from.Active:=false;
  cds_d_to.Active:=false;
  // Заполняем по очереди все справочники.
  par:=VarArrayCreate([0, 2], varVariant);
  // KNS
  par[0]:=25;
  par[1]:=null;
  par[2]:=null;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_kns.data:=pp;
  // NS
  par[0]:=24;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_ns.data:=pp;
  // Kust
  par[0]:=28;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_kust.data:=pp;
  // Deposit
  par[0]:=6;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_deposit.data:=pp;
  // Shop
  par[0]:=1;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_shop.data:=pp;
  // Diametr
  par[0]:=73;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_d_from.data:=pp;
  cds_d_to.data:=pp;
  ResetChecks;
  bt_del_rec.Enabled:=false;
end;


procedure Tfr_pipe_select.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_pipe_select.FormShow(Sender: TObject);
begin
  If not Init Then Close;
end;

procedure Tfr_pipe_select.rg_objClick(Sender: TObject);
begin
  ResetHostInfo;
  CASE rg_obj.ItemIndex Of
    0 : Begin
         ed_kns.Enabled:=true;
         ed_kns.SetFocus;
        end;
    1 : Begin
         ed_ns.Enabled:=true;
         ed_ns.SetFocus;
        end;
    2 : Begin
         ed_kust.Enabled:=true;
         ed_kust.SetFocus;
        end;
  end;
end;

function Tfr_pipe_select.IsRightSpr : boolean;
Begin
  Result:=cds_kns.Active and cds_ns.Active and cds_kust.Active and cds_deposit.Active and cds_shop.Active and cds_d_from.Active and cds_d_to.Active;
  If Result Then
  Result:=(cds_kns.RecordCount>0)and(cds_ns.RecordCount>0)and(cds_kust.RecordCount>0)and(cds_deposit.RecordCount>0)and(cds_shop.RecordCount>0)and(cds_d_from.RecordCount>0)and(cds_d_to.RecordCount>0);
end;

procedure Tfr_pipe_select.BitBtn1Click(Sender: TObject);
var
  prr,pp,pcc : variant;
  kvo : integer;
  bres : boolean;
begin
  If not IsRightSpr Then Begin
     MessageDlg('Ошибка в справочниках!', mtError,[mbOk], 0);
     Exit;
  end;
  cds_select.Active:=false;
  filtr.Clear;
  prr:=VarArrayCreate([0, 7], varVariant);
  prr[0]:=rg_obj.ItemIndex;
  prr[1]:=null;
  CASE rg_obj.ItemIndex of
    0 : If ed_kns.Text<>'' Then Begin
           prr[1]:=ed_kns.KeyValue;
           filtr.Add('КНС : '+ed_kns.Text);
        end
        Else Begin
           MessageDlg('Не выбрана КНС!', mtError,[mbOk], 0);
           filtr.Clear;
           Exit;
        end;
    1 : If ed_ns.Text<>'' Then Begin
           prr[1]:=ed_ns.KeyValue;
           filtr.Add('НС : '+ed_ns.Text);
        end
        Else Begin
           MessageDlg('Не выбрана НС!', mtError,[mbOk], 0);
           filtr.Clear;
           Exit;
        end;
    2 : If ed_kust.Text<>'' Then Begin
           prr[1]:=ed_kust.KeyValue;
           filtr.Add('Куст : '+ed_kust.Text);
        end
        Else Begin
           MessageDlg('Не выбран Куст скважин!', mtError,[mbOk], 0);
           filtr.Clear;
           Exit;
        end;
  end;
  If VarIsNull(prr[1]) Then Begin
     MessageDlg('Не выбрана принадлежность водоводов!', mtError,[mbOk], 0);
     filtr.Clear;
     Exit;
  end;
  prr[2]:=null;
  If ch_deposit.Checked Then if ed_deposit.Text<>'' Then Begin
     prr[2]:=ed_deposit.KeyValue;
     filtr.Add('Месторождение : '+ed_deposit.Text);
  end
  Else Begin
     MessageDlg('Не выбрано мосторождение!', mtError,[mbOk], 0);
     filtr.Clear;
     Exit;
  end;
  prr[3]:=null;
  If ch_shop.Checked Then if ed_shop.Text<>'' Then Begin
     prr[3]:=ed_shop.KeyValue;
     filtr.Add('Цех : '+ed_shop.Text);
  end
  Else Begin
     MessageDlg('Не выбран цех!', mtError,[mbOk], 0);
     filtr.Clear;
     Exit;
  end;
  prr[4]:=null;
  If ch_d_from.Checked Then if ed_d_from.Text<>'' Then Begin
     prr[4]:=ed_d_from.KeyValue;
     filtr.Add('Диаметр с : '+ed_d_from.Text);
  end
  Else Begin
     MessageDlg('Не выбран начальный диаметр!', mtError,[mbOk], 0);
     filtr.Clear;
     Exit;
  end;
  prr[5]:=null;
  If ch_d_to.Checked Then if ed_d_to.Text<>'' Then Begin
     prr[5]:=ed_d_to.KeyValue;
     filtr.Add('Диаметр до : '+ed_d_to.Text);
  end
  Else Begin
     MessageDlg('Не выбран конечный диаметр!', mtError,[mbOk], 0);
     filtr.Clear;
     Exit;
  end;
  prr[6]:=null;
  If ch_year_from.Checked Then Begin
     prr[6]:=ed_year_from.Value;
     filtr.Add('Год строительства с : '+String(prr[6]));
  end;
  prr[7]:=null;
  If ch_year_to.Checked Then Begin
     prr[7]:=ed_year_to.Value;
     filtr.Add('Год строительства по : '+String(prr[7]));
  end;
  // Расчетные данные
  pcc:=null;
  pcpc:=null;
  bres:=(ch_calc_select.Checked) and (ch_speed_from.Checked or ch_speed_to.Checked or ch_reg_flow.Checked);
  If bres Then Begin
     filtr.Add('Условия расчетных параметров: ');
     pcc:=VarArrayCreate([0, 3], varVariant);
     If ch_speed_from.Checked Then Begin
        pcc[0]:=ed_speed_from.Value;
        filtr.Add('Скорость течения с : '+String(pcc[0]));
     end
     Else pcc[1]:=null;
     If ch_speed_to.Checked Then Begin
        pcc[1]:=ed_speed_to.Value;
        filtr.Add('Скорость течения по : '+String(pcc[1]));
     end
     Else pcc[1]:=null;
     If ch_reg_flow.Checked Then Begin
        pcc[2]:=ed_reg_flow.Value;
        filtr.Add('Тип течения течения по : '+String(pcc[2]));
     end
     Else pcc[2]:=null;
     pcc[3]:=ed_period.ItemIndex+1;
  end;
  // Посылаем запрос
  pp:=DM.GetPipeSelect(prr,pcc);
  If VarIsNull(pp) Then Begin
     MessageDlg('Ошибка в запросе!', mtError,[mbOk], 0);
     filtr.Clear;
     Exit;
  end;
  pcpc:=pcc;
  cds_select.Data:=pp;
  kvo:=cds_select.RecordCount;
  If kvo=0 Then MessageDlg('Не найдено объектов по данному запросу!', mtInformation,[mbOk], 0)
  Else MessageDlg('По данному запросу найдено '+IntToStr(kvo)+' объектов!!', mtInformation,[mbOk], 0)
end;

procedure Tfr_pipe_select.cds_selectAfterOpen(DataSet: TDataSet);
begin
  bt_add_manual.Enabled:=true;
  If cds_select.RecordCount>0 Then Begin
     bt_del_rec.Enabled:=true;
     bt_select_to_excel.Enabled:=true;
  end
  Else Begin
     bt_del_rec.Enabled:=false;
     bt_select_to_excel.Enabled:=false;
  end;
end;

procedure Tfr_pipe_select.cds_selectAfterClose(DataSet: TDataSet);
begin
  bt_del_rec.Enabled:=false;
  bt_add_manual.Enabled:=false;
  bt_select_to_excel.Enabled:=false;
end;

procedure Tfr_pipe_select.bt_del_recClick(Sender: TObject);
begin
  If MessageDlg('Удалить текущую запись из выборки?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
     cds_select.Delete;
  If cds_select.RecordCount=0 Then Begin
     bt_del_rec.Enabled:=false;
     bt_select_to_excel.Enabled:=false;
  end;
end;

procedure Tfr_pipe_select.bt_add_manualClick(Sender: TObject);
var
  ii,i2 : integer;
  par,pp : variant;
begin
  If not cds_select.Active Then Exit;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=180;
  par[1]:=VarArrayOf(['pipe']);
  If ChangingPipes.Count>0 Then Begin
     For ii:=0 To ChangingPipes.Count-1 Do Begin
         cds_tmp.Active:=false;
         par[2]:=VarArrayOf([StrToInt(ChangingPipes.Strings[ii])]);
         pp:=DM.GetData(par);
         If not VarIsNull(pp) Then Begin
            cds_tmp.Data:=pp;
            If cds_tmp.RecordCount>0 Then Begin
               cds_select.Insert;
               For i2:=0 To cds_select.FieldList.Count-1 Do
                   cds_select.Fields.Fields[i2].Value:=cds_tmp.Fields.Fields[i2].Value;
               cds_select.Post;
            end;
         end;
     end;
     bt_add_manual.Enabled:=false;
  end;
end;

procedure Tfr_pipe_select.bt_del_manual_selectClick(Sender: TObject);
begin
   ChangingPipes.Clear;
end;

procedure Tfr_pipe_select.bt_select_to_excelClick(Sender: TObject);
var
  ii,shnom,i2,jj : integer;
  rr : variant;
  shmk : boolean;
begin
  If not cds_select.Active Then Exit;
  If cds_select.RecordCount=0 Then Exit;
  xl:=CreateOleObject('Excel.Application');
  xl.visible:=true;
  xl.application.workbooks.Add();
  sheet:=xl.application.workbooks[1].worksheets[1];
  sheet.cells[1,1]:='ПОКАЧЕВНЕФТЕГАЗ';
  sheet.cells[2,1]:=fr_main.StatusBar1.Panels[2].Text;
  sheet.cells[3,1]:='Выборка водоводов по условиям:';
  ii:=4;
  If filtr.Count>0 Then
     For i2:=0 To filtr.Count-1 Do Begin
         sheet.cells[ii,2]:=filtr.Strings[i2];
         Inc(ii);
     end;
  shnom:=ii;
  Inc(ii,2);
  sheet.cells[shnom,1]:='ИД';
  sheet.cells[shnom+1,1]:='';
  sheet.cells[shnom,2]:='Участок';
  sheet.cells[shnom+1,2]:='';
  sheet.cells[shnom,3]:='Длина';
  sheet.cells[shnom+1,3]:='м';
  sheet.cells[shnom,4]:='Диаметр';
  sheet.cells[shnom+1,4]:='мм';
  sheet.cells[shnom,5]:='Толщина стенки';
  sheet.cells[shnom+1,5]:='мм';
  sheet.cells[shnom,6]:='Год строительства';
  sheet.cells[shnom+1,6]:='';
  cds_select.First;
  shmk:=false;
  While not cds_select.EOF Do Begin
    sheet.cells[ii,1]:=cds_select.FieldByName('ID').AsString;
    sheet.cells[ii,2]:=cds_select.FieldByName('NAME').AsString;
    sheet.cells[ii,3]:=cds_select.FieldByName('LEN').AsString;
    sheet.cells[ii,4]:=cds_select.FieldByName('DIAMETR').AsString;
    sheet.cells[ii,5]:=cds_select.FieldByName('THICK').AsString;
    sheet.cells[ii,6]:=cds_select.FieldByName('BUILD_YEAR').AsString;
    If not VarIsNull(pcpc) Then Begin
       rr:=DM.GetResElements(cds_select.FieldByName('ID').AsInteger, 4, Integer(pcpc[3]));
       If not VarIsNull(rr) Then
        For i2:=0 To VarArrayHighBound(rr,1) Do
         if not VarIsNull(rr[i2]) Then Begin
           sheet.cells[ii,7+i2]:=rr[i2][1];
           If not shmk Then Begin
              sheet.cells[shnom,7+i2]:=rr[i2][0];
              sheet.cells[shnom+1,7+i2]:=rr[i2][2];
           end;
        end;
       shmk:=true;
    end;
    cds_select.Next;
    Inc(ii);
  end;
  {If ch_calc_select.Checked Then
  Else}
end;

procedure Tfr_pipe_select.ch_calc_selectClick(Sender: TObject);
begin
  If ch_calc_select.Checked Then Begin
    ed_period.Items.Text:=DM.GetPeriodList;
    ed_period.ItemIndex:=0;
  end;

end;

procedure Tfr_pipe_select.cds_selectAfterInsert(DataSet: TDataSet);
begin
  If not bt_select_to_excel.Enabled Then  bt_select_to_excel.Enabled:=true;
end;

end.
