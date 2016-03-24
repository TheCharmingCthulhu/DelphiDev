unit zglGameTypes;

interface

uses
  SysUtils, Classes, zglHeader;

type
  // CLASS FORWARDING
  TzglEvent = class;
  TzglGame = class;
  TzglWindow = class;

  // INTERFACE
  TzglEventHandler = procedure;
  TzglUpdateEventHandler = procedure(dt: Double);
  TzglActivateEventHandler = procedure(activate: Boolean);
  TzglCloseQueryEventHandler = function: Boolean;
  TzglEvent = class(TObject)
  private
    FInit, FLoad, FDraw, FExit, FLoop: TzglEventHandler;
    FUpdate: TzglUpdateEventHandler;
    FActivate: TzglActivateEventHandler;
    FCloseQuery: TzglCloseQueryEventHandler;
  protected
  public
    procedure RegisterEvents;
    procedure UnregisterEvents;

    constructor Create;
    destructor Destroy; Override;

    property OnInit: TzglEventHandler read FInit write FInit;
    property OnLoad: TzglEventHandler read FLoad write FLoad;
    property OnDraw: TzglEventHandler read FDraw write FDraw;
    property OnExit: TzglEventHandler read FExit write FExit;
    property OnLoop: TzglEventHandler read FLoop write FLoop;
    property OnUpdate: TzglUpdateEventHandler read FUpdate write FUpdate;
    property OnActivate: TzglActivateEventHandler read FActivate write FActivate;
    property OnCloseQuery: TzglCloseQueryEventHandler read FCloseQuery write FCloseQuery;
  end;

  TzglSystemResolution = class(TPersistent)
  private
    FDesktopWidth, FDesktopHeight: Integer;
  protected
  public
    property DesktopWidth: Integer read FDesktopWidth;
    property DesktopHeight: Integer read FDesktopHeight;
  end;

  TzglSystemInfo = class(TPersistent)
  private
    FResolution: TzglSystemResolution;
  protected
  public
    function FramesPerSecond: Integer;

    constructor Create;
    destructor Destroy; Override;

    property Resolution: TzglSystemResolution read FResolution write FResolution;
  end;

  TzglGameSettings = class(TObject)
  private
    FClearColorBuffer: Boolean;
    FClearDepthBuffer: Boolean;
    FClearStencilBuffer: Boolean;
    FUseDepthBuffer: Boolean;
    FUseDepthMask: Boolean;
    FUseCorrectResolution: Boolean;
    FUseCorrectWidth, FUseCorrectHeight: Boolean;
    FUseLog: Boolean;
    FUseEnglishInput: Boolean;
    FUseSoundFiles: Boolean;
    FUseDTCorrection: Boolean;
    FPlaySounds: Boolean;
    FAutopauseApp: Boolean;
    FAutoCenterWindow: Boolean;
    FClipInvisibleSprites: Boolean;
    FLogFilename: PAnsiChar;
    function GetSystemInfo: TzglSystemInfo;
    function GetLogFilename: String;
    procedure SetLogFilename(const Value: String);
    procedure InitializeGameSettings;
  protected
  public
    constructor Create;
    destructor Destroy; Override;

    property ClearColorBuffer: Boolean read FClearColorBuffer write FClearColorBuffer;
    property ClearDepthBuffer: Boolean read FClearDepthBuffer write FClearDepthBuffer;
    property ClearStencilBuffer: Boolean read FClearStencilBuffer write FClearStencilBuffer;
    property UseDepthBuffer: Boolean read FUseDepthBuffer write FUseDepthBuffer;
    property UseDepthMask: Boolean read FUseDepthMask write FUseDepthMask;
    property UseCorrectResolution: Boolean read FUseCorrectResolution write FUseCorrectResolution;
    property UseCorrectWidth: Boolean read FUseCorrectWidth write FUseCorrectWidth;
    property UseCorrectHeight: Boolean read FUseCorrectHeight write FUseCorrectHeight;
    property UseLog: Boolean read FUseLog write FUseLog;
    property UseEnglishInput: Boolean read FUseEnglishInput write FUseEnglishInput;
    property UseSoundFiles: Boolean read FUseSoundFiles write FUseSoundFiles;
    property UseDTCorrection: Boolean read FUseDTCorrection write FUseDTCorrection;
    property PlaySounds: Boolean read FPlaySounds write FPlaySounds;
    property AutopauseApp: Boolean read FAutopauseApp write FAutopauseApp;
    property AutoCenterWindow: Boolean read FAutoCenterWindow write FAutoCenterWindow;
    property ClipInvisibleSprites: Boolean read FClipInvisibleSprites write FClipInvisibleSprites;
    property LogFilename: String read GetLogFilename write SetLogFilename;
    property SystemInfo: TzglSystemInfo read GetSystemInfo;
  end;

  TzglGame = class(TObject)
  private
    FName: String;
    FBaseDir: String;
    FGameSettings: TzglGameSettings;
    FWindow: TzglWindow;
    FEngineLoaded: Boolean;

    procedure ValidateGameSettings;
  protected
    procedure Initialize; Virtual;
    procedure Finalize; Virtual;
  public
    procedure SetupWindow(const AWidth, AHeight: Integer; const ARefreshRate: Word; const AFullscreenMode, AVSyncMode: Boolean);
    procedure RunEngine;
    procedure StopEngine;

    constructor Create(const AName: String);
    destructor Destroy; Override;
  end;

  TzglWindow = class(TObject)
  private
    FWidth, FHeight: Integer;
    FRefreshRate: Word;
    FFullscreenMode: Boolean;
    FVSyncMode: Boolean;
  protected
    procedure SetOptions;
  public
    procedure SetCaption(const AName: String);
    procedure ShowCursor(const AEnable: Boolean);

    constructor Create(const AWidth, AHeight: Integer; const ARefreshRate: Word; const AFullscreenMode, AVSyncMode: Boolean); Overload;
    destructor Destroy; Override;

    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property RefreshRate: Word read FRefreshRate write FRefreshRate;
    property HasFullscreenEnabled: Boolean read FFullscreenMode write FFullscreenMode;
    property HasVSyncEnabled: Boolean read FVSyncMode write FVSyncMode;
  end;

