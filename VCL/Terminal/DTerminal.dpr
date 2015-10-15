program DTerminal;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Terminal in 'Terminal.pas' {Main},
  IntelligentAI in 'Units\IntelligentAI.pas',
  IntelligentParser in 'Units\IntelligentParser.pas',
  AppSettings in '..\..\Units\AppSettings.pas',
  StringExtensions in '..\..\Units\StringExtensions.pas',
  WinAPIWrapper in '..\..\Units\WinAPIWrapper.pas';

{$R *.res}

begin
  TStyleManager.TrySetStyle('Carbon');
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
