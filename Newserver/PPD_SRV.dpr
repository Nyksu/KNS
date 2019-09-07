program PPD_SRV;

uses
  Forms,
  Srv_face in 'Srv_face.pas' {Form1},
  PPD_SRV_TLB in 'PPD_SRV_TLB.pas',
  RDM in 'RDM.pas' {PPD_Server_2: TRemoteDataModule} {PPD_Server_2: CoClass},
  About in '..\uiforms\About.pas' {fr_about};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  //Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfr_face, fr_face);
  Application.CreateForm(Tfr_about, fr_about);
  Application.Run;
end.
