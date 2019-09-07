unit URAS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, DBClient, Grids, DBGrids, StdCtrls, Buttons, Objs;

type
  Tfr_t_ras = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ls_period: TListBox;
    gr_ras: TDBGrid;
    ds_ras: TDataSource;
    bt_go_obj: TBitBtn;
    bt_close: TBitBtn;
    cds_res: TClientDataSet;
    cds_ras: TClientDataSet;
    cds_rasunit_id: TIntegerField;
    cds_rasname: TStringField;
    cds_rasplan_id: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure bt_closeClick(Sender: TObject);
    procedure ls_periodClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bt_go_objClick(Sender: TObject);
  private
    Procedure SetClear;
    function FindObjectTag(id : integer) : Pointer;
    { Private declarations }
  public
    Procedure ShowUnitsRas;
    { Public declarations }
  end;



var
  fr_t_ras: Tfr_t_ras;
  IsShow : boolean;

implementation

{$R *.DFM}

uses ppd_main, PPD_DM;

Procedure Tfr_t_ras.ShowUnitsRas;
var
  ss : string;
  ii : integer;
Begin
  If IsShow Then Exit;
  ss:=DM.GetPeriodList;
  If ss<>'' Then ls_period.Items.Text:=ss
  Else Exit;
  For ii:=0 To ls_period.Items.Count-1 Do ls_period.Items.Strings[ii]:=IntToStr(ii+1)+'-й период';
  cds_ras.Active:=false;
  cds_ras.CreateDataSet;
  Show;
  IsShow:=true;
end;

procedure Tfr_t_ras.FormCreate(Sender: TObject);
begin
  IsShow:=false;
end;

procedure Tfr_t_ras.bt_closeClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_t_ras.ls_periodClick(Sender: TObject);
var
  per,pl : integer;
  pp,par,rr,nm : variant;
  nam : string;
begin
  //
  cds_ras.Active:=false;
  cds_ras.CreateDataSet;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=111;
  par[1]:=VarArrayOf(['u']);
  nm:=VarArrayOf(['NAME','PLAN_ID']);
  If ls_period.Items.Count>0 Then Begin
     per:=ls_period.ItemIndex+1;
     pp:=DM.GetResElementAll(-1,16,per);
     If not VarIsNull(pp) Then Begin
        cds_res.data:=pp;
        While not cds_res.EOF Do Begin
           par[2]:=VarArrayOf([cds_res.FieldByName('UNIT_ID').AsInteger]);
           rr:=DM.GetTehDataNams(par,nm);
           nam:='';
           pl:=0;
           If not VarIsNull(rr) Then Begin
              If not VarIsNull(rr[0]) Then nam:=rr[0];
              If not VarIsNull(rr[1]) Then pl:=rr[1];
              cds_ras.InsertRecord([cds_res.FieldByName('UNIT_ID').AsInteger,nam,pl]);
           end
           Else Begin
             // На тот случай если нужно искать узел на ВРП (ВПП)
           end;
           cds_res.Next;
        end;
        cds_res.Active:=false;
     end;
  end;
end;

procedure Tfr_t_ras.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cds_ras.Active:=false;
  IsShow:=false;
  SetClear;
end;

Procedure Tfr_t_ras.SetClear;
var
  ii : integer;
Begin
  if fr_main.tmr_find.Enabled Then fr_main.tmr_find.Enabled:=false;
  if findList.Count>0 Then For ii:=0 To findList.Count-1 Do Tmyobject(findList.Items[ii]).visible:=true;
  findList.Clear;
  fr_main.FieldMain.Repaint;
end;

function Tfr_t_ras.FindObjectTag(id : integer) : Pointer;
var
  ii : integer;
Begin
  Result:=nil;
  fr_main.fieldmain.SelectAll;
  For ii:=0 To fr_main.fieldmain.Selection.Count-1 Do
      If Tmyobject(fr_main.fieldmain.Selection.Items[ii]).tag=id Then Begin
         Result:=fr_main.fieldmain.Selection.Items[ii];
         fr_main.fieldmain.DeSelectAll;
         Exit;
      end;
  fr_main.fieldmain.DeSelectAll;
end;

procedure Tfr_t_ras.bt_go_objClick(Sender: TObject);
var
 ob : Pointer;
 pp,par : variant;
 pid,id : integer;
begin
  par:=VarArrayCreate([0,2],varVariant);
  SetClear;
  If cds_ras.Active Then
     If cds_ras.RecordCount>0 Then Begin
        id:=cds_ras.FieldByName('UNIT_ID').AsInteger;
        pid:=cds_ras.FieldByName('PLAN_ID').AsInteger;
        if (pid=1)and(fr_main.map_type<>1) Then fr_main.bt_s2Click(Sender);
        if (pid=0)and(fr_main.map_type<>0) Then fr_main.bt_s1Click(Sender);
        if pid>1 Then Begin
           par[0]:=78;
           par[1]:=VarArrayOf(['kust']);
           par[2]:=VarArrayOf([pid]);
           pp:=DM.GetTehData(par);
           If not VarIsNull(pp) Then fr_main.set_kust_map(pid)
           Else Begin
             par[0]:=22;
             par[1]:=VarArrayOf(['NS']);
             par[2]:=VarArrayOf([pid]);
             pp:=DM.GetTehData(par);
             If not VarIsNull(pp) Then fr_main.set_kust_map(pid)
             Else Begin
               par[0]:=19;
               par[1]:=VarArrayOf(['KNS']);
               par[2]:=VarArrayOf([pid]);
               pp:=DM.GetTehData(par);
               If not VarIsNull(pp) Then fr_main.set_kns_map(pid);
             end;
           end;
        end;
        ob:=FindObjectTag(id);
        If ob=nil Then Begin
           MessageDlg('Объект не найден!', mtWarning ,[mbOk], 0);
           Exit;
        end
        Else Begin
           findList.Add(ob);
           fr_main.tmr_find.enabled:=true;
           fr_main.fieldmain.SetSelected(ob);
        end;
     end;
end;

end.
