unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, DBCtrls, Mask, Provider, //BdeProv,
  Db, DBClient, DBTables, Spin, Grids, DBGrids, users, RXCtrls, RXSpin,
  Menus, RXDBCtrl;

type
  Tfr_sql = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    DB_SQLTXT: TDatabase;
    Panel3: TPanel;
    Panel4: TPanel;
    ed_find_sql: TSpinEdit;
    bt_gotoSQL: TButton;
    q_SQLtxt: TQuery;
    cds_SQLtxt: TClientDataSet;
    ds_SQLtxt: TDataSource;
    pr_SQLtxt: TProvider;
    bt_Save_all: TBitBtn;
    q_rules: TQuery;
    ds_rules: TDataSource;
    q_max_id: TQuery;
    ed_sql_txt: TMemo;
    Splitter1: TSplitter;
    DBGrid1: TDBGrid;
    bt_preor: TButton;
    bt_next: TButton;
    bt_commit: TButton;
    bt_back_trans: TButton;
    bt_execute: TButton;
    rb_sql: TRadioButton;
    rb_dml: TRadioButton;
    DB: TDatabase;
    q_test: TQuery;
    ds_test: TDataSource;
    pn_chec_connect: TPanel;
    pn_chec_connect1: TPanel;
    cds_txt: TClientDataSet;
    cds_txt_id: TIntegerField;
    cds_txt_txt: TMemoField;
    OpenDlg: TOpenDialog;
    SavDlg: TSaveDialog;
    cds_update: TClientDataSet;
    lst_aliases: TComboBox;
    Label5: TLabel;
    Session1: TSession;
    MainMenu1: TMainMenu;
    Updates1: TMenuItem;
    n_give: TMenuItem;
    n_get: TMenuItem;
    Users1: TMenuItem;
    n_crypt: TMenuItem;
    n_exit: TMenuItem;
    Panel5: TPanel;
    RxLabel2: TRxLabel;
    ed_max_nom: TRxSpinEdit;
    ed_find_coment: TEdit;
    bt_find_context: TButton;
    DBNavigator1: TDBNavigator;
    Panel6: TPanel;
    Panel7: TPanel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBText1: TDBText;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    TabSheet3: TTabSheet;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    cds_SQLtxtID: TIntegerField;
    cds_SQLtxtROLE_ID: TIntegerField;
    cds_SQLtxtCHANGE_DATE: TDateTimeField;
    cds_SQLtxtCOMENT: TStringField;
    cds_SQLtxtSQL: TBlobField;
    DBNavigator2: TDBNavigator;
    DBMemo2: TDBMemo;
    RxDBGrid1: TRxDBGrid;
    Splitter2: TSplitter;
    DBLookupComboBox2: TDBLookupComboBox;
    Label6: TLabel;
    q_SQLtxtID: TIntegerField;
    q_SQLtxtROLE_ID: TIntegerField;
    q_SQLtxtCHANGE_DATE: TDateTimeField;
    q_SQLtxtCOMENT: TStringField;
    q_SQLtxtSQL: TBlobField;
    ch_autosave: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure cds_SQLtxtAfterInsert(DataSet: TDataSet);
    procedure cds_SQLtxtBeforeCancel(DataSet: TDataSet);
    procedure bt_Save_allClick(Sender: TObject);
    procedure bt_gotoSQLClick(Sender: TObject);
    procedure bt_executeClick(Sender: TObject);
    procedure bt_commitClick(Sender: TObject);
    procedure bt_back_transClick(Sender: TObject);
    procedure pn_chec_connectClick(Sender: TObject);
    procedure pn_chec_connect1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt_preorClick(Sender: TObject);
    procedure ed_sql_txtChange(Sender: TObject);
    procedure bt_nextClick(Sender: TObject);
    procedure bt_cryptClick(Sender: TObject);
    procedure bt_exportClick(Sender: TObject);
    procedure bt_importClick(Sender: TObject);
    procedure bt_find_contextClick(Sender: TObject);
    procedure DB_SQLTXTAfterConnect(Sender: TObject);
    procedure DB_SQLTXTAfterDisconnect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cds_SQLtxtBeforePost(DataSet: TDataSet);
    procedure cds_txtAfterPost(DataSet: TDataSet);
    procedure cds_SQLtxtAfterDelete(DataSet: TDataSet);
  private
    procedure OnClose;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fr_sql: Tfr_sql;
  new_nom_sql,id_txt : integer;

