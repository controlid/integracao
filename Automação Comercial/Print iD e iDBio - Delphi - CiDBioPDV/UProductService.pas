unit UProductService;

interface

uses UProductManager, UProduct, System.Classes;

type

TProductService = class(TObject)
  private
    FProductManager: TProductManager;

  public
    constructor Create;
    function CreateDefaults: TList;
    function CreateProduct(ProductName: string; ProductPrice: integer): TProduct;
    function ListAll: TList;
    function FindByID(ID: integer): TProduct;

end;

implementation

{ TProductService }

constructor TProductService.Create;
begin
  inherited Create;
  FProductManager := TProductManager.Create;
end;

function TProductService.CreateDefaults: TList;
var
  Products: TList;
begin
  Products := TList.Create;

  Products.Add(CreateProduct('iDClass 1510', 3));
  Products.Add(CreateProduct('iDClass 373', 5));
  Products.Add(CreateProduct('iDAccess', 8));
  Products.Add(CreateProduct('iDAccess Pro', 9));
  Products.Add(CreateProduct('iDAccess Nano', 4));
  Products.Add(CreateProduct('iDAccess Nano Slave', 7));
  Products.Add(CreateProduct('iDFit 4x2', 9));
  Products.Add(CreateProduct('iDFlex', 6));
  Products.Add(CreateProduct('iDFlex IP65', 8));
  Products.Add(CreateProduct('iDTouch', 3));
  Products.Add(CreateProduct('iDBox', 2));
  Products.Add(CreateProduct('iDBlock Preta', 8));
  Products.Add(CreateProduct('iDBlock Inox', 9));
  Products.Add(CreateProduct('iDBlock Braço Articulado', 7));
  Products.Add(CreateProduct('iDBlock Balcão', 5));
  Products.Add(CreateProduct('iDBlock PNE', 2));
  Products.Add(CreateProduct('iDProx Compact', 3));
  Products.Add(CreateProduct('iDProx Slim', 7));
  Products.Add(CreateProduct('iDBio', 5));
  Products.Add(CreateProduct('Print iD', 9));
  Products.Add(CreateProduct('Print iD Touch', 6));
  Products.Add(CreateProduct('SAT iD', 5));

  Result := Products;
end;

function TProductService.CreateProduct(ProductName: string; ProductPrice: integer): TProduct;
var
  Product: TProduct;
begin
  Product := TProduct.Create;
  Product.ID := FProductManager.GetNextID;
  Product.Name := ProductName;
  Product.Price := ProductPrice;

  FProductManager.Add(Product);

  Result := Product;
end;

function TProductService.FindByID(ID: integer): TProduct;
var
  Product: TProduct;
begin
  Result := nil;

  for Product in FProductManager.GetAll do
  begin
    if ID <> Product.ID then Continue;

    Result := Product;
    break;
  end;
end;

function TProductService.ListAll: TList;
begin
  Result := FProductManager.GetAll;
end;

end.
