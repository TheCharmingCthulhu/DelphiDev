program MVVM;

uses
  Vcl.Forms,
  FormMain in 'FormMain.pas' {MainForm},
  SoundTrack in 'Source\Models\SoundTrack.pas',
  SoundTrackViewModel in 'Source\ViewModels\SoundTrackViewModel.pas',
  MainViewModel in 'Source\ViewModels\MainViewModel.pas',
  FormSoundTrack in 'FormSoundTrack.pas' {SoundTrackForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
