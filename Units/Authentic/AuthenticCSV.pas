unit AuthenticCSV;

{*
  *** COPYRIGHT: TheCharmingCthulhu -> David ***
  *** MADE: Using RFC4180 and my own Brain =) ***
  *** DESCRIPTION: Parses any *.csv file ever written. UNIX & WINDOWS *
    * Automatically detects the seperator and allows to query through *
    * Create fully awesome *.csv files without any worries *
    * Edit them with pleasure ***
*}

interface

uses
  SysUtils, Classes, StrUtils, System.Generics.Collections;

type
  TItem = record
    Value: string;
    function AsInteger: Integer;
    function AsDateTime: TDateTime;
    function AsCurrency: Currency;
    function Equals(AItem: TItem): Boolean;
  end;

  TRow = class
  private
    FItems: TList<TItem>;
    function GetItem(Column: Integer): TItem; overload;
    function GetAsString: string;
    function GetItemCount: Integer;
  public
    constructor Create(const AValues: Array of Variant);
    destructor Destroy; override;

    property ItemCount: Integer read GetItemCount;
    property Item[Column: Integer]: TItem read GetItem;
    property AsString: string read GetAsString;
  end;

  TCSVParser = class
  private
    FHeader: TStringList;
    FRows: TList<TRow>;
    FIsHeaderValid: Boolean;
    FSeperator: Char;
    FQuoteMode: Boolean;

    function GetColumnByIndex(Index: Integer): string;
    function GetColumnIndex(Index: string): Integer;
    function GetItems: TArray<TRow>;
    function GetItemsCount: Integer;
  public
    function AnalyzeHeader(const ALine: string): Boolean;
    procedure IdentifySeperator(const AHeader: string);
    procedure LoadFromFile(const AFileName: string); overload;
    procedure SaveToFile(const AFilePath: string;
      const AUseIndentation: Boolean = False); overload;

    procedure New(const AColumns: array of string;
      const ASeperator: Char = ',');
    procedure AddColumn(const AColumn: string);
    procedure AddRow(const AItems: Array of Variant);

    function GetColumnItems(const AColumnName: string): TList<TItem>;
    function GetItemsByValue(const AItem: TItem): TList<TRow>;

    constructor Create;
    destructor Destroy; override;

    property IsHeaderValid: Boolean read FIsHeaderValid write FIsHeaderValid;

    property Column[index: Integer]: string read GetColumnByIndex;
    property ColumnIndex[index: String]: Integer read GetColumnIndex;
    property ItemsCount: Integer read GetItemsCount;
    property Items: TArray<TRow> read GetItems;
  end;

