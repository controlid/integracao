unit UFingerService;

interface

uses UFingerManager, UFinger, UOrder, System.Classes, UUser;

type

TFingerService = class(TObject)
  private
    FFingerManager: TFingerManager;

  public
    constructor Create;
    property Manager: TFingerManager read FFingerManager;
    function CreateFinger(ID: integer): TFinger;
    procedure AssociateToUser(User: TUser);
    function IdentifyByID(ID: Int64): TFinger;

end;

var
  FingerTest: TFinger;

implementation

{ TFingerService }

constructor TFingerService.Create;
begin
  inherited Create;
  FFingerManager := TFingerManager.Create;

  FingerTest := TFinger.Create;
  FingerTest.UserID := 50;
end;

procedure TFingerService.AssociateToUser(User: TUser);
var
  Finger: TFinger;
begin
  for Finger in FFingerManager.GetAll do
  begin
    if Finger.UserID <> 0 then continue;

    Finger.UserID := User.ID;
  end;
end;

function TFingerService.CreateFinger(ID: integer): TFinger;
var
  Finger: TFinger;
begin
  Finger := TFinger.Create;
  Finger.ID := ID;

  FFingerManager.Add(Finger);

  Result := Finger;
end;

function TFingerService.IdentifyByID(ID: Int64): TFinger;
var
  Finger: TFinger;
begin
  Result := FingerTest;

  for Finger in FFingerManager.GetAll do
  begin
    if Finger.ID <> ID then continue;

    Result := Finger;

    break;
  end;
end;

end.

