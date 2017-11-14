program AHK;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  AHKManager in 'Source\AHKManager.pas';

var
  Thr, Thr2: TAHKThread;

begin
  try
    Thr:=TAHKManager.Instance.NewThread;
    Thr.Run('Test:=LOL');
    Thr.Variable:='Test';
//    Thr.Run('MsgBox %Test%');
//    Thr.Variables['Test']:='LOL';
//    WriteLn(Thr.Variables['Test']);
//
//    Thr2:=TAHKManager.Instance.CreateThread;
//    Thr.Run('MsgBox %Test%');

    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
