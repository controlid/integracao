program CIDPrinter;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  CIDPrinter_TLB in 'C:\Users\Albert\Documents\Embarcadero\Studio\20.0\Imports\CIDPrinter_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