implementation

{$R *.DFM}

procedure Tfr_sql.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure Tfr_sql.cds_SQLtxtAfterInsert(DataSet: TDataSet);
begin
  If new_nom_sql=0 then Begin
    q_max_id.ParamByName('start').AsInteger:=Round(ed_max_nom.Value);
    q_max_id.Active:=true;
    new_nom_sql:=q_max_id.FieldByName('id').AsInteger;
    q_max_id.Active:=false;
  end;
  Inc(new_nom_sql);
  cds_SQLtxt.FieldByName('id').AsInteger:=new_nom_sql;
  cds_SQLtxt.FieldByName('change_date').AsDateTime:=now;
end;

procedure Tfr_sql.cds_SQLtxtBeforeCancel(DataSet: TDataSet);
begin
   If cds_SQLtxt.State=dsInsert Then Dec(new_nom_sql);
end;

procedure Tfr_sql.bt_Save_allClick(Sender: TObject);
begin
  If cds_SQLtxt.ApplyUpdates(-1)<>0 Then Begin
     ShowMessage('ОБЛОМ!!!');
  end
  Else new_nom_sql:=0;
end;

procedure Tfr_sql.bt_gotoSQLClick(Sender: TObject);
begin
  cds_SQLtxt.Locate('id',ed_find_sql.Value,[loCaseInsensitive]);
end;

procedure Tfr_sql.bt_executeClick(Sender: TObject);
begin
  If cds_txt.state<>dsBrowse Then Begin
     cds_txt_txt.value:=ed_sql_txt.text;
     If ed_sql_txt.text='' Then Begin
        If cds_txt.state=dsInsert Then Dec(id_txt);
        cds_txt.Cancel;
     end
     Else cds_txt.Post;
  end;
  If ed_sql_txt.Text>'' Then Begin
     q_test.Active:=false;
     q_test.SQL.Text:=ed_sql_txt.Text;
     If not DB.InTransaction Then DB.StartTransaction;
     bt_commit.Enabled:=true;
     bt_back_trans.Enabled:=true;
     If rb_sql.Checked Then q_test.Open
     Else q_test.ExecSQL;
  end;
end;

procedure Tfr_sql.bt_commitClick(Sender: TObject);
begin
  If DB.InTransaction Then DB.Commit;
  bt_commit.Enabled:=false;
  bt_back_trans.Enabled:=false;
end;

procedure Tfr_sql.bt_back_transClick(Sender: TObject);
begin
  If DB.InTransaction Then DB.Rollback;
  bt_commit.Enabled:=false;
  bt_back_trans.Enabled:=false;
end;

