program TechnobaseWeAreOnePlaylistTool;

uses
  Vcl.Forms,
  tbMain in 'tbMain.pas' {Main},
  tbwTechnobaseDataProvider in 'Units\tbwTechnobaseDataProvider.pas',
  tbwTypes in 'Units\tbwTypes.pas',
  ccFastHTTPClient in 'E:\Applications\Development\Delphi\Projects\Units\CharmingCthulhu\ccFastHTTPClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
