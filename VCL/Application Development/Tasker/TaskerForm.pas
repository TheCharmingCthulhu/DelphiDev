unit TaskerForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Managers, Task;

type
  { Client }
  TMain = class(TForm)
    lvTasks: TListView;
    edtMessage: TEdit;
    btnNewTask: TButton;
    edtName: TEdit;
    cboxTaskType: TComboBox;
    procedure btnNewTaskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Initialize;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.btnNewTaskClick(Sender: TObject);
begin
  TTaskManager.GetInstance.NewTask(cboxTaskType.Text, edtName.Text, edtMessage.Text);
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TMain.Initialize;
begin
  cboxTaskType.Items.AddStrings(TTaskManager.GetInstance.GetTaskTypes);
end;

end.
