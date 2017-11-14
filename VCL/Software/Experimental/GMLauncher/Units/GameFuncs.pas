unit GameFuncs;

{ Launcher Functions for Garrys Mod }
interface

uses
  System.Classes, System.Variants, System.SysUtils, IniFiles;

const
  mapsFolder: string = 'garrysmod/maps/';
  gmFolder: string = 'garrysmod/gamemodes/';
  maximumPlayers: integer = 32;

var
  settings: TIniFile;

  // Server Info
  serverName: string;
  rconPassword: string;
  map: string;
  gamemode: string;
  authKey: string;
  addonID: string;
  networkMode: integer;
  maxPlayers: integer;
  port: integer;
  useAddons: boolean;
  secured: boolean;

procedure LoadSettings;
procedure SaveSettings;
procedure UnloadSettings;

procedure GetMaps(mapList: TStringList);
procedure GetGamemodes(gmList: TStringList);

implementation

procedure LoadSettings;
begin
    settings := TIniFile.Create(IncludeTrailingPathDelimiter(GetCurrentDir)
     + 'GMLauncherSettings.ini');

    // Server Details
    serverName := settings.ReadString('Server-Settings', 'server_name',
     'Garry'#39's Mod dedicated server');
    rconPassword := settings.ReadString('Server-Settings', 'rcon_password', '');
    map := settings.ReadString('Server-Settings', 'map', 'gm_flatgrass');
    gamemode := settings.ReadString('Server-Settings', 'gamemode', 'sandbox');
    authkey := settings.ReadString('Server-Settings', 'auth_key', '');
    addonID := settings.ReadString('Server-Settings', 'addon_id', '');

    networkMode := settings.ReadInteger('Server-Settings', 'network_mode', 0);
    maxPlayers := settings.ReadInteger('Server-Settings', 'max_players', 32);
    port := settings.ReadInteger('Server-Settings', 'port', 27015);

    secured := settings.ReadBool('Server-Settings', 'vac_secured', true);
    useAddons := settings.ReadBool('Server-Settings', 'use_addons', useAddons);
end;

procedure SaveSettings;
begin
  settings.WriteString('Server-Settings', 'server_name', serverName);
  settings.WriteString('Server-Settings', 'rcon_password', rconPassword);
  settings.WriteString('Server-Settings', 'map', map);
  settings.WriteString('Server-Settings', 'gamemode', gamemode);
  settings.WriteString('Server-Settings', 'auth_key', authKey);
  settings.WriteString('Server-Settings', 'addon_id', addonID);
  settings.WriteInteger('Server-Settings', 'network_mode', networkMode);
  settings.WriteInteger('Server-Settings', 'max_players', maxPlayers);
  settings.WriteInteger('Server-Settings', 'port', port);
  settings.WriteBool('Server-Settings', 'vac_secured', secured);
  settings.WriteBool('Server-Settings', 'use_addons', useAddons);

  settings.UpdateFile;
end;

procedure UnloadSettings;
begin
  FreeAndNil(settings);
end;

procedure GetMaps(mapList: TStringList);
var
  searchRec: TSearchRec;
  fileName: string;
begin
  if FindFirst(mapsFolder + '*.bsp', faAnyFile, searchRec) = 0 then
  begin
    repeat
      fileName := ExtractFileName(searchRec.Name).Replace('.bsp', '');
      mapList.Add(fileName);
    until FindNext(searchRec) <> 0;
  end;
end;

procedure GetGamemodes(gmList: TStringList);
var
  searchRec: TSearchRec;
  dir: string;
begin
  if FindFirst(gmFolder + '*', System.SysUtils.faDirectory, searchRec) = 0 then
  begin
    repeat
      dir := ExtractFileName(searchRec.Name);
      if ExtractFileExt(dir) <> '' then
        continue;

      if (dir <> 'base') and (dir <> '..') and (dir <> '.') then
      begin
        gmList.Add(dir);
      end;
    until FindNext(searchRec) <> 0;
  end;
end;

end.
