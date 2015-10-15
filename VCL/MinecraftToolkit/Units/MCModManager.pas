unit MCModManager;

interface

uses
  SysUtils, Classes, RegularExpressions, Generics.Collections,
  FastHTTP;

type
  TModResources = (
    mrCurse
  );

  TModCrawler = class
  private
    FClient: TFastHTTPClient;
  public
    procedure CrawlForMods(const APageID: Integer); virtual; abstract;

    constructor Create;
    destructor Destroy; override;
  end;

  TCurseModItem = record
    URL: String;
    Name: String;
    AverageDownloads: Extended;
    TotalDownloads: Extended;
    LastUpdate: TDate;
    CreatedOn: TDate;
    Likes: Extended;
    Versions: Array of String;
  end;

  TCurseCrawler = class(TModCrawler)
  private
    FModList: TList<TCurseModItem>;
    const
      FModListUrl: String = 'http://www.curse.com/mc-mods/minecraft?page=';
  public
    procedure CrawlForMods(const APageID: Integer); reintroduce;

    constructor Create;
    destructor Destroy; override;
  end;

const
  MOD_RESOURCES: Array[TModResources] of String =
  ('http://www.curse.com');

implementation

{ TCurseCrawler }

constructor TCurseCrawler.Create;
begin
  inherited Create;

end;

destructor TCurseCrawler.Destroy;
begin

  inherited;
end;

procedure TCurseCrawler.CrawlForMods(const APageID: Integer);
var
  RegEx: TRegEx;
  ModListItems: TMatchCollection;
  ModItems: TMatchCollection;
  WebResponse: String;
  I: Integer;
begin
  WebResponse := FClient.Get(FModListUrl + APageID.ToString);

  RegEx.Create('(?s)<ul class="group">(.*?)<\/ul>');
  if RegEx.IsMatch(WebResponse) then
  begin
    ModListItems := RegEx.Matches(WebResponse);

    RegEx.Create('>([A-z0-9, .]{1,})<|href="([A-z\/-]{1,})"');
    for I := 0 to ModListItems.Count-1 do
    begin
      if RegEx.IsMatch(ModListItems.Item[I].Value) then
      begin
        ModItems := RegEx.Matches(ModListItems.Item[I].Value);


      end;
    end;
  end;
end;

{ TModCrawler }

constructor TModCrawler.Create;
begin
  inherited Create;

  FClient := TFastHTTPClient.Create;
end;

destructor TModCrawler.Destroy;
begin
  FreeAndNil(FClient);

  inherited;
end;

end.
