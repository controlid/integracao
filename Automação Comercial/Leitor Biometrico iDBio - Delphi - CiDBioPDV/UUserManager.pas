unit UUserManager;

interface

uses System.Classes, UUser;

type

TUserManager = class(TObject)
  public
    constructor Create;
    procedure Add(pUser: TUser);
    function GetAll: TList;
    function GetNextID: integer;

end;

var
  Users: TList;
  NextID: Integer;

implementation

{ TUserManager }

constructor TUserManager.Create;
begin
  inherited Create;
  Users := TList.Create;
  NextID := 1;
end;

procedure TUserManager.Add(pUser: TUser);
begin
  Users.Add(pUser);
  NextID := NextID + 1;
end;

function TUserManager.GetAll: TList;
begin
  Result := Users;
end;

function TUserManager.GetNextID: integer;
begin
  Result := NextID;
  NextID := NextID + 1;
end;

end.
