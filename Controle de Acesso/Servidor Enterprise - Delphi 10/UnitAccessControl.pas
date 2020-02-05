unit UnitAccessControl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, System.Actions, Vcl.ActnList, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.Menus, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.CheckLst, Vcl.Grids, UnitDevice,
  System.JSON, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdCustomHTTPServer, IdHTTPServer, IdContext;

type
  TFormControleAcesso = class(TForm)
    PageControlControleAcesso: TPageControl;
    TabSheetDevice: TTabSheet;
    GroupBoxLogin: TGroupBox;
    LabelDeviceHostname: TLabel;
    ButtonDeviceLogin: TButton;
    EditDeviceLogin: TEdit;
    EditDevicePassword: TEdit;
    LabelDeviceLogin: TLabel;
    LabelDevicePassword: TLabel;
    MemoResponse: TMemo;
    RadioGroupProtocol: TRadioGroup;
    LabelDevicePort: TLabel;
    DevicePort: TEdit;
    StatusBar1: TStatusBar;
    GroupBoxResponse: TGroupBox;
    ButtonOnline: TButton;
    Label1: TLabel;
    DeviceIP: TEdit;
    ServerIP: TEdit;
    Label2: TLabel;
    ServerPort: TEdit;
    Button1: TButton;
    IdHTTPServer1: TIdHTTPServer;
    procedure ButtonDeviceLoginClick(Sender: TObject);
    procedure AddMessageInResponse(Text: String); overload;
    procedure ButtonOnlineClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    procedure AddMessageInResponse(ResponseBody: TJSONValue); overload;
    procedure IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  end;

var
  FormControleAcesso: TFormControleAcesso;
  DeviceAccessControl: TDeviceAccessControl;
  ResponseBody: TJSONValue;

implementation

{$R *.dfm}

procedure TFormControleAcesso.AddMessageInResponse(ResponseBody: TJSONValue);
begin
  AddMessageInResponse(TStringStream.Create(ResponseBody.ToString,
    TEncoding.UTF8, true).DataString);
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

procedure TFormControleAcesso.Button1Click(Sender: TObject);
begin
  IdHTTPServer1.OnCommandGet := IdHTTPServer1CommandGet;
  IdHTTPServer1.DefaultPort := StrToInt(ServerPort.Text);
  IdHTTPServer1.Active := True;
  AddMessageInResponse('Servidor web iniciado.');
end;

procedure TFormControleAcesso.ButtonDeviceLoginClick(Sender: TObject);
var
  ResponseBody: TJSONValue;
begin
  DeviceAccessControl := TDeviceAccessControl.Create(
    RadioGroupProtocol.items[RadioGroupProtocol.ItemIndex],
    DeviceIP.Text,
    StrToInt(DevicePort.Text));
  ResponseBody := DeviceAccessControl.Login(EditDeviceLogin.Text, EditDevicePassword.Text);
  //Se quisermos pegar o valor, basta chamar: ResponseBody.GetValue<string>('session');
  AddMessageInResponse('Sessão iniciada.');
end;

procedure TFormControleAcesso.ButtonOnlineClick(Sender: TObject);

var
  ResponseBody: TJSONValue;
  idServidor: string;
begin
  ResponseBody := DeviceAccessControl.criar_device_servidor(ServerIP.Text + ':' + ServerPort.Text);
  idServidor := ResponseBody.GetValue<string>('ids[0]');

  ResponseBody := DeviceAccessControl.ativar_modo_online(idServidor);
  ResponseBody := DeviceAccessControl.setando_general_online();
  AddMessageInResponse('Modo online ativado.');
end;

procedure TFormControleAcesso.IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo);
begin
  AddMessageInResponse('Request recebido para pagina: ' + ARequestInfo.Document);
  AResponseInfo.ContentText := '{"result":{"event":7,"user_id":6,"user_name":"Neal Caffrey","user_image":false, "portal_id":1,"actions":[{"action":"door","parameters":"door=1"},{"action":"door","parameters":"door=2"}]}}';
end;

end.
