program GMLauncher;

uses
  Vcl.Forms,
  Vcl.Themes,
  Classes,
  GMLauncherForm in 'GMLauncherForm.pas' {Main},
  WinAPIWrapper in '..\..\Unit Projects\WinAPIWrapper.pas',
  GameFuncs in 'Units\GameFuncs.pas',
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Smokey Quartz Kamri');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
