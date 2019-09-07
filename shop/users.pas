unit users;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Buttons, DBCtrls, Db, DBClient, Get_str, spr_id,
  UnxCrypt;

type
  Tfr_users = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    DBText1: TDBText;
    Label2: TLabel;
    lb_account: TLabel;
    bt_exit: TBitBtn;
    bt_account: TButton;
    bt_add: TBitBtn;
    bt_del: TBitBtn;
    bt_roles: TButton;
    bt_names: TButton;
    bt_ps: TButton;
    cds_users: TClientDataSet;
    ds_users: TDataSource;
    ch_show_del: TCheckBox;
    bt_divname: TButton;
    Label3: TLabel;
    Label4: TLabel;
    DBText2: TDBText;
    DBText3: TDBText;
    procedure bt_exitClick(Sender: TObject);
    procedure ds_usersDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure bt_addClick(Sender: TObject);
    procedure ch_show_delClick(Sender: TObject);
    procedure bt_delClick(Sender: TObject);
    procedure bt_accountClick(Sender: TObject);
    procedure bt_rolesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bt_namesClick(Sender: TObject);
    procedure bt_psClick(Sender: TObject);
    procedure bt_divnameClick(Sender: TObject);
  private
    procedure ReShowUsr;
    function CheckNicName(nic:string) : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure ShowUsers;

var
  fr_users: Tfr_users;

implementation

uses ppd_dm;

{$R *.DFM}


Procedure ShowUsers;
Begin
  try
    try
      fr_users:=Tfr_users.Create(Application);
      fr_users.ShowModal;
    finally
      fr_users.free;
    end;
  except
  end;
end;

procedure Tfr_users.bt_exitClick(Sender: TObject);
begin
  cds_users.active:=false;
  Close;
end;

procedure Tfr_users.ReShowUsr;
var
  par,pp : variant;
Begin
  cds_users.active:=false;
  If not ch_show_del.Checked Then Begin
     par:=VarArrayCreate([0, 3], varVariant);
     par[3]:=VarArrayOf(['com']);
  end
  Else par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=194;
  par[1]:=null;
  par[2]:=null;
  pp:=DM.GetData(par);
  if not VarIsNull(pp) Then Begin
     cds_users.data:=pp;
  end;
end;

function Tfr_users.CheckNicName(nic:string) : boolean;
var
  par,pp : variant;
Begin
  Result:=true;
  par:=VarArrayCreate([0, 2], varVariant);
  par[0]:=195;
  par[1]:=VarArrayOf(['nic']);
  par[2]:=VarArrayOf([nic]);
  pp:=DM.GetTehData(par);
  If VarIsNull(pp) Then Exit;
  If pp=0 Then Result:=false;
end;

procedure Tfr_users.ds_usersDataChange(Sender: TObject; Field: TField);
begin
  lb_account.Visible:=false;
  If cds_users.active Then
     If cds_users.RecordCount>0 Then Begin
        lb_account.Visible:=true;
        lb_account.Caption:='';
        CASE cds_users.FieldByName('STATE').AsInteger of
             0 : lb_account.Caption:='Активирован';
             1 : lb_account.Caption:='Не активирован';
             2 : lb_account.Caption:='Удален';
        end;
     end;
end;

procedure Tfr_users.FormCreate(Sender: TObject);
begin
  ReShowUsr;
end;

procedure Tfr_users.bt_addClick(Sender: TObject);
var
  fio, nik, psw, str, dn, pos : string;
  par,pp : variant;
  rolid,res : integer;
