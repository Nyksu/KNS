unit Unit_press;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, StdCtrls, Buttons,
  ImgList;

type
  Tfr_units_press = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ls_units: TListView;
    Chart_press: TChart;
    Splitter1: TSplitter;
    Series1: TBarSeries;
    bt_exit: TBitBtn;
    bt_del: TBitBtn;
    ch_clear_units: TCheckBox;
    ImageList1: TImageList;
    pn_u_id: TPanel;
    procedure bt_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ls_unitsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure bt_delClick(Sender: TObject);
  private
    procedure ShowGraph(par : variant);
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure ShowUnitsPress;

var
  fr_units_press: Tfr_units_press;

implementation

uses ppd_dm;

{$R *.DFM}

Type
PUzOpt = ^TUzOpt;
TUzOpt = record
  ID : Integer;
  Name : string;
  ListIndex : Integer;
end;

var
  isCreate : boolean;

Procedure ShowUnitsPress;
Begin
  isCreate:=true;
  try
     try
       fr_units_press:=Tfr_units_press.Create(Application);
       fr_units_press.ShowModal;
     finally
       fr_units_press.Free;
     end
  except
  end;
end;

procedure Tfr_units_press.bt_exitClick(Sender: TObject);
var
  ii,cc : integer;
  p : pointer;
begin
  isCreate:=true;
  cc:=ls_units.Items.Count;
  For ii:=0 To cc-1 Do Begin
      p:=ls_units.Items.Item[ii].Data;
      ls_units.Items.Item[ii].Data:=nil;
      FreeMem(p);
  end;
  If ch_clear_units.Checked Then ChengingUnits.Clear;
  Close;
end;

procedure Tfr_units_press.FormCreate(Sender: TObject);
var
  cu,ii : integer;
  Puot : PUzOpt;
  nn : string;
  Li : TListItem;
begin
  cu:=ChengingUnits.Count;
  If cu=0 Then Exit;
  For ii:=0 To cu-1 Do Begin
     nn:=DM.GetUnitName(StrToInt(ChengingUnits.Strings[ii]));
     If nn='' Then nn:='ID('+ChengingUnits.Strings[ii]+')';
     New(Puot);
     Puot^.ID:=StrToInt(ChengingUnits.Strings[ii]);
     Puot^.Name:=nn;
     Puot^.ListIndex:=ii;
     Li:=ls_units.Items.Add;
     Li.Caption:=nn;
     Li.Data:=Puot;
     Li.ImageIndex:=0;
  end;
  isCreate:=false;
end;

procedure Tfr_units_press.ls_unitsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  Puot : PUzOpt;
  par : variant;
begin
  If isCreate Then Exit;
  Puot:=Item.Data;
  pn_u_id.Caption:=IntToStr(Puot^.ID);
  par:=DM.GetUnitRes(Puot^.ID);
  If VarIsNull(par) Then Exit;
  ShowGraph(par);
end;

procedure Tfr_units_press.ShowGraph(par : variant);
var
  cc,ii : integer;
Begin
   With Series1 Do Begin
       Clear;
       cc:=VarArrayHighBound(par,1);
       For ii:=0 To cc Do Add(par[ii][1],par[ii][0],clBlue);
   end;
end;

procedure Tfr_units_press.bt_delClick(Sender: TObject);
var
  Puot : PUzOpt;
begin
   If ls_units.Items.Count=0 Then Exit;
   Puot:=ls_units.Selected.Data;
   ls_units.Selected.Delete;
   ChengingUnits.Delete(Puot^.ListIndex);
end;

end.
