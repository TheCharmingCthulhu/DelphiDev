program Noise;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  NoiseUtilities in 'Source\NoiseUtilities.pas';

var
  I, J: Integer;
  PerlinNoise: TPerlinNoise;
  Tiles: Array of Integer;
begin
  try
    try
      SetLength(Tiles, 10);
      for I := 0 to Length(Tiles)-1 do
        Tiles[I] := I+1;

      PerlinNoise:=TPerlinNoise.Create(50, 50, 2);

      for I := 0 to Length(PerlinNoise.Noise)-1 do
      begin
        for J := 0 to Length(PerlinNoise.Noise[I])-1 do
        begin
          WriteLn(StringOfChar('x', Trunc(TPerlinNoise.Interpolate(Tiles[0], Tiles[Length(Tiles)-1], PerlinNoise.Noise[I][J]))));
        end;
      end;
    finally
      FreeAndNil(PerlinNoise);
    end;

    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
