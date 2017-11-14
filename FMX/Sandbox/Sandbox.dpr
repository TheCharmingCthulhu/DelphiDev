program Sandbox;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormSandbox in 'FormSandbox.pas' {frmSandbox},
  sboxControls in 'Src\sboxControls.pas',
  sboxListbox in 'Src\sboxListbox.pas' {FrameListbox: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSandbox, frmSandbox);
  Application.Run;
end.
