unit SoundTrackViewModel;

interface

uses
  SysUtils, Variants, Classes, SyncObjs, Generics.Defaults, Generics.Collections, SoundTrack;

type
  TSoundTrackViewModel = class
  private
    FSoundTrack: TSoundTrack;
  public
    property SoundTrack: TSoundTrack read FSoundTrack write FSoundTrack;

    constructor Create;
    destructor Destroy; Override;
  end;

implementation

{ TSoundTrackViewModel }

constructor TSoundTrackViewModel.Create;
begin
  FSoundTrack:=TSoundTrack.Create;
end;

destructor TSoundTrackViewModel.Destroy;
begin
  FreeAndNil(FSoundTrack);

  inherited;
end;

end.
