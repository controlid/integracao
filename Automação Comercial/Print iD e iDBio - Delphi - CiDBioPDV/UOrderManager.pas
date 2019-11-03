unit UOrderManager;

interface

uses System.Classes, UOrder;

type

TOrderManager = class(TObject)
  public
    constructor Create;
    procedure Add(pOrder: TOrder);
    function GetAll: TList;
    function GetNextID: integer;

end;

var
  Orders: TList;
  NextID: integer;

implementation

{ TProductManager }

constructor TOrderManager.Create;
begin
  inherited Create;

  if Orders = nil then
  begin
    Orders := TList.Create;
  end;

  if NextID = 0 then
  begin
    NextID := 1;
  end;
end;

procedure TOrderManager.Add(pOrder: TOrder);
begin
  Orders.Add(pOrder);
end;

function TOrderManager.GetAll: TList;
begin
  Result := Orders;
end;

function TOrderManager.GetNextID: integer;
begin
  Result := NextID;
  NextID := NextID + 1;
end;

end.
