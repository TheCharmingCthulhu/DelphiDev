unit MainViewModel;

interface

uses
  SysUtils, Variants, Classes, SyncObjs, Generics.Defaults, Generics.Collections, SoundTrack, SoundTrackViewModel;

type
  TMainViewModelHandler = procedure(AItem: TObject) of object;
  TMainViewModel = class
  private
    FTracks: TList<TSoundTrack>;
    FSoundTrackViewModel: TSoundTrackViewModel;

    FOnItemsChanged: TMainViewModelHandler;
  public
    constructor Create;
    destructor Destroy; Override;

    procedure CreateTrack;
    procedure RemoveTrack;

    property OnItemsChanged: TMainViewModelHandler read FOnItemsChanged write FOnItemsChanged;

    property SoundTrackViewModel: TSoundTrackViewModel read FSoundTrackViewModel write FSoundTrackViewModel;
  end;

implementation

{ TMainViewModel }

constructor TMainViewModel.Create;
begin
  FTracks:=TList<TSoundTrack>.Create;
  FSoundTrackViewModel:=TSoundTrackViewModel.Create;
end;

procedure TMainViewModel.CreateTrack;
var
  Track: TSoundTrack;
begin
  Track:=TSoundTrack.Create;
  Track.Assign(FSoundTrackViewModel.SoundTrack);

  FTracks.Add(Track);

  if Assigned(FOnItemsChanged) then FOnItemsChanged(Track);
end;

destructor TMainViewModel.Destroy;
var
  I: Integer;
begin
  FreeAndNil(FSoundTrackViewModel);

  for I := 0 to FTracks.Count-1 do
    FTracks[I].Free;
  FTracks.Clear;
  FreeAndNil(FTracks);

  inherited;
end;

procedure TMainViewModel.RemoveTrack;
begin

end;

end.
