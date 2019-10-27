unit UOrder;

interface

uses System.SysUtils;

type

TOrder = class(TObject)
  private
    FID: integer;
    FName: string;
    FQuantity: integer;
    FPrice: integer;

  public
    property ID: integer read FID write FID;
    property Name: string read FName write FName;
    property Quantity: integer read FQuantity write FQuantity;
    property Price: integer read FPrice write FPrice;

    function GetDisplayName: string;

end;

implementation

{ TOrder }

function TOrder.GetDisplayName: string;
begin
  Result := FName + ' x' + IntToStr(FQuantity) + ' - R$ ' + IntToStr(FPrice) + ',00';
end;

end.
