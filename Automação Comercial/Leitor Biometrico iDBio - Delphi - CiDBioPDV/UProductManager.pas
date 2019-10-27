unit UProductManager;

interface

uses System.Classes, UProduct;

type

TProductManager = class(TObject)
  public
    constructor Create;
    procedure Add(pProduct: TProduct);
    function GetAll: TList;
    function GetNextID: Integer;

end;

var
  Products: TList;
  NextID: Integer;

implementation

{ TProductManager }

constructor TProductManager.Create;
begin
  inherited Create;

  if Products = nil then
  begin
    Products := TList.Create;
  end;

  if NextID = 0 then
  begin
    NextID := 1;
  end;
end;

procedure TProductManager.Add(pProduct: TProduct);
begin
  Products.Add(pProduct);
end;

function TProductManager.GetAll: TList;
begin
  Result := Products;
end;

function TProductManager.GetNextID: Integer;
begin
  Result := NextID;
  NextID := NextID + 1;
end;

end.
