unit Autohotkey;

interface

uses
  SysUtils, Variants, Classes, SyncObjs, Generics.Defaults, Generics.Collections, Windows;

type
  TAhkText = function(AScript: LPTSTR; AParameter1: LPTSTR; AParameter2: LPTSTR): UINT; cdecl;

const
  AUTOHOTKEY_DLL = 'AutoHotkey.dll';

type
  TAutohotkeyEngine = class
  private
    FEngine: THandle;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TAutohotkeyEngine }

constructor TAutohotkeyEngine.Create;
var
  ATest: TAhkText;
begin
  FEngine:=LoadLibrary(AUTOHOTKEY_DLL);
  @ATest:=GetProcAddress(FEngine, 'ahkdll');
  ATest('', '', '');
end;

destructor TAutohotkeyEngine.Destroy;
begin
  FreeLibrary(FEngine);

  inherited;
end;

end.
