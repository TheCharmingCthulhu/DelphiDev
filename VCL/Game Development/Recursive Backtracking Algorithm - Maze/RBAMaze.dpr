program RBAMaze;

uses
  Vcl.Forms,
  RBAMazeForm in 'RBAMazeForm.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
