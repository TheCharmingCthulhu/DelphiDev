program MinecraftToolkit;

uses
  Vcl.Forms,
  Form_ModdingToolkit in 'Form_ModdingToolkit.pas' {ModdingToolkit},
  Vcl.Themes,
  Vcl.Styles,
  Form_VersionSelector in 'Form_VersionSelector.pas' {VersionSelector},
  MCUnit in 'Units\MCUnit.pas',
  MCModManager in 'Units\MCModManager.pas',
  FastHTTP in '..\..\Units\FastHTTP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TVersionSelector, VersionSelector);
  Application.Run;
end.
