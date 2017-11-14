program Motomatic;

uses
  Vcl.Forms,
  FormMain in 'FormMain.pas' {FormBase},
  Autohotkey in 'Source\Autohotkey.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormBase, FormBase);
  Application.Run;
end.
