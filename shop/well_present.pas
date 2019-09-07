unit well_present;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, ExtCtrls, StrUtils;

type
  Tfr_present_well = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ls_files_accepted: TListBox;
    ed_filename: TFilenameEdit;
    bt_add: TBitBtn;
    bt_close: TBitBtn;
    bt_del: TBitBtn;
    bt_start: TBitBtn;
    ch_work_only: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure bt_addClick(Sender: TObject);
    procedure bt_delClick(Sender: TObject);
    procedure bt_closeClick(Sender: TObject);
    procedure bt_startClick(Sender: TObject);
  private
    xl : variant;
    sheet : variant;
    procedure Clear;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure LetsTestWellPresent;

var
  fr_present_well: Tfr_present_well;

implementation

{$R *.DFM}

uses ppd_dm, ComObj, ResList;

Procedure LetsTestWellPresent;
Begin
  try
    try
      fr_present_well:=Tfr_present_well.Create(Application);
      fr_present_well.ShowModal;
    finally
      fr_present_well.free;
    end;
  except
  end;
end;

procedure Tfr_present_well.Clear;
begin
  ls_files_accepted.Clear;
  ed_filename.Clear;
end;

procedure Tfr_present_well.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Clear;
  Action:=caFree;
end;

procedure Tfr_present_well.FormCreate(Sender: TObject);
begin
  Clear;
end;

procedure Tfr_present_well.bt_addClick(Sender: TObject);
var
 ii,rr : integer;
begin
  rr:=0;
  If ed_filename.FileName<>'' Then Begin
     For ii:=0 To ls_files_accepted.Items.Count-1 Do
         If ls_files_accepted.Items.Strings[ii]=ed_filename.FileName Then Inc(rr);
     If rr=0 Then ls_files_accepted.Items.Add(ed_filename.FileName);
     ed_filename.Clear;
  end;
end;

procedure Tfr_present_well.bt_delClick(Sender: TObject);
begin
  If ls_files_accepted.Items.Count>0 Then
        ls_files_accepted.Items.Delete(ls_files_accepted.ItemIndex);
  ed_filename.Clear;
end;

procedure Tfr_present_well.bt_closeClick(Sender: TObject);
begin
  Close;
end;

procedure Tfr_present_well.bt_startClick(Sender: TObject);
var
  par,pp : variant;
  jj,ii,filescount : integer;
  exfn,ss,welln,mest,str,kname : string;
  yep : boolean;
