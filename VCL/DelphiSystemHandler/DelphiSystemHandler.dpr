program DelphiSystemHandler;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Main},
  dshLibrary in 'Units\dshLibrary.pas',
  dshTypes in 'Units\dshTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
