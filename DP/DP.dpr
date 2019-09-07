program DP;

uses
  Forms,
  Dp_main in 'Dp_main.pas' {fr_main_dp};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfr_main_dp, fr_main_dp);
  Application.Run;
end.