begin
  // Очищаем временную таблицу
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=182;
  par[1]:=null;
  par[2]:=null;
  cod_err:=300;
  DM.StartTrans;
  pp:=DM.RunSQL(par);
  If pp<>0 Then Begin
     DM.BackTrans;
     Exit;
  end;
  DM.ComTrans;
  // Start Logs
  InicResList('Обработка реестра скважин.','Создание списка скважин.');
  filescount:=ls_files_accepted.Items.Count;
  fr_lstresult.AddErrorStr('Найденные ошибки:');
  fr_lstresult.AddStr('Заливаем опознанные скважины');
  For jj:=0 To filescount-1 Do Begin
      exfn:=ls_files_accepted.Items.Strings[jj];
      fr_lstresult.AddStr('> Обработка файла: '+exfn);
      xl:=CreateOleObject('Excel.Application');
      xl.visible:=false;
      xl.application.workbooks.open(exfn);
      sheet:=xl.application.workbooks[1].worksheets[1];
      exfn:='';
      mest:='';
      kname:='';
      DM.cds_tmp.Active:=false;
      ss:=sheet.cells[12,1];
      ii:=12;
      While (ii<1000)and(ss<>'end') Do
        If ss<>'' Then Begin
          CASE ss[1] of
               '1','2','3','4','5','6','7','8','9','0' : Begin
                  welln:=DelRSpace(ss);
                  par[0]:=135;
                  par[1]:=VarArrayOf(['!nom']);
                  par[2]:=VarArrayOf([#39+welln+#39]);
                  pp:=DM.GetData(par);
                  If VarIsNull(pp) Then Exit;
                  DM.cds_tmp.data:=pp;
                  If DM.cds_tmp.RecordCount>0 Then Begin
                     yep:=false;
                     While (not DM.cds_tmp.Eof)and(not yep) Do Begin
                        If kname=DM.cds_tmp.FieldByName('BUSH').AsString Then yep:=true;
                        if not yep Then DM.cds_tmp.Next;
                     end;
                     If yep Then Begin
                        fr_lstresult.AddStr('>>> Добавляем скважину в реестр: куст № '+kname+' , скважина № '+welln);
                        par[0]:=183;
                        par[1]:=VarArrayOf(['idd','pi1','pi2','ps1']);
                        par[2]:=VarArrayOf([DM.cds_tmp.FieldByName('ID').AsInteger,ii,jj,'']);
                        cod_err:=301;
                        DM.StartTrans;
                        pp:=DM.RunSQL(par);
                        If pp<>0 Then Begin
                           DM.BackTrans;
                           Exit;
                        end;
                        DM.ComTrans;
                     end
                     Else Begin
                       fr_lstresult.AddStr('<--- Скважина № '+welln+' не найдена или находится в другом кусте.');
                       fr_lstresult.AddErrorStr('Скважина № '+welln+' не найдена или находится в другом кусте.');
                     end;
                     DM.cds_tmp.Active:=false;
                  end;
               end;
               Else Begin
                 If Pos('Месторождение : ',ss)=1 Then Begin
                    mest:=ss;
                    Delete(mest,1,16);
                    fr_lstresult.AddStr('> '+ss);
                 end;
                 If Pos('КУСТ :',ss)=1 Then Begin
                    kname:=ss;
                    Delete(kname,1,6);
                    kname:=DelRSpace(kname);
                    fr_lstresult.AddStr('>> '+ss);
                 end;
                 If Pos('КНС :',ss)=1 Then fr_lstresult.AddStr('> '+ss);
               end;
          end;
          Inc(ii);
          ss:=sheet.cells[ii,1];
          Application.ProcessMessages;
        end
        Else Begin
          Inc(ii);
          ss:=sheet.cells[ii,1];
        end;
      xl.application.workbooks.Close;
      xl.application.Quit;
      xl.Quit;
  end;
  xl.visible:=true;
  // Ищем несуществующие сважины
  If ch_work_only.Checked Then Begin
     par:=VarArrayCreate([0, 3], varVariant);
     par[3]:=VarArrayOf(['com']);
  end;
  fr_lstresult.AddStr('*********************************');
  fr_lstresult.AddStr('*********************************');
  fr_lstresult.AddStr('---------------------------------');
  fr_lstresult.AddStr('---------------------------------');
  Application.ProcessMessages;
  par[0]:=184;
  par[1]:=null;
  par[2]:=null;
  pp:=DM.GetData(par);
  DM.cds_tmp.Active:=false;
  If VarIsNull(pp) Then Exit;
  DM.cds_tmp.data:=pp;
  fr_lstresult.AddStr('');
  fr_lstresult.AddStr('');
  fr_lstresult.AddStr('Результаты сверки скважин на схеме с реестром скважин:');
  fr_lstresult.AddStr('');
  If DM.cds_tmp.RecordCount>0 Then
     While not DM.cds_tmp.Eof Do Begin
       welln:=DM.cds_tmp.FieldByName('NOMER').AsString;
       kname:=DM.cds_tmp.FieldByName('NAME').AsString;
       fr_lstresult.AddStr('<< Скважина № '+welln+' расп. в '+kname+' в реестре скважин не найдена!');
       fr_lstresult.AddErrorStr('Скважина № '+welln+' расп. в '+kname+' в реестре скважин не найдена!');
       DM.cds_tmp.Next;
       Application.ProcessMessages;
     end
  Else Begin
     fr_lstresult.AddStr('>> Все скважины соответствуют реестру!!!!!!');
  end;
  DM.cds_tmp.Active:=false;
  fr_lstresult.AddStr('');
  fr_lstresult.AddStr('');
  fr_lstresult.AddStr('<----------- THE END ----------->');
end;

end.
