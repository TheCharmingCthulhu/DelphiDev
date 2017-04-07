unit AHKManager;

interface

uses
  SysUtils, Variants, Classes, Generics.Collections, Winapi.Windows;

type
  TAHKThread = function(AScript: PWideString; AOptions: PWideString; AParameters: PWideString): THandle; cdecl;
  TAHKThreadReady = function: Integer; cdecl;
  TAHKExecute = function(AScript: PWideString): Boolean; cdecl;
  TAHKGetVar = function(AVariableName: PWideString; AType: LongWord): PWideString; cdecl;

  TAHKManager = class
  private
    FHandle: THandle;
    FThread: TAHKThread;
    FThreadReady: TAHKThreadReady;
    FExecute: TAHKExecute;
    FGetVariable: TAHKGetVar;
    function GetVariable(Name: String): String;
    procedure SetVariable(Name: String; const Value: String);
  public
    constructor Create;
    function Execute(AScript, AOptions, AParameters: String): Boolean; Overload;
    function Execute(AScript: String): Boolean; Overload;
    class var Instance: TAHKManager;

    property Variables[Name: String]: String read GetVariable write SetVariable;
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
    @FThread:=GetProcAddress(FHandle, 'ahkTextDll');
    @FThreadReady:=GetProcAddress(FHandle, 'ahkReady');
    @FExecute:=GetProcAddress(FHandle, 'ahkExec');
    @FGetVariable:=GetProcAddress(FHandle, 'ahkGetVar');
  end;
end;

function TAHKManager.Execute(AScript, AOptions, AParameters: String): Boolean;
var
  Handle: THandle;
  X: Integer;
begin
  Handle:=0;
  Handle:=FThread(nil, nil, nil);
  if Handle <> 0 then
  begin
    if FThreadReady <> 0 then
    begin
      Result:=FExecute(PWideString(AScript));
    end;
  end;
end;

function TAHKManager.Execute(AScript: String): Boolean;
begin
  Execute(AScript, '', '');
end;

function TAHKManager.GetVariable(Name: String): String;
var
  Variable: PWideString;
begin
  Variable:=FGetVariable(PWideString(Name), 0);

  Result:=Copy(String(Variable), 0, Pos(#0, String(Variable))-1);
end;

procedure TAHKManager.SetVariable(Name: String; const Value: String);
begin

end;

initialization
  TAHKManager.Instance:=TAHKManager.Create;

finalization
  FreeAndNil(TAHKManager.Instance);

end.
