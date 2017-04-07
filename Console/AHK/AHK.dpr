program AHK;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  AHKManager in 'Source\AHKManager.pas';

begin
  try
    TAHKManager.Instance.Execute('Msgbox Hello World');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
