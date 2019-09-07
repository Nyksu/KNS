unit PPD_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PPD_DM, PSWrd, Menus, ComCtrls, ActnList, ImgList, ExtCtrls, ToolWin,
  shop_ch, deposit_ch, spr_id, dep_shop, pump_spr, ComObj, StrUtils;

type
  Tfr_main = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    n_open: TMenuItem;
    N3: TMenuItem;
    n_exit: TMenuItem;
    n_reconnect: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    StatusBar1: TStatusBar;
    CoolBar1: TCoolBar;
    Panel1: TPanel;
    Img_lst_tools: TImageList;
    act_tools: TActionList;
    N9: TMenuItem;
    n_shop_dep: TMenuItem;
    n_dep_ns: TMenuItem;
    n_shop: TMenuItem;
    n_deposit: TMenuItem;
    N14: TMenuItem;
    n_pump_type: TMenuItem;
    n_pipe_type: TMenuItem;
    n_direction: TMenuItem;
    n_found_state: TMenuItem;
    N10: TMenuItem;
    n_ns_import: TMenuItem;
    n_kns_import: TMenuItem;
    n_kust_import: TMenuItem;
    ofd_import_elements: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure n_exitClick(Sender: TObject);
    procedure n_openClick(Sender: TObject);
    procedure n_shopClick(Sender: TObject);
    procedure n_depositClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure n_shop_depClick(Sender: TObject);
    procedure n_pump_typeClick(Sender: TObject);
    procedure n_ns_importClick(Sender: TObject);
    procedure n_kns_importClick(Sender: TObject);
    procedure n_kust_importClick(Sender: TObject);
  private
    xl : variant;
    sheet : variant;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fr_main: Tfr_main;

implementation

uses ResList;

{$R *.DFM}

procedure Tfr_main.FormCreate(Sender: TObject);
begin
  DecimalSeparator:='.';
  THOUSANDSEPARATOR:=' ';
  DateSeparator:='.';
  conn:=false;
  try
    If StartDM Then Begin
      If CreatBridge=0 Then conn:=true;
    end
    Else MessageDlg('Непреодолимая ошибка!', mtError, [mbOk], 0);
  except
  end;
  fr_main.Caption:=fr_main.Caption+' '+vers;
end;

procedure Tfr_main.FormActivate(Sender: TObject);
begin
  If not conn Then Close;
end;

procedure Tfr_main.n_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_main.n_openClick(Sender: TObject);
var
 par,pp : variant;
begin
   par:=VarArrayCreate([0, 2], varVariant);
   par[0]:=1;//номер ЭсКуЭл
   par[1]:=null; //имена
   par[2]:=null; //значения
   pp:=VarArrayCreate([0, 1], varVariant);
   pp[0]:='Открыть ЦЕХ.';//шапка формы
   pp[1]:='Выберите цех для открытия схемы'; //шапка - коментарий
   ShowMessage(IntToStr(GetIdSpr(pp,par)));
end;

procedure Tfr_main.n_shopClick(Sender: TObject);
begin
  Shops;
end;

procedure Tfr_main.n_depositClick(Sender: TObject);
begin
  Deposits;
end;

procedure Tfr_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDM;
end;

procedure Tfr_main.n_shop_depClick(Sender: TObject);
begin
  DP_SH;
end;

procedure Tfr_main.n_pump_typeClick(Sender: TObject);
begin
  PumpsType;
end;

procedure Tfr_main.n_ns_importClick(Sender: TObject);
var
 exfn : string;
 ii,ux,uy,b_x,b_y : integer;
 ss,str,name : string;
 par,pp : variant;
 lp,dd : real;
 allok : boolean;
