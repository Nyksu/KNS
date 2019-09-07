unit users;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBClient, Provider, {BdeProv,} Db, DBTables, StdCtrls, ExtCtrls, DBCtrls,
  Mask, Grids, DBGrids, Unxcrypt;

type
  Tfr_users = class(TForm)
    q_users: TQuery;
    p_users: TProvider;
    cds_users: TClientDataSet;
    ds_users: TDataSource;
    DBGrid1: TDBGrid;
    ed_psw: TMaskEdit;
    ed_rul: TDBLookupComboBox;
    q_rules: TQuery;
    ds_rules: TDataSource;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    q_usersID: TIntegerField;
    q_usersROLE_ID: TIntegerField;
    q_usersNAME: TStringField;
    q_usersLOGIN_NAME: TStringField;
    q_usersPSW: TStringField;
    q_usersSTATE: TIntegerField;
    DBEdit1: TDBEdit;
    cds_usersID: TIntegerField;
    cds_usersROLES_ID: TIntegerField;
    cds_usersNAME: TStringField;
    cds_usersLOGIN_NAME: TStringField;
    cds_usersPSW: TStringField;
    cds_usersSTATE: TIntegerField;
    procedure ds_usersDataChange(Sender: TObject; Field: TField);
    procedure cds_usersBeforePost(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cds_usersBeforeInsert(DataSet: TDataSet);
    procedure cds_usersAfterInsert(DataSet: TDataSet);
  private
    //ed_old_st : boolean;
    max_id : integer;
    { Private declarations }
  public
    { Public declarations }
  end;


Procedure StartUsers;

var
  fr_users: Tfr_users;


implementation

{$R *.DFM}

Uses Main;

Procedure StartUsers;
Begin
  try
    try
      fr_users:=Tfr_users.Create(Application);
      fr_users.ShowModal;
    finally
      fr_users.Free;
    end;
  except
  end;
end;

procedure Tfr_users.ds_usersDataChange(Sender: TObject; Field: TField);
begin
   ed_psw.text:=cds_users.FieldByName('PSW').AsString;
end;

procedure Tfr_users.cds_usersBeforePost(DataSet: TDataSet);
begin
   If ed_psw.text<>cds_users.FieldByName('PSW').AsString Then
     cds_users.FieldByName('PSW').AsString:=CreateInterbasePassword(ed_psw.text);
end;

procedure Tfr_users.Button2Click(Sender: TObject);
begin
   fr_users.Close;
end;

procedure Tfr_users.Button1Click(Sender: TObject);
begin
   cds_users.ApplyUpdates(-1);
end;

procedure Tfr_users.FormCreate(Sender: TObject);
begin
   cds_users.Active:=true;
   q_rules.Active:=true;
   max_id:=0;
end;

procedure Tfr_users.cds_usersBeforeInsert(DataSet: TDataSet);
begin
   cds_users.First;
   While not cds_users.EOF Do Begin
      If max_id<cds_users.FieldByName('id').AsInteger Then
         max_id:=cds_users.FieldByName('id').AsInteger;
      cds_users.Next;
   end;
   Inc(max_id);
end;

procedure Tfr_users.cds_usersAfterInsert(DataSet: TDataSet);
begin
   cds_users.FieldByName('id').AsInteger:=max_id;
end;

end.
