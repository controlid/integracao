unit UnitAccessControl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.Actions, Vcl.ActnList, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.Menus, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.CheckLst, Vcl.Grids, UnitDevice, System.JSON;

type
  TFormControleAcesso = class(TForm)
    PageControlControleAcesso: TPageControl;
    TabSheetDevice: TTabSheet;
    GroupBoxLogin: TGroupBox;
    LabelDeviceHostname: TLabel;
    EditDeviceHostname: TEdit;
    ButtonDeviceLogin: TButton;
    EditDeviceLogin: TEdit;
    EditDevicePassword: TEdit;
    LabelDeviceLogin: TLabel;
    LabelDevicePassword: TLabel;
    ButtonTestConnection: TButton;
    GroupBoxUser: TGroupBox;
    LabelDeviceStatusTestConnection: TLabel;
    EditUsername: TEdit;
    LabelUsername: TLabel;
    LabelUserID: TLabel;
    EditUserID: TEdit;
    ButtonCreateUser: TButton;
    ButtonListUser: TButton;
    ButtonDeleteUser: TButton;
    ButtonUpdateUser: TButton;
    GroupBoxGroup: TGroupBox;
    ButtonListGroup: TButton;
    ButtonCreateGroup: TButton;
    EditGroupName: TEdit;
    LabelGroupName: TLabel;
    GroupBoxUserGroup: TGroupBox;
    ButtonCreateUserGroup: TButton;
    LabelUserGroupGroupID: TLabel;
    EditUserGroupGrupoID: TEdit;
    LabelUserGroupUserID: TLabel;
    EditUserGroupUserID: TEdit;
    GroupBoxCard: TGroupBox;
    LabelCardUserID: TLabel;
    EditCardUserID: TEdit;
    ButtonCardRegister: TButton;
    LabelStatusCardRegistration: TLabel;
    MemoResponse: TMemo;
    LabelResponse: TLabel;
    RadioGroupProtocol: TRadioGroup;
    LabelDevicePort: TLabel;
    EditDevicePort: TEdit;
    procedure ButtonTestConnectionClick(Sender: TObject);
    procedure ButtonDeviceLoginClick(Sender: TObject);
    procedure ButtonCreateUserClick(Sender: TObject);
    procedure ButtonListUserClick(Sender: TObject);
    procedure ButtonDeleteUserClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormControleAcesso: TFormControleAcesso;
  DeviceAccessControl: TDeviceAccessControl;

implementation

{$R *.dfm}

procedure TFormControleAcesso.ButtonCreateUserClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if EditUserID.Text <> '' then
  begin
    ResponseBody := DeviceAccessControl.CreateUser(StrToInt(EditUserID.Text), EditUsername.Text);
  end
  else
  begin
    ResponseBody := DeviceAccessControl.CreateUser(0, EditUsername.Text);
  end;

  MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
end;

procedure TFormControleAcesso.ButtonDeleteUserClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
var
  ButtonSelected: Integer;
begin
  if EditUserID.Text = '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar todos usuários.' + #13#10#13#10 + 'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end
  else if EditUserID.Text <> '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar o usuário com ID: ' + IntToStr(StrToInt(EditUserID.Text)) + #13#10#13#10'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end;

  if ButtonSelected = mrOk then
  begin
    if EditUserID.Text = '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteUsers(0);
    end
    else if EditUserID.Text <> '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteUsers(StrToInt(EditUserID.Text));
    end;


    MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
  end;

end;

procedure TFormControleAcesso.ButtonDeviceLoginClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if DeviceAccessControl <> nil then
  begin
    ResponseBody := DeviceAccessControl.Login(EditDeviceLogin.Text, EditDevicePassword.Text);
    MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
  end
  else
  begin
    ShowMessage('Primeiro teste a conexão');
  end;
end;

procedure TFormControleAcesso.ButtonListUserClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
    if EditUserID.Text <> '' then
    begin
      ResponseBody := DeviceAccessControl.ListUsers(StrToInt(EditUserID.Text));
    end
    else
    begin
      ResponseBody := DeviceAccessControl.ListUsers(0);
    end;

    MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
end;

procedure TFormControleAcesso.ButtonTestConnectionClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if RadioGroupProtocol.ItemIndex = -1 then
  begin
    ShowMessage('Selecione o protocolo');
    exit;
  end;

  if EditDevicePort.Text = '' then
  begin
    EditDevicePort.Text := '80';
  end;

  if RadioGroupProtocol.ItemIndex = 0 then
  begin
    DeviceAccessControl := TDeviceAccessControl.Create('http', EditDeviceHostname.Text, StrToInt(EditDevicePort.Text));
  end;

  if RadioGroupProtocol.ItemIndex = 1 then
  begin
    DeviceAccessControl := TDeviceAccessControl.Create('https', EditDeviceHostname.Text, StrToInt(EditDevicePort.Text));
  end;

  ResponseBody := DeviceAccessControl.Login(EditDeviceLogin.Text, EditDevicePassword.Text);

  if ResponseBody <> nil then
  begin
    LabelDeviceStatusTestConnection.Caption := 'Status: Sucesso';
  end
  else
  begin
    LabelDeviceStatusTestConnection.Caption := 'Status: Falha';
  end;
end;

end.
