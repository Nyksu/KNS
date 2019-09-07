unit Srv_face;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, RxMenus, RXShell, Inifiles, syncobjs, Formula, ComCtrls,
  About;

type
  Tfr_face = class(TForm)
    ls_users: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    ls_operations: TListBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    n_hide: TMenuItem;
    n_block: TMenuItem;
    n_close: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    RxTrayIcon1: TRxTrayIcon;
    RxPopupMenu1: TRxPopupMenu;
    Show1: TMenuItem;
    Close1: TMenuItem;
    ed_last_sql: TMemo;
    st_bar: TStatusBar;
    N2: TMenuItem;
    n_about: TMenuItem;
    procedure Show1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure n_hideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure n_aboutClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowVersion;
  public
    Procedure ShowLastSql(SQLtxt : string);
    Procedure ShowLastPar(par : variant);
    Procedure ShowMember (membr : string);
    Procedure HideMember (membr : string);
    Procedure WriteStrToFile(str : string);
    Procedure BeginWFile(filname : string);
    Function BeginRFile(filname : string) : boolean;
    Procedure EndFile;
    Function IsFile(filname : string) : boolean;
    Function DelFile(filname : string) : boolean;
    Function ReadFromFile : string;
    Function IsEndFile : boolean;
    Function ReadParamFromINI(fln,section,ident,def : string) : string;
    Function MakeFormatStr(par,len : variant;br : string) : string;
    Function StrAnyChar(str : string;dir,ll : integer) : string;
    { Public declarations }
  end;

var
  fr_face: Tfr_face;
  vers : string;
  ini : TInifile;
  bd_path,ppd_path,ToCalc,FromCalc,OUT_FORMAT,exe_path : string;
  OUT_PARAMS,TIME_PARAMS,TIME_FORMAT,IN_PARAMS,IN_FORMAT : string;
  db_tmp : string;
  CanWriteToFile : TCriticalSection;

implementation

{$R *.DFM}

var
  ff : TextFile;

Procedure Tfr_face.ShowLastSql(SQLtxt : string);
Begin
  ed_last_sql.lines.Text:=SQLtxt;
end;

Procedure Tfr_face.ShowLastPar(par : variant);
var
  sss : string;
Begin
  If ls_operations.Items.Count>100 Then ls_operations.Items.Delete(0);
  Case VarType(par) of
    varNull      : sss:='Null'+par;
    varSmallint  : sss:='sInt='+IntToStr(par);
    varInteger   : sss:='Int='+IntToStr(par);
    varSingle    : sss:='Single='+IntToStr(par);
    varDouble    : sss:='Double='+IntToStr(par);
    varDate      : sss:='Date='+DateToStr(par);
    varBoolean   : If par Then sss:='true' else sss:='false';
    varVariant   : sss:='Var='+par;
    varString    : sss:='Str='+par;
    varOleStr    : sss:='OLEStr='+par;
  end;
  ls_operations.Items.Add(sss);
end;

Procedure Tfr_face.ShowMember (membr : string);
Begin
  ls_users.Items.Add(membr);
end;

procedure Tfr_face.ShowVersion;
var
  loc_InfoBufSize : integer;
  loc_InfoBuf     : PChar;
  loc_VerBufSize  : integer;
  loc_VerBuf      : PChar;
  FLangID         :string;
  FExeName        :string;
