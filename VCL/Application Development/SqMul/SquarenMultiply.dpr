program SquarenMultiply;

uses
  Vcl.Forms,
  FormSqMul in 'FormSqMul.pas' {FormSquarenMulti},
  smController in 'smController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormSquarenMulti, FormSquarenMulti);
  Application.Run;
end.