procedure Tfr_sql.pn_chec_connectClick(Sender: TObject);
begin
  If pn_chec_connect.BevelOuter<>bvRaised Then Begin
     If DB.InTransaction Then If MessageDlg('DATABASE ni transaction!!  Commit?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes then DB.Commit
          Else DB.Rollback;
     bt_commit.Enabled:=false;
     bt_back_trans.Enabled:=false;
     DB.Connected:=false;
  end
  Else Begin
     DB.AliasName:=lst_aliases.SelText;
     If DB.AliasName='' Then DB.AliasName:='pp2';
     DB.Params.Text:='';
     try
      DB.Connected:=true;
     except
      DB.Connected:=false;
     end;
  end;
  If DB.Connected Then pn_chec_connect.BevelOuter:=bvLowered
  Else pn_chec_connect.BevelOuter:=bvRaised;
  If DB.Connected Then pn_chec_connect.Caption:='DISCONNECT'
  Else pn_chec_connect.Caption:='DATABASE connect';
  bt_preor.Enabled:=DB.Connected;
  bt_next.Enabled:=DB.Connected;
  bt_execute.Enabled:=DB.Connected;
end;

procedure Tfr_sql.OnClose;
Begin
   If cds_SQLtxt.Active Then
     try
     If not varisnull(cds_SQLtxt.Delta) Then
        if MessageDlg('Сохранить изменения в SQL текстах?',
           mtConfirmation, [mbYes, mbNo], 0) = mrYes then
               If cds_SQLtxt.ApplyUpdates(-1)<>0 Then Begin
                  ShowMessage('ОБЛОМ!!!');
               end
               Else new_nom_sql:=0;
     except
     end;
end;

procedure Tfr_sql.pn_chec_connect1Click(Sender: TObject);
begin
  new_nom_sql:=0;
  If pn_chec_connect1.BevelOuter<>bvRaised Then Begin
     OnClose;
     cds_SQLtxt.Active:=false;
     If DB_SQLTXT.InTransaction Then DB_SQLTXT.Commit;
     DB_SQLTXT.Connected:=false;
     bt_Save_all.Enabled:=false;
  end
  Else Begin
     try
      DB_SQLTXT.Connected:=true;
      cds_SQLtxt.Active:=true;
      q_rules.Active:=true;
     except
      DB_SQLTXT.Connected:=false;
     end;
  end;
  If DB_SQLTXT.Connected Then pn_chec_connect1.BevelOuter:=bvLowered
  Else pn_chec_connect1.BevelOuter:=bvRaised;
  If DB_SQLTXT.Connected Then pn_chec_connect1.Caption:='DISCONNECT'
  Else pn_chec_connect1.Caption:='DATABASE connect';
  bt_preor.Enabled:=DB.Connected;
  bt_Save_all.Enabled:=DB_SQLTXT.Connected;
  bt_gotoSQL.Enabled:=DB_SQLTXT.Connected;
  n_crypt.Enabled:=DB_SQLTXT.Connected;
end;

procedure Tfr_sql.FormCreate(Sender: TObject);
begin
  id_txt:=0;
  Session1.GetAliasNames(lst_aliases.Items);
end;

procedure Tfr_sql.bt_preorClick(Sender: TObject);
begin
  If cds_txt.state<>dsBrowse Then Begin
     cds_txt_txt.value:=ed_sql_txt.text;
     If ed_sql_txt.text='' Then Begin
        If cds_txt.state=dsInsert Then Dec(id_txt);
        cds_txt.Cancel;
     end
     Else cds_txt.Post;
  end;
  cds_txt.Prior;
  ed_sql_txt.text:=cds_txt_txt.value;
end;

procedure Tfr_sql.ed_sql_txtChange(Sender: TObject);
begin
  If cds_txt.state=dsBrowse Then Begin
     If cds_txt_id.value>=0 Then cds_txt.Edit
     Else Begin
       cds_txt.Insert;
       Inc(id_txt);
       cds_txt_id.value:=id_txt;
     end;
  end;
end;

procedure Tfr_sql.bt_nextClick(Sender: TObject);
begin
  If cds_txt.state<>dsBrowse Then Begin
     cds_txt_txt.value:=ed_sql_txt.text;
     If ed_sql_txt.text='' Then Begin
        If cds_txt.state=dsInsert Then Dec(id_txt);
        cds_txt.Cancel;
     end
     Else cds_txt.Post;
  end;
  If cds_txt.EOF Then Begin
     ed_sql_txt.text:='';
     cds_txt.Insert;
     Inc(id_txt);
     cds_txt_id.value:=id_txt;
  end
  Else Begin
     cds_txt.Next;
     ed_sql_txt.text:=cds_txt_txt.value;
  end;
end;

procedure Tfr_sql.bt_cryptClick(Sender: TObject);
begin
  StartUsers;
end;

procedure Tfr_sql.bt_exportClick(Sender: TObject);
begin
  If DB_SQLTXT.Connected Then Begin
     cds_SQLtxt.ApplyUpdates(-1);
     If DB_SQLTXT.InTransaction Then DB_SQLTXT.Commit;
     SavDlg.Execute;
     If (SavDlg.FileName='')or(SavDlg.FileName='*.cds') Then Begin
        ShowMessage('Куда ж тебя сохранить!!??');
        Exit;
     end;
     cds_SQLtxt.SaveToFile(SavDlg.FileName,dfBinary);
     ShowMessage('Все сохранено!! Потом надешь файл '+SavDlg.FileName);
  end;
end;

procedure Tfr_sql.bt_importClick(Sender: TObject);
begin
  If DB_SQLTXT.Connected Then Begin
     //If not DB_SQLTXT.InTransaction Then DB_SQLTXT.StartTransaction;
     OpenDlg.Execute;
     If (OpenDlg.FileName='')or(OpenDlg.FileName='*.cds') Then Begin
        ShowMessage('Откель взять файл то!!??');
        Exit;
     end;
     cds_update.LoadFromFile(OpenDlg.FileName);
     cds_update.First;
     While not cds_update.EOF Do Begin
       if cds_SQLtxt.Locate('ID',cds_update.FieldByName('ID').AsInteger,[loCaseInsensitive]) then Begin
         if cds_SQLtxt.FieldByName('CHANGE_DATE').AsDateTime<
            cds_update.FieldByName('CHANGE_DATE').AsDateTime Then Begin
          cds_SQLtxt.Edit;
          cds_SQLtxt.FieldByName('ROLES_ID').AsInteger:=cds_update.FieldByName('ROLES_ID').AsInteger;
          cds_SQLtxt.FieldByName('SQL').Value:=cds_update.FieldByName('SQL').Value;
          cds_SQLtxt.FieldByName('COMENT').Value:=cds_update.FieldByName('COMENT').Value;
          cds_SQLtxt.FieldByName('CHANGE_DATE').AsDateTime:=cds_update.FieldByName('CHANGE_DATE').AsDateTime;
          cds_SQLtxt.Post;
         end
       end
       Else Begin
         cds_SQLtxt.Insert;
         cds_SQLtxt.FieldByName('ID').AsInteger:=cds_update.FieldByName('ID').AsInteger;
         cds_SQLtxt.FieldByName('ROLES_ID').AsInteger:=cds_update.FieldByName('ROLES_ID').AsInteger;
         cds_SQLtxt.FieldByName('SQL').Value:=cds_update.FieldByName('SQL').Value;
         cds_SQLtxt.FieldByName('COMENT').Value:=cds_update.FieldByName('COMENT').Value;
         cds_SQLtxt.FieldByName('CHANGE_DATE').AsDateTime:=cds_update.FieldByName('CHANGE_DATE').AsDateTime;
         cds_SQLtxt.Post;
       end;
       cds_update.Next;
     end;
     cds_SQLtxt.ApplyUpdates(-1);
     new_nom_sql:=0;
     ShowMessage('Все обновлено!!');
  end;
end;

procedure Tfr_sql.bt_find_contextClick(Sender: TObject);
begin
  If cds_SQLtxt.Active Then Begin
     cds_SQLtxt.Locate('coment',VarArrayOf([ed_find_coment.text]),[loPartialKey]);
  end;
end;

procedure Tfr_sql.DB_SQLTXTAfterConnect(Sender: TObject);
begin
  n_crypt.Enabled:=true;
end;

procedure Tfr_sql.DB_SQLTXTAfterDisconnect(Sender: TObject);
begin
  n_crypt.Enabled:=false;
end;

procedure Tfr_sql.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OnClose;
  DB.Connected:=false;
  DB_SQLTXT.Connected:=false;
end;

procedure Tfr_sql.cds_SQLtxtBeforePost(DataSet: TDataSet);
begin
  cds_SQLtxt.FieldByName('change_date').AsDateTime:=now;
end;

procedure Tfr_sql.cds_txtAfterPost(DataSet: TDataSet);
begin
  If ch_autosave.Checked Then
     If cds_SQLtxt.ApplyUpdates(-1)<>0 Then ShowMessage('ОБЛОМ!!!');
end;

procedure Tfr_sql.cds_SQLtxtAfterDelete(DataSet: TDataSet);
begin
  If ch_autosave.Checked Then
     If cds_SQLtxt.ApplyUpdates(-1)<>0 Then ShowMessage('ОБЛОМ!!!');
end;

end.
