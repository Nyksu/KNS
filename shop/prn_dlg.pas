unit prn_dlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXSpin, DPrint, Buttons, ExtCtrls, Objs, printers, winspool, Dtypes, Spin;

type
  Tfr_print_dlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bt_prn_setup: TBitBtn;
    Panel3: TPanel;
    PrintPreview1: TPrintPreview;
    Label1: TLabel;
    ed_mastab: TRxSpinEdit;
    bt_set_mas_to_page: TButton;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    bt_print: TBitBtn;
    GroupBox1: TGroupBox;
    bt_exit: TBitBtn;
    rb_portrait: TRadioButton;
    rb_landscape: TRadioButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    ed_d_bottom: TSpinEdit;
    ed_d_left: TSpinEdit;
    ed_d_right: TSpinEdit;
    ed_d_top: TSpinEdit;
    Button2: TButton;
    Button3: TButton;
    procedure bt_prn_setupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_printClick(Sender: TObject);
    procedure bt_exitClick(Sender: TObject);
    procedure ed_mastabChange(Sender: TObject);
    procedure rb_portraitClick(Sender: TObject);
    procedure ed_d_topChange(Sender: TObject);
    procedure ed_d_bottomChange(Sender: TObject);
    procedure ed_d_rightChange(Sender: TObject);
    procedure ed_d_leftChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bt_set_mas_to_pageClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetPrinterPages : integer;
  end;

Procedure ShPrnDlg;

var
  fr_print_dlg: Tfr_print_dlg;

implementation

uses PPD_main;

{$R *.DFM}


Procedure ShPrnDlg;
Begin
  try
     try
       fr_print_dlg:=Tfr_print_dlg.Create(Application);
       fr_print_dlg.ShowModal;
     finally
       fr_print_dlg.Free;
     end
  except
  end;
end;

procedure Tfr_print_dlg.bt_prn_setupClick(Sender: TObject);
begin
  Printersetupdialog1.execute;
  //fr_main.FieldMain.Printer := Printer;
  GetPrinterPages;
end;

function Tfr_print_dlg.GetPrinterPages;
var str1:string;
    V : pointer;
    countbytes: integer;
    i : integer;
    str : pchar;
    MPI2 : PPrinterInfo2A;
    Needed : PDword;
    DevMode : DEVMODEA;
begin
 str1 := Printer.printers[Printer.printerindex];
 {узнаем кол-во байтов нужное для возврата параметров}
 CountBytes := DeviceCapabilities(Pchar(Str1),Pchar('LPT1'),DC_PAPERNAMES,0,0);
 {создаем буфер}
 getmem(V,(CountBytes+1)*64);
 DeviceCapabilities(Pchar(Str1),Pchar('LPT1'),DC_PAPERNAMES,V,0);
 for  i := 0 to CountBytes - 1 do
  begin
   str := pointer(integer(V)+i*64);
//   PaperBox.Items.add(str);
  end;
  FreeMem(V,CountBytes);

  New(MPI2);
  New(Needed);

  GetPrinter(
    Printer.Handle,
    2,
    MPI2,
    Sizeof(MPI2^),
    Needed
   );

//  DevMode := MPI2^.pdevmode^;
//  DevMode.dmPaperSize;
  dispose(MPI2);
  dispose(Needed);
end;

procedure Tfr_print_dlg.FormCreate(Sender: TObject);
var rect : Tlongrect;
begin
  GetPrinterPages;
  PageSize.Left := 0;
  PageSize.Top := 0;
  PageSize.Right := 0;
  PageSize.Bottom := 0;
  UsePageExtents := false;
  rect := fr_main.FieldMain.getdiagramextents;
  PageExtents.Top := rect.Top ;
  PageExtents.Left := rect.left ;
  PageExtents.Bottom := rect.Bottom ;
  PageExtents.Right := rect.Right ;

end;

procedure Tfr_print_dlg.bt_printClick(Sender: TObject);
var i,j : integer;
    printpages : boolean;
begin
  printpages := false;
  for i := 1 to MAXPAGES do
   for j := 1 to MAXPAGES do
    if printpreview1.Pages[i,j] then printpages := true;

  if printdialog1.Execute then
   if printpages then
     for i := 1 to MAXPAGES do begin
      for j := 1 to MAXPAGES do begin
       if printpreview1.Pages[i,j] = True then begin
         fr_main.FieldMain.Print(prtSelected,[Point(i,j)]);
       end;
      end;
     end
    else fr_main.FieldMain.Print(prtAll,[]);
end;

procedure Tfr_print_dlg.bt_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_print_dlg.ed_mastabChange(Sender: TObject);
begin
  If ed_mastab.value<=0 Then ed_mastab.value:=1;
  fr_main.fieldmain.PrintScale := Round(ed_mastab.value);
  fr_main.fieldmain.Repaint;
end;

procedure Tfr_print_dlg.rb_portraitClick(Sender: TObject);
begin
  if Sender=rb_portrait then
  printer.Orientation := poPortrait else
  printer.Orientation := poLandscape;
  PrintPreview1.Refresh;
end;

procedure Tfr_print_dlg.ed_d_topChange(Sender: TObject);
var Cap: Integer;
begin
  Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSY);
  pagesize.top := round(Cap/25*ed_d_top.Value);
  PrintPreview1.Refresh;
end;

procedure Tfr_print_dlg.ed_d_bottomChange(Sender: TObject);
var Cap: Integer;
begin
  Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSY);
  pagesize.bottom := round(Cap/25*ed_d_bottom.Value);
  PrintPreview1.Refresh;
end;

procedure Tfr_print_dlg.ed_d_rightChange(Sender: TObject);
var Cap: Integer;
begin
  Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSX);
  pagesize.right := round(Cap/25*ed_d_right.Value);
  PrintPreview1.Refresh;
end;

procedure Tfr_print_dlg.ed_d_leftChange(Sender: TObject);
var Cap: Integer;
begin
  Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSX);
  pagesize.left := round(Cap/25*ed_d_left.Value);
  PrintPreview1.Refresh;
end;

procedure Tfr_print_dlg.FormShow(Sender: TObject);
begin
  ed_mastab.Value:=100;
end;

procedure Tfr_print_dlg.bt_set_mas_to_pageClick(Sender: TObject);
begin
 PrintPreview1.ResetToDefault;
end;

procedure Tfr_print_dlg.Button1Click(Sender: TObject);
var rect : TLongrect;
begin
 PageExtents.Top := PageExtents.Top - 100;
 PageExtents.Left := PageExtents.Left - 100;
 PageExtents.Right := PageExtents.Right + 100;
 PageExtents.Bottom := PageExtents.Bottom + 100;
 UsePageExtents := true;
 PrintPreview1.Refresh;
end;

procedure Tfr_print_dlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   PrintPreview1.ResetToDefault;
   UsePageExtents := false;
end;

procedure Tfr_print_dlg.Button2Click(Sender: TObject);
var rect : Tlongrect;
begin
  UsePageExtents := false;
  rect := fr_main.FieldMain.getdiagramextents;
  PageExtents.Top := rect.Top ;
  PageExtents.Left := rect.left ;
  PageExtents.Bottom := rect.Bottom ;
  PageExtents.Right := rect.Right ;
  PrintPreview1.Refresh;
end;

end.
