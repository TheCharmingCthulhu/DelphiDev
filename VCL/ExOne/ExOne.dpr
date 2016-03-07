program ExOne;

uses
  Vcl.Forms,
  ExOneMain in 'ExOneMain.pas' {Main},
  eoTypes in 'Units\eoTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
