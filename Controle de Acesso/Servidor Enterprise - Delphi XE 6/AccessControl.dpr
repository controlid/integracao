program AccessControl;
uses
  Vcl.Forms,
  UnitAccessControl in 'UnitAccessControl.pas' {FormControleAcesso},
  UnitHttpClient in 'UnitHttpClient.pas',
  UnitDevice in 'UnitDevice.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormControleAcesso, FormControleAcesso);
  Application.Run;
end.
