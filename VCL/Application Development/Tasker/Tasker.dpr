program Tasker;

uses
  Vcl.Forms,
  TaskerForm in 'TaskerForm.pas' {Main},
  Task in 'Src\Models\Task.pas',
  Managers in 'Src\Managers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