begin
  If cds_users.active Then Begin
     fio:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Введите ФИО пользователя','');
     If (fio='')or(length(fio)<6) Then Begin
        MessageDlg('Операция отменена. Короткое ФИО пользователя.', mtError, [mbOk], 0);
        Exit;
     end;
     nik:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Введите ПСЕВДОНИМ пользователя','');
     If nik='' Then Begin
        MessageDlg('Операция отменена. Пропущен псевдоним пользователя.', mtError, [mbOk], 0);
        Exit;
     end;
     If CheckNicName(nik) Then Begin
        MessageDlg('Операция отменена. Такой псевдоним пользователя уже существует.', mtError, [mbOk], 0);
        Exit;
     end;
     psw:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Введите ПАРОЛЬ пользователя','');
     If (psw='')or(length(psw)<3) Then Begin
        MessageDlg('Операция отменена. Короткий ПАРОЛЬ пользователя.', mtError, [mbOk], 0);
        Exit;
     end;
     str:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Повторите ввод ПАРОЛЯ пользователя','');
     If str<>psw Then Begin
        MessageDlg('Операция отменена. Некорректрый ПАРОЛЬ пользователя.', mtError, [mbOk], 0);
        Exit;
     end;
     par:=VarArrayCreate([0, 2], varVariant);
     par[0]:=196;
     par[1]:=null;
     par[2]:=null;
     pp:=VarArrayOf(['Добавление пользователя','Выберите статус пользователя в системе:']);
     rolid:=GetIdSpr(pp,par);
     If rolid<0 Then Begin
        MessageDlg('Операция отменена. Не выбран статус пользователя в системе.', mtError, [mbOk], 0);
        Exit;
     end;
     psw:=CreateInterbasePassword(psw);
     dn:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Введите Подразделение (отдел) пользователя','');
     pos:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Введите Должность пользователя','');
     par[0]:=197;
     par[1]:=VarArrayOf(['rol','fio','nic','ps','dn','pos']);
     par[2]:=VarArrayOf([rolid,fio,nik,psw,dn,pos]);
     DM.StartTrans;
     res:=DM.RunSQL(par);
     if res<>0 Then Begin
        DM.BackTrans;
        MessageDlg('Операция отменена. Ошибка при вставке.', mtError, [mbOk], 0);
        Exit;
     end;
     DM.ComTrans;
     ReShowUsr;
  end;
end;

procedure Tfr_users.ch_show_delClick(Sender: TObject);
begin
  ReShowUsr;
end;

procedure Tfr_users.bt_delClick(Sender: TObject);
var
  st,usr,res : integer;
  par,pp : variant;
