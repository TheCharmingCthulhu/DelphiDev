unit tbwTechnobaseDataProvider;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Win.Registry, System.IniFiles,
  System.Generics.Defaults, System.Generics.Collections, System.Contnrs, System.SyncObjs, ccFastHttpClient, tbwTypes;

type
  TtbwTracklistProvider = class;
  TtbwDJProvider = class;

  TtbwTechnobaseFM = class(TObject)
  private
    FTracklistProvider: TtbwTracklistProvider;
  protected
  public
    constructor Create;
    destructor Destroy; Override;

    property TracklistProvider: TtbwTracklistProvider read FTracklistProvider;
  end;

  TtbwTracklistProvider = class(TObject)
  private
    FHttpClient: TFastHttpClient;
  protected
  public
    function FetchTrackList: TArray<TtbwTrackInfo>;

    constructor Create;
    destructor Destroy; Override;
  end;

  TtbwDJProvider = class(TObject)
  private
  protected
  public
  end;

implementation

{ TtbwTechnobaseFM }

constructor TtbwTechnobaseFM.Create;
begin
  FTracklistProvider := TtbwTracklistProvider.Create;
end;

destructor TtbwTechnobaseFM.Destroy;
begin
  FreeAndNil(FTracklistProvider);

  inherited;
end;

{ TtbwTracklistProvider }

constructor TtbwTracklistProvider.Create;
begin
  inherited Create;

  FHttpClient := TFastHTTPClient.Create;
end;

destructor TtbwTracklistProvider.Destroy;
begin
  FreeAndNil(FHttpClient);

  inherited;
end;

function TtbwTracklistProvider.FetchTrackList: TArray<TtbwTrackInfo>;
begin

end;

end.