Begin
  FExeName:=Application.ExeName;
  FLangID:='041904E3';
  loc_InfoBufSize := GetFileVersionInfoSize(PChar(FExeName),DWORD(loc_InfoBufSize));
  if loc_InfoBufSize > 0 then
  begin
    loc_InfoBuf := AllocMem(loc_InfoBufSize);
    GetFileVersionInfo(PChar(FExeName),0,loc_InfoBufSize,loc_InfoBuf);

    VerQueryValue(loc_InfoBuf,PChar('StringFileInfo\'+FLangId+'\FileVersion'),Pointer(loc_VerBuf),DWORD(loc_VerBufSize));

    vers:=loc_VerBuf;
    st_bar.Panels.Items[0].Text:='Версия '+vers;

    FreeMem(loc_InfoBuf, loc_InfoBufSize);
  end;
end;

Procedure Tfr_face.HideMember (membr : string);
var
  idx : integer;
Begin
  idx:=ls_users.Items.IndexOf(membr);
  ls_users.Items.Delete(idx);
end;

procedure Tfr_face.Show1Click(Sender: TObject);
begin
   Show;
end;

procedure Tfr_face.Close1Click(Sender: TObject);
begin
   Close;
end;

procedure Tfr_face.n_hideClick(Sender: TObject);
begin
  Hide;
end;

procedure Tfr_face.FormCreate(Sender: TObject);
begin
  Application.ShowMainForm:=false;
  exe_path:=ExtractFilePath(Application.EXEName);
  ini:=TIniFile.Create(exe_path+'ppd_srv.ini');
  bd_path:=ini.ReadString('DB','path','C:\BASE\PPD\ppdb.gdb');
  db_tmp:=ini.ReadString('DB','temp','C:\BASE\PPD\');
  ppd_path:=ini.ReadString('PATH','ppd','');
  ToCalc:=ini.ReadString('PATH','ToCalc','');
  FromCalc:=ini.ReadString('PATH','FromCalc','');
  OUT_FORMAT:=ini.ReadString('Extention','OUT_FORMAT','');
  OUT_PARAMS:=ini.ReadString('Extention','OUT_PARAMS','');
  TIME_PARAMS:=ini.ReadString('Extention','TIME_PARAMS','');
  TIME_FORMAT:=ini.ReadString('Extention','TIME_FORMAT',''); 
  IN_PARAMS:=ini.ReadString('Extention','IN_PARAMS','');
  IN_FORMAT:=ini.ReadString('Extention','IN_FORMAT','');
  ini.free;
  CanWriteToFile:=TCriticalSection.Create;
  ShowVersion;
end;

Function Tfr_face.ReadParamFromINI(fln,section,ident,def : string) : string;
Begin
  Application.ShowMainForm:=false;
  ini:=TIniFile.Create(exe_path+fln);
  Result:=ini.ReadString(section,ident,def);
  ini.free;
end;

procedure Tfr_face.N12Click(Sender: TObject);
begin
  ls_operations.Items.Clear;
end;

procedure Tfr_face.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CanWriteToFile.Free;
  Action:=caFree;
end;

Procedure Tfr_face.WriteStrToFile(str : string);
Begin
  WriteLn(ff,str);
end;

Function Tfr_face.ReadFromFile : string;
var
  ss : string;
Begin
  ReadLn(ff,ss);
  Result:=ss;
end;

Procedure Tfr_face.BeginWFile(filname : string);
Begin
  {$I-}
  AssignFile(ff,filname);
  ReWrite(ff);
  {$I+}
end;

Function Tfr_face.IsFile(filname : string) : boolean;
Begin
  Result:=FileExists(filname);
end;

Function Tfr_face.DelFile(filname : string) : boolean;
Begin
  Result:=DeleteFile(filname);
end;

Function Tfr_face.BeginRFile(filname : string) : boolean;
Begin
  Result:=false;
  If not FileExists(filname) Then Exit;
  {$I-}
  AssignFile(ff,filname);
  Reset(ff);
  {$I+}
  Result:=true;
end;

Procedure Tfr_face.EndFile;
Begin
  CloseFile(ff);
end;

Function Tfr_face.IsEndFile : boolean;
Begin
  Result:=EOF(ff);
end;

Function Tfr_face.StrAnyChar(str : string;dir,ll : integer) : string;
var
  len : integer;
  ss : string;
Begin
  len:=Length(str);
  ss:=str;
  While len<ll Do Begin
    Inc(len);
    CASE dir of
         0 : ss:=ss+' ';
         1 : ss:=' '+ss;
    end;
  end;
  Result:=ss;
end;

Function Tfr_face.MakeFormatStr(par,len : variant;br : string) : string;
var
  cc,ii,dd : integer;
  ss,st : string;
Begin
  Result:='';
  ss:='';
  cc:=VarArrayHighBound(par,1);
  If cc<>VarArrayHighBound(len,1) Then Exit;
  For ii:=0 To cc Do Begin
     Case VarType(par[ii]) of
      varNull      : st:=' ';
      varSmallint  : st:=IntToStr(par[ii]);
      varInteger   : st:=IntToStr(par[ii]);
      varSingle    : st:=FloatToStrF(par[ii],ffFixed,15,2);
      varDouble    : st:=FloatToStrF(par[ii],ffFixed,15,2);
      varDate      : st:=DateToStr(par[ii]);
      varBoolean   : If par[ii] Then st:='TRUE' Else st:='FALSE';
      varVariant   : st:=par[ii];
      varString    : st:=par[ii];
      varOleStr    : st:=par[ii];
     end;
     if len[ii]>0 Then dd:=0 Else dd:=1;
     st:=StrAnyChar(st,dd,Trunc(ABS(len[ii])));
     If ii=0 Then ss:=st Else ss:=ss+br+st;
  end;
  Result:=ss;
end;

procedure Tfr_face.n_aboutClick(Sender: TObject);
begin
  AboutShow(vers);
end;

end.