implementation

{ TzglWindowManager }

constructor TzglWindow.Create(const AWidth, AHeight: Integer; const ARefreshRate: Word; const AFullscreenMode,
  AVSyncMode: Boolean);
begin
  inherited Create;

  FWidth := AWidth;
  FHeight := AHeight;
  FRefreshRate := ARefreshRate;
  FFullscreenMode := AFullscreenMode;
  FVSyncMode := FVSyncMode;

  SetOptions;
end;

destructor TzglWindow.Destroy;
begin

  inherited;
end;

procedure TzglEvent.RegisterEvents;
begin
  if Assigned(FInit) then
    zgl_Reg(SYS_APP_INIT, @FInit);

  if Assigned(FLoop) then
    zgl_Reg(SYS_APP_LOOP, @FLoop);

  if Assigned(FLoad) then
    zgl_Reg(SYS_LOAD, @FLoad);

  if Assigned(FDraw) then
    zgl_Reg(SYS_DRAW, @FDraw);

  if Assigned(FExit) then
    zgl_Reg(SYS_EXIT, @FExit);

  if Assigned(FUpdate) then
    zgl_Reg(SYS_UPDATE, @FUpdate);

  if Assigned(FActivate) then
    zgl_Reg(SYS_ACTIVATE, @FActivate);

  if Assigned(FCloseQuery) then
    zgl_Reg(SYS_CLOSE_QUERY, @FCloseQuery);
end;

procedure TzglWindow.SetOptions;
begin
  scr_SetOptions(FWidth, FHeight, FRefreshRate, FFullscreenMode, FVSyncMode);
end;

procedure TzglWindow.ShowCursor(const AEnable: Boolean);
begin
  wnd_ShowCursor(AEnable);
end;

procedure TzglWindow.SetCaption(const AName: String);
begin
  wnd_SetCaption(AName);
end;

procedure TzglEvent.UnregisterEvents;
begin
  zgl_Reg(SYS_APP_INIT, nil);
  zgl_Reg(SYS_APP_LOOP, nil);
  zgl_Reg(SYS_LOAD, nil);
  zgl_Reg(SYS_DRAW, nil);
  zgl_Reg(SYS_UPDATE, nil);
  zgl_Reg(SYS_EXIT, nil);
  zgl_Reg(SYS_ACTIVATE, nil);
  zgl_Reg(SYS_CLOSE_QUERY, nil);
end;

{ TzglEventManager }

constructor TzglEvent.Create;
begin
  inherited Create;

end;

destructor TzglEvent.Destroy;
begin

  inherited;
end;

{ TzglGameSettings }

constructor TzglGameSettings.Create;
begin
  inherited Create;

  FAutoCenterWindow := True;
  FUseLog := True;
  FClearColorBuffer := True;
  FClipInvisibleSprites := True;
  FAutopauseApp := True;

  {$IFDEF WINDOWS}
  FUseDTCorrection := True;
  {$ENDIF}
end;

destructor TzglGameSettings.Destroy;
begin

  inherited;
end;

function TzglGameSettings.GetLogFilename: String;
begin
  Result := FLogFilename;
end;

function TzglGameSettings.GetSystemInfo: TzglSystemInfo;
begin
  Result := nil;

  try
    Result := TzglSystemInfo.Create;
    Result.Resolution.FDesktopWidth := zgl_Get(DESKTOP_WIDTH);
    Result.Resolution.FDesktopHeight := zgl_Get(DESKTOP_HEIGHT);
  except
    FreeAndNil(Result);
  end;
end;

