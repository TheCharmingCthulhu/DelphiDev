unit smController;

interface

type
  TsmSquarenMultiply = class
  private
    FBasis: Extended;
    FExponent: Extended;
    FRest: Extended;
    function GetValues: TArray<Extended>;
  protected
    function GetBinaryArray: TArray<Boolean>;
  public
    property Basis: Extended read FBasis write FBasis;
    property Exponent: Extended read FExponent write FExponent;
    property Rest: Extended read FRest write FRest;
    property BinaryArray: TArray<Boolean> read GetBinaryArray;
    property Values: TArray<Extended> read GetValues;
  end;

implementation

{ TsmSquarenMultiply }

function TsmSquarenMultiply.GetBinaryArray: TArray<Boolean>;
var
  Value: Extended;
  Index, Count: Integer;
begin
  Count:=0;
  Value:=FExponent;

  // E.g. 19/2 => 9.5
  repeat
    Value:=Trunc(Value / 2);

    Inc(Count);
  until Value < 1;

  SetLength(Result, Count);

  Value:=FExponent;
  Index:=Count-1;
  repeat
    Result[Index]:=Trunc(Value) mod 2 <> 0;

    Value:=Trunc(Value / 2);

    Dec(Index);
  until Index = -1;
end;

function TsmSquarenMultiply.GetValues: TArray<Extended>;
var
  Value: Extended;
  Index, Count: Integer;
begin
  Value:=FExponent;
  Count:=0;

  repeat
    Value:=Trunc(Value / 2);

    Inc(Count);
  until Value < 1;

  SetLength(Result, Count);

  Value:=FExponent;
  Index:=0;
  repeat
    Result[Index]:=Value;

    Value:=Trunc(Value / 2);

    Inc(Index);
  until Index >= Count - 1;
end;

end.
