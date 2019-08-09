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
    GroupBoxUser: TGroupBox;
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
    EditUserGroupGroupID: TEdit;
    LabelUserGroupUserID: TLabel;
    EditUserGroupUserID: TEdit;
    GroupBoxCard: TGroupBox;
    LabelCardUserID: TLabel;
    EditCardUserID: TEdit;
    ButtonRegisterCard: TButton;
    MemoResponse: TMemo;
    RadioGroupProtocol: TRadioGroup;
    LabelDevicePort: TLabel;
    EditDevicePort: TEdit;
    ButtonListUserGroup: TButton;
    GroupBoxBiometry: TGroupBox;
    LabelBiometryUserID: TLabel;
    EditTemplateUserID: TEdit;
    ButtonTemplateRegister: TButton;
    CheckBoxPanicFinger: TCheckBox;
    LabelGroupID: TLabel;
    EditGroupID: TEdit;
    StatusBar1: TStatusBar;
    ButtonDeleteGroup: TButton;
    ButtonListCard: TButton;
    EditCardID: TEdit;
    LabelCardID: TLabel;
    ButtonDeleteCard: TButton;
    ButtonListTemplate: TButton;
    LabelTemplateID: TLabel;
    EditTemplateID: TEdit;
    ButtonDeleteTemplate: TButton;
    GroupBoxResponse: TGroupBox;
    GroupBoxSyncronization: TGroupBox;
    LabelSyncronizationHostname: TLabel;
    LabelSyncronizationLogin: TLabel;
    LabelSyncronizationPassword: TLabel;
    LabelSyncronizationPort: TLabel;
    EditSyncronizationHostname: TEdit;
    ButtonSyncUsers: TButton;
    EditSyncronizationLogin: TEdit;
    EditSyncronizationPassword: TEdit;
    RadioGroupSyncronizationProtocol: TRadioGroup;
    EditSyncronizationPort: TEdit;
    procedure ButtonDeviceLoginClick(Sender: TObject);
    procedure ButtonCreateUserClick(Sender: TObject);
    procedure ButtonListUserClick(Sender: TObject);
    procedure ButtonDeleteUserClick(Sender: TObject);
    procedure ButtonUpdateUserClick(Sender: TObject);
    procedure ButtonCreateGroupClick(Sender: TObject);
    procedure ButtonListGroupClick(Sender: TObject);
    procedure ButtonCreateUserGroupClick(Sender: TObject);
    procedure ButtonRegisterCardClick(Sender: TObject);
    procedure ButtonListUserGroupClick(Sender: TObject);
    procedure ButtonTemplateRegisterClick(Sender: TObject);
    procedure ButtonDeleteGroupClick(Sender: TObject);
    procedure ButtonListCardClick(Sender: TObject);
    procedure ButtonDeleteCardClick(Sender: TObject);
    procedure ButtonDeleteTemplateClick(Sender: TObject);
    procedure ButtonListTemplateClick(Sender: TObject);
    procedure ButtonSyncUsersClick(Sender: TObject);
    procedure AddMessageInResponse(Text: String); overload;
  private
    { Private declarations }
  public
    procedure AddMessageInResponse(ResponseBody: TJSONValue); overload;
  end;

var
  FormControleAcesso: TFormControleAcesso;
  DeviceAccessControl: TDeviceAccessControl;

implementation

{$R *.dfm}

procedure TFormControleAcesso.ButtonTemplateRegisterClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if EditTemplateUserID.Text = '' then
  begin
    ShowMessage('Preencha o campo Usuário ID');
    exit;
  end;

  if CheckBoxPanicFinger.Checked then
  begin
    ResponseBody := DeviceAccessControl.RegisterTemplate(StrToInt(EditTemplateUserID.Text), 1);
  end
  else
  begin
    ResponseBody := DeviceAccessControl.RegisterTemplate(StrToInt(EditTemplateUserID.Text), 0);
  end;

  MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
end;

