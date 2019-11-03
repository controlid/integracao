unit UUserService;

interface

uses UUserManager, UUser, UOrder, System.Classes, UFinger;

type

TUserService = class(TObject)
  private
    FUserManager: TUserManager;

  public
    constructor Create;
    property Manager: TUserManager read FUserManager;
    function CreateUser(Username: string): TUser;
    function FindByID(ID: integer): TUser;

end;

implementation

{ TUserService }

constructor TUserService.Create;
begin
  inherited Create;
  FUserManager := TUserManager.Create;
end;

function TUserService.CreateUser(Username: string): TUser;
var
  User: TUser;
begin
  User := TUser.Create;

  User.ID := FUserManager.GetNextID;
  User.Name := Username;

  FUserManager.Add(User);

  Result := User;
end;

function TUserService.FindByID(ID: integer): TUser;
var
  User: TUser;
begin
  Result := nil;

  for User in FUserManager.GetAll do
  begin
    if ID <> User.ID then Continue;

    Result := User;
    break;
  end;
end;

end.