begin
  If ofd_import_elements.Execute Then Begin
     exfn:=ofd_import_elements.FileName;
     xl:=CreateOleObject('Excel.Application');
     xl.visible:=false;
     xl.application.workbooks.open(exfn);
     sheet:=xl.application.workbooks[1].worksheets[1];
     ii:=2;
     InicResList('Импорт элементов схемы','Насосные станции');
     ss:=sheet.cells[ii,1];
     par:=VarArrayCreate([0, 2], varVariant);
     allok:=true;
     DM.StartTrans;
     While (ii<1000)and(ss<>'') Do Begin
       try
       str:=sheet.cells[ii,2];
       name:=DelRSpace(str);
       str:=sheet.cells[ii,10];
       lp:=StrToFloat(DelRSpace(str));
       str:=sheet.cells[ii,9];
       dd:=StrToFloat(DelRSpace(str));
       str:=sheet.cells[ii,5];
       ux:=Round(StrToFloat(DelRSpace(str)));
       str:=sheet.cells[ii,6];
       uy:=Round(StrToFloat(DelRSpace(str)));
       str:=sheet.cells[ii,7];
       b_x:=Round(StrToFloat(DelRSpace(str)));
       str:=sheet.cells[ii,8];
       b_y:=Round(StrToFloat(DelRSpace(str)));
       except
         DM.BackTrans;
         allok:=false;
         fr_lstresult.AddStr('Ошибка в '+IntToStr(ii)+' строке! Насосная станция: '+name);
         Break;
       end;
       par[0]:=21;
       par[1]:=VarArrayOf(['shop', 'name', 'l_pres', 'd_d', 'ux', 'uy', 'bx', 'by', 'dep']); //имена
       par[2]:=VarArrayOf([7,name,lp,dd,ux,uy,b_x,b_y,1]);
       pp:=DM.RunSQL(par);
       If pp<>0 Then Begin
          DM.BackTrans;
          allok:=false;
          fr_lstresult.AddStr('Ошибка вставки. Строка: '+IntToStr(ii)+', Насосная станция: '+name);
          Break;
       end;
       fr_lstresult.AddStr('Обработана строка '+IntToStr(ii)+'. Добавлена Насосная станция: '+name);
       Inc(ii);
       ss:=sheet.cells[ii,1];
       Application.ProcessMessages;
     end;
     If allok Then DM.ComTrans;
     xl.visible:=true;
     xl.application.workbooks.Close;
     xl.application.Quit;
     xl.Quit;
  end;
end;

procedure Tfr_main.n_kns_importClick(Sender: TObject);
var
 exfn : string;
 ii,ux,uy,b_x,b_y : integer;
 ss,str,name : string;
 par,pp : variant;
 lp,dd : real;
 allok : boolean;
begin
  If ofd_import_elements.Execute Then Begin
     exfn:=ofd_import_elements.FileName;
     xl:=CreateOleObject('Excel.Application');
     xl.visible:=false;
     xl.application.workbooks.open(exfn);
     sheet:=xl.application.workbooks[1].worksheets[1];
     ii:=2;
     InicResList('Импорт элементов схемы','Кустовые Насосные станции');
     ss:=sheet.cells[ii,1];
     par:=VarArrayCreate([0, 2], varVariant);
     allok:=true;
     DM.StartTrans;
     While (ii<1000)and(ss<>'') Do Begin
       try
       str:=sheet.cells[ii,2];
       name:=DelRSpace(str);
       str:=sheet.cells[ii,10];
       lp:=StrToFloat(DelRSpace(str));
       str:=sheet.cells[ii,9];
       dd:=StrToFloat(DelRSpace(str));
       str:=sheet.cells[ii,5];
       ux:=Round(StrToFloat(DelRSpace(str)));
       str:=sheet.cells[ii,6];
       uy:=Round(StrToFloat(DelRSpace(str)));
       str:=sheet.cells[ii,7];
       b_x:=Round(StrToFloat(DelRSpace(str)));
       str:=sheet.cells[ii,8];
       b_y:=Round(StrToFloat(DelRSpace(str)));
       except
         DM.BackTrans;
         allok:=false;
         fr_lstresult.AddStr('Ошибка в '+IntToStr(ii)+' строке! Насосная станция: '+name);
         Break;
       end;
       par[0]:=20;
       par[1]:=VarArrayOf(['shop', 'name', 'l_pres', 'd_d', 's_p', 'd_s', 'i_s', 'ux', 'uy', 'bx', 'by', 'dep']);
       par[2]:=VarArrayOf([8,name,lp,dd,0,0,0,ux,uy,b_x,b_y,1]);
       pp:=DM.RunSQL(par);
       If pp<>0 Then Begin
          DM.BackTrans;
          allok:=false;
          fr_lstresult.AddStr('Ошибка вставки. Строка: '+IntToStr(ii)+', Насосная станция: '+name);
          Break;
       end;
       fr_lstresult.AddStr('Обработана строка '+IntToStr(ii)+'. Добавлена Насосная станция: '+name);
       Inc(ii);
       ss:=sheet.cells[ii,1];
       Application.ProcessMessages;
     end;
     If allok Then DM.ComTrans;
     xl.visible:=true;
     xl.application.workbooks.Close;
     xl.application.Quit;
     xl.Quit;
  end;
