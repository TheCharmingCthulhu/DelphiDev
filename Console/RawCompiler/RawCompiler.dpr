program RawCompiler;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  rawInterpreter in 'Src\rawInterpreter.pas',
  rawGenerator in 'Src\rawGenerator.pas',
  rawTypes in 'Src\rawTypes.pas';

var
  RawInterpreter: TrawBasicInterpreter;

begin
  try
    RawInterpreter.ParseLine('begin\n\r\n\rend;');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
