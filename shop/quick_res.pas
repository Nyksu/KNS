unit quick_res;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids;

type
  Tfr_quick_result = class(TForm)
    Panel1: TPanel;
    Panel4: TPanel;
    lb_period: TListBox;
    Panel5: TPanel;
    gr_params: TStringGrid;
    Splitter1: TSplitter;
    bt_close: TButton;
    mm_per_about: TMemo;
    procedure bt_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lb_periodClick(Sender: TObject);
  private
    procedure SetResToGrid(par : variant);
    procedure ClearFields;
    { Private declarations }
  public
    Procedure ShowElRes(id,tp : integer);
    { Public declarations }
  end;

Procedure ShowQRes;



var
  fr_quick_result: Tfr_quick_result;
  IsShow : boolean;

implementation

uses ppd_dm;

{$R *.DFM}

var
  iid,ttp : integer;

Procedure ShowQRes;
Begin
  fr_quick_result.Show;
  IsShow:=true;
end;

procedure Tfr_quick_result.bt_closeClick(Sender: TObject);
begin
  IsShow:=false;
  Hide;
end;

procedure Tfr_quick_result.FormShow(Sender: TObject);
var
  ss : string;
begin
  ss:=DM.GetPeriodList;
  If ss<>'' Then lb_period.Items.Text:=ss;
end;

Procedure Tfr_quick_result.ShowElRes(id,tp : integer);
var
  ppp : pointer;
  pr : integer;
  rr : Variant;
Begin
  iid:=id;
  ttp:=tp;
  If not IsShow Then Exit;
  If (tp>0)and(id>0)and(lb_period.ItemIndex>=0) Then Begin
    pr:=StrToInt(lb_period.Items.Strings[lb_period.ItemIndex]);
    rr:=DM.GetResElements(id, tp, pr);
    SetResToGrid(rr);
  end;
end;

procedure Tfr_quick_result.ClearFields;
var
  ii,rc : integer;
Begin
  rc:=gr_params.RowCount;
  For ii:=1 To rc Do Begin
     gr_params.Cells[0,ii]:='';
     gr_params.Cells[1,ii]:='';
     gr_params.Cells[2,ii]:='';
  end;
end;

procedure Tfr_quick_result.SetResToGrid(par : variant);
var
 rc,ii : integer;
Begin
  If VarIsNull(par) Then Exit;
  rc:=VarArrayHighBound(par,1);
  ClearFields;
  For ii:=0 To rc Do If not VarIsNull(par[ii]) Then Begin
     gr_params.Cells[0,ii+1]:=par[ii][0];
     gr_params.Cells[1,ii+1]:=par[ii][1];
     gr_params.Cells[2,ii+1]:=par[ii][2];
  end;
end;

procedure Tfr_quick_result.FormCreate(Sender: TObject);
begin
  IsShow:=false;
  iid:=0;
  ttp:=0;
  gr_params.Cells[0,0]:='Параметр';
  gr_params.Cells[1,0]:='Значение';
  gr_params.Cells[2,0]:='Ед. изм.';
end;

procedure Tfr_quick_result.lb_periodClick(Sender: TObject);
begin
  ShowElRes(iid,ttp);
  mm_per_about.Text:='';
  mm_per_about.text:=DM.GetAboutPeriod(StrToInt(lb_period.Items.Strings[lb_period.ItemIndex]));
end;

end.
