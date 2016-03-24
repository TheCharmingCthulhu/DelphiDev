program ExOne;

{$APPTYPE GUI} // Hide Console Window (Uses: GUI-Subsystem)

{$R *.res}

uses
  SysUtils,
  zglHeader,
  zglGameTypes in 'Units\zglGameTypes.pas',
  eoMain in 'Units\eoMain.pas';

var
  EventMgr: TzglEvent;
  WindowMgr: TzglWindow;
  GameMgr: TzglGame;

procedure OnInit;
begin

end;

procedure OnDraw;
begin

end;

procedure OnUpdate(dt: Double);
begin

end;

procedure OnExit;
begin
  FreeAndNil(EventMgr);
  FreeAndNil(WindowMgr);
end;

begin
  try
    GameMgr := TzglGame.Create('ExOne');
    GameMgr.SetupWindow(640, 480, REFRESH_MAXIMUM, False, False);
    GameMgr.RunEngine;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

