program Canvas;

uses
  Vcl.Forms,
  FormMain in 'FormMain.pas' {Main},
  FormTimebar in 'FormTimebar.pas' {Timebar},
  ucTimebar in 'Source\Controls\ucTimebar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TTimebar, Timebar);
  Application.Run;
end.
