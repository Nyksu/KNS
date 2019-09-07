unit pipe_d_spr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Db, DBClient,
  Buttons, Ask_Integer;

type
  Tfr_pipe_d = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pn_color: TPanel;
    cds_pipe_d: TClientDataSet;
    ds_pipe_d: TDataSource;
    bt_ed_color: TButton;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    bt_ed_d: TBitBtn;
    bt_add: TBitBtn;
    bt_close: TBitBtn;
    procedure bt_closeClick(Sender: TObject);
    procedure ds_pipe_dDataChange(Sender: TObject; Field: TField);
    procedure bt_ed_colorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_addClick(Sender: TObject);
    procedure bt_ed_dClick(Sender: TObject);
  private
    procedure ShowDpipe;
    { Private declarations }
  public
    { Public declarations }
  end;

Function StartDPipe : boolean;

var
  fr_pipe_d: Tfr_pipe_d;

implementation

Uses PPD_DM, ColorChange;

{$R *.DFM}

var
  funcres : boolean;

Function StartDPipe : boolean;
Begin
  try
   try
    funcres:=false;
    fr_pipe_d:=Tfr_pipe_d.Create(Application);
    fr_pipe_d.ShowModal;
   finally
    Result:=funcres;
    fr_pipe_d.free;
   end;
  except
  end;
end;

procedure Tfr_pipe_d.ShowDpipe;
var
 par,pp : variant;
Begin
  cds_pipe_d.Active:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  par[1]:=null;
  par[2]:=null;
  par[0]:=73;
  pp:=DM.GetData(par);
  If VarIsNull(pp) Then Exit;
  cds_pipe_d.data:=pp;
end;

procedure Tfr_pipe_d.bt_closeClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_pipe_d.ds_pipe_dDataChange(Sender: TObject; Field: TField);
begin
  If cds_pipe_d.Active Then
     If cds_pipe_d.RecordCount>0 Then
        pn_color.Color:=cds_pipe_d.FieldByName('COLOR').AsInteger;
end;

procedure Tfr_pipe_d.bt_ed_colorClick(Sender: TObject);
var
  newcolor,oldcolor,res : integer;
  par,pp : variant;
begin
  If cds_pipe_d.Active Then
     If cds_pipe_d.RecordCount>0 Then Begin
        oldcolor:=cds_pipe_d.FieldByName('COLOR').AsInteger;
        newcolor:=fr_getColor.GetCol(oldcolor);
        If (newcolor>=0)and(newcolor<>oldcolor) Then Begin
           // Изменяем параметры цвета водовода
           par:=VarArrayCreate([0, 2], varVariant);
           par[0]:=188;
           par[1]:=VarArrayOf(['clr','did']);
           par[2]:=VarArrayOf([newcolor,cds_pipe_d.FieldByName('ID').AsInteger]);
           DM.StartTrans;
           res:=DM.RunSQL(par);
           If res<>0 Then Begin
              DM.BackTrans;
              Exit;
           end;
           DM.ComTrans;
           funcres:=true;
           pn_color.Color:=newcolor;
           cds_pipe_d.Edit;
           cds_pipe_d.FieldByName('COLOR').AsInteger:=newcolor;
           cds_pipe_d.Post;
        end;
     end;
end;

procedure Tfr_pipe_d.FormCreate(Sender: TObject);
begin
  ShowDpipe;
end;

procedure Tfr_pipe_d.bt_addClick(Sender: TObject);
var
  newd,newcolor,newid,res : integer;
  par,pp : variant;
begin
  newd:=Ask_Int('Диаметр водовода','Введите новый диаметр водовода',100,1500,50);
  If newd<=0 Then Exit;
  Randomize;
  newcolor:=Round(Random(16777215));
  newcolor:=fr_getColor.GetCol(newcolor);
  If newcolor<0 Then Exit;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=189;
  par[1]:=null;
  par[2]:=null;
  pp:=DM.GetTehData(par);
  If VarIsNull(pp) Then Exit;
  newid:=pp;
  par[0]:=190;
  par[1]:=VarArrayOf(['d','clr','did']);
  par[2]:=VarArrayOf([newd,newcolor,newid]);
  DM.StartTrans;
  res:=DM.RunSQL(par);
  If res<>0 Then Begin
     DM.BackTrans;
     Exit;
  end;
  DM.ComTrans;
  ShowDpipe;
end;

procedure Tfr_pipe_d.bt_ed_dClick(Sender: TObject);
var
  newd,oldd,res : integer;
  par,pp : variant;
begin
  If cds_pipe_d.Active Then
     If cds_pipe_d.RecordCount>0 Then Begin
        par:=VarArrayCreate([0, 2], varVariant);
        par[0]:=191;
        oldd:=cds_pipe_d.FieldByName('DIAMETR').AsInteger;
        newd:=Ask_Int('Диаметр водовода','Введите новый диаметр водовода',oldd,1500,50);
        If (newd>0)and(newd<>oldd) Then Begin
           par[1]:=VarArrayOf(['d','did']);
           par[2]:=VarArrayOf([newd,cds_pipe_d.FieldByName('ID').AsInteger]);
           DM.StartTrans;
           res:=DM.RunSQL(par);
           If res<>0 Then Begin
              DM.BackTrans;
              Exit;
           end;
           DM.ComTrans;
           funcres:=true;
           ShowDpipe;
        end;
     end;
end;

end.
