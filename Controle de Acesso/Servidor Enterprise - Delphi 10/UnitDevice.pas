unit UnitDevice;

interface

uses UnitHttpClient, IdHTTP, System.Classes, System.JSON, System.SysUtils, Vcl.Dialogs;

type
  TDeviceAccessControl = class
    Protocol: String;
    Hostname: String;
    Port: Integer;
    URL: String;
    Session: String;

    DeviceLogin: String;
    DevicePassword: String;

    private
      procedure CreateURL;
      procedure AddContentTypeApplicationJSON(Headers: TStringList);
      procedure AddSession(Params: TStringList);

      //OBJECTS
      function CreateObjects(Objects: TJSONValue): TJSONValue;

    public
      constructor Create(Protocol, Hostname: String; Port: Integer); overload;

      //SESION MANAGEMENT
      function Login(Login, Password: String): TJSONValue;

      //USER
      function CreateUser(ID: Integer; Name: String): TJSONValue;
      function CreateUsers(Users: TJSONValue): TJSONValue;
      function ListUsers(ID: Integer): TJSONValue;
      function UpdateUsers(ID: Integer; Name: String): TJSONValue;
      function DeleteUsers(ID: Integer): TJSONValue;

      //GROUP
      function CreateGroup(ID: Integer; Name: String): TJSONValue;
      function ListGroups(ID: Integer): TJSONValue;
      function DeleteGroups(ID: Integer): TJSONValue;

      //USER_GROUP
      function CreateUserGroup(GroupID, UserID: Integer): TJSONValue;
      function ListUserGroups: TJSONValue;

      //CARD
      function ListCards(ID: Integer): TJSONValue;
      function DeleteCards(ID: Integer): TJSONValue;

      //TEMPLATE
      function ListTemplates(ID: Integer): TJSONValue;
      function DeleteTemplates(ID: Integer): TJSONValue;

      //REGISTER
      function RegisterCard(UserID: Integer; MessageText: String): TJSONValue;
      function RegisterTemplate(UserID, PanicFinger: Integer): TJSONValue;

      //MONITOR_EVENTS
      function criar_device_servidor(hostname: String): TJSONValue;
      function ativar_modo_online(idservidor:string): TJSONValue;
      function setando_general_online():TJSONValue;

  end;

var
  HTTP: THTTP;

implementation

constructor TDeviceAccessControl.Create(Protocol, Hostname: String; Port: Integer);
begin
  Self.Protocol := Protocol;
  Self.Hostname := Hostname;
  Self.Port := Port;
  HTTP := THTTP.Create;
  Self.CreateURL;
end;

function TDeviceAccessControl.CreateGroup(ID: Integer; Name: String): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  GroupJSON: TJSONObject;
  ValuesJSONArray: TJSONArray;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  GroupJSON := TJSONObject.Create;
  GroupJSON.AddPair(TJSONPair.Create('name', Name));

  if ID > 0 then
  begin
    GroupJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));
  end;

  ValuesJSONArray := TJSONArray.Create;
  ValuesJSONArray.AddElement(GroupJSON);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'groups'));
  JSON.AddPair(TJSONPair.Create('values', ValuesJSONArray));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/create_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.Login(Login, Password: String): TJSONValue;
var
  Headers: TStringList;
  JSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  DeviceLogin := Login;
  DevicePassword := Password;

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('login', DeviceLogin));
  JSON.AddPair(TJSONPair.Create('password', DevicePassword));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/login.fcgi', Headers, nil, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);

  Session := Result.GetValue<String>('session');
end;

function TDeviceAccessControl.criar_device_servidor(hostname: string): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  UserJSON: TJSONObject;
  ValuesJSONArray: TJSONArray;


  Body: TStringStream;
  ResponseBody: String;
begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  UserJSON := TJSONObject.Create;
  UserJSON.AddPair(TJSONPair.Create('name', 'ControliD'));
  UserJSON.AddPair(TJSONPair.Create('ip', 'http://'+hostname+'/api'));
  UserJSON.AddPair(TJSONPair.Create('public_key', ''));

  ValuesJSONArray := TJSONArray.Create;
  ValuesJSONArray.AddElement(UserJSON);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'devices'));
  JSON.AddPair(TJSONPair.Create('values', ValuesJSONArray));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/create_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.RegisterTemplate(UserID, PanicFinger: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('type', 'biometry'));
  JSON.AddPair(TJSONPair.Create('user_id', TJSONNumber.Create(UserID)));
  JSON.AddPair(TJSONPair.Create('save', TJSONBool.Create(True)));
  JSON.AddPair(TJSONPair.Create('sync', TJSONBool.Create(False)));
  JSON.AddPair(TJSONPair.Create('panic_finger', TJSONNumber.Create(PanicFinger)));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/remote_enroll.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.RegisterCard(UserID: Integer; MessageText: String): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('type', 'card'));
  JSON.AddPair(TJSONPair.Create('user_id', TJSONNumber.Create(UserID)));
  JSON.AddPair(TJSONPair.Create('message', MessageText));
  JSON.AddPair(TJSONPair.Create('save', TJSONBool.Create(True)));
  JSON.AddPair(TJSONPair.Create('sync', TJSONBool.Create(False)));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/remote_enroll.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.CreateUser(ID: Integer; Name: string): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  UserJSON: TJSONObject;
  ValuesJSONArray: TJSONArray;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  UserJSON := TJSONObject.Create;
  UserJSON.AddPair(TJSONPair.Create('registration', ''));
  UserJSON.AddPair(TJSONPair.Create('password', ''));
  UserJSON.AddPair(TJSONPair.Create('salt', ''));
  UserJSON.AddPair(TJSONPair.Create('name', Name));

  if ID > 0 then
  begin
    UserJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));
  end;

  ValuesJSONArray := TJSONArray.Create;
  ValuesJSONArray.AddElement(UserJSON);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'users'));
  JSON.AddPair(TJSONPair.Create('values', ValuesJSONArray));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/create_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.setando_general_online: TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  JSONValues: TJSONArray;
  JSONUsuario: TJSONObject;
  DADOS_SERVIDOR: TJSONObject;
  DADOS_ONLINE_CLIENT: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  DADOS_SERVIDOR := TJSONObject.Create;
  DADOS_SERVIDOR.AddPair(TJSONPair.Create('online', '1'));

  DADOS_ONLINE_CLIENT := TJSONObject.Create;
  DADOS_ONLINE_CLIENT.AddPair(TJSONPair.Create('extract_template','0'));

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('general', DADOS_SERVIDOR));
  JSON.AddPair(TJSONPair.Create('online_client', DADOS_ONLINE_CLIENT));

  Body         :=TStringStream.Create(JSON.ToString, TEncoding.UTF8);
  ResponseBody :=HTTP.MakeRequest(URL, '/set_configuration.fcgi', Headers, Params, Body);
  Result       :=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.CreateUserGroup(GroupID, UserID: Integer): TJSONValue;
var
  JSON: TJSONObject;
  UserGroupJSON: TJSONObject;
  ValuesJSONArray: TJSONArray;
  Body: TStringStream;
  ResponseBody: String;

begin
  UserGroupJSON := TJSONObject.Create;
  UserGroupJSON.AddPair(TJSONPair.Create('user_id', TJSONNumber.Create(UserID)));
  UserGroupJSON.AddPair(TJSONPair.Create('group_id', TJSONNumber.Create(GroupID)));

  ValuesJSONArray := TJSONArray.Create;
  ValuesJSONArray.AddElement(UserGroupJSON);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'user_groups'));
  JSON.AddPair(TJSONPair.Create('values', ValuesJSONArray));

  Result := CreateObjects(JSON);
end;

function TDeviceAccessControl.CreateUsers(Users: TJSONValue): TJSONValue;
begin
  Result := CreateObjects(Users);
end;

