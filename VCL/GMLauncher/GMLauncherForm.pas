unit GMLauncherForm;

interface

uses
  Winapi.Windows, Winapi.Messages,
  FileCtrl,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  WinAPIWrapper, GameFuncs;

type
  TMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    editServerName: TEdit;
    editUDPPort: TEdit;
    editRCONPassword: TEdit;
    cboxMap: TComboBox;
    cboxNetworkMode: TComboBox;
    cboxMaxPlayers: TComboBox;
    btnRun: TButton;
    Label7: TLabel;
    cboxGamemodes: TComboBox;
    chBoxSecured: TCheckBox;
    procedure btnRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure InitFields();
    procedure SaveFields();
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.InitFields;
var
  mapList: TStringList;
  gmList: TStringList;
  I: integer;
begin
  mapList := TStringList.Create;
  gmList := TStringList.Create;

  try
    // Init Settings INI
    GameFuncs.LoadSettings;

    // Set Server Description
    Main.editServerName.Text := GameFuncs.serverName;
    
    // Init Game Maps
    GameFuncs.GetMaps(mapList);
    if mapList.Count > 0 then
    begin
      Main.cboxMap.Items.AddStrings(mapList);
      Main.cboxMap.ItemIndex := Main.cboxMap.Items.IndexOf(GameFuncs.map);
    end else
    begin
      raise Exception.Create('Error: ' + 'No maps have been found.');
    end;

    // Init Network Modes
    Main.cboxNetworkMode.Items.Add('Internet');
    Main.cboxNetworkMode.Items.Add('LAN');
    Main.cboxNetworkMode.ItemIndex := GameFuncs.networkMode;

    // Init Max Player Count;
    for I := 1 to GameFuncs.maximumPlayers do
    begin
      Main.cboxMaxPlayers.Items.Add(I.ToString());
    end;

    // Selected Max Player Count
    Main.cboxMaxPlayers.ItemIndex := GameFuncs.maxPlayers - 1;

    // Load Gamemodes
    GameFuncs.GetGamemodes(gmList);
    if gmList.Count > 0 then
    begin
      Main.cboxGamemodes.Items.AddStrings(gmList);
      Main.cboxGamemodes.ItemIndex :=
       Main.cboxGamemodes.Items.IndexOf(GameFuncs.gamemode);
    end else
    begin
      raise Exception.Create('Error: ' + 'No gamemodes have been found.');
    end;

    // Set RCON Password
    Main.editRCONPassword.Text := GameFuncs.rconPassword;

    // Set UDP Port
    Main.editUDPPort.Text := GameFuncs.port.ToString();

    // Set VAC Status
    Main.chBoxSecured.Checked := GameFuncs.secured;

  finally
    FreeAndNil(mapList);
    FreeAndNil(gmList);
  end;
end;


procedure TMain.btnRunClick(Sender: TObject);
var
  targetWin: Winapi.Windows.HWND;
  args: string;
  pArgs: PChar;
begin
  targetWin := WinAPIWrapper.GetActiveWindow;

  args := Format('-console -game "%0:s" +map "%1:s" +maxplayers %2:d' +
   '+gamemode "%3:s" +rcon %4:s +port %5:d +hostname "%6:s"',
     ['garrysmod', Main.cboxMap.Text,
      StrToInt(Main.cboxMaxPlayers.Text), Main.cboxGamemodes.Text,
      Main.editRCONPassword.Text, StrToInt(Main.editUDPPort.Text),
      Main.editServerName.Text]);

  GetMem(pArgs, Length(args) * SizeOf(string));
  StringToWideChar(args, pArgs, Length(args) * SizeOf(string));

  // Launch the application, save settings, free the memory.
  WinAPIWrapper.RunApplication(targetWin, 'srcds.exe', pArgs);
  Main.SaveFields;
  FreeMem(pArgs);
end;

procedure TMain.SaveFields;
begin
  // Set all the fields first.
  GameFuncs.serverName := Main.editServerName.Text;
  GameFuncs.rconPassword := Main.editRCONPassword.Text;
  GameFuncs.map := Main.cboxMap.Text;
  GameFuncs.gamemode := Main.cboxGamemodes.Text;
  GameFuncs.networkMode := Main.cboxNetworkMode.ItemIndex;
  GameFuncs.maxPlayers := StrToInt(Main.cboxMaxPlayers.Text);
  GameFuncs.port := StrToInt(Main.editUDPPort.Text);
  GameFuncs.secured := Main.chBoxSecured.Checked;

  // Save it.
  GameFuncs.SaveSettings;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  InitFields();
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  Main.SaveFields;
  GameFuncs.UnloadSettings;
end;

end.
