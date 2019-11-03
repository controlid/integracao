unit UFinger;

interface

type

TFinger = class(TObject)
  FID: Int64;
  FUserID: integer;

  public
    constructor Create;
    property ID: Int64 read FID write FID;
    property UserID: integer read FUserID write FUserID;

end;

implementation

{ TFinger }

constructor TFinger.Create;
begin
  inherited Create;
  FUserID := 0;
end;

end.
