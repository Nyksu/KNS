unit findrule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, RXSpin, Grids, DBGrids, Db, Objs, DBClient;

type
  Tfr_find = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    rg_objects: TRadioGroup;
    bt_find: TBitBtn;
    bt_exit: TBitBtn;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    ed_id: TRxSpinEdit;
    Label2: TLabel;
    ed_name: TEdit;
    cds_find: TClientDataSet;
    gr_result: TDBGrid;
    bt_goto_object: TButton;
    ds_find: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure rg_objectsClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure bt_findClick(Sender: TObject);
    procedure bt_exitClick(Sender: TObject);
    procedure bt_goto_objectClick(Sender: TObject);
  private
    //procedure ClearFace;
    function GetFindData(tb : string;tip : integer) : variant;
    function FindObjectTag(id : integer) : Pointer;
    procedure GoToObj;
    { Private declarations }
  public
    procedure ClearFace;
    { Public declarations }
  end;

procedure ShowFindElementDlg;
procedure HideFindElementDlg;

var
  fr_find: Tfr_find;
  find_state : integer;
  itemsShow : integer;

implementation

uses ppd_main, PPD_DM;

{$R *.DFM}


procedure ShowFindElementDlg;
Begin
  If find_state<=0 Then fr_find.Show;
end;

procedure HideFindElementDlg;
Begin
  If find_state=1 Then fr_find.Hide;
end;

procedure Tfr_find.FormCreate(Sender: TObject);
begin
  find_state:=-1;
  itemsShow:=0;
end;

procedure Tfr_find.ClearFace;
var
  ii : integer;
Begin
  cds_find.Active:=false;
  if fr_main.tmr_find.Enabled Then fr_main.tmr_find.Enabled:=false;
  if findList.Count>0 Then For ii:=0 To findList.Count-1 Do Tmyobject(findList.Items[ii]).visible:=true;
  findList.Clear;
  fr_main.FieldMain.Repaint;
  itemsShow:=0;
end;

procedure Tfr_find.FormShow(Sender: TObject);
begin
  find_state:=1;
end;

procedure Tfr_find.FormHide(Sender: TObject);
begin
  find_state:=0;
end;

procedure Tfr_find.rg_objectsClick(Sender: TObject);
begin
  ClearFace;
end;

procedure Tfr_find.RadioGroup1Click(Sender: TObject);
begin
   CASE RadioGroup1.ItemIndex of
      0 : Begin
            ed_id.Enabled:=true;
            ed_name.Enabled:=false;
          end;
      1 : Begin
            ed_id.Enabled:=false;
            ed_name.Enabled:=true;
          end;
      2 : Begin
            ed_id.Enabled:=false;
            ed_name.Enabled:=false;
          end;
   end;
end;

function Tfr_find.GetFindData(tb : string;tip : integer) : variant;
var
 par,pp : variant;
begin
   Result:=null;
   par:=VarArrayCreate([0, 2], varVariant);
   if RadioGroup1.ItemIndex=0 Then Begin
      If tip=0 Then par[0]:=138;
      if tip=1 Then par[0]:=137;
      if tip=2 Then par[0]:=141;
      par[1]:=VarArrayOf(['!tb','cod']);
      par[2]:=VarArrayOf([tb,ed_id.Value]);
      cod_err:=410;
      pp:=DM.GetData(par);
      If VarIsNull(pp) Then Exit;
    end;
    if RadioGroup1.ItemIndex=1 Then Begin
      If tip=0 Then par[0]:=139;
      if tip=1 Then par[0]:=140;
      if tip=2 Then par[0]:=142;
      par[1]:=VarArrayOf(['!tb','!nam']);
      par[2]:=VarArrayOf([tb,ed_name.text]);
      cod_err:=411;
      pp:=DM.GetData(par);
      If VarIsNull(pp) Then Exit;
    end;
    Result:=pp;
end;

procedure Tfr_find.bt_findClick(Sender: TObject);
var
 pp : variant;
begin
   ClearFace;
   pp:=null;
   CASE rg_objects.ItemIndex of
       0 : Begin // НС
             pp:=GetFindData('NS',0);
           end;
       1 : Begin // КНС
             pp:=GetFindData('KNS',0);
           end;
       2 : Begin // Куст
             pp:=GetFindData('kust',2);
           end;
       3 : Begin //Скважина
             pp:=GetFindData('well',1);
           end;
       4 : Begin //Насос
             pp:=GetFindData('pump',0);
           end;
       5 : Begin  //Водовод
             pp:=GetFindData('pipe',0);
           end;
       6 : Begin  //Задвижка
             pp:=GetFindData('catch',0);
           end;
       7 : Begin  //Узел
             pp:=GetFindData('connect_unit',0);
           end;
   end;
   If VarIsNull(pp) Then Exit;
   cds_find.data:=pp;
end;

procedure Tfr_find.bt_exitClick(Sender: TObject);
begin
  HideFindElementDlg;
end;

function Tfr_find.FindObjectTag(id : integer) : Pointer;
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

procedure Tfr_find.GoToObj;
var
 ob : Pointer;
begin
  ob:=FindObjectTag(cds_find.FieldByName('ID').AsInteger);
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

procedure Tfr_find.bt_goto_objectClick(Sender: TObject);
var
 ob : Pointer;
 id,idp : integer;
 pp,par : variant;