procedure TFormControleAcesso.ButtonRegisterCardClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if EditCardUserID.Text = '' then
  begin
    ShowMessage('Preencha o campo Usuário ID');
    exit;
  end;

  ResponseBody := DeviceAccessControl.RegisterCard(StrToInt(EditCardUserID.Text), 'Encoste o cartão');

  MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
end;

procedure TFormControleAcesso.ButtonSyncUsersClick(Sender: TObject);
var
  DeviceSyncronization: TDeviceAccessControl;
  ResponseBody: TJSONValue;
  JSON: TJSONObject;
  ValuesJSON: TJSONArray;
begin
  if DeviceAccessControl = nil then
  begin
    ShowMessage('Primeiro faça login em um dispositivo');
    exit;
  end;

  if EditSyncronizationPort.Text = '' then
  begin
    EditSyncronizationPort.Text := '80';
  end;

  if RadioGroupSyncronizationProtocol.ItemIndex = 0 then
  begin
    DeviceSyncronization := TDeviceAccessControl.Create('http', EditSyncronizationHostname.Text, StrToInt(EditSyncronizationPort.Text));
  end;

  if RadioGroupSyncronizationProtocol.ItemIndex = 1 then
  begin
    DeviceSyncronization := TDeviceAccessControl.Create('https', EditSyncronizationHostname.Text, StrToInt(EditSyncronizationPort.Text));
  end;

  ResponseBody := DeviceSyncronization.Login(EditSyncronizationLogin.Text, EditSyncronizationPassword.Text);

  AddMessageInResponse(ResponseBody);

  ResponseBody := DeviceAccessControl.ListUsers(0);

  AddMessageInResponse(ResponseBody);

  ValuesJSON := ResponseBody.GetValue<TJSONArray>('users');

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'users'));
  JSON.AddPair(TJSONPair.Create('values', ValuesJSON));

  ResponseBody := DeviceSyncronization.CreateUsers(JSON);

  AddMessageInResponse(ResponseBody);
end;

procedure TFormControleAcesso.AddMessageInResponse(ResponseBody: TJSONValue);
begin
  AddMessageInResponse(TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString);
end;

procedure TFormControleAcesso.AddMessageInResponse(Text: String);
begin
  if Text.Length > 140 then
  begin
    delete(Text, 130, Text.Length);
    Text := Text + '...';
  end;

  MemoResponse.Text := Text + #13#10 + MemoResponse.Text;
end;

procedure TFormControleAcesso.ButtonCreateGroupClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if EditGroupID.Text <> '' then
  begin
    ResponseBody := DeviceAccessControl.CreateGroup(StrToInt(EditGroupID.Text), EditGroupName.Text);
  end
  else
  begin
    ResponseBody := DeviceAccessControl.CreateGroup(0, EditGroupName.Text);
  end;

  MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
end;

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

procedure TFormControleAcesso.ButtonCreateUserGroupClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if (EditUserGroupGroupID.Text = '') or (EditUserGroupUserID.Text = '') then
  begin
    ShowMessage('Preencha os campos Grupo ID e Usuário ID');
    exit
  end;

  ResponseBody := DeviceAccessControl.CreateUserGroup(StrToInt(EditUserGroupGroupID.Text), StrToInt(EditUserGroupUserID.Text));

  MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
end;

procedure TFormControleAcesso.ButtonDeleteTemplateClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
  ButtonSelected: Integer;
begin
  if EditTemplateID.Text = '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar todas biometrias.' + #13#10#13#10 + 'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end
  else if EditTemplateID.Text <> '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar a biometria com ID: ' + IntToStr(StrToInt(EditTemplateID.Text)) + #13#10#13#10'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end;

  if ButtonSelected = mrOk then
  begin
    if EditTemplateID.Text = '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteTemplates(0);
    end
    else if EditTemplateID.Text <> '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteTemplates(StrToInt(EditTemplateID.Text));
    end;

    MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
  end;

end;

procedure TFormControleAcesso.ButtonDeleteCardClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
  ButtonSelected: Integer;
