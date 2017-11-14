unit Terminal;

interface

uses
  Winapi.Windows, Winapi.Messages, ShellAPI, ShLWApi,
  System.SysUtils, System.Variants, System.Classes, System.Contnrs,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.MPlayer, Vcl.Tabs, Vcl.DockTabSet,
  WinAPIWrapper, AppSettings,
  IntelligentAI, IntelligentParser;

type
  TMain = class(TForm)
    editTerminal: TEdit;
    memoConsole: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure editTerminalKeyPress(Sender: TObject; var Key: Char);
    procedure editTerminalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FTrayMsg: boolean;
    FTrayIcon: ShellAPI.TNotifyIconData;
    FSlideSpeed: integer;
    FIsHidden: boolean;
    procedure Console_ScrollToEnd;
  public
    { -- Fields -- }
    AIFunctionMode: boolean;

    { -- Properties -- }
    property Hidden: boolean read FIsHidden;

    { -- Custom Functions -- }
    procedure Console_WriteLine(text: string);
    procedure OnHotKeyPress(var Msg:TWMHotKey); message WM_HOTKEY;
    procedure TrayShow(const msg: string);
    procedure TrayHide;
    procedure TrayMessage(var Msg: TMessage); message WM_USER + 100;

    { -- Main Root -- }
    procedure OnRootActivate(Sender: TObject);
    procedure OnRootDeactivate(Sender: TObject);
  end;

  TCommandList = class(TStringList)
    private
      FIndex: integer;
      FMaxItems: integer;
    public
      constructor Create(const maxItems: integer);
      function GetItemUp: string;
      function GetItemDown: string;
  end;
var
  // Forms
  Main: TMain;

  // Vars
  CommandList: TCommandList;
  Root: TApplication;

  // Hotkeys
  hkTerminalTransform: TGlobalHotKey;

  // Settings
  terminalSettings: TSettings;

// -- Terminal Functions
procedure TerminalCallback(var msg:TWMHotkey);
procedure TerminalReset;
procedure TerminalHide;
procedure TerminalShow;

implementation

{$R *.dfm}

uses StringExtensions;

// Hide the terminal.
procedure TerminalHide();
var
  speedLayer: integer;
  sleepTime: integer;
begin
  if Main.FIsHidden = False then
  begin
    // Set top window before hiding, to avoid the dissapearance of the app.
    WinAPIWrapper.SetTopWindow(Main.Handle);
    // Set a speedLayer [1/*] of the height where a speed change will be ocurring.
    speedLayer := -Round(Main.Height / 4);
    sleepTime := 12;

    while not (Main.Top <= -Main.Height) do
    begin
      if (Main.Top < speedLayer * 3) then
      begin
        sleepTime := 9;
      end else if (Main.Top < speedLayer * 2) then
      begin
        sleepTime := 6;
      end else if (Main.Top < speedLayer) then
      begin
        sleepTime := 3;
      end;

      Main.Top := Main.Top - Main.FSlideSpeed;
      Sleep(sleepTime);
    end;

    Main.FIsHidden := True;
    Main.Hide;
    Main.TrayShow('Terminal hidden, application still running.');
  end;
end;

// Show the terminal.
procedure TerminalShow;
begin
  // Show Terminal
  Main.Show;

  // Set the terminal form topMost.
  WinAPIWrapper.SetTopWindow(Main.Handle);

  while not (Main.Top = 0) do
  begin
    Main.Top := Main.Top + Main.FSlideSpeed;
    Sleep(5);
  end;

  // If terminal is called again, activate it, show it and reset it.
  Main.FIsHidden := False;
  Main.TrayHide;

  WinAPIWrapper.SetActiveWindow(Main.Handle);
  TerminalReset;
end;

// Initialize the Terminal.
procedure TerminalInit;
var
  DesktopRes: TResolutionInfo;
  TerminalTHandle: Winapi.Windows.THandle;
