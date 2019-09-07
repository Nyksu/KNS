unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DPrint, StdCtrls, RXSpin, winspool, Dtypes, Spin , Objs, printers;

type

  TMyPage = record
   {сия бяка по умолчанию означает отступ от краев страницы
    не печатаемой принтером или ученьшеной ползователем}
   OffsetX,OffsetY : integer;
  end;

  TPrintPreviewform = class(TForm)
    PrintPreview1: TPrintPreview;
    Button1: TButton;
    Button2: TButton;
    RxSpinEdit1: TRxSpinEdit;
    Button3: TButton;
    Button4: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox2: TGroupBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RxSpinEdit1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   function GetPrinterPages : integer;
  end;

var
  PrintPreviewform: TPrintPreviewform;

implementation

uses PPD_main;

{$R *.DFM}

procedure TPrintPreviewform.FormCreate(Sender: TObject);
begin
 PrintPreview1.BorderStyle := bssingle;
 GetPrinterPages;
end;

procedure TPrintPreviewform.RxSpinEdit1Change(Sender: TObject);
begin
 if RxSpinEdit1.value<>0 then
 fr_main.fieldmain.PrintScale := Round(RxSpinEdit1.value)
 else RxSpinEdit1.value := 1;
 fr_main.fieldmain.Repaint;
end;

procedure TPrintPreviewform.Button4Click(Sender: TObject);
var str1:string;
    V : pointer;
    countbytes: integer;
    i : integer;
    str : pchar;
begin
 Printersetupdialog1.execute;
 GetPrinterPages;
end;

procedure TPrintPreviewform.Button1Click(Sender: TObject);
begin
 if printdialog1.Execute then
    fr_main.FieldMain.Print(prtAll,[]);
end;

procedure TPrintPreviewform.Button2Click(Sender: TObject);
begin
 close;
end;

function TPrintPreviewform.GetPrinterPages;
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

procedure TPrintPreviewform.RadioButton1Click(Sender: TObject);
begin
 if Sender=RadioButton1 then
 printer.Orientation := poPortrait else
 printer.Orientation := poLandscape;
 PrintPreview1.Refresh;
end;


procedure TPrintPreviewform.SpinEdit4Change(Sender: TObject);
var Cap: Integer;
begin
 Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSY);
 pagesize.top := round(Cap/25.4*SpinEdit4.Value);
 PrintPreview1.Refresh;
end;

procedure TPrintPreviewform.SpinEdit1Change(Sender: TObject);
var Cap: Integer;
begin
 Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSY);
 pagesize.bottom := round(Cap/25.4*SpinEdit1.Value);
 PrintPreview1.Refresh;
end;

procedure TPrintPreviewform.SpinEdit3Change(Sender: TObject);
var Cap: Integer;
begin
 Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSY);
 pagesize.right := round(Cap/25.4*SpinEdit3.Value);
 PrintPreview1.Refresh;
end;

procedure TPrintPreviewform.SpinEdit2Change(Sender: TObject);
var Cap: Integer;
begin
 Cap := GetDeviceCaps(Printer.Handle,LOGPIXELSY);
 pagesize.left := round(Cap/25.4*SpinEdit2.Value);
 PrintPreview1.Refresh;
end;

end.

