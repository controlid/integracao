program CIDPrinter;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  CIDPrinter_TLB in 'CIDPrinter_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
