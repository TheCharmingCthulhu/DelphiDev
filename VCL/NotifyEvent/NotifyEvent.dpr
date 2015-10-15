program NotifyEvent;

uses
  Vcl.Forms,
  NotifyEventForm in 'NotifyEventForm.pas' {NotifyForm},
  NotifyExample in 'NotifyExample.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TNotifyForm, NotifyForm);
  Application.Run;
end.
