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

    private
      procedure CreateURL;
      procedure AddContentTypeApplicationJSON(Headers: TStringList);
      procedure AddSession(Params: TStringList);

    public
      constructor Create(Protocol, Hostname: String; Port: Integer); overload;
      function Login(Login, Password: String): TJSONValue;
      function CreateUser(ID: Integer; Name: String): TJSONValue;
      function ListUsers(ID: Integer): TJSONValue;
      function DeleteUsers(ID: Integer): TJSONValue;
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

  function TDeviceAccessControl.Login(Login, Password: String): TJSONValue;
  var
    Headers: TStringList;
    JSON: TJSONObject;
    Body: TStringStream;
    ResponseBody: String;

  begin
    Headers := TStringList.Create;
    AddContentTypeApplicationJSON(Headers);

    JSON := TJSONObject.Create;
    JSON.AddPair(TJSONPair.Create('login', Login));
    JSON.AddPair(TJSONPair.Create('password', Password));

    Body := TStringStream.Create(JSON.ToString);

    ResponseBody := HTTP.MakeRequest(URL, '/login.fcgi', Headers, nil, Body);

    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);

    Session := Result.GetValue<String>('session');
  end;

  function TDeviceAccessControl.CreateUser(ID: Integer; Name: string): TJSONValue;
  var
    Params: TStringList;
    Headers: TStringList;
    JSON: TJSONObject;
    UserJSON: TJSONObject;
    UsersJSONArray: TJSONArray;
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

    UsersJSONArray := TJSONArray.Create;
    UsersJSONArray.AddElement(UserJSON);

    JSON := TJSONObject.Create;
    JSON.AddPair(TJSONPair.Create('object', 'users'));
    JSON.AddPair(TJSONPair.Create('values', UsersJSONArray));

    Body := TStringStream.Create(JSON.ToString);

    ResponseBody := HTTP.MakeRequest(URL, '/create_objects.fcgi', Headers, Params, Body);

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

    Body := TStringStream.Create(JSON.ToString);

    ResponseBody := HTTP.MakeRequest(URL, '/destroy_objects.fcgi', Headers, Params, Body);

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

    Body := TStringStream.Create(JSON.ToString);

    ResponseBody := HTTP.MakeRequest(URL, '/load_objects.fcgi', Headers, Params, Body);

    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResponseBody), 0, true);
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
