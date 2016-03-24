unit xwEngine;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Win.Registry, System.IniFiles, System.Generics.Defaults,
  System.Generics.Collections, System.Contnrs, System.SyncObjs, SfmlSystem, SfmlWindow, SfmlGraphics, xwEngineTypes;

type
  TxwWindow = class
  private
    FTitle: String;
    FVideoMode: TSfmlVideoMode;
    FWindowStyles: TSfmlWindowStyles;
    FRender: TSfmlRenderWindow;
  protected
  public
    constructor Create(const ATitle: String; const AFullscreenMode: Boolean = False);
    destructor Destroy; Override;

    property Render: TSfmlRenderWindow read FRender write FRender;
  end;

  TxwEngineState = (esInitialize, esRunning, esPaused, esFinalize);
  TwxEngine = class
  private
    FGameWindow: TxwWindow;
    FIsRunning: Boolean;
    FState: TxwEngineState;
  protected
    procedure Initialize;
    procedure Finalize;
    procedure Render;
    procedure Shutdown;
  public
    procedure Update;

    constructor Create(const AFramerate: Integer);
    destructor Destroy; Override;

    property IsRunning: Boolean read FIsRunning write FIsRunning;
  end;

implementation

{ TwxEngine }

constructor TwxEngine.Create(const AFramerate: Integer);
begin
  FGameWindow:=TxwWindow.Create(ENGINE_TITLE);
  FGameWindow.FRender.SetFramerateLimit(AFramerate);

  FState:=esInitialize;
  FIsRunning:=True;
end;

destructor TwxEngine.Destroy;
begin

  inherited;
end;

procedure TwxEngine.Finalize;
begin

end;

procedure TwxEngine.Initialize;
begin

end;

procedure TwxEngine.Render;
var
  Event: TSfmlEvent;
begin
  if FGameWindow.FRender.IsOpen then
  begin
    if FGameWindow.FRender.PollEvent(Event) then
    begin
      if Event.EventType = sfEvtClosed then
      begin
        Shutdown;
        Exit;
      end;

      FGameWindow.FRender.Clear;
      FGameWindow.FRender.Display;
    end;
  end;
end;

procedure TwxEngine.Update;
var
  Event: TSfmlEvent;
begin
  case FState of
    esInitialize:
    begin
      Initialize;
      FState:=esRunning;
    end;
    esRunning:
    begin
      Render;
    end;
    esPaused: ;
    esFinalize:
    begin
      Finalize;
      Shutdown;
      Exit;
    end;
  end;
end;

procedure TwxEngine.Shutdown;
begin
  FIsRunning:=False;
end;

{ TxwWindow }

constructor TxwWindow.Create(const ATitle: String; const AFullscreenMode: Boolean = False);
begin
  FTitle:=ATitle;

  FVideoMode.Width:=640;
  FVideoMode.Height:=480;
  FVideoMode.BitsPerPixel:=32;

  FWindowStyles:=[sfTitleBar, sfClose];
  if AFullscreenMode then
    FWindowStyles:=FWindowStyles + [sfFullscreen];

  FRender:=TSfmlRenderWindow.Create(FVideoMode, FTitle, FWindowStyles);
end;

destructor TxwWindow.Destroy;
begin
  FreeAndNil(FRender);

  inherited;
end;

end.
