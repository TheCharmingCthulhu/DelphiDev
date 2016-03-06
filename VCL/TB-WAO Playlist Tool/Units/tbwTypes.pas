unit tbwTypes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Win.Registry, System.IniFiles,
  System.Generics.Defaults, System.Generics.Collections, System.Contnrs, System.SyncObjs;

type
  TtbwDJInfo = Record

  End;

  TtbwTrackInfo = Record
    Title: String[255];
    AlbumCover: TBitmap;
    PurchaseLinks: TArray<String>;
  End;

implementation

end.
