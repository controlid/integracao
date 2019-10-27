unit UnitHttpClient;

interface

uses
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.Classes, Vcl.Dialogs;

type
  THTTP = class
    Http: TIdHTTP;

    private
      function CreateURL(Hostname, Path: string; Params: TStringList): string;

    public
      function MakeRequest(Hostname, Path: string; Headers, Params: TStringList; Body: TStringStream): String;
  end;

implementation
  function THTTP.MakeRequest(Hostname, Path: string; Headers, Params: TStringList; Body: TStringStream): String;
  begin
    Http := TIdHTTP.Create;
    Http.Request.ContentType := Headers.Values['Content-Type'];

    Result := Http.Post(CreateURL(Hostname, Path, Params), Body);
  end;

  function THTTP.CreateURL(Hostname: string; Path: string; Params: TStringList): String;
  var
    URL: string;
    I: Integer;
  begin
    URL := Hostname + Path;

    if (Params <> nil) and (Params.Count <> 0) then
    begin
      URL := URL + '?';

      for I := 0 to Params.Count - 1 do
      begin
        URL := URL + Params.Names[I] + '=' + Params.Values[Params.Names[I]] + '&';
      end;
    end;

    Result := URL;
  end;

end.