begin
  findList.Clear;
  If not cds_find.Active Then Exit;
  If cds_find.RecordCount=0 Then Exit;
  par:=VarArrayCreate([0,2],varVariant);
  CASE rg_objects.ItemIndex of
     0,1 : Begin // КНС и НС
             If (fr_main.map_type>rg_objects.ItemIndex) Then Begin
                fr_main.bt_s1Click(Sender);
             end;
             GoToObj;
           end;
       2 : Begin // Куст
             If (fr_main.map_type<>1) Then Begin
                fr_main.bt_s2Click(Sender);
             end;
             GoToObj;
           end;
       3 : Begin //Скважина
             par[0]:=94;
             par[1]:=VarArrayOf(['well']);
             par[2]:=VarArrayOf([cds_find.FieldByName('ID').AsInteger]);
             cod_err:=412;
             pp:=DM.GetTehData(par);
             If VarIsNull(pp) Then Exit;
             id:=pp[1];
             fr_main.set_kust_map(id);
             GoToObj;
           end;
       4 : Begin //Насос
             par[0]:=83;
             par[1]:=VarArrayOf(['pump']);
             par[2]:=VarArrayOf([cds_find.FieldByName('ID').AsInteger]);
             cod_err:=413;
             pp:=DM.GetTehData(par);
             If VarIsNull(pp) Then Exit;
             If VarIsNull(pp[1]) Then Begin
                id:=pp[2];
                fr_main.set_ns_map(id);
             end
             Else Begin
                id:=pp[1];
                fr_main.set_kns_map(id);
             end;
             GoToObj;
           end;
       5 : Begin  //Водовод
             par[0]:=44;
             par[1]:=VarArrayOf(['pipe']);
             par[2]:=VarArrayOf([cds_find.FieldByName('ID').AsInteger]);
             cod_err:=414;
             pp:=VarArrayOf(['NS_ID','KNS_ID','KUST_ID','SHEM_ID']);
             pp:=DM.GetTehDataNams(par,pp);
             If VarIsNull(pp) Then Exit;
             If (not VarIsNull(pp[0]))and(pp[3]=4) Then Begin
                id:=pp[0];
                fr_main.set_ns_map(id);
             end;
             If (not VarIsNull(pp[1]))and(pp[3]=2) Then Begin
                id:=pp[1];
                fr_main.set_kns_map(id);
             end;
             If (not VarIsNull(pp[2]))and(pp[3]=3) Then Begin
                id:=pp[2];
                fr_main.set_kust_map(id);
             end;
             if (pp[3]=1)and(fr_main.map_type<>1) Then fr_main.bt_s2Click(Sender);
             if (pp[3]=0)and(fr_main.map_type<>0) Then fr_main.bt_s1Click(Sender);
             GoToObj;
           end;
       6 : Begin  //Задвижка
             par[0]:=37;
             par[1]:=VarArrayOf(['catch']);
             par[2]:=VarArrayOf([cds_find.FieldByName('ID').AsInteger]);
             cod_err:=415;
             pp:=VarArrayOf(['NS_ID','KNS_ID','KUST_ID','SHEM_ID']);
             pp:=DM.GetTehDataNams(par,pp);
             If VarIsNull(pp) Then Exit;
             If (not VarIsNull(pp[0]))and(pp[3]=4) Then Begin
                id:=pp[0];
                fr_main.set_ns_map(id);
             end;
             If (not VarIsNull(pp[1]))and(pp[3]=2) Then Begin
                id:=pp[1];
                fr_main.set_kns_map(id);
             end;
             If (not VarIsNull(pp[2]))and(pp[3]=3) Then Begin
                id:=pp[2];
                fr_main.set_kust_map(id);
             end;
             if (pp[3]=1)and(fr_main.map_type<>1) Then fr_main.bt_s2Click(Sender);
             if (pp[3]=0)and(fr_main.map_type<>0) Then fr_main.bt_s1Click(Sender);
             GoToObj;
           end;
       7 : Begin  //Узел
             par[0]:=111;
             par[1]:=VarArrayOf(['u']);
             par[2]:=VarArrayOf([cds_find.FieldByName('ID').AsInteger]);
             cod_err:=416;
             pp:=VarArrayOf(['PLAN_ID']);
             pp:=DM.GetTehDataNams(par,pp);
             If VarIsNull(pp) Then Exit;
             if (pp[0]=1)and(fr_main.map_type<>1) Then fr_main.bt_s2Click(Sender);
             if (pp[0]=0)and(fr_main.map_type<>0) Then fr_main.bt_s1Click(Sender);
             if pp[0]>1 Then Begin
             // 78 kust
             // 22 ns
             // 19 kns
                idp:=pp[0];
                par[0]:=78;
                par[1]:=VarArrayOf(['kust']);
                par[2]:=VarArrayOf([idp]);
                cod_err:=417;
                pp:=DM.GetTehData(par);
                If not VarIsNull(pp) Then Begin
                   //id:=pp[0];
                   fr_main.set_kust_map(idp);
                end
                Else Begin
                     par[0]:=22;
                     par[1]:=VarArrayOf(['NS']);
                     par[2]:=VarArrayOf([idp]);
                     cod_err:=418;
                     pp:=DM.GetTehData(par);
                     If not VarIsNull(pp) Then Begin
                        //id:=pp[0];
                        fr_main.set_ns_map(idp);
                     end
                     Else Begin
                          par[0]:=19;
                          par[1]:=VarArrayOf(['KNS']);
                          par[2]:=VarArrayOf([idp]);
                          cod_err:=419;
                          pp:=DM.GetTehData(par);
                          If not VarIsNull(pp) Then Begin
                             //id:=pp[0];
                             fr_main.set_kns_map(idp);
                          end;
                     end;
                end;
             end;
             GoToObj;
           end;
   end;
end;

end.
