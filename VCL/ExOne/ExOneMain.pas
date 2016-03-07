unit ExOneMain;

{$I zglCustomConfig.cfg}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, eoTypes,  Generics.Collections,

  {$IFDEF USE_ZENGL_STATIC}
  zglHeader
  {$ENDIF}
  ;


type
  TMain = class(TForm)
    pViewPort: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FRunning: Boolean;
    FFontList: TList<zglPFont>;

    procedure Initialize;
    procedure InitializeFonts;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

{ Global: Functions / Procedures }
procedure OnInit;
begin
  Main.InitializeFonts;
end;

procedure OnUpdate(dt: Double);
begin
  //Main.Text := Format('%s %.2f', ['Delta Time:', dt]);

  Application.ProcessMessages;
end;

procedure OnDraw;
begin
  //text_Draw(
end;

procedure OnExit;
begin

end;

{ Form: Main }
procedure TMain.FormActivate(Sender: TObject);
begin
  if zglLoad(libZenGL) then
  begin
    FRunning := True;

    // Register Events
    zgl_Reg(SYS_APP_INIT, @OnInit);
    zgl_Reg(SYS_DRAW, @OnDraw);
    zgl_Reg(SYS_UPDATE, @OnUpdate);
    zgl_Reg(SYS_EXIT, @OnExit);

    // Window Settings
    wnd_ShowCursor(True);

    // Screen Setup
    scr_SetOptions(640, 480, REFRESH_MAXIMUM, False, False); // Set Screensize;

    // ZenGL Options
    zgl_InitToHandle( Main.pViewPort.Handle );

    Application.Terminate;
  end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  for I := 0 in FFontList.Count-1 do
  begin
    FFontList[I]
  end;

  FreeAndNil(FFontList);

  if FRunning then
    zgl_Exit();
end;

procedure TMain.Initialize;
begin

end;

procedure TMain.InitializeFonts;
begin

end;

procedure TMain.FormCreate(Sender: TObject);
begin
  FFontList := TList<zglPFont>.Create;

  Initialize;
end;

end.
