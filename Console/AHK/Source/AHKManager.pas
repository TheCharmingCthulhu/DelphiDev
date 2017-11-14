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
  TAHKFuncTerminate = function(ATimeout: Integer): Boolean; cdecl;
  
  TAHKManager = class
  private
    FHandle: THandle;
  public
    function NewThread: TAHKThread; Overload;
    function NewThread(AScript: String; AOptions, AParameters: Array of String): TAHKThread; Overload;
    class var Instance: TAHKManager;
    constructor Create;
    destructor Destroy; override;
  end;

  TAHKThread = class(TThread)
  private
    FThread: TAHKFuncThread;
    FThreadReady: TAHKFuncThreadReady;
    FExecute: TAHKFuncExecute;
    FTerminate: TAHKFuncTerminate;
    FGetVariable: TAHKFuncGetVar;
    FSetVariable: TAHKFuncSetVar;
    FScript: String;
    FOptions: TStringList;
    FParameters: TStringList;
    FScripts: TQueue<String>;
    FLastResult: Boolean;
    FVariable: String;
    FResult: String;
    function GetVariable(Name: String): Variant;
    procedure SetVariable(Name: String; const Value: Variant);
  protected
    procedure Execute; override;
  public
    procedure Run(AScript: String);

    constructor Create(AHandle: NativeUInt; AScript: String; AOptions, AParameters: Array of String);
    destructor Destroy; override;

    property LastResult: Boolean read FLastResult;
    property Scripts: TQueue<String> read FScripts;
    property Variable: String read FVariable write FVariable;
    property Result: String read FResult write FResult;
  end;

implementation

{ TAHKManager }

constructor TAHKManager.Create;
begin
  FHandle:=LoadLibrary('AutoHotkey.dll');
end;

destructor TAHKManager.Destroy;
begin
  FreeLibrary(FHandle);

  inherited;
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
    @FTerminate:=GetProcAddress(AHandle, 'ahkTerminate');
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

  FScripts:=TQueue<String>.Create;
end;

destructor TAHKThread.Destroy;
begin
  FreeAndNil(FScripts);
  FreeAndNil(FParameters);
  FreeAndNil(FOptions);

  inherited;
end;

procedure TAHKThread.Execute;
begin
  inherited;

  if FThread(PWideString(FScript), PWideString(FOptions.Text), PWideString(FParameters.Text)) <> 0 then
    while FThreadReady <> 0 do
    begin
      if FScripts.Count > 0 then
        FLastResult:=FExecute(PWideString(FScripts.Dequeue));

      if Trim(FVariable) <> '' then
      begin
        FResult:=String(FGetVariable(PWideString(FVariable), 0));
      end;

      Sleep(25);
    end;
end;

procedure TAHKThread.Run(AScript: String);
begin
  Scripts.Enqueue(AScript);
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