begin
  try
    // Initialize TMain's fields.
    Main.FSlideSpeed := 10;
    //Main.FTrayMsg := terminalSettings.Data.ReadBool('Terminal-Settings',
    // 'ShowTrayMsg', True);

    // Always initialize the variables that are created in a code(function)
    // otherwise the computer won't know what the fuck the instance is or means. :)
    TerminalTHandle := 0;

    // Get Current Resolution.
    WinAPIWrapper.GetDesktopResolution(DesktopRes);

    // Set Application's and EditTerminal control's width.
    Main.Width := DesktopRes.Width;
    Main.editTerminal.Width := Main.Width;

    // Hide the Terminal on application start in a new thread. ;)
  finally
    FreeAndNil(DesktopRes);
    FreeAndNil(TerminalTHandle);
  end;
end;

procedure TerminalReset;
begin
  if not StringExtensions.IsStringEmpty(Main.editTerminal.Text) then
  begin
    Main.editTerminal.Clear;
  end;

  Main.editTerminal.Color := clBlack;
end;

procedure LoadTerminalSettings;
begin

end;

// Initializes all the global variables in the form.
procedure GlobalVarsCreate();
begin
  // Create the command list.
  CommandList := TCommandList.Create(10);

  // Initialize Hotkeys
  hkTerminalTransform := TGlobalHotkey.Create('TerminalHotkey');

  // Root Application
  Root := TApplication.Create(Main.Owner);
  Root.OnActivate := Main.OnRootActivate;
  Root.OnDeactivate := Main.OnRootDeactivate;

  // Settings
  terminalSettings := TSettings.Create;
end;

// Free and nil all used variable allocated memory storage places.
procedure GlobalVarsDestroy();
begin
 FreeAndNil(CommandList);
end;

procedure TerminalCallback(var msg:TWMHotkey);
begin
  if Main.FIsHidden = False then
   begin
     TerminalHide;
   end else if Main.FIsHidden = True then
   begin
     TerminalShow;
   end;
end;

// Register new hotkeys in the application.
procedure RegisterHotkeys;
begin
  if not hkTerminalTransform.Registered then
  begin
    hkTerminalTransform.RegisterHotkey(VK_F10,
     Winapi.Windows.MOD_NOREPEAT);

    hkTerminalTransform.Callback := TerminalCallback;
  end;
end;

procedure UnregisterHotkeys;
begin
  if hkTerminalTransform.Registered then
  begin
    hkTerminalTransform.UnregisterHotkey;
    FreeAndNil(hkTerminalTransform);
  end;
end;

{ -- TMain -- }
procedure TMain.OnHotKeyPress(var Msg:TWMHotKey);
begin
   if msg.HotKey = hkTerminalTransform.AtomKeyID then
    begin
      if Assigned(hkTerminalTransform.Callback) then
      begin
        hkTerminalTransform.Callback(msg);
      end;
    end;
end;

procedure TMain.editTerminalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  spaceIndex: integer;
begin
  if Key = VK_UP then
  begin
    Main.editTerminal.Text := CommandList.GetItemDown;
  end else if Key = VK_DOWN then
  begin
    Main.editTerminal.Text := CommandList.GetItemUp;
  end;

  if (Key = VK_UP) or (Key = VK_DOWN) then
  begin
    Main.editTerminal.SelStart := Length(Main.editTerminal.Text);
    Main.editTerminal.SelLength := 0;
  end;

  if (shift = [ssCtrl]) and (Key = VK_BACK) then
  begin
    spaceIndex := LastDelimiter(' ', Main.editTerminal.Text)-1;
    if spaceIndex > -1 then
    begin
      Main.editTerminal.SelStart := spaceIndex;
      Main.editTerminal.SelLength := Length(Main.editTerminal.Text);
      Main.editTerminal.SelText := '';
    end else
    begin
      Main.editTerminal.Clear;
    end;
  end;
end;

procedure TMain.editTerminalKeyPress(Sender: TObject; var Key: Char);
var
  // Allocate memory.
  aiResult: TArtificialResult;
  command: string;
  arguments: TStringList;
