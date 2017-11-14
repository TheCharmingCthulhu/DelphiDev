program AnySerializer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  asTools in 'Source\asTools.pas',
  asTest in 'Source\asTest.pas';

var
  Dumper: TasDumper;
  Sample, Sample2: TasSample;
  Data: TArray<TasSample>;
  Serializer: TasSerializer;
  Example, Result: TasExample;

procedure TestRecords;
begin
  try
    // Record serialization...
    Dumper:=TasDumper.Create;

    with Sample do
    begin
      Id:=1;
      Name:='David';
      Lastname:='Dembinski';
    end;

    with Sample2 do
    begin
      Id:=2;
      Name:='James';
      Lastname:='Bond';
    end;

    // Save records...
    Dumper.Dump([Sample, Sample2]);

    // Load records...
    Data:=Dumper.Loads<TasSample>;
  finally
    FreeAndNil(Dumper);
  end;
end;

procedure TestClasses;
begin
  // Classes serialization...
  try
    Serializer:=TasSerializer.Create;
    Example:=TasExample.Create;
    with Example do
    begin
      Id:=1;
      Name:='David';
    end;

    Serializer:=TasSerializer.Create;
    Serializer.Serialize(Example);
    Result:=Serializer.Deserialize<TasExample>;

    ReadLn;
  finally
    FreeAndNil(Serializer);
    FreeAndNil(Example);
  end;
end;

begin
  try
    TestClasses;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
