unit open_maps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, StdCtrls, DBCtrls, RXCtrls, Grids, DBGrids, ExtCtrls,
  Menus, Buttons;

type
  Tfr_open_maps = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    lb_creator: TRxLabel;
    DBMemo1: TDBMemo;
    cds_maps: TClientDataSet;
    ds_maps: TDataSource;
    bt_open: TBitBtn;
    bt_close: TBitBtn;
    ppm_ed_shem: TPopupMenu;
    n_del_shem: TMenuItem;
    n_rename_shem: TMenuItem;
    procedure ds_mapsDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure bt_openClick(Sender: TObject);
  private
    procedure GetMapsList;
    { Private declarations }
  public
    { Public declarations }
  end;

Function OpenShem : boolean;

var
  fr_open_maps: Tfr_open_maps;

implementation

uses PPD_main, PPD_DM;

{$R *.DFM}

Function OpenShem : boolean;
Begin
  Result:=false;
  try
     try
       fr_open_maps:=Tfr_open_maps.Create(Application);
       fr_open_maps.ShowModal;
     finally
       fr_open_maps.Free;
     end
  except
  end;
end;

procedure Tfr_open_maps.ds_mapsDataChange(Sender: TObject; Field: TField);
var
  pp, par : variant;
begin
  lb_creator.Caption:='';
  if cds_maps.Active Then
     if cds_maps.RecordCount>0 Then Begin
        lb_creator.Caption:='ЗАО "РУСИНТЕЛ"';
        if cds_maps.FieldByName('CREATER').AsInteger>0 Then Begin
           par:=VarArrayCreate([0, 2], varVariant);
           par[0]:=151;
           par[1]:=VarArrayOf(['u']); //имена
           par[2]:=VarArrayOf([cds_maps.FieldByName('CREATER').AsInteger]); //значения
           pp:=DM.GetTehData(par);
           if not VarIsNull(pp) Then lb_creator.Caption:=pp;
        end;
     end;
end;

procedure Tfr_open_maps.GetMapsList;
var
  pp, par : variant;
Begin
  cds_maps.Active:=false;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=152;
  par[1]:=null;
  par[2]:=null;
  pp:=DM.GetData(par);
  If not VarIsNull(pp) Then cds_maps.Data:=pp;
end;

procedure Tfr_open_maps.FormCreate(Sender: TObject);
begin
  GetMapsList;
end;

procedure Tfr_open_maps.bt_openClick(Sender: TObject);
var
  res : integer;
begin
  if cds_maps.Active Then
     if cds_maps.RecordCount>0 Then Begin
        res:=DM.SetMapWork(cds_maps.FieldByName('ID').AsInteger);
        If res=0 Then Begin
           fr_main.ClearToolBtn(2);
           fr_main.bt_s1Click(Sender);
           fr_main.StatusBar1.Panels[2].Text:=cds_maps.FieldByName('NAME').AsString;
           GetMapsList;
           isCalcOk:=false;
           fr_main.StatusBar1.Panels.Items[1].Text:='Расчет модели не проводился';
        end
        Else MessageDlg('Ошибка смены схемы!', mtError, [mbOk], 0);
     end;
end;

end.
