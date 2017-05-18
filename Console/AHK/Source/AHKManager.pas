unit AHKManager;

interface

uses
  SysUtils, Variants, Classes, Generics.Collections, Winapi.Windows;

type
  TAHKThread = class;

  TAHKFuncThread = function(AScript: PWideString; AOptions: PWideString; AParameters: PWideString): THandle; cdecl;
  TAHKFuncThreadReady = function: Integer; cdecl;
  TAHKFuncExecute = function(AScript: PWideString): Boolean; cdecl;
  TAHKFuncGetVar = function(AVariableName: PWideString; AType: LongWord): PWideString; cdecl;
  TAHKFuncSetVar = function(AVariableName: PWideString; AValue: String): Integer; cdecl;
  
  TAHKManager = class
  private
    FHandle: THandle;
  public
    constructor Create;
    function NewThread: TAHKThread; Overload;
    function NewThread(AScript: String; AOptions, AParameters: Array of String): TAHKThread; Overload;
    class var Instance: TAHKManager;
  end;

  TAHKThread = class(TThread)
  private
    FThread: TAHKFuncThread;
    FThreadReady: TAHKFuncThreadReady;
    FExecute: TAHKFuncExecute;
    FGetVariable: TAHKFuncGetVar;
    FSetVariable: TAHKFuncSetVar;
    FScript: String;
    FOptions: TStringList;
    FParameters: TStringList;
    function GetVariable(Name: String): Variant;
    procedure SetVariable(Name: String; const Value: Variant);
  protected
    procedure Execute; override;
  public
    function Run(AScript: String): Boolean;
    
    constructor Create(AHandle: NativeUInt; AScript: String; AOptions, AParameters: Array of String);
    destructor Destroy; override;

    property Variables[Name: String]: Variant read GetVariable write SetVariable;
  end;
  
implementation

{ TAHKManager }

constructor TAHKManager.Create;
begin
  FHandle:=LoadLibrary('AutoHotkey.dll');
end;

function TAHKManager.NewThread(AScript: String; AOptions, AParameters: Array of String): TAHKThread;
begin
  Result:=nil;

  try
    Result:=TAHKThread.Create(FHandle, AScript, AOptions, AParameters);
  except
    FreeAndNil(Result);
  end;
end;

function TAHKManager.NewThread: TAHKThread;
begin
  Result:=NewThread('', [], []);
end;

{ TAHKThread }

constructor TAHKThread.Create(AHandle: NativeUInt; AScript: String; AOptions, AParameters: Array of String);
var
  Str: String;
begin
  inherited Create;

  SetFreeOnTerminate(True);

  if AHandle <> 0 then
  begin
    @FThread:=GetProcAddress(AHandle, 'ahkTextDll');
    @FThreadReady:=GetProcAddress(AHandle, 'ahkReady');
    @FExecute:=GetProcAddress(AHandle, 'ahkExec');
    @FGetVariable:=GetProcAddress(AHandle, 'ahkGetVar');
    @FSetVariable:=GetProcAddress(AHandle, 'ahkAssign');
  end;

  FScript:=AScript;

  FOptions:=TStringList.Create;
  for Str in AOptions do
    FOptions.Add(Str);

  FParameters:=TStringList.Create;
  for Str in AParameters do
    FParameters.Add(Str);
end;

destructor TAHKThread.Destroy;
begin
  FreeAndNil(FParameters);
  FreeAndNil(FOptions);
  
  inherited;
end;

procedure TAHKThread.Execute;
begin
  inherited;

  if FThread(PWideString(FScript), PWideString(FOptions.Text), PWideString(FParameters.Text)) <> 0 then
  begin
    while FThreadReady <> 0 do
    begin
      // Running AHK Thread ;)
    end;
  end;
end;

function TAHKThread.Run(AScript: String): Boolean;
begin
  Result:=FExecute(PWideString(AScript));
end;

function TAHKThread.GetVariable(Name: String): Variant;
var
  Variable: PWideString;
begin
  Variable:=FGetVariable(PWideString(Name), 0);

  Result:=Copy(String(Variable), 0, Pos(#0, String(Variable))-1);
end;

procedure TAHKThread.SetVariable(Name: String; const Value: Variant);
begin
  if FSetVariable(PWideString(Name), VarToStr(Value)) <> 0 then
     FSetVariable(PWideString(Name), '');
end;


initialization
  TAHKManager.Instance:=TAHKManager.Create;

finalization
  FreeAndNil(TAHKManager.Instance);

end.
