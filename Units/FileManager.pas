unit FileManager;

interface

uses
  SysUtils, IOUtils, Winapi.Windows, Classes, Types;

type
  TEagleThreadHandler = procedure(AFileList: TStringList) of object;
  TEagleThread = class(TThread)
  private
    FNotificationHandle: THandle;
    FPath: string;
    FEagleSharped: Boolean;
    FFileList: TStringList;
    FOnNotification: TEagleThreadHandler;
  protected
    procedure Execute; override;
    function CheckDirectory: Integer; // RETURNS FILE COUNT;
  public
    constructor Create(var APath: String);
    destructor Destroy; override;
  end;

  TEagleEye = class(TObject)
  private
    FPath: String;
    FEagle: TEagleThread;
    
    function GetOnFileFound: TEagleThreadHandler;
    procedure SetOnFileFound(const AValue: TEagleThreadHandler);
    
  public
    constructor Create(const APath: String;
      const ARecursiveMode: Boolean = False);
    destructor Destroy; override;

    property OnFileFound: TEagleThreadHandler 
      read GetOnFileFound write SetOnFileFound;
  end;

implementation

{ TFileManager }

constructor TEagleEye.Create(const APath: String;
  const ARecursiveMode: Boolean = False);
begin
  if NOT DirectoryExists(APath) then
  begin
    ForceDirectories(APath);
  end;

  FPath := APath;

  FEagle := TEagleThread.Create(FPath);
  FEagle.Start;
end;

destructor TEagleEye.Destroy;
begin
  FreeAndNil(FEagle);
  
  inherited;
end;

function TEagleEye.GetOnFileFound: TEagleThreadHandler;
begin
  Result := FEagle.FOnNotification;
end;

procedure TEagleEye.SetOnFileFound(const AValue: TEagleThreadHandler);
begin
  FEagle.FOnNotification := AValue;
end;

{ TEagleThread }

function TEagleThread.CheckDirectory: Integer;
var
  FileList: TStringDynArray;
  I: Integer;
begin
  FFileList.Clear;

  FileList := TDirectory.GetFiles(FPath, '*.*', TSearchOption.soAllDirectories);
  for I := 0 to Length(FileList)-1 do
  begin
    FFileList.Add(ExtractFileName(FileList[I]));
  end;
end;

constructor TEagleThread.Create(var APath: String);
begin
  inherited Create(true);

  FEagleSharped := True;
  FPath := APath;
  FFileList := TStringList.Create;
  
  FNotificationHandle := FindFirstChangeNotification(PChar(APath), True,
    FILE_NOTIFY_CHANGE_FILE_NAME OR
    FILE_NOTIFY_CHANGE_DIR_NAME OR
    FILE_NOTIFY_CHANGE_CREATION);
end;

destructor TEagleThread.Destroy;
begin
  FindCloseChangeNotification(FNotificationHandle);

  FFileList.Clear;
  FreeAndNil(FFileList);

  inherited;
end;

procedure TEagleThread.Execute;
var
  WAIT_STATE: Cardinal;
begin
  WAIT_STATE := 1;
  
  // LOOP FOR FILE CHANGE NOTIFICATIONS UNTIL THE EAGLE LOST ITS SHARPED ABILITY
  while (FEagleSharped) do
  begin
    case WAIT_STATE of
      WAIT_ABANDONED:
      begin

      end;

      WAIT_OBJECT_0:
      begin
        CheckDirectory();
        if Assigned(FOnNotification) then
           Synchronize(nil, procedure begin
              FOnNotification(FFileList);
           end);

        FindNextChangeNotification(FNotificationHandle);
      end;

      1:
      begin
        if CheckDirectory > 0 then
        begin
          if Assigned(FOnNotification) then
             Synchronize(nil, procedure begin
                FOnNotification(FFileList);
             end);
        end;
      end;
      
      WAIT_FAILED:
      begin
        raise Exception.Create('Error: ' + GetLastError.ToString);
      end;
    end;

    WAIT_STATE := WaitForSingleObject(FNotificationHandle, INFINITE);
  end;
end;

end.
