unit Managers;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Generics.Defaults, Generics.Collections, Contnrs, SyncObjs, Task;

type
  { Server }
  TTaskManager = class
  private
    class var FInstance: TTaskManager;

    FTasks: TDictionary<Integer, TTask>;
  public
    procedure NewTask(ATaskType: String; AName: String; AMessage: String);
    function GetTask(AName: String): TTask; Overload;
    function GetTask(AID: Integer): TTask; Overload;
    function GetTaskTypes: TArray<String>;

    constructor Create;
    destructor Destroy; Override;

    class function GetInstance: TTaskManager;
  end;

implementation

{ TTaskManager }

constructor TTaskManager.Create;
begin
  FTasks:=TDictionary<Integer, TTask>.Create;
end;

destructor TTaskManager.Destroy;
begin
  FreeAndNil(FTasks);

  inherited;
end;

function TTaskManager.GetTask(AName: String): TTask;
var
  TaskPair: TPair<Integer, TTask>;
begin
  Result:=Nil;

  for TaskPair in FTasks do
    if TaskPair.Value.Name = AName then
    begin
      Result:=TaskPair.Value;
      Exit;
    end;
end;

class function TTaskManager.GetInstance: TTaskManager;
begin
  if NOT Assigned(FInstance) then
    FInstance:=TTaskManager.Create;

  Result:=FInstance;
end;

function TTaskManager.GetTask(AID: Integer): TTask;
begin
  Result:=FTasks[AID];
end;

function TTaskManager.GetTaskTypes: TArray<String>;
var
  I: Integer;
begin
  SetLength(Result, Length(TASK_TYPES));

  for I := 0 to Length(TASK_TYPES)-1 do
    Result[I]:=TASK_TYPES[I];
end;

procedure TTaskManager.NewTask(ATaskType: String; AName, AMessage: String);
var
  Task: TTask;
begin
  if ATaskType = GetTaskTypes[0] then


  Task.Name:=AName;
  Task.Message:=AMessage;

  FTasks.Add(FTasks.Count, Task);
end;

end.