const
  Alphabet: TSysCharSet = ['A' .. 'Z', 'a' .. 'z'];
  Numeric: TSysCharSet = ['0' .. '9'];
  Seperators: TSysCharSet = [';', ':', #9 , '|', ','];
  SpecialChars: TSysCharSet = ['_', '-'];

implementation

{ TCSVFile }

procedure TCSVParser.IdentifySeperator(const AHeader: string);
var
  Seperator: Char;
begin
  FSeperator := ',';

  for Seperator in Seperators do
  begin
    if Pos(Seperator, AHeader) <> 0 then
    begin
      FSeperator := Seperator;
      Break;
    end;
  end;
end;

constructor TCSVParser.Create;
begin
  FHeader := TStringList.Create;
  FIsHeaderValid := True;
  FRows := TList<TRow>.Create;
  FQuoteMode := False;
end;

procedure TCSVParser.New(const AColumns: array of string;
  const ASeperator: Char = ',');
var
  Row: TRow;
  Column: string;
begin
  FSeperator := ASeperator;

  // CLEANUP
  FHeader.Clear;

  for Row in FRows do
  begin
    Row.Free;
  end;
  FRows.Clear;

  // ADD COLUMNS
  for Column in AColumns do
  begin
    if NOT AnalyzeHeader(Column) then
    begin
      raise Exception.Create('AuthenticCSV -> CreateNew Failed: Header contains invalid characters.' +
        'Only Alphabetical and Numeric values are allowed.');
    end;

    FHeader.Add(Column);
  end;
end;

destructor TCSVParser.Destroy;
var
  Row: TRow;
begin
  FHeader.Clear;
  FreeAndNil(FHeader);

  for Row in FRows do
  begin
    Row.Free;
  end;
  FreeAndNil(FRows);

  inherited;
end;

function TCSVParser.GetColumnByIndex(Index: Integer): string;
begin
  if Index < FHeader.Count then
  begin
    Result := FHeader[Index];
  end else
  begin
    raise Exception.Create('AuthenticCSV -> Parser Failed: Column not found.');
  end;
end;

function TCSVParser.GetColumnItems(const AColumnName: string): TList<TItem>;
var
  I: Integer;
begin
  Result := TList<TItem>.Create;

  try
    for I := 0 to FRows.Count-1 do
    begin
      Result.Add(FRows[I].Item[I]);
    end;
  except
    Result.Free;
  end;
end;

function TCSVParser.GetColumnIndex(Index: string): Integer;
begin
  Result := FHeader.IndexOf(Index);
end;

function TCSVParser.GetItems: TArray<TRow>;
begin
  SetLength(Result, FRows.Count);
  Result := FRows.ToArray;
end;

function TCSVParser.GetItemsByValue(const AItem: TItem): TList<TRow>;
var
  ResultRow: TRow;
  Row: TRow;
  Item: TItem;
begin
  Result := TList<TRow>.Create;
  ResultRow := TRow.Create([FHeader.Text]);

  try
    for Row in FRows do
    begin
      for Item in Row.FItems do
      begin
        if Item.Equals(AItem) then
        begin
          ResultRow.FItems.Add(Item);
        end;
      end;

      Result.Add(Row);
    end;
  except
    for Row in Result do
    begin
      Row.FItems.Clear;
      Row.Free;
    end;

    Result.Free;
  end;
end;

function TCSVParser.GetItemsCount: Integer;
begin
  Result := FRows.Count;
end;

procedure TCSVParser.AddColumn(const AColumn: string);
var
  Word: string;
begin
  Word := AColumn.Trim;
  if (FIsHeaderValid) AND (FHeader.IndexOf(Word) <> 0) then
  begin
    FHeader.Add(Word);
  end;
end;

procedure TCSVParser.AddRow(const AItems: Array of Variant);
var
  Row: TRow;
begin
  if (FHeader.Count >= Length(AItems)) then
  begin
    Row := TRow.Create(AItems);
    FRows.Add(Row);
  end else
  begin
    raise Exception.Create('AuthenticCSV -> Parser Failed: More values provided than columns exist.');
  end;
end;

function TCSVParser.AnalyzeHeader(const ALine: string): Boolean;
var
  I: Integer;
  Letter: Char;
begin
  Result := True;

  // Checks if header line contains any illegal symbol.
  for I := 1 to Length(ALine) do
  begin
    Letter := ALine[I];
    if NOT CharInSet(Letter, Alphabet) AND  // Is not an alphabetical character.
       NOT CharInSet(Letter, Numeric) AND // Also not an numeric value.
       NOT CharInSet(Letter, Seperators) AND // Not even a seperator.
       NOT CharInSet(Letter, SpecialChars) AND
       (Letter <> #32) AND // No space?
       (Letter <> #13#10) then // Dang, he missed it, a newline.
    begin
      Result := False;
      Break;
    end;
  end;
end;

procedure TCSVParser.LoadFromFile(const AFileName: string);
var
  Letter: Char;
  Line: string;
  Word: string;
  Row: TRow;
  Item: TItem;
  F: TextFile;
  I: Integer;
  ValidHeader: Boolean;
begin
  try
    // CLEANUP
    FHeader.Clear;
    FRows.Clear;

    // LOAD FILE
    Assign(F, AFileName);
    Reset(F);
    Word := '';
    Line := '';

    // PARSE HEADER
    while Letter <> #13 do
    begin
      Read(F, Letter);
      if Letter = #13 then
        Break;
      Line := Line + Letter;
    end;

    IdentifySeperator(Line);
    ValidHeader := AnalyzeHeader(Line);
    if ValidHeader then
    begin
      for I := 1 to Length(Line) do
      begin
        if NOT CharInSet(Line[I], Seperators) then
        begin
          Word := Word + Line[I];
        end else
        begin
          AddColumn(Word);
          Word := '';
        end;
      end;
      
      // Insert the last header.
      if Length(Word) > 0 then
      begin
        AddColumn(Word);
        Word := '';
      end;
    end;

    if NOT ValidHeader then
    begin
      FHeader.Clear;
      Reset(F);
    end;

    // PARSE RECORDS
    Word := '';
    Row := TRow.Create([]);
    while NOT Eof(F) do
    begin
      Read(F, Letter);

      // Add record on carriage return (#13 => newline => new record);
      if Letter = #13 then
      begin
        // Insert last word.
        Word := Trim(Word);
        Item.Value := Word;
        Row.FItems.Add(Item);
        Read(F, Letter);
        if Letter = #10 then
          Letter := #0;
        Word := '';

        // Add record to the list.
        FRows.Add(Row);

        // Defined a new one.
        Row := TRow.Create([]);
        Row.FItems.Clear;
      end;

      // Read full quote.
      if Letter = '"' then
      begin
        Read(F, Letter);
        while Letter <> '"' do
        begin
          if (Letter = #13) OR
             (Letter = #10) then
          begin
            Word := Trim(Word);
            Read(F, Letter);
            Continue;
          end;

          Word := Word + Letter;
          Read(F, Letter);
        end;

        // Add to the local record list.
        Word := Trim(Word);
        Item.Value := Word;
        Row.FItems.Add(Item);
        Word := '';
        Continue;
      end;

      // FSeperator is automatically detected.
      if Letter <> FSeperator then
      begin
        Word := Word + Letter;
      end else
      begin
        if Length(Word) > 0 then
        begin
          Word := Trim(Word);
          Item.Value := Word;
          Row.FItems.Add(Item);
          Word := '';
        end;
      end;
    end;

    // Insert last word that would be otherwise skipped.
    if Length(Word) > 0 then
    begin
      if Word <> #0 then
      begin
        Word := Trim(Word);
        Item.Value := Word;
        Row.FItems.Add(Item);

        // Add the last record.
        FRows.Add(Row);
      end;
    end;
  finally
    if FileExists(AFileName) then
      CloseFile(F);
  end;
end;

procedure TCSVParser.SaveToFile(const AFilePath: string;
  const AUseIndentation: Boolean = False);
var
  CSVFile: TextFile;
  Seperator: string;
  SepStrip: Integer;
  ColumnStr: string;
  RowStr: string;
  Row: TRow;
  Item: TItem;
  ItemDifference: Integer;
  I: Integer;
begin
  try
    Assign(CSVFile, AFilePath);
    Rewrite(CSVFile);

    if AUseIndentation then
    begin
      Seperator := FSeperator + ' ';
      SepStrip := 2;
    end else
    begin
      Seperator := FSeperator;
      SepStrip := 1;
    end;

    ColumnStr := FHeader.Text;
    ColumnStr := ReplaceStr(ColumnStr, #13#10, Seperator);
    ColumnStr := ColumnStr.Substring(0, Length(ColumnStr)-SepStrip);
    WriteLn(CSVFile, ColumnStr);

    for Row in FRows do
    begin
      ItemDifference := FHeader.Count - Row.FItems.Count;
      if ItemDifference > 0 then
      begin
        for I := 0 to ItemDifference-1 do
        begin
          Item.Value := '';
          Row.FItems.Add(Item);
        end;
      end;

      RowStr := Row.AsString;
      RowStr := ReplaceStr(RowStr, #13#10, Seperator);
      RowStr := RowStr.Substring(0, Length(RowStr)-SepStrip);
      WriteLn(CSVFile, RowStr);
    end;
  finally
    CloseFile(CSVFile);
  end;
end;

{ TRow }

constructor TRow.Create(const AValues: Array of Variant);
var
  Item: TItem;
  I: Integer;
begin
  FItems := TList<TItem>.Create;

  for I := 0 to Length(AValues)-1 do
  begin
    Item.Value := AValues[I];
    FItems.Add(Item);
  end;
end;

destructor TRow.Destroy;
begin
  FItems.Clear;
  FreeAndNil(FItems);

  inherited;
end;

function TRow.GetAsString: string;
var
  Item: TItem;
begin
  Result := '';

  try
    for Item in FItems do
    begin
      Result := Result + Item.Value + #13#10;
    end;

    Result.Substring(Length(Result)-2, 2);
  except
    Result := '';
  end;
end;

function TRow.GetItem(Column: Integer): TItem;
var
  Item: TItem;
begin
  try
    Result := FItems[Column];
  except
    Item.Value := '';
    Result := Item;
  end;
end;

function TRow.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

{ TItem }

function TItem.AsCurrency: Currency;
begin
  try
    Result := StrToCurr(Value);
  except
    Result := 0;
  end;
end;

function TItem.AsDateTime: TDateTime;
begin
  try
    Result := StrToDateTime(Value);
  except
    Result := 0;
  end;
end;

function TItem.AsInteger: Integer;
begin
  try
    Result := StrToInt(Value);
  except
    Result := 0;
  end;
end;

function TItem.Equals(AItem: TItem): Boolean;
begin
  Result := Value = AItem.Value;
end;

end.
