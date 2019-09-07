unit pipe_speed_color;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, RXCtrls, RXSpin;

type
  Tfr_spd_pipe_color = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    tb2: TTrackBar;
    tb3: TTrackBar;
    tb4: TTrackBar;
    lb1: TRxLabel;
    lb2: TRxLabel;
    lb3: TRxLabel;
    lb4: TRxLabel;
    GroupBox1: TGroupBox;
    lb_max: TLabel;
    bt_next: TBitBtn;
    ed2: TRxSpinEdit;
    ed3: TRxSpinEdit;
    ed4: TRxSpinEdit;
    procedure bt_nextClick(Sender: TObject);
    procedure tb2Change(Sender: TObject);
    procedure tb3Change(Sender: TObject);
    procedure tb4Change(Sender: TObject);
    procedure Panel3DblClick(Sender: TObject);
    procedure Panel4DblClick(Sender: TObject);
    procedure ed2Change(Sender: TObject);
    procedure ed3Change(Sender: TObject);
    procedure ed4Change(Sender: TObject);
  private
    vmin : real;
    vmax : real;
    v1 : real;
    v2 : real;
    v3 : real;
    v4 : real;
    proc : real;
    cl1 : integer;
    cl2 : integer;
    cl3 : integer;
    cl4 : integer;
    rs : variant;
    { Private declarations }
  public
    Function GetSpeedColor(per : integer) : variant;
    { Public declarations }
  end;

var
  fr_spd_pipe_color: Tfr_spd_pipe_color;

implementation

Uses PPD_DM, ColorChange;

{$R *.DFM}

Function Tfr_spd_pipe_color.GetSpeedColor(per : integer) : variant;
var
  rr : variant;
  str : string;
Begin
  Result:=null;
  rs:=null;
  rr:=DM.GetMinMaxSpeedPipePer(per, 0);
  If VarIsNull(rr) Then Exit;
  vmin:=rr;
  rr:=DM.GetMinMaxSpeedPipePer(per, 1);
  If VarIsNull(rr) Then Exit;
  vmax:=rr;
  if abs(vmin)>vmax Then vmax:=abs(vmin);
  lb_max.Caption:='MAX = '+FloatToStr(vmax)+' ì/ñ';
  proc:=vmax/100;

  str:=DM.GetParamINI('PIPE SPEED','V2',FloatToStr(Round(25*proc*100)/100));
  ed2.Value:=StrToFloat(str);
  str:=DM.GetParamINI('PIPE SPEED','V3',FloatToStr(Round(75*proc*100)/100));
  ed3.Value:=StrToFloat(str);
  str:=DM.GetParamINI('PIPE SPEED','V4',FloatToStr(Round(100*proc*100)/100));
  ed4.Value:=StrToFloat(str);

  str:=DM.GetParamINI('PIPE SPEED','C2',IntToStr(clNavy));
  cl2:=StrToInt(str);
  Panel3.Color:=cl2;
  str:=DM.GetParamINI('PIPE SPEED','C3',IntToStr(clFuchsia));
  cl3:=StrToInt(str);
  Panel4.Color:=cl3;

  fr_spd_pipe_color.ShowModal;
  Result:=rs;
end;

procedure Tfr_spd_pipe_color.bt_nextClick(Sender: TObject);
begin
  if (v4>v3)and(v3>v2)and(v2>v1) Then Begin
      rs:=VarArrayCreate([0, 3], varVariant);
      if v4>vmax Then v4:=vmax;
      rs[0]:=VarArrayOf([0,0]);
      rs[1]:=VarArrayOf([v2,cl2]);
      rs[2]:=VarArrayOf([v3,cl3]);
      rs[3]:=VarArrayOf([v4,clRed]);

      DM.SetParamINI('PIPE SPEED','V2',FloatToStr(v2));
      DM.SetParamINI('PIPE SPEED','V3',FloatToStr(v3));
      DM.SetParamINI('PIPE SPEED','V4',FloatToStr(v4));
      DM.SetParamINI('PIPE SPEED','C2',IntToStr(cl2));
      DM.SetParamINI('PIPE SPEED','C3',IntToStr(cl3));

      Close;
  end;
end;

procedure Tfr_spd_pipe_color.tb2Change(Sender: TObject);
begin
  ed2.Value:=Round(tb2.Position*proc*100)/100;
end;

procedure Tfr_spd_pipe_color.tb3Change(Sender: TObject);
begin
  ed3.Value:=Round(tb3.Position*proc*100)/100;
end;

procedure Tfr_spd_pipe_color.tb4Change(Sender: TObject);
begin
  ed4.Value:=Round(tb4.Position*proc*100)/100;
end;

procedure Tfr_spd_pipe_color.Panel3DblClick(Sender: TObject);
var
  cl : integer;
begin
  cl:=fr_getColor.GetCol(Panel3.Color);
  if cl>=0 Then Begin
     cl2:=cl;
     Panel3.Color:=cl;
  end;
end;

procedure Tfr_spd_pipe_color.Panel4DblClick(Sender: TObject);
var
  cl : integer;
begin
  cl:=fr_getColor.GetCol(Panel4.Color);
  if cl>=0 Then Begin
     cl3:=cl;
     Panel4.Color:=cl;
  end;
end;

procedure Tfr_spd_pipe_color.ed2Change(Sender: TObject);
begin
  v2:=ed2.Value;
  tb2.Position:=Round(v2/proc);
  lb2.Caption:=FloatToStr(v2)+' ì/ñ';
end;

procedure Tfr_spd_pipe_color.ed3Change(Sender: TObject);
begin
  v3:=ed3.Value;
  tb3.Position:=Round(v3/proc);
  lb3.Caption:=FloatToStr(v3)+' ì/ñ';
end;

procedure Tfr_spd_pipe_color.ed4Change(Sender: TObject);
begin
  v4:=ed4.Value;
  tb4.Position:=Round(v4/proc);
  lb4.Caption:=FloatToStr(v4)+' ì/ñ';
end;

end.
