unit rawInterpreter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Win.Registry, System.IniFiles,
  System.Generics.Defaults, System.Generics.Collections, System.Contnrs, System.SyncObjs, rawTypes;

type
  TrawSyntaxAspect = class
  private
  protected
  public
  end;

  TrawSymbol = class
  private
  protected
  public
  end;

  TrawKeywordHandler = procedure(AKeyword: String) of object;
  TrawKeyword = class
  private
    FKeyword: String;
    FOnKeyword: TrawKeywordHandler;
  protected
  public
    property OnKeyword: TrawKeywordHandler read FOnKeyword write FOnKeyword;
  end;

  TrawInterpreterClass = class of TrawInterpreter;
  TrawInterpreter = class
  private
    FSyntax: TrawSyntaxAspect;
    FKeywords: TList<TrawKeyword>;
  protected
  public
    function ParseLine(const ALine: String): Boolean; Virtual; Abstract;

    constructor Create; Virtual;
    destructor Destroy; Override;
  end;

  TrawTextInterpreter = class(TrawInterpreter)
  private
  protected
  public
    class function CreateNewKeyword(const AKeyword: String): TrawKeyword;
  end;

  TrawSymbolicInterpreter = class(TrawInterpreter)
  private
    FSymbols: TList<TrawSymbol>;
  protected
  public
    constructor Create; Override;
    destructor Destroy; Override;
  end;

  TrawBasicInterpreter = class(TrawTextInterpreter)
  private
  protected
  public
    constructor Create; Override;
    destructor Destroy; Override;

    function ParseLine(const ALine: string): Boolean; override;
  end;

implementation

{ TrawInterpreter }

constructor TrawInterpreter.Create;
begin
  inherited Create;

  FKeywords:=TList<TrawKeyword>.Create;
end;

destructor TrawInterpreter.Destroy;
var
  I: Integer;
begin
  for I := 0 to FKeywords.Count-1 do
    FKeywords[I].Free;
  FKeywords.Clear;
  FreeAndNil(FKeywords);

  inherited;
end;

{ TrawBasicInterpreter }

constructor TrawBasicInterpreter.Create;
begin
  inherited Create;

  FKeywords.Add(CreateNewKeyword('begin'));
end;

destructor TrawBasicInterpreter.Destroy;
begin

  inherited;
end;

function TrawBasicInterpreter.ParseLine(const ALine: string): Boolean;
begin

end;

{ TrawSymbolicInterpreter }

constructor TrawSymbolicInterpreter.Create;
begin
  inherited Create;
  FSymbols:=TList<TrawSymbol>.Create;
end;

destructor TrawSymbolicInterpreter.Destroy;
var
  I: Integer;
begin
  for I := 0 to FSymbols.Count-1 do
    FSymbols[I].Free;
  FSymbols.Clear;
  FreeAndNil(FSymbols);

  inherited;
end;

{ TrawTextInterpreter }

class function TrawTextInterpreter.CreateNewKeyword(const AKeyword: String): TrawKeyword;
begin
  Result:=TrawKeyword.Create;
  Result.FKeyword:=AKeyword;
end;

end.
