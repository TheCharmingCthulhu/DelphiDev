unit Task;

interface

type
  TTaskType = class of TTask;

  { Model / Item }
  TTask = class
  private
    FID: Integer;
    FName, FMessage: String;
  public
    property ID: Integer read FID write FID;
    property Name: String read FName write FName;
    property Message: String read FMessage write FMessage;
  end;

  TTaskWarning = class(TTask)

  end;

  TTaskCritical = class(TTask)

  end;

  TTaskDefault = class(TTask)

  end;

  TTaskLow = class(TTask)

  end;

const
  TASK_TYPES: Array[0..3] of String = ('Warning', 'Critical', 'Default', 'Low');

implementation

end.
