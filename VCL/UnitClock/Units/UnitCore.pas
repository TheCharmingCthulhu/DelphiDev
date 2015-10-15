unit UnitCore;

interface

uses
  SysUtils, Classes, Generics.Collections, StringExtensions;

type
  TFixCostItem = record
    Name: string[255];
    Cost: Currency;
  end;

  TFixCostManagerHandler = procedure of object;
  TFixCostManager = class(TObject)
  private
    FFixCosts: TList<TFixCostItem>;
    FOnItemUpdate: TFixCostManagerHandler;
    FTotalCosts: Currency;

    procedure CalculateCosts;
    function GetFixCostItemCount: Integer;
    function GetFixCostItem(Index: Integer): TFixCostItem;
  public
    procedure AddItem(const AName: string; const ACost: Currency);
    procedure RemoveItem(const AId: Integer);
    procedure SaveToFile;
    procedure LoadFromFile;

    constructor Create;
    destructor Destroy; override;

    property TotalCosts: Currency read FTotalCosts;
    property Items[Index: Integer]: TFixCostItem read GetFixCostItem;
    property ItemCount: Integer read GetFixCostItemCount;

    property OnItemUpdate: TFixCostManagerHandler
      read FOnItemUpdate write FOnItemUpdate;
  end;

  TCashAnalyzerHandler = procedure(const ACash: Currency) of object;
  TCashAnalyzer = class(TObject)
  private
    FRemainingCash: Currency;
    FCash: Currency;
    FDays: Integer;
    FSavings: TList<Integer>;
    FOnUpdate: TCashAnalyzerHandler;
    procedure UpdateCash;
  public
    procedure SetDays(const ADays: Integer);
    procedure SetCash(const ACash: Currency);

    constructor Create;
    destructor Destroy; override;

    property Cash: Currency read FCash;
    property Days: Integer read FDays;
    property RemainingCash: Currency read FRemainingCash;
    property OnCashUpdate: TCashAnalyzerHandler read FOnUpdate write FOnUpdate;
  end;

var
  CorePath: string;

implementation

{ TFixCostManager }

procedure TFixCostManager.AddItem(const AName: string;
  const ACost: Currency);
var
  FixCostItem: TFixCostItem;
begin
  with FixCostItem do
  begin
    Name := AName;
    Cost := ACost;
  end;
  FFixCosts.Add(FixCostItem);

  CalculateCosts;

  if Assigned(OnItemUpdate) then
    OnItemUpdate;
end;

procedure TFixCostManager.CalculateCosts;
var
  I: Integer;
begin
  for I := 0 to FFixCosts.Count-1 do
  begin
    FTotalCosts := FTotalCosts + FFixCosts[I].Cost;
  end;
end;

constructor TFixCostManager.Create;
begin
  FFixCosts := TList<TFixCostItem>.Create;
end;

destructor TFixCostManager.Destroy;
begin
  FFixCosts.Clear;
  FreeAndNil(FFixCosts);
  inherited;
end;

function TFixCostManager.GetFixCostItem(Index: Integer): TFixCostItem;
begin
  Result := FFixCosts[Index];
end;

function TFixCostManager.GetFixCostItemCount: Integer;
begin
  Result := FFixCosts.Count;
end;

procedure TFixCostManager.LoadFromFile;
var
  F: File of TFixCostItem;
  Rec: TFixCostItem;
begin
  FillChar(Rec, SizeOf(Rec), #0);

  if FileExists(CorePath + '\fixed_costs.dat') then
  begin
    Assign(F, CorePath + '\fixed_costs.dat');
    Reset(F);

    while NOT EOF(F) do
    begin
      Read(F, Rec);
      FFixCosts.Add(Rec);
    end;

    CloseFile(F);

    if Assigned(FOnItemUpdate) then
      FOnItemUpdate;
  end;
end;

procedure TFixCostManager.RemoveItem(const AId: Integer);
var
  I: Integer;
begin
  for I := 0 to FFixCosts.Count-1 do
  begin
    if I = AId then
    begin
      FFixCosts.Remove(FFixCosts.Items[I]);
      Break;
    end;
  end;

  if Assigned(OnItemUpdate) then
    OnItemUpdate;
end;

procedure TFixCostManager.SaveToFile;
var
  F: File of TFixCostItem;
  Rec: TFixCostItem;
  I: Integer;
begin
  AssignFile(F, CorePath + '/fixed_costs.dat');
  ReWrite(F);

  for I := 0 to FFixCosts.Count-1 do
  begin
    with Rec do
    begin
      Name := FFixCosts[I].Name;
      Cost := FFixCosts[I].Cost;
    end;

    Write(F, Rec);
  end;

  CloseFile(F);
end;

{ TCashAnalyzer }

constructor TCashAnalyzer.Create;
begin
  FSavings := TList<Integer>.Create;
end;

destructor TCashAnalyzer.Destroy;
begin
  FSavings.Clear;
  FreeAndNil(FSavings);
  inherited;
end;

procedure TCashAnalyzer.SetCash(const ACash: Currency);
begin
  FCash := ACash;

  UpdateCash;

end;

procedure TCashAnalyzer.SetDays(const ADays: Integer);
begin
  FDays := ADays;

  UpdateCash;

  if Assigned(OnCashUpdate) then
    OnCashUpdate(FRemainingCash);
end;

procedure TCashAnalyzer.UpdateCash;
var
  Cash: Currency;
  I: Integer;
begin
  if (FCash > 0) AND
     (FDays > 0) then
  begin
    Cash := FCash;
    for I := 0 to FSavings.Count-1 do
    begin
      Cash := Cash - FSavings[I];
    end;

    FRemainingCash := Cash / FDays;
  end;
end;

initialization
  CorePath := ExpandVars('%appdata%') + '\UnitClock\Core\';
  if NOT DirectoryExists(CorePath) then
    if NOT ForceDirectories(CorePath) then
        raise Exception.Create('Error: Applications Data Folder could not be created.' + #13#10 + 'Status Code: ' +
          IntToStr(GetLastError));

end.
