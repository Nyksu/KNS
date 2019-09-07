unit ch_plan_work;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, Db, DBClient, DBCtrls;

type
  Tfr_change_plan_work = class(TForm)
    Panel1: TPanel;
    gr_plans: TDBGrid;
    ed_name: TEdit;
    ed_coment: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    bt_setplan: TBitBtn;
    bt_add: TBitBtn;
    bt_del: TBitBtn;
    bt_edit: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    lb_active_plan: TLabel;
    Panel4: TPanel;
    bt_exit: TBitBtn;
    cds_plans: TClientDataSet;
    ds_plans: TDataSource;
    DBMemo1: TDBMemo;
    bt_save: TBitBtn;
    bt_cancel: TBitBtn;
    procedure bt_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bt_setplanClick(Sender: TObject);
    procedure bt_addClick(Sender: TObject);
    procedure bt_editClick(Sender: TObject);
    procedure bt_cancelClick(Sender: TObject);
    procedure bt_saveClick(Sender: TObject);
    procedure bt_delClick(Sender: TObject);
  private
    ed_state : integer;
    ed_id : integer;
    procedure RefreshGrd;
    procedure SetEditInsert;
    procedure SetFreeState;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure SetWorkPlan;

var
  fr_change_plan_work: Tfr_change_plan_work;

implementation

uses ppd_dm;

{$R *.DFM}

Procedure SetWorkPlan;
Begin
  try
     try
       fr_change_plan_work:=Tfr_change_plan_work.Create(Application);
       fr_change_plan_work.ShowModal;
     finally
       fr_change_plan_work.Free;
     end
  except
  end;
end;

procedure Tfr_change_plan_work.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_change_plan_work.RefreshGrd;
var
  pp, par : variant;
Begin
  cds_plans.Active:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=146;
  par[1]:=null; //имена
  par[2]:=null; //значения
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_plans.data:=pp;
end;

procedure Tfr_change_plan_work.FormShow(Sender: TObject);
begin
  //Активация формы
  //Выводим установленное значение плана событий
  lb_active_plan.Caption:=DM.GetNameSetWorkPlan;
  //Заполняем таблицу доступными планами событий
  RefreshGrd;
  ed_state:=0;
end;

procedure Tfr_change_plan_work.bt_setplanClick(Sender: TObject);
begin
  If cds_plans.active and (cds_plans.RecordCount>0) Then Begin
     num_plan_work:=cds_plans.FieldByName('ID').AsInteger;
     lb_active_plan.Caption:=cds_plans.FieldByName('NAME').AsString;
  end
  Else MessageDlg('Не выбран план работы!', mtError, [mbOk], 0);
end;

procedure Tfr_change_plan_work.SetFreeState;
Begin
  bt_setplan.Enabled:=true;
  bt_add.Enabled:=true;
  bt_del.Enabled:=true;
  bt_edit.Enabled:=true;

  bt_save.Enabled:=false;
  bt_cancel.Enabled:=false;
  ed_name.Enabled:=false;
  ed_coment.Enabled:=false;

  ed_state:=0;

  RefreshGrd;
  ed_name.text:='';
  ed_coment.Lines.Text:='';
end;

procedure Tfr_change_plan_work.SetEditInsert;
Begin
  bt_setplan.Enabled:=false;
  bt_add.Enabled:=false;
  bt_del.Enabled:=false;
  bt_edit.Enabled:=false;
  bt_save.Enabled:=true;
  bt_cancel.Enabled:=true;
  ed_name.Enabled:=true;
  ed_coment.Enabled:=true;
  Case ed_state of
     1 : Begin
           cds_plans.Active:=false;
           ed_name.text:='';
           ed_coment.Lines.Text:='';
           ed_name.SetFocus;
         end;
     2 : Begin
           ed_name.text:=cds_plans.FieldByName('NAME').AsString;
           ed_coment.Lines.Text:=cds_plans.FieldByName('COMENT').AsString;
           ed_id:=cds_plans.FieldByName('ID').AsInteger;
           cds_plans.Active:=false;
           ed_name.SetFocus;
         end;
  end;
end;

procedure Tfr_change_plan_work.bt_addClick(Sender: TObject);
begin
  ed_state:=1;
  SetEditInsert;
end;

procedure Tfr_change_plan_work.bt_editClick(Sender: TObject);
begin
  If cds_plans.active and (cds_plans.RecordCount>0) Then Begin
    ed_state:=2;
    SetEditInsert;
  end;
end;

procedure Tfr_change_plan_work.bt_cancelClick(Sender: TObject);
begin
  SetFreeState;
end;

procedure Tfr_change_plan_work.bt_saveClick(Sender: TObject);
var
  pp, par : variant;
begin
  CASE ed_state of
    1 : If ed_name.text<>'' Then Begin //Insert
          par:=VarArrayCreate([0, 2], varVariant);
          par[0]:=147;
          par[1]:=VarArrayOf(['name','coment']); //имена
          par[2]:=VarArrayOf([ed_name.text,ed_coment.Lines.Text]); //значения
          cod_err:=300;
          DM.StartTrans;
          pp:=DM.RunSQL(par);
          If pp<>0 Then Begin
             DM.BackTrans;
          end
          Else DM.ComTrans;
        end;
    2 : Begin //Edit
          par:=VarArrayCreate([0, 2], varVariant);
          par[0]:=148;
          par[1]:=VarArrayOf(['plan','name','coment']); //имена
          par[2]:=VarArrayOf([ed_id,ed_name.text,ed_coment.Lines.Text]); //значения
          cod_err:=301;
          DM.StartTrans;
          pp:=DM.RunSQL(par);
          If pp<>0 Then Begin
             DM.BackTrans;
          end
          Else DM.ComTrans;
        end;
  end;
  SetFreeState;
end;

procedure Tfr_change_plan_work.bt_delClick(Sender: TObject);
var
  pp, par : variant;
begin
  if MessageDlg('Внимание!! Удаление плана событий! Удалить?', mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;
  If cds_plans.active and (cds_plans.RecordCount>0) Then Begin
     par:=VarArrayCreate([0, 2], varVariant);
     par[0]:=149;
     par[1]:=VarArrayOf(['plan']); //имена
     par[2]:=VarArrayOf([cds_plans.FieldByName('ID').AsInteger]); //значения
     cod_err:=302;
     DM.StartTrans;
     pp:=DM.RunSQL(par);
     If pp<>0 Then Begin
        DM.BackTrans;
     end
     Else DM.ComTrans;
     SetFreeState;
  end;
  If cds_plans.active and (cds_plans.RecordCount=0) Then Begin
     num_plan_work:=0;
     lb_active_plan.Caption:=DM.GetNameSetWorkPlan;
  end;
end;

end.
