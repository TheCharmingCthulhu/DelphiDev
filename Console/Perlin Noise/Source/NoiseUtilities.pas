unit NoiseUtilities;

interface

uses
  SysUtils, Variants, Classes, SyncObjs, Generics.Collections, System.Math;

type
  TNoiseArray = array of array of double;

  TWhiteNoise = class
  private
    FNoise: TNoiseArray;
  public
    function Next(AWidth, AHeight: Integer): TNoiseArray;

    constructor Create(AWidth, AHeight: Integer);

    property Noise: TNoiseArray read FNoise;

    class function Interpolate(AStart, AEnd, AAlpha: Double): Double;
  end;

  TSmoothNoise = class(TWhiteNoise)
  public
    function Next(AWidth, AHeight, AOctave: Integer): TNoiseArray;

    constructor Create(AWidth, AHeight, AOctave: Integer);
  end;

  TPerlinNoise = class(TSmoothNoise)
  public
    function Next(AWidth, AHeight, AOctave: Integer; APersistence: Double = 0.5): TNoiseArray;

    constructor Create(AWidth, AHeight, AOctave: Integer; APersistence: Double = 0.5);
  end;

implementation

{ TWhiteNoise }

constructor TWhiteNoise.Create(AWidth, AHeight: Integer);
begin
  FNoise:=Next(AWidth, AHeight);
end;

class function TWhiteNoise.Interpolate(AStart, AEnd, AAlpha: Double): Double;
begin
  Result:=AStart * (1 - AAlpha) + AAlpha * AEnd;
end;

function TWhiteNoise.Next(AWidth, AHeight: Integer): TNoiseArray;
var
  I, J: Integer;
begin
  SetLength(Result, AWidth);

  for I := 0 to Length(Result)-1 do
  begin
    SetLength(Result[I], AHeight);

    for J := 0 to Length(Result[I])-1 do
    begin
      Result[I][J] := RandomRange(0, 100) / 100;
    end;
  end;
end;

{ TSmoothNoise }

constructor TSmoothNoise.Create(AWidth, AHeight, AOctave: Integer);
begin
  FNoise:=Next(AWidth, AHeight, AOctave);
end;

function TSmoothNoise.Next(AWidth, AHeight, AOctave: Integer): TNoiseArray;
var
  Base: TNoiseArray;
  I, J, Period: Integer;
  Frequency: Double;
  SampleI0, SampleI1, SampleJ0, SampleJ1: Integer;
  HorizontalBlend, VerticalBlend: Double;
begin
  Base:=inherited Next(AWidth, AHeight);

  Period := 1 shl AOctave;
  Frequency := 1.0 / Period;

  SetLength(Result, AWidth);

  for I := 0 to Length(Result)-1 do
  begin
    SetLength(Result[I], AHeight);

    // Sample Horizontally
    SampleI0 := Trunc(I / Period) * Period;
    SampleI1 := (SampleI0 + Period) mod AWidth; // Wrap Around

    HorizontalBlend := (I - SampleI0) * Frequency;

    for J := 0 to Length(Result[I])-1 do
    begin
      // Sample Vertically
      SampleJ0 := Trunc(J / Period) * Period;
      SampleJ1 := (SampleJ0 + Period) mod AHeight; // Wrap Around

      VerticalBlend := (J - SampleJ0) * Frequency;

      Result[I][J]:=Interpolate(Interpolate(Base[SampleI0][SampleJ0], Base[SampleI1][SampleJ0], HorizontalBlend),
                                Interpolate(Base[SampleI0][SampleJ1], Base[SampleI1][SampleJ1], HorizontalBlend), VerticalBlend);
    end;
  end;
end;

{ TPerlinNoise }

constructor TPerlinNoise.Create(AWidth, AHeight, AOctave: Integer; APersistence: Double = 0.5);
begin
  FNoise:=Next(AWidth, AHeight, AOctave);
end;

function TPerlinNoise.Next(AWidth, AHeight, AOctave: Integer; APersistence: Double = 0.5): TNoiseArray;
var
  I, J, K: Integer;
  Amplitude, TotalAmplitude: Double;
begin
  Amplitude := 1.0;
  TotalAmplitude := 0.0;

  SetLength(Result, AWidth);
  for I := 0 to Length(Result)-1 do
    SetLength(Result[I], AHeight);

  for I := AOctave-1 DownTo 0 do
  begin
    Amplitude := Amplitude / APersistence;

    TotalAmplitude := TotalAmplitude + Amplitude;

    for J := 0 to Length(Result)-1 do
    begin
      for K := 0 to Length(Result[J])-1 do
      begin
        // Generate smooth noise & insert modify with the amplitude to mix into perlin noise.
        Result[J][K] := inherited Next(AWidth, AHeight, I)[J][K] * Amplitude;
      end;
    end;
  end;

  // Normalisation
  for I := 0 to Length(Result)-1 do
  begin
    for J := 0 to Length(Result[I])-1 do
    begin
      Result[I][J] := Result[I][J] / TotalAmplitude;
    end;
  end;
end;

end.
