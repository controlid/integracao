program SCVBio;

uses
  Vcl.Forms,
  uCaptura in 'uCaptura.pas' {Form1},
  SCVBioControlID in 'SCVBioControlID.pas',
  ControliD in 'ControliD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
