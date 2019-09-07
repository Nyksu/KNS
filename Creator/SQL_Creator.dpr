program SQL_Creator;

uses
  Forms,
  Main in 'Main.pas' {fr_sql},
  users in 'users.pas' {fr_users},
  SQL_Creator_TLB in 'SQL_Creator_TLB.pas';

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfr_sql, fr_sql);
  Application.Run;
end.
