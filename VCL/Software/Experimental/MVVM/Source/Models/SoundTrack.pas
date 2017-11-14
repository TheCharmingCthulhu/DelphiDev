unit SoundTrack;

interface

uses
  SysUtils, Variants, Classes, SyncObjs, Generics.Defaults, Generics.Collections;

type
  TSoundTrack = class(TPersistent)
  private
    FTitle: String;
    FArtist: String;
    FAlbum: String;
    FDuration: Integer;
    FDate: TDateTime;
    function GetDuration: String;
    procedure SetDuration(const Value: String);
    function GetDate: String;
    procedure SetDate(const Value: String); Overload;
  public
    procedure Assign(Source: TPersistent); override;
    procedure AssignDate(const Value: TDate); Overload;

    property Title: String read FTitle write FTitle;
    property Artist: String read FArtist write FArtist;
    property Album: String read FAlbum write FAlbum;
    property Duration: String read GetDuration write SetDuration;
    property Date: String read GetDate write SetDate;
  End;

implementation

{ TSoundTrack }

procedure TSoundTrack.Assign(Source: TPersistent);
begin
  if Source is TSoundTrack then
  begin
    FTitle:=TSoundTrack(Source).Title;
    FArtist:=TSoundTrack(Source).Artist;
    FAlbum:=TSoundTrack(Source).Album;
    SetDuration(TSoundTrack(Source).Duration);
    SetDate(TSoundTrack(Source).Date);
  end;
end;

function TSoundTrack.GetDate: String;
begin
  Result:=DateToStr(FDate);
end;

function TSoundTrack.GetDuration: String;
begin
  Result:=IntToStr(FDuration);
end;

procedure TSoundTrack.SetDate(const Value: String);
begin
  FDate:=StrToDateDef(Value, Now);
end;

procedure TSoundTrack.AssignDate(const Value: TDate);
begin
  FDate:=Value;
end;

procedure TSoundTrack.SetDuration(const Value: String);
begin
  FDuration:=StrToIntDef(Value, 0);
end;

end.
