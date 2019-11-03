unit UOrderService;

interface

uses UOrderManager, UProduct, UOrder, System.Classes;

type

TOrderService = class(TObject)
  private
    FOrderManager: TOrderManager;

  public
    constructor Create;
    property Manager: TOrderManager read FOrderManager write FOrderManager;
    function CreateOrder(Product: TProduct; Quantity: integer): TOrder;
    function ListAll: TList;
    function FindByID(ID: integer): TOrder;
    procedure DeleteByID(ID: integer);

end;

implementation

{ TOrderService }

constructor TOrderService.Create;
begin
  inherited Create;
  FOrderManager := TOrderManager.Create;
end;

function TOrderService.CreateOrder(Product: TProduct; Quantity: integer): TOrder;
var
  Order: TOrder;
begin
  Order := TOrder.Create;

  Order.ID := FOrderManager.GetNextID;
  Order.Name := Product.Name;
  Order.Price := Quantity * Product.Price;
  Order.Quantity := Quantity;

  FOrderManager.Add(Order);

  Result := Order;
end;

procedure TOrderService.DeleteByID(ID: integer);
var
  Order: TOrder;
  I: Integer;
begin
  for I := 0 to (FOrderManager.GetAll.Count - 1) do
  begin
    Order := FOrderManager.GetAll.Items[I];

    if Order.ID <> ID then continue;

    FOrderManager.GetAll.Delete(I);

    break;
  end;
end;

function TOrderService.FindByID(ID: integer): TOrder;
var
  Order: TOrder;
begin
  Result := nil;

  for Order in FOrderManager.GetAll do
  begin
    if ID <> Order.ID then Continue;
    
    Result := Order;
    break;
  end;
end;

function TOrderService.ListAll: TList;
begin
  Result := FOrderManager.GetAll;
end;

end.
