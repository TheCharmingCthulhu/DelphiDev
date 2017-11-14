unit asTest;

interface

uses
  SysUtils, Variants, Classes, SyncObjs, Generics.Defaults, Generics.Collections;

type
  TasSample = record
    Id: Integer;
    Name: String;
    Lastname: String;
  end;

  TasExample = class
  private
    FID: Integer;
    FName: String;
    FEnabled: Boolean;
    FNumbers: TList<Integer>;
  public
    property ID: Integer read FID write FID;
    property Name: String read FName write FName;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Numbers: TList<Integer> read FNumbers write FNumbers;
    constructor Create;
  end;

implementation

{ TasExample }

constructor TasExample.Create;
begin
  FNumbers:=TList<Integer>.Create;
end;

end.
