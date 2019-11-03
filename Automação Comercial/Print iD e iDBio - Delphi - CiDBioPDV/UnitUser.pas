unit UnitUser;

interface

type

TUser = class(TObject)
  private
    FID: Integer;
    FName: string;

  public
    property ID: Integer read FID write FID;
    property Name: string read FName write FName;
end;

implementation

{ TUser }

end.
