program Digitais;

{$mode objfpc}{$H+}

uses
  ShareMem,
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uDigital, ControliD, CapDigitais, LResources
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TCaptura, Captura);
  Application.Run;
end.

