unit YoutubeAPI;

interface

uses
  SysUtils, Classes, WinAPIWrapper;

type
//  TMediaType = ();

  TVideo = class
  private
    FVideoUrl: string;
  public
    procedure Download;

    constructor Create(const AUrl: string);
    destructor Destroy; override;
  end;

implementation

{ TVideo }

constructor TVideo.Create(const AUrl: string);
begin
  FVideoUrl := AUrl;
end;

destructor TVideo.Destroy;
begin

  inherited;
end;

procedure TVideo.Download;
begin
  RunApplication(GetCurrentDir + '\Bin\youtube_dl.exe', Format('URL %s', [FVideoUrl]));
end;

initialization
  if NOT FileExists(GetCurrentDir + '\Bin\youtube_dl.exe') then
  begin
    raise Exception.Create('Error: youtube_dl.exe is missing from your binaries folder,' + #13#10
        + 'please reinstall or download and extract the youtube_dl.exe into your binaries folder.');
  end;

end.