function TDeviceAccessControl.CreateObjects(Objects: TJSONValue): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  Body := TStringStream.Create(Objects.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/create_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.DeleteCards(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  CardJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'cards'));

  if ID > 0 then
  begin
    CardJSON := TJSONObject.Create;
    CardJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('cards', CardJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/destroy_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.DeleteGroups(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  GroupJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'groups'));

  if ID > 0 then
  begin
    GroupJSON := TJSONObject.Create;
    GroupJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('groups', GroupJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/destroy_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.DeleteTemplates(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  TemplateJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'templates'));

  if ID > 0 then
  begin
    TemplateJSON := TJSONObject.Create;
    TemplateJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('templates', TemplateJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/destroy_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.DeleteUsers(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  UserJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'users'));

  if ID > 0 then
  begin
    UserJSON := TJSONObject.Create;
    UserJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('users', UserJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/destroy_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.ListCards(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  CardJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'cards'));

  if ID > 0 then
  begin
    CardJSON := TJSONObject.Create;
    CardJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('cards', CardJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/load_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.ListGroups(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  GroupJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'groups'));

  if ID > 0 then
  begin
    GroupJSON := TJSONObject.Create;
    GroupJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('groups', GroupJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/load_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.ListTemplates(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  TemplateJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'templates'));

  if ID > 0 then
  begin
    TemplateJSON := TJSONObject.Create;
    TemplateJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('templates', TemplateJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/load_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.ListUserGroups: TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'user_groups'));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/load_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.ListUsers(ID: Integer): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  WhereJSON: TJSONObject;
  UserJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;
  FieldsJSON: TJSONArray;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  FieldsJSON := TJSONArray.Create;
  FieldsJSON.Add('id');
  FieldsJSON.Add('registration');
  FieldsJSON.Add('name');
  FieldsJSON.Add('password');
  FieldsJSON.Add('salt');
  FieldsJSON.Add('expires');
  //FieldsJSON.Add('user_type_id');
  FieldsJSON.Add('begin_time');
  FieldsJSON.Add('end_time');

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'users'));
  JSON.AddPair(TJSONPair.Create('fields', FieldsJSON));

  if ID > 0 then
  begin
    UserJSON := TJSONObject.Create;
    UserJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('users', UserJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/load_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.UpdateUsers(ID: Integer; Name: String): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  ValuesJSON: TJSONObject;
  WhereJSON: TJSONObject;
  UserJSON: TJSONObject;
  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  ValuesJSON := TJSONObject.Create;
  ValuesJSON.AddPair(TJSONPair.Create('name', Name));

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('object', 'users'));

  if ID > 0 then
  begin
    UserJSON := TJSONObject.Create;
    UserJSON.AddPair(TJSONPair.Create('id', TJSONNumber.Create(ID)));

    WhereJSON := TJSONObject.Create;
    WhereJSON.AddPair(TJSONPair.Create('users', UserJSON));

    JSON.AddPair(TJSONPair.Create('where', WhereJSON));
  end;

  JSON.AddPair(TJSONPair.Create('values', ValuesJSON));

  Body := TStringStream.Create(JSON.ToString, TEncoding.UTF8);

  ResponseBody := HTTP.MakeRequest(URL, '/modify_objects.fcgi', Headers, Params, Body);

  Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

function TDeviceAccessControl.ativar_modo_online(idservidor:string): TJSONValue;
var
  Params: TStringList;
  Headers: TStringList;
  JSON: TJSONObject;
  JSONValues: TJSONArray;
  JSONUsuario: TJSONObject;
  DADOS_SERVIDOR: TJSONObject;

  Body: TStringStream;
  ResponseBody: String;

begin
  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  Params := TStringList.Create;
  AddSession(Params);

  Headers := TStringList.Create;
  AddContentTypeApplicationJSON(Headers);

  DADOS_SERVIDOR := TJSONObject.Create;
  DADOS_SERVIDOR.AddPair(TJSONPair.Create('server_id', idservidor));

  JSON := TJSONObject.Create;
  JSON.AddPair(TJSONPair.Create('online_client', DADOS_SERVIDOR));

  Body         :=TStringStream.Create(JSON.ToString, TEncoding.UTF8);
  ResponseBody :=HTTP.MakeRequest(URL, '/set_configuration.fcgi', Headers, Params, Body);
  Result       :=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
end;

procedure TDeviceAccessControl.CreateURL;
begin
  URL := Protocol + '://' + Hostname + ':' + IntToStr(Port);
end;

procedure TDeviceAccessControl.AddContentTypeApplicationJSON(Headers: TStringList);
begin
   Headers.AddPair('Content-Type', 'application/json');
end;

procedure TDeviceAccessControl.AddSession(Params: TStringList);
begin
  Params.AddPair('session', Session);
end;

end.
