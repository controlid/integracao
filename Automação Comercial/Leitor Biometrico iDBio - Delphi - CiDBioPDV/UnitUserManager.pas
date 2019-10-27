unit UnitUserManager;

interface

uses
  UnitUser, System.Classes, Vcl.Dialogs;

type

TUserManager = class(TObject)
  private
    FUsers: TList;

  public
    property Users: TList read FUsers write FUsers;
    constructor Create;
    procedure Add(pUser: TUser);
    procedure Remove(Index: Integer);
    function Count: Integer;
    function Get(Index: Integer): TUser;
end;

implementation

{ TUserManager }

procedure TUserManager.Add(pUser: TUser);
begin
  FUsers.Add(pUser);
end;

function TUserManager.Count: Integer;
begin
  Result := FUsers.Count;
end;

constructor TUserManager.Create;
begin
  inherited Create;
  FUsers := TList.Create;
end;

function TUserManager.Get(Index: Integer): TUser;
var
  User: TUser;
begin
  if Index >= Count then
  begin
    for User in FUsers do
    begin
      if User.ID = Index then
      begin
        User.Name := 'Doug Achado';
        Result := User;
        exit;
      end;
    end;
  end
  else
  begin
    ShowMessage('Item não encontrado!');
  end;
end;

procedure TUserManager.Remove(Index: Integer);
begin
  if Index < Count then
     FUsers.Delete(Index)
  else
    ShowMessage('Item não encontrado!');
end;

end.