begin

  if (Key = #13) and
      (not StringExtensions.IsStringEmpty(Main.editTerminal.Text)) then
  begin
    try
      // Point to the memory storage and use it.
      aiResult := TArtificialResult.Create;
      arguments := TStringList.Create;

      // Add command to the last commandline stack.
      CommandList.Add(Main.editTerminal.Text);
      CommandList.FIndex := CommandList.Count;

      // Parse the command by splitting on spaces and trimming spaces. :)
      IntelligentParser.ParseBySpace(Main.editTerminal.Text, arguments);
      command := arguments[0]; // Set the command
      arguments.Delete(0); // Delete the command.
      // Execute the command with arguments.
      IntelligentAI.TArtificialTerminal.Command(command, arguments, aiResult);

      // Check if the procedure call has been successful.
      if(aiResult.Code = TArtificialState.SUCCESS) then
        begin
          // Write to the Console and scroll to the end.
          Main.Console_WriteLine(aiResult.Value);
          Main.Console_ScrollToEnd;

          // Clear the Terminal.
          Main.editTerminal.Clear;
        end
      else if (aiResult.Code = TArtificialState.MISSING_ARGUMENTS) then
      begin
        Main.Console_WriteLine('Error: Missing Arguments');
        Main.Console_WriteLine('Description:' + aiResult.Value);
        Main.Console_ScrollToEnd;
        exit;
      end else if (aiResult.Code = TArtificialState.ERROR) then
      begin
        Main.Console_WriteLine('Error: ' + aiResult.Value);
        Main.editTerminal.Clear;
        Main.Console_ScrollToEnd;
      end;
    finally
      // Restore memory storage and nil the instances.
      FreeAndNil(aiResult);
      FreeAndNil(arguments);
    end;
  end;
end;

// Scroll the Console to the end.
procedure TMain.Console_ScrollToEnd();
begin
  Main.memoConsole.SelStart := Length(Main.memoConsole.Text);
  Main.memoConsole.SelLength := Length(Main.memoConsole.Text)-1;
end;

// Insert a text with a newline char into the console.
procedure TMain.Console_WriteLine(text: string);
begin
  if not IsStringEmpty(text) then
  begin
    Main.memoConsole.Lines.Text := Main.memoConsole.Lines.Text + '> '
      + text + #13#10;
  end;
end;

// On Creation of the Form;
procedure TMain.FormCreate(Sender: TObject);
begin
  GlobalVarsCreate;
  LoadTerminalSettings;
  TerminalInit;
end;

// On Destroying the Form;
procedure TMain.FormDestroy(Sender: TObject);
begin
  GlobalVarsDestroy;
  UnregisterHotkeys;
end;

procedure TMain.TrayShow(const msg: string);
begin
  FTrayIcon.Wnd := Main.Handle;
  FTrayIcon.cbSize := SizeOf(FTrayIcon);
  FTrayIcon.uID := 0;
  FTrayIcon.uFlags := ShellAPI.NIF_MESSAGE + ShellAPI.NIF_ICON;
  FTrayIcon.uCallbackMessage := WM_USER + 100;
  FTrayIcon.uTimeout := 5000; // 5 Seconds
  FTrayIcon.hIcon := Application.Icon.Handle;
  StrPCopy(FTrayIcon.szInfo, msg);
  ShellAPI.Shell_NotifyIcon(NIM_ADD, @FTrayIcon);
end;

procedure TMain.TrayHide;
begin
  ShellAPI.Shell_NotifyIcon(NIM_DELETE, @FTrayIcon);
end;

procedure TMain.TrayMessage(var Msg: TMessage);
begin
  case Msg.LParam of
    WM_LBUTTONDOWN:
    begin
      if self.FIsHidden then
      begin
        TerminalShow;
      end else if not self.FIsHidden then
      begin
        TerminalHide;
      end;
    end;
  end;
end;

{ -- Root -- }
procedure TMain.OnRootActivate(Sender: TObject);
begin
  RegisterHotkeys;
end;

procedure TMain.OnRootDeactivate(Sender: TObject);
begin
  if Main.AIFunctionMode = False then
  begin
    TerminalHide();
  end;
end;

{ -- TCommandList -- }
constructor TCommandList.Create(const maxItems: integer);
begin
  self.FMaxItems := maxItems;
end;

function TCommandList.GetItemUp;
begin
  if self.Count > 0 then
  begin
    if self.FIndex < self.Count then
    begin
      Inc(self.FIndex);
      result := self[self.FIndex - 1];
    end
  end;
end;

function TCommandList.GetItemDown;
begin
  if self.Count > 0 then
  begin
    if self.FIndex > 0 then
    begin
      Dec(self.FIndex);
      result := self[self.FIndex];
    end;
  end;
end;

end.
