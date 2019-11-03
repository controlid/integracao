unit UUser;

interface

uses System.Classes;

type

TUser = class(TObject)
  FID: integer;
  FName: string;

  public
    constructor Create;
    property ID: integer read FID write FID;
    property Name: string read FName write FName;

end;


implementation

{ TUser }

constructor TUser.Create;
begin
  inherited Create;
end;

end.
