unit UFingerManager;

interface

uses System.Classes, UFinger;

type

TFingerManager = class(TObject)
  public
    constructor Create;
    procedure Add(pFinger: TFinger);
    function GetAll: TList;
    function GetNextID: integer;

end;

var
  Fingers: TList;
  NextID: integer;

implementation

{ TUserManager }

constructor TFingerManager.Create;
begin
  inherited Create;
  Fingers := TList.Create;
  NextID := 1;
end;

function TFingerManager.GetAll: TList;
begin
  Result := Fingers;
end;

function TFingerManager.GetNextID: integer;
begin
  Result := NextID;
  NextID := NextID + 1;
end;

procedure TFingerManager.Add(pFinger: TFinger);
begin
  Fingers.Add(pFinger);
end;

end.
