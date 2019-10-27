program CiDBioPDV;

uses
  Vcl.Forms,
  FApp in 'FApp.pas' {FormApp},
  ControliD in 'ControliD.pas',
  UProduct in 'UProduct.pas',
  UProductManager in 'UProductManager.pas',
  UProductService in 'UProductService.pas',
  UOrder in 'UOrder.pas',
  UOrderManager in 'UOrderManager.pas',
  UOrderService in 'UOrderService.pas',
  FCreateUser in 'FCreateUser.pas' {FormCreateUser},
  UFinger in 'UFinger.pas',
  UUser in 'UUser.pas',
  UUserManager in 'UUserManager.pas',
  UUserService in 'UUserService.pas',
  UFingerManager in 'UFingerManager.pas',
  UFingerService in 'UFingerService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormApp, FormApp);
  Application.CreateForm(TFormCreateUser, FormCreateUser);
  Application.Run;
end.