procedure TzglGameSettings.InitializeGameSettings;
begin

  if NOT Assigned(FLogFilename) then
  begin
    FLogFilename := PAnsiChar(zgl_Get(LOG_FILENAME));
  end;
end;

procedure TzglGameSettings.SetLogFilename(const Value: String);
begin
  FLogFilename := PAnsiChar(Value);
end;

{ TzglGame }

constructor TzglGame.Create(const AName: String);
begin
  inherited Create;

  FGameSettings := TzglGameSettings.Create;
  FWindow := TzglWindow.Create;

  FName := AName;
end;

destructor TzglGame.Destroy;
begin
  FreeAndNil(FGameSettings);
  FreeAndNil(FWindow);

  inherited;
end;

procedure TzglGame.Finalize;
begin
  inherited;

end;

procedure TzglGame.Initialize;
begin
  // WINDOW SETTINGS
  FWindow.SetCaption(FName);
end;

procedure TzglGame.ValidateGameSettings;
begin
  with FGameSettings do
  begin

    if FClearColorBuffer then
      zgl_Enable(COLOR_BUFFER_CLEAR)
    else
      zgl_Disable(COLOR_BUFFER_CLEAR);

    if FClearDepthBuffer then
      zgl_Enable(DEPTH_BUFFER_CLEAR)
    else
      zgl_Disable(DEPTH_BUFFER_CLEAR);

    if FClearStencilBuffer then
      zgl_Enable(STENCIL_BUFFER_CLEAR)
    else
      zgl_Disable(STENCIL_BUFFER_CLEAR);

    if FUseDepthBuffer then
      zgl_Enable(DEPTH_BUFFER)
    else
      zgl_Disable(DEPTH_BUFFER);

    if FUseDepthMask then
      zgl_Enable(DEPTH_MASK)
    else
      zgl_Disable(DEPTH_MASK);

    if FUseCorrectResolution then
      zgl_Enable(CORRECT_RESOLUTION)
    else
      zgl_Disable(CORRECT_RESOLUTION);

    if FUseCorrectWidth then
      zgl_Enable(CORRECT_WIDTH)
    else
      zgl_Disable(CORRECT_WIDTH);

    if FUseCorrectHeight then
      zgl_Enable(CORRECT_HEIGHT)
    else
      zgl_Disable(CORRECT_HEIGHT);

    if FUseLog then
      zgl_Enable(APP_USE_LOG)
    else
      zgl_Disable(APP_USE_LOG);

    if FUseEnglishInput then
      zgl_Enable(APP_USE_ENGLISH_INPUT)
    else
      zgl_Disable(APP_USE_ENGLISH_INPUT);

    if FUseSoundFiles then
      zgl_Enable(SND_CAN_PLAY_FILE)
    else
      zgl_Disable(SND_CAN_PLAY_FILE);

    if FPlaySounds then
      zgl_Enable(SND_CAN_PLAY)
    else
      zgl_Disable(SND_CAN_PLAY);

    if FAutopauseApp then
      zgl_Enable(APP_USE_AUTOPAUSE)
    else
      zgl_Disable(APP_USE_AUTOPAUSE);

    if FAutoCenterWindow then
      zgl_Enable(WND_USE_AUTOCENTER)
    else
      zgl_Disable(WND_USE_AUTOCENTER);

    if FClipInvisibleSprites then
      zgl_Enable(CLIP_INVISIBLE)
    else
      zgl_Disable(CLIP_INVISIBLE);

    {$IFDEF WINDOWS}
    if FUseDTCorrection then
      zgl_Enable(APP_USE_DT_CORRECTION)
    else
      zgl_Disable(APP_USE_DT_CORRECTION);
    {$ENDIF}
  end;
end;

procedure TzglGame.RunEngine;
begin
  if zglLoad(libZenGL) then
  begin
    FEngineLoaded := True;

    FGameSettings.InitializeGameSettings;
    ValidateGameSettings;

    zgl_Init; // LAUNCH ENGINE

    Initialize; // INITIALIZE ENGINE
  end;
end;

procedure TzglGame.SetupWindow(const AWidth, AHeight: Integer; const ARefreshRate: Word; const AFullscreenMode,
  AVSyncMode: Boolean);
begin
  with FWindow do
  begin
    FWidth := AWidth;
    FHeight := AHeight;
    FRefreshRate := ARefreshRate;
    FFullscreenMode := AFullscreenMode;
    FVSyncMode := AVSyncMode;
  end;
end;

procedure TzglGame.StopEngine;
begin
  if FEngineLoaded then
  begin
    FEngineLoaded := False;

    Finalize;

    zgl_Exit; // SHUTDOWN ENGINE
  end;
end;

{ TzglSystemInfo }

constructor TzglSystemInfo.Create;
begin

end;

destructor TzglSystemInfo.Destroy;
begin

  inherited;
end;

function TzglSystemInfo.FramesPerSecond: Integer;
begin
  Result := zgl_Get(RENDER_FPS);
end;

end.
