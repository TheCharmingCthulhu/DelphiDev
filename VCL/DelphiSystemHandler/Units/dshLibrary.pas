unit dshLibrary;

interface

uses
  SysUtils, Classes, Registry, Winapi.Windows, dshTypes, Generics.Collections;

type
  TdshDelphiVersion = class(TPersistent)
  private
    FVersion: String;
  protected
  public
    constructor Create(const AName, AVersion: String);
    destructor Destroy; Override;

    property Version: String read FVersion;
  end;

  TdshLibraryManager = class(TObject)
  private
    FRegEdit: TRegistry;
    FInstalledVersions: TList<TdshDelphiVersion>;
    procedure Load;
  protected
    procedure Initialize; Virtual;
    procedure Finalize; Virtual;
  public
    constructor Create;
    destructor Destroy; Override;
  end;

implementation

{ TdshLibraryManager }

constructor TdshLibraryManager.Create;
begin
  inherited Create;

  FRegEdit := TRegistry.Create;
  FInstalledVersions := TList<TdshDelphiVersion>.Create;

  Load;

  Initialize;
end;

destructor TdshLibraryManager.Destroy;
var
  I: Integer;
begin
  Finalize;

  FreeAndNil(FRegEdit);

  for I:=0 to FInstalledVersions.Count-1 do
    FInstalledVersions[I].Free;
  FInstalledVersions.Clear;
  FreeAndNil(FInstalledVersions);

  inherited;
end;

procedure TdshLibraryManager.Finalize;
begin

end;

procedure TdshLibraryManager.Initialize;
begin

end;

procedure TdshLibraryManager.Load;
var
  KeyList: TStringList;
begin
  FRegEdit.RootKey := HKEY_CURRENT_USER;

  if FRegEdit.KeyExists(KEY_DELPHI_ROOT) then
  begin
    try
      KeyList := TStringList.Create;
      FRegEdit.GetKeyNames(KeyList);

      for I := 0 to KeyList.Count-1 do
      begin
        FInstalledVersions.Add(nil);
      end;
    finally
      KeyList.Clear;
      FreeAndNil(KeyList);
    end;

    FRegEdit.OpenKey('', False);
  end else
    raise Exception.Create('DelphiSystemHandler: "KEY_DELPHI_ROOT" has not been found.' + #10#13 + 'Value: "' + KEY_DELPHI_ROOT + '"');
end;

{ TdshDelphiVersion }

constructor TdshDelphiVersion.Create(const AName, AVersion: String);
begin

end;

destructor TdshDelphiVersion.Destroy;
begin

  inherited;
end;

end.