begin
  if EditCardID.Text = '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar todos cartões.' + #13#10#13#10 + 'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end
  else if EditCardID.Text <> '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar o cartão com ID: ' + IntToStr(StrToInt(EditCardID.Text)) + #13#10#13#10'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end;

  if ButtonSelected = mrOk then
  begin
    if EditCardID.Text = '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteCards(0);
    end
    else if EditCardID.Text <> '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteCards(StrToInt(EditCardID.Text));
    end;

    MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
  end;

end;

procedure TFormControleAcesso.ButtonDeleteGroupClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
  ButtonSelected: Integer;
begin
  if EditGroupID.Text = '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar todos grupos.' + #13#10#13#10 + 'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end
  else if EditGroupID.Text <> '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá apagar o grupo com ID: ' + IntToStr(StrToInt(EditGroupID.Text)) + #13#10#13#10'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end;

  if ButtonSelected = mrOk then
  begin
    if EditGroupID.Text = '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteGroups(0);
    end
    else if EditGroupID.Text <> '' then
    begin
      ResponseBody := DeviceAccessControl.DeleteGroups(StrToInt(EditGroupID.Text));
    end;

    MemoResponse.Text := TStringStream.Create(ResponseBody.ToString, TEncoding.UTF8, true).DataString;
  end;

end;

procedure TFormControleAcesso.ButtonDeleteUserClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
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

    AddMessageInResponse(ResponseBody);
  end;

end;

procedure TFormControleAcesso.ButtonDeviceLoginClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
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

  AddMessageInResponse(ResponseBody);
end;

procedure TFormControleAcesso.ButtonListTemplateClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if EditTemplateID.Text <> '' then
  begin
    ResponseBody := DeviceAccessControl.ListTemplates(StrToInt(EditTemplateID.Text));
  end
  else
  begin
    ResponseBody := DeviceAccessControl.ListTemplates(0);
  end;

  AddMessageInResponse(ResponseBody);
end;

procedure TFormControleAcesso.ButtonListCardClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if EditCardID.Text <> '' then
  begin
    ResponseBody := DeviceAccessControl.ListCards(StrToInt(EditCardID.Text));
  end
  else
  begin
    ResponseBody := DeviceAccessControl.ListCards(0);
  end;

  AddMessageInResponse(ResponseBody);
end;

procedure TFormControleAcesso.ButtonListGroupClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  if EditGroupID.Text <> '' then
  begin
    ResponseBody := DeviceAccessControl.ListGroups(StrToInt(EditGroupID.Text));
  end
  else
  begin
    ResponseBody := DeviceAccessControl.ListGroups(0);
  end;

  AddMessageInResponse(ResponseBody);
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

    AddMessageInResponse(ResponseBody);
end;

procedure TFormControleAcesso.ButtonListUserGroupClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
    ResponseBody := DeviceAccessControl.ListUserGroups;

    AddMessageInResponse(ResponseBody);
end;

procedure TFormControleAcesso.ButtonUpdateUserClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
  ButtonSelected: Integer;
begin
  if EditUserID.Text = '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá alterar todos usuários.' + #13#10#13#10 + 'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end
  else if EditUserID.Text <> '' then
  begin
    ButtonSelected := MessageDlg('Essa ação irá alterar o usuário com ID: ' + IntToStr(StrToInt(EditUserID.Text)) + #13#10#13#10'Deseja continuar?', mtWarning, mbOKCancel, 0);
  end;

  if ButtonSelected = mrOk then
  begin
    if EditUserID.Text = '' then
    begin
      ResponseBody := DeviceAccessControl.UpdateUsers(0, EditUsername.Text);
    end
    else if EditUserID.Text <> '' then
    begin
      ResponseBody := DeviceAccessControl.UpdateUsers(StrToInt(EditUserID.Text), EditUsername.Text);
    end;

    AddMessageInResponse(ResponseBody);
  end;

end;

end.
