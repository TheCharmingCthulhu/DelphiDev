program FileLatch;

uses
  Vcl.Forms,
  FileLatchMain in 'FileLatchMain.pas' {Main},
  LatchInvoker in 'LatchInvoker.pas' {LInvoker},
  EncryptionUtils in 'Units\EncryptionUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TLInvoker, LInvoker);
  Application.Run;
end.
