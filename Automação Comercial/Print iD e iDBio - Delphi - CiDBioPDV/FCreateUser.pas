unit FCreateUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UUserService, ControliD, UFinger, UFingerService, UUser;

type
  TFormCreateUser = class(TForm)
    LabelAdminPassword: TLabel;
    EditAdminPassword: TEdit;
    ButtonCreateUser: TButton;
    EditUsername: TEdit;
    LabelUsername: TLabel;
    ButtonEnroll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCreateUserClick(Sender: TObject);
    function PasswordIsValid: Boolean;
    procedure ButtonEnrollClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCreateUser: TFormCreateUser;
  UserService: TUserService;
  Fingers: TList;
  LeitorBiometrico: CIDBio;
  FingerService: TFingerService;

implementation

{$R *.dfm}

procedure TFormCreateUser.FormCreate(Sender: TObject);
begin
  UserService := TUserService.Create;
  Fingers := TList.Create;

  LeitorBiometrico := CIDBio.Create;
  LeitorBiometrico.Init;

  FingerService := TFingerService.Create;
end;

procedure TFormCreateUser.ButtonEnrollClick(Sender: TObject);
var
  ID: integer;
  Code: RetCode;
  Finger: TFinger;
begin
  ID := FingerService.Manager.GetNextID;

  Code := LeitorBiometrico.CaptureAndEnroll(ID);

  if RetCode.ERROR_TEMPLATE_ALREADY_ENROLLED = Code then
  begin
    ShowMessage('Dedo já foi cadastrado');
    exit;
  end;

  if RetCode.ERROR_MERGING = Code then
  begin
    ShowMessage('Dedo mal posicionado, tente novamente...');
    exit;
  end;

  if RetCode.ERROR_CAPTURE_TIMEOUT = Code then
  begin
    ShowMessage('Tempo esgotado, tente novamente...');
    exit;
  end;

  if RetCode.ERROR_IO_ON_HOST = Code then
  begin
    ShowMessage('Outro aplicativo está usando o iDBio');
    exit;
  end;

  if RetCode.SUCCESS <> Code then
  begin
    ShowMessage('Erro desconhecido');
    exit;
  end;  

  Finger := FingerService.CreateFinger(ID);
  Fingers.Add(Finger);

  ShowMessage('Dedo cadastrado com sucesso!');
end;

procedure TFormCreateUser.ButtonCreateUserClick(Sender: TObject);
var
  Username: string;
  User: TUser;
begin
  if (not PasswordIsValid) then
  begin
    ShowMessage('Senha de administrador incorreta!');
    exit;
  end;

  if EditUsername.Text = '' then
  begin
    ShowMessage('Informe o nome do usuário');
    exit;
  end;

  if Fingers.Count = 0 then
  begin
    ShowMessage('Cadastre no mínimo 1 dedo');
    exit;
  end;

  Username := EditUsername.Text;

  User := UserService.CreateUser(Username);

  FingerService.AssociateToUser(User);

  ShowMessage('Usuário cadastrado com sucesso!');
  Self.Close;
end;

function TFormCreateUser.PasswordIsValid: Boolean;
var
  AdminPassword: string;
begin
  Result := false;

  AdminPassword := EditAdminPassword.Text;

  if AdminPassword <> '123' then exit;

  Result := true;
end;

end.
