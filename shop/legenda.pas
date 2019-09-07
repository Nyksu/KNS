unit legenda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Objs, StdCtrls, ExtCtrls, ComCtrls, ImgList;

type
  Tfr_legend = class(TForm)
    Panel1: TPanel;
    bt_hide: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure bt_hideClick(Sender: TObject);
  private
    idi : integer;
    

    { Private declarations }
  public
    Procedure ClearList;
    Procedure AddItem(cl : integer; cmt : string);
    { Public declarations }
  end;

Procedure CreateLegend;

var
  fr_legend: Tfr_legend;

implementation

{$R *.DFM}

uses ppd_dm;

Procedure CreateLegend;
Begin
  try
    fr_legend:=Tfr_legend.Create(Application);
  except
  end;
end;

Procedure Tfr_legend.AddItem(cl : integer; cmt : string);
var
  iimg : TBitMap;
  TreeNode: TTreeNode;
Begin
  iimg:=TBitMap.Create;
  iimg.LoadFromFile(DM.legendimgname);
  iimg.Canvas.Brush.Style:=bsSolid;
  iimg.Canvas.Brush.Color:=cl;
  iimg.Canvas.Rectangle(4,4,28,17);
  ImageList1.Add(iimg,nil);
  iimg.free;
  TreeNode:=TreeView1.Items.AddObject(nil,cmt,nil);
  TreeNode.ImageIndex:=idi;
  TreeNode.StateIndex:=idi;
  TreeNode.SelectedIndex:=idi;
  Inc(idi);
end;

procedure Tfr_legend.FormCreate(Sender: TObject);
begin
  idi:=0;
end;

procedure Tfr_legend.bt_hideClick(Sender: TObject);
begin
  fr_legend.Hide;
end;

Procedure Tfr_legend.ClearList;
Begin
  TreeView1.Items.Clear;
  ImageList1.Clear;
  idi:=0;
end;

end.
