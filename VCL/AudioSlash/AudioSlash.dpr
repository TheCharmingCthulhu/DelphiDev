program AudioSlash;

uses
  Vcl.Forms,
  AudioSlash_Form in 'AudioSlash_Form.pas' {Main},
  YoutubeAPI in 'Units\YoutubeAPI.pas',
  WinAPIWrapper in '..\..\Units\WinAPIWrapper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
