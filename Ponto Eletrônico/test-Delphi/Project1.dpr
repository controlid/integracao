program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form2},
  RepCid_TLB in 'RepCid_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
