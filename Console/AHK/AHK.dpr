program AHK;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  AHKManager in 'Source\AHKManager.pas';

var
  I:Integer;
  Data: String;

begin
  try

    for I := 0 to 100 do
    begin
      TAHKManager.Instance.Execute('Dick:=10 + 5');
      Data:=TAHKManager.Instance.Variables['Dick'];

      WriteLn(Data);
    end;

    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
