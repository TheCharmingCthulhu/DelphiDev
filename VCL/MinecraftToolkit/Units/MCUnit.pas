unit MCUnit;

interface

uses
  SysUtils, Classes, Windows, IOUtils, RegularExpressions,
  FastHTTP;

var
  APPDATA_PATH: String;

type
  TMinecraftInfo = class
  private
    FInstalledVersions: TStringList;
    FGamePath: String;
  public
    procedure CheckInstalledVersions;
  
    constructor Create;
    destructor Destroy; override;

    property GamePath: String read FGamePath write FGamePath;
    property Versions: TStringList read FInstalledVersions;
  end;

  TGameInfo = class
  private
    FMinecraftVersions: TStringList;
    FVersion: String;
    FModded: Boolean;

    function IsGameModded(const AGameVersion: String): Boolean;
    function IsValidMinecraftVersion(const AVersion: String): Boolean;
  public
    procedure GetMinecraftVersions;
    procedure SetMinecraftVersion(const AGameVersion: String);

    constructor Create;
    destructor Destroy; override;

    property Version: String read FVersion;
    property Modded: Boolean read FModded write FModded;
  end;

  TModdedVersions = (mvForgeModLoader);

const
  INSTALLED_GAME_VERSIONS_PATH: String = '.minecraft\versions\';
  MODDED_VERSIONS: Array[TModdedVersions] of String = ('Forge Mod Loader');
    
implementation

{ TMinecraftInfo }

procedure TMinecraftInfo.CheckInstalledVersions;
var
  VersionRecord: TSearchRec;
begin
  if FindFirst(FGamePath, faDirectory, VersionRecord) = 0 then
  begin
      repeat
        if (VersionRecord.Name <> '.') AND (VersionRecord.Name <> '..') then
        begin
          // ON MODDED VERSIONS FOUND
          if Pos('Forge', VersionRecord.Name) <> 0 then
          begin
            FInstalledVersions.Add('Forge Mod Loader - ' +
              Copy(VersionRecord.Name, 0, Pos('-Forge', VersionRecord.Name)-1));
          end else // VANILLA VERSIONS FOUND
          begin
            FInstalledVersions.Add('Minecraft - ' + VersionRecord.Name);
          end;
        end;
      until FindNext(VersionRecord) <> 0;
  end;
end;

constructor TMinecraftInfo.Create;
begin
  inherited Create;
  FInstalledVersions := TStringList.Create;

  FGamePath := GetEnvironmentVariable('appdata') + '\' + 
    INSTALLED_GAME_VERSIONS_PATH + '*';

  CheckInstalledVersions;
end;

destructor TMinecraftInfo.Destroy;
begin
  FInstalledVersions.Clear;
  FreeAndNil(FInstalledVersions);

  inherited;
end;

{ TMinecraftVersionInfo }

function TGameInfo.IsGameModded(const AGameVersion: String): Boolean;
var
  GameName: String;
  ModName: String;
begin
  GameName := Copy(AGameVersion, 0, Pos('-', AGameVersion)-2);

  for ModName in MODDED_VERSIONS do
  begin
    if ModName = GameName then
    begin
      Result := True;
      Break;
    end else
      Result := False;
  end;
end;

function TGameInfo.IsValidMinecraftVersion(const AVersion: String):
  Boolean;
begin
  if Pos(AVersion, FMinecraftVersions.Text) <> 0 then
  begin
    Result := True;
  end else
    Result := False;
end;

constructor TGameInfo.Create;
begin
  inherited Create;
  FMinecraftVersions := TStringList.Create;

  GetMinecraftVersions; // DOWNLOAD MINECRAFT VERSIONS.
end;

destructor TGameInfo.Destroy;
begin
  FreeAndNil(FMinecraftVersions);
  inherited;
end;

procedure TGameInfo.GetMinecraftVersions;
var
  VersionRetriever: TFastHTTPClient;
  Response, VersionName, Version: String;
  RegEx: TRegEx;
  VersionMatches: TMatchCollection;
  I: Integer;
begin
  try
    VersionRetriever := TFastHTTPClient.Create;
    Response := VersionRetriever.Get('https://mcversions.net/');

    RegEx.Create('<h3>([A-z0-9.]*?)<\/h3>'); // RETRIEVES VERSIONS
    if RegEx.IsMatch(Response) then
    begin
      VersionMatches := RegEx.Matches(Response);

      for I := 0 to VersionMatches.Count-1 do
      begin
        Version := VersionMatches.Item[I].Groups.Item[1].Value;

        RegEx.Create('[0-9]*\.[0-9]*\.[0-9]*|[0-9]*\.[0-9]*');  // STABLE VERSIONS
        if RegEx.IsMatch(Version) then
        begin
          VersionName := 'Stable Release';
        end;

        RegEx.Create('[0-9]*[a-z][0-9]*[a-z]'); // BETA VERSIONS
        if RegEx.IsMatch(Version) then
        begin
          VersionName := 'Snapshot Build';
        end;

        RegEx.Create('b[A-z0-9.]{1,}'); // ALPHA VERSIONS
        if RegEx.IsMatch(Version) then
        begin
          VersionName := 'Beta Build';
        end;

        RegEx.Create('[ac][A-z0-9.]{1,}'); // VERY EARLY MINECRAFT VERSIONS
        if RegEx.IsMatch(Version) then
        begin
          VersionName := 'Alpha Build';
        end;

        FMinecraftVersions.Values[VersionMatches.Item[I].Groups.Item[1].Value] :=
          VersionName;
      end;
    end;
  finally
    FreeAndNil(VersionRetriever);
  end;
end;

procedure TGameInfo.SetMinecraftVersion(const AGameVersion: String);
var
  Version: String;
begin
  if Pos('-', AGameVersion) <> 0 then
  begin
    Version := Copy(AGameVersion,
      AGameVersion.IndexOf('-') + 3,
      Length(AGameVersion) - AGameVersion.IndexOf('-') + 3);

    if IsValidMinecraftVersion(Version) then
    begin
      FModded := IsGameModded(AGameVersion);
      FVersion := Version;
    end;
  end else
  begin
    raise Exception.Create('Error: Invalid Minecraft Version Format.' + #13#10 +
                           'Example: <Name> - <Version> | Forge Mod Loader - 1.7.10');
  end;
end;

initialization
begin
  APPDATA_PATH := GetEnvironmentVariable('appdata') + '\MinecraftToolkit';
  if NOT DirectoryExists(APPDATA_PATH) then
  begin
    ForceDirectories(APPDATA_PATH);
  end;
end;

end.
