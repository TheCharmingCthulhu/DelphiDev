unit Form_ModdingToolkit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, JvExComCtrls, JvListView,
  Vcl.StdCtrls, Vcl.Buttons, JvExButtons, JvBitBtn, JvgGroupBox, JvExControls,
  JvLabel, JvExStdCtrls, JvGroupBox, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, JvCombobox,
  MCModManager, MCUnit, FastHTTP,
  JvStatusBar;

type
  TModdingToolkit = class(TForm)
    lvModList: TJvListView;
    gboxMinecraftModList: TJvGroupBox;
    gboxTools: TJvGroupBox;
    lblModName: TJvLabel;
    lblModVersion: TJvLabel;
    lblAuthor: TJvLabel;
    btnDownload: TJvBitBtn;
    cboxModList: TJvComboBox;
    lblModListInfo: TJvLabel;
    btnNextPage: TJvBitBtn;
    btnLastPage: TJvBitBtn;
    sbarMinecraftInfo: TJvStatusBar;
    btnLoad: TJvBitBtn;
    procedure cboxModListChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  private
    FMinecraftInfo: TMinecraftInfo;
    FGameVersionInfo: TGameInfo;
    procedure InitGUI;
  public
    property MinecraftInfo: TMinecraftInfo
      read FMinecraftInfo write FMinecraftInfo;
    property GameVersionInfo: TGameInfo
      read FGameVersionInfo write FGameVersionInfo;
  end;

var
  ModdingToolkit: TModdingToolkit;
implementation

{$R *.dfm}

procedure TModdingToolkit.btnLoadClick(Sender: TObject);
var
  CurseCrawler: TCurseCrawler;
begin
  if cboxModList.Text = MOD_RESOURCES[mrCurse] then
  begin
    try
      CurseCrawler := TCurseCrawler.Create;
      CurseCrawler.CrawlForMods(1);
    finally
      FreeAndNil(CurseCrawler);
    end;
  end;
end;

procedure TModdingToolkit.cboxModListChange(Sender: TObject);
begin
  if cboxModList.ItemIndex <> -1 then
  begin

  end;
end;

procedure TModdingToolkit.FormShow(Sender: TObject);
begin
  InitGUI;
end;

procedure TModdingToolkit.InitGUI;
var
  ModListName: String;
begin
  if Assigned(MinecraftInfo) then
  begin

  end;

  if Assigned(GameVersionInfo) then
  begin
    sbarMinecraftInfo.Panels[1].Text := GameVersionInfo.Version;
  end;

  for ModListName in MOD_RESOURCES do
  begin
    cboxModList.Items.Add(ModListName);
  end;
end;

end.
