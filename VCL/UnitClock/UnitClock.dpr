program UnitClock;

uses
  Vcl.Forms,
  UCForm in 'UCForm.pas' {Main},
  UnitCore in 'Units\UnitCore.pas',
  UnitMgr in 'Units\UnitMgr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
