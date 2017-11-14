unit asTools;

interface

uses
  SysUtils, Variants, Classes, SyncObjs, Generics.Defaults, Generics.Collections,
  RTTI, ZLib;

type
  TasSerializer = class
  private
    procedure WriteString(AString: String; AStream: TStream);
    function ReadString(AStream: TStream): String;

    procedure Compress(AInput, AOutput: TStream);
    procedure Decompress(AInput, AOutput: TStream);
  public
    procedure Serialize(AObject: TObject);
    function Deserialize<T>: T;
  end;

  TasDumper = class
  private
  public
    procedure Dump<T: record>(ARecords: array of T);
    function Loads<T: record>: TArray<T>;
  end;

implementation

{ TasSerializer }

procedure TasSerializer.Compress(AInput, AOutput: TStream);
begin
  with TZCompressionStream.Create(TCompressionLevel.clDefault, AOutput) do
  begin
    try
      AInput.Position:=0;

      CopyFrom(AInput, AInput.Size);
    finally
      Free;
    end;
  end;
end;

procedure TasSerializer.Decompress(AInput, AOutput: TStream);
var
  Stream:TStream;
begin
  try
    Stream:=TZDecompressionStream.Create(AInput);
    Stream.Position:=0;

    AOutput.CopyFrom(Stream, Stream.Size);
    AOutput.Position:=0;
  finally
    FreeAndNil(Stream);
  end;
end;

function TasSerializer.Deserialize<T>: T;
var
  Input, Output: TStream;
begin
  try
    Input:=TFileStream.Create('object.dat', fmOpenRead);
    Output:=TMemoryStream.Create;

    Decompress(Input, Output);

    ReadString(Output);
  finally
    FreeAndNil(Output);
    FreeAndNil(Input);
  end;
end;

procedure TasSerializer.Serialize(AObject: TObject);
var
  Input, Output: TStream;
  Context: TRttiContext;
  ObjectType: TRttiType;
  Field: TRttiField;
begin
  try
    // Data Stream...
    Input:=TMemoryStream.Create;
    // File Stream...
    Output:=TFileStream.Create('object.dat', fmCreate);

    // RTTI
    Context:=TRttiContext.Create;

    ObjectType:=Context.GetType(AObject.ClassType);

    WriteString(ObjectType.QualifiedName, Input);

  //    for Field in ObjectType.GetFields do
  //      if NOT Field.GetValue(AObject).IsEmpty then
  //        WriteString(VarToStr(Field.GetValue(AObject).AsVariant), Input);

    // Reset position after writing to stream...
    Input.Position:=0;

    Compress(Input, Output);
  finally
    Context.Free;

    FreeAndNil(Input);
    FreeAndNil(Output);
  end;
end;

procedure TasSerializer.WriteString(AString: String; AStream: TStream);
begin
  AStream.WriteData(Length(AString));
  AStream.WriteData(TEncoding.ASCII.GetBytes(AString), Length(AString));
end;

function TasSerializer.ReadString(AStream: TStream): String;
var
  Size: SmallInt;
  Buffer: TBytes;
begin
  AStream.ReadData(Size);
  SetLength(Buffer, Size);

  AStream.Seek(2, soFromCurrent);
  AStream.ReadData(Buffer, Size);

  Result:=TEncoding.UTF8.GetString(Buffer);
end;

{ TasDumper }

procedure TasDumper.Dump<T>(ARecords: array of T);
var
  Stream: TStream;
  Item: T;
begin
  try
    Stream:=TFileStream.Create('dump.dat', fmCreate);
    Stream.WriteData(Length(ARecords));

    for Item in ARecords do
      Stream.Write(Item, SizeOf(Item));
  finally
    FreeAndNil(Stream);
  end;
end;

function TasDumper.Loads<T>: TArray<T>;
var
  Stream: TStream;
  Index, Count: Integer;
begin
  try
    Stream:=TFileStream.Create('dump.dat', fmOpenRead);
    Stream.ReadData(Count);
    SetLength(Result, Count);

    Index:=0;
    while Stream.Position < Stream.Size do
    begin
      Stream.Read(Result[Index], SizeOf(T));

      Inc(Index);
    end;
  finally
    FreeAndNil(Stream);
  end;
end;

end.