begin
  If cds_users.active Then
     If cds_users.RecordCount>0 Then
        if MessageDlg('ВНИМАНИЕ! Удаление пользователя!  Удалить пользователя системы?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then Begin
           st:=cds_users.FieldByName('STATE').AsInteger;
           usr:=cds_users.FieldByName('ID').AsInteger;
           par:=VarArrayCreate([0, 2], varVariant);
           If st<2 Then Begin
             // Чуть-чуть удалить
             par[0]:=198;
             par[1]:=VarArrayOf(['st','usr']);
             par[2]:=VarArrayOf([2,usr]);
           end
           Else if MessageDlg('ВНИМАНИЕ! Полное удаление пользователя не обратимо!  Продолжить удаление?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then Begin
             // Совсем удалить
             par[0]:=199;
             par[1]:=VarArrayOf(['usr']);
             par[2]:=VarArrayOf([usr]);
           end
           Else Exit;
           DM.StartTrans;
           res:=DM.RunSQL(par);
           if res<>0 Then Begin
              DM.BackTrans;
              MessageDlg('Операция отменена. Ошибка при удалении.', mtError, [mbOk], 0);
              Exit;
           end;
           DM.ComTrans;
           ReShowUsr;
        end;
end;

procedure Tfr_users.bt_accountClick(Sender: TObject);
var
  st,usr,res : integer;
  par : variant;
begin
  If cds_users.active Then
     If cds_users.RecordCount>0 Then Begin
        st:=cds_users.FieldByName('STATE').AsInteger;
        usr:=cds_users.FieldByName('ID').AsInteger;
        par:=VarArrayCreate([0, 2], varVariant);
        par[0]:=198;
        par[1]:=VarArrayOf(['st','usr']);
        if st=0 Then par[2]:=VarArrayOf([1,usr])
        Else par[2]:=VarArrayOf([st-1,usr]);
        DM.StartTrans;
        res:=DM.RunSQL(par);
        if res<>0 Then Begin
           DM.BackTrans;
           MessageDlg('Операция отменена. Ошибка при изменении.', mtError, [mbOk], 0);
           Exit;
        end;
        DM.ComTrans;
        ReShowUsr;
     end;
end;

procedure Tfr_users.bt_rolesClick(Sender: TObject);
var
  st,usr : integer;
  par,pp : variant;
  rolid, rnew, res : integer;
begin
  If cds_users.active Then
     If cds_users.RecordCount>0 Then Begin
        usr:=cds_users.FieldByName('ID').AsInteger;
        rolid:=cds_users.FieldByName('roles_id').AsInteger;
        par:=VarArrayCreate([0, 2], varVariant);
        par[0]:=196;
        par[1]:=null;
        par[2]:=null;
        pp:=VarArrayOf(['Изменение статуса пользователя','Выберите статус пользователя в системе:']);
        rnew:=GetIdSprSet(pp,par,rolid);
        If (rnew<>rolid)and(rnew>=0) Then Begin
           par[0]:=200;
           par[1]:=VarArrayOf(['role','usr']);
           par[2]:=VarArrayOf([rnew,usr]);
           DM.StartTrans;
           res:=DM.RunSQL(par);
           if res<>0 Then Begin
              DM.BackTrans;
              MessageDlg('Операция отменена. Ошибка при изменении.', mtError, [mbOk], 0);
              Exit;
           end;
           DM.ComTrans;
           ReShowUsr;
        end;
     end;
end;

procedure Tfr_users.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cds_users.active:=false;
end;

procedure Tfr_users.bt_namesClick(Sender: TObject);
var
  usr : integer;
  par : variant;
  res : integer;
  fio,str : string;
begin
  If cds_users.active Then
     If cds_users.RecordCount>0 Then Begin
        fio:=cds_users.FieldByName('NAME').AsString;
        usr:=cds_users.FieldByName('ID').AsInteger;
        str:=Get_Str_Par('Параметры пользователя','Изменение ФИО пользователя','Введите ФИО пользователя',fio);
        If (str='')or(length(str)<6) Then Begin
           MessageDlg('Операция отменена. Короткое ФИО пользователя.', mtError, [mbOk], 0);
           Exit;
        end;
        If str<>fio Then Begin
           par:=VarArrayCreate([0, 2], varVariant);
           par[0]:=201;
           par[1]:=VarArrayOf(['nam','usr']);
           par[2]:=VarArrayOf([str,usr]);
           DM.StartTrans;
           res:=DM.RunSQL(par);
           if res<>0 Then Begin
              DM.BackTrans;
              MessageDlg('Операция отменена. Ошибка при изменении.', mtError, [mbOk], 0);
              Exit;
           end;
           DM.ComTrans;
           ReShowUsr;
        end;
     end;
end;

procedure Tfr_users.bt_psClick(Sender: TObject);
var
  usr : integer;
  par : variant;
  res : integer;
  ps,str : string;
begin
  If cds_users.active Then
     If cds_users.RecordCount>0 Then Begin
        ps:=Get_Str_Par('Параметры пользователя','Изменение пароля пользователя','Введите новый пароль пользователя','');
        If (ps='')or(length(ps)<3) Then Begin
           MessageDlg('Операция отменена. Короткий пароль пользователя.', mtError, [mbOk], 0);
           Exit;
        end;
        str:=Get_Str_Par('Параметры пользователя','Изменение пароля пользователя','повторите ввод нового пароля пользователя','');
        If str<>ps Then Begin
           MessageDlg('Операция отменена. Не корректный пароль пользователя.', mtError, [mbOk], 0);
           Exit;
        end;
        usr:=cds_users.FieldByName('ID').AsInteger;
        If str=ps Then Begin
           ps:=CreateInterbasePassword(ps);
           par:=VarArrayCreate([0, 2], varVariant);
           par[0]:=202;
           par[1]:=VarArrayOf(['ps','usr']);
           par[2]:=VarArrayOf([ps,usr]);
           DM.StartTrans;
           res:=DM.RunSQL(par);
           if res<>0 Then Begin
              DM.BackTrans;
              MessageDlg('Операция отменена. Ошибка при изменении.', mtError, [mbOk], 0);
              Exit;
           end;
           DM.ComTrans;
           ReShowUsr;
        end;
     end;
end;

procedure Tfr_users.bt_divnameClick(Sender: TObject);
var
  dn,pos : string;
  par,pp : variant;
  res,usr : integer;
begin
  If cds_users.active Then
     If cds_users.RecordCount>0 Then Begin
        pp:=cds_users.FieldByName('DIVNAME').Value;
        If VarIsNull(pp) Then dn:='' Else dn:=pp;
        pp:=cds_users.FieldByName('POSIT').Value;
        If VarIsNull(pp) Then pos:='' Else pos:=pp;
        usr:=cds_users.FieldByName('ID').AsInteger;
        dn:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Введите Подразделение (отдел) пользователя',dn);
        pos:=Get_Str_Par('Параметры пользователя','Добавление пользователя','Введите Должность пользователя',pos);
        par:=VarArrayCreate([0, 2], varVariant);
        par[0]:=204;
        par[1]:=VarArrayOf(['pos','dn','usr']);
        par[2]:=VarArrayOf([pos,dn,usr]);
        DM.StartTrans;
        res:=DM.RunSQL(par);
        if res<>0 Then Begin
           DM.BackTrans;
           MessageDlg('Операция отменена. Ошибка при изменении.', mtError, [mbOk], 0);
           Exit;
        end;
        DM.ComTrans;
        ReShowUsr;
     end;
end;

end.
