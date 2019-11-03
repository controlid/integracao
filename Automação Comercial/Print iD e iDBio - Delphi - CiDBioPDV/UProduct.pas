unit UProduct;

interface

type

TProduct = class(TObject)
  private
    FID: integer;
    FName: string;
    FPrice: integer;

  public
    property ID: integer read FID write FID;
    property Name: string read FName write FName;
    property Price: integer read FPrice write FPrice;

end;

implementation

end.
