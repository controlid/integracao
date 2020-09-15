program SCVBio;

uses
  Forms,
  uCaptura in 'uCaptura.pas' {Form1},
  ControliD in 'ControliD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
