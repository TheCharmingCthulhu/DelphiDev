unit IntelligentParser;

interface

uses
  SysUtils, System.Classes;

procedure ParseBySpace(const str: string; args: TStringList);
procedure Parse(const str: string; args: TStringList);

implementation

procedure ParseBySpace(const str :string; args: TStringList);
var
  I: Integer;
begin
  args.StrictDelimiter := True;
  args.Delimiter := ' ';
  args.DelimitedText := str;

  for I := 0 to args.Count-1 do
  begin
    args[I] := args[I].Trim;
  end;
end;

procedure Parse(const str: string; args: TStringList);
var
  I: Integer;
begin
  args.StrictDelimiter := True;
  args.Delimiter := '-';
  args.DelimitedText := str;

  for I := 0 to args.Count-1 do
  begin
    args[I] := args[I].Trim;
  end;
end;

end.