end;

procedure Tfr_main.n_kust_importClick(Sender: TObject);
var
 exfn : string;
 ii,ux,uy,b_x,b_y,itmp,jj,errco : integer;
 ss,str,name,kns_name,kust_name,well_name,plast_name : string;
 par,pp,rss : variant;
 lp,dd : real;
 allok : boolean;
 kns_id,kust_id,well_id,shop_id,deposit_id : integer;
begin
  If ofd_import_elements.Execute Then Begin
     kns_id:=-1;
     kust_id:=-1;
     well_id:=-1;
     errco:=0;
     kns_name:='';
     kust_name:='';
     exfn:=ofd_import_elements.FileName;
     xl:=CreateOleObject('Excel.Application');
     xl.visible:=false;
     xl.application.workbooks.open(exfn);
     sheet:=xl.application.workbooks[1].worksheets[1];
     ii:=2;
     InicResList('Импорт элементов схемы','Кусты и скважины');
     ss:=sheet.cells[ii,1];
     par:=VarArrayCreate([0, 2], varVariant);
     allok:=true;
     DM.StartTrans;
     try
     While (ii<10000)and(ss<>'') Do Begin
       str:=sheet.cells[ii,2];
       if ss='КНС' Then Begin
          par[0]:=205;
          par[1]:=VarArrayOf(['nam']);
          par[2]:=VarArrayOf([str]);
          pp:=DM.GetTehData(par);
          if VarIsNull(pp) Then Begin
             DM.BackTrans;
             allok:=false;
             fr_lstresult.AddStr('Критическая ошибка. Строка: '+IntToStr(ii)+', не найдена КНС: '+str);
             Break;
          end
          Else Begin
             kns_id:=pp[0];
             fr_lstresult.AddStr('Найдена КНС: '+str);
             kns_name:=str;
          end;
       end
       Else if (ss='куст')and(kns_id>0) Then Begin
          name:=sheet.cells[ii,3];
          shop_id:=StrToInt(sheet.cells[ii,14]);
          deposit_id:=StrToInt(sheet.cells[ii,15]);
          ux:=Round(StrToFloat(sheet.cells[ii,6]));
          uy:=Round(StrToFloat(sheet.cells[ii,7]));
          b_x:=Round(StrToFloat(sheet.cells[ii,8]));
          b_y:=Round(StrToFloat(sheet.cells[ii,9]));
          par[0]:=206;
          par[1]:=VarArrayOf(['nom','nam','shop','dep']);
          par[2]:=VarArrayOf([StrToInt(str),name,shop_id,deposit_id]);
          pp:=DM.GetTehData(par);
          kust_name:=str+name;
          if VarIsNull(pp) Then Begin
             // Вставка куста
             //fr_lstresult.AddStr('Найден Куст: '+str+name);
             par[0]:=79;
             par[1]:=VarArrayOf(['nomer','kns','ux','uy','bx','by','lnam','shop','dep']);
             par[2]:=VarArrayOf([StrToInt(str),kns_id,ux,uy,b_x,b_y,name,shop_id,deposit_id]);
             itmp:=DM.RunSQL(par);
             If itmp<>0 Then Begin
                DM.BackTrans;
                allok:=false;
                fr_lstresult.AddStr('Критическая ошибка. Строка: '+IntToStr(ii)+', Ошибка вставки куста: '+kust_name);
                Break;
             end
             Else Begin
                kust_id:=DM.GetLastID;
                fr_lstresult.AddStr('Добавлен Куст: '+kust_name);
             end;
          end
          Else Begin
             kust_id:=pp[0];
             fr_lstresult.AddStr('Найден Куст: '+kust_name+'. Координаты куста не изменены!');
             itmp:=pp[1];
             If itmp<>kns_id Then Begin
                par[0]:=19;
                par[1]:=VarArrayOf(['KNS']);
                par[2]:=VarArrayOf([itmp]);
                pp:=DM.GetTehData(par);
                fr_lstresult.AddStr('Не критическая ошибка. Куст: '+kust_name+' относится не к той КНС!! В файле: '+kns_name+' , а в базе: '+pp[1]);
                Inc(errco);
             end;
          end;
       end
       Else if (ss='скв.')and(kust_id>0) Then Begin
          well_name:=str;
          ux:=Round(StrToFloat(sheet.cells[ii,6]));
          uy:=Round(StrToFloat(sheet.cells[ii,7]));
          par[0]:=209;
          par[1]:=VarArrayOf(['nom','kust']);
          par[2]:=VarArrayOf([str,kust_id]);
          pp:=VarArrayOf(['id']);
          pp:=DM.GetTehDataNams(par,pp);
          well_id:=-1;
          if VarIsNull(pp) Then Begin
             // Вставляем скважину
             par[0]:=97;
             par[1]:=VarArrayOf(['kust','state','nomer','depth','d','d_p','x','y']);
             par[2]:=VarArrayOf([kust_id,2,well_name,0,0,0,ux,uy]);
             itmp:=DM.RunSQL(par);
             If itmp<>0 Then Begin
                DM.BackTrans;
                allok:=false;
                fr_lstresult.AddStr('Критическая ошибка. Строка: '+IntToStr(ii)+', Ошибка вставки скважины: '+well_name);
                Break;
             end
             Else Begin
                well_id:=DM.GetLastID;
                fr_lstresult.AddStr('Добавлена Скважина: '+well_name);
             end;
          end
          Else Begin
            // Если скважина уже есть
            fr_lstresult.AddStr('Найдена Скважина: '+well_name);
            well_id:=pp[0];
          end;
          If well_id>0 Then Begin
             // Разбираемся с пластами
             par[0]:=207;
             par[1]:=VarArrayOf(['well']);
             par[2]:=VarArrayOf([well_id]);
             itmp:=DM.RunSQL(par);
             If itmp<>0 Then Begin
                DM.BackTrans;
                allok:=false;
                fr_lstresult.AddStr('Критическая ошибка. Строка: '+IntToStr(ii)+', Ошибка удаления параметров скважины: '+well_name);
                Break;
             end
             Else Begin
                jj:=10;
                plast_name:=sheet.cells[ii,jj];
                while (jj<14)and(plast_name<>'') Do Begin
                   par[0]:=208;
                   par[1]:=VarArrayOf(['nam']);
                   par[2]:=VarArrayOf([plast_name]);
                   pp:=DM.GetTehData(par);
                   If VarIsNull(pp) Then Begin
                      fr_lstresult.AddStr('Не критическая ошибка (строка '+IntToStr(ii)+'). Пласт: '+plast_name+' отсутствует в справочнике базы! Пласт не добавлен в Скважину: '+well_name);
                      Inc(errco);
                   end
                   Else Begin
                     itmp:=pp[0];
                     par[0]:=106;
                     par[1]:=VarArrayOf(['well','k','a','pres','plast']);
                     par[2]:=VarArrayOf([well_id,0,0,0,itmp]);
                     itmp:=DM.RunSQL(par);
                     If itmp<>0 Then Begin
                        fr_lstresult.AddStr('Не критическая ошибка (строка '+IntToStr(ii)+'). Ошибка вставки Пласта: '+plast_name+' Пласт не добавлен в Скважину: '+well_name);
                        Inc(errco);
                     end
                     Else fr_lstresult.AddStr('В Скважину: '+well_name+' добавлен пласт: '+plast_name);
                   end;
                   Inc(jj);
                   plast_name:=sheet.cells[ii,jj];
                end;
             end;
          end;
       end;
       Inc(ii);
       ss:=sheet.cells[ii,1];
       Application.ProcessMessages;
     end;
     except
       allok:=false;
       fr_lstresult.AddStr('Критическая ошибка. Строка: '+IntToStr(ii)+', Ошибка конвертации объекта: '+ss);
       if DM.StateDB=1 Then DM.BackTrans;
     end;
     If allok Then Begin
        DM.ComTrans;
        fr_lstresult.AddStr('Элементы успешно импортированы!!');
        fr_lstresult.AddStr('Пройдено строк : '+IntToStr(ii));
        fr_lstresult.AddStr('Найдено не критических ошибок : '+IntToStr(errco));
     end
     Else fr_lstresult.AddStr('Импорт элементов отменен по возникшей критической ошибке!');
     xl.visible:=true;
     xl.application.workbooks.Close;
     xl.application.Quit;
     xl.Quit;
  end;
end;

end.
