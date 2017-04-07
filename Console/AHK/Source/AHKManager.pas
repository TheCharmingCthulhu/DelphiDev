unit AHKManager;

interface

uses
  SysUtils, Variants, Classes, Generics.Collections, Winapi.Windows;

type
  TAHKTextDll = procedure(AScript: PWideString; AOptions: PWideString; AParameters: PWideString); cdecl;

  TAHKManager = class
  private
    FHandle: THandle;
    FTextDll: TAHKTextDll;
  public
    constructor Create;
    procedure Execute(AScript, AOptions, AParameters: String); Overload;
    procedure Execute(AScript: String); Overload;
    class var Instance: TAHKManager;
  end;

implementation

{ TAHKManager }

constructor TAHKManager.Create;
var
  Text: String;
  Data: PAnsiChar;
begin
  FHandle:=LoadLibrary('AutoHotkey.dll');
  if FHandle <> 0 then
  begin
    @FTextDll:=GetProcAddress(FHandle, 'ahktextdll');
  end;
end;

procedure TAHKManager.Execute(AScript, AOptions, AParameters: String);
begin
  FTextDll(PWideString(AScript), PWideString(AOptions), PWideString(AParameters));
end;

procedure TAHKManager.Execute(AScript: String);
begin
  Execute(AScript, '', '');
end;

initialization
  TAHKManager.Instance:=TAHKManager.Create;

finalization
  FreeAndNil(TAHKManager.Instance);

end.
