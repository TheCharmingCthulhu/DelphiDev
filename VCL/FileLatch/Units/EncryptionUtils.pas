unit EncryptionUtils;

interface

uses
  SysUtils, Classes, DECCipher, DECUtil;

type
  TCrywStream = class(TStream)
  private
    FStream: TStream;
  protected
    procedure SetSize(NewSize: Longint); override;
  public
    constructor Create(AStream: TStream);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;

    procedure DoProgress(Writing: Boolean); virtual;
  end;

  TCryw = class(TThread)
  private
    FFileName: string;
    FKey: string;
  protected
    procedure Execute; override;
  public
    constructor Create(const AFileName: string; const AKey: string);
    destructor Destroy; override;

    property FileName: string read FFileName;
  end;

  TEncryptor = class
  private
    FKey: string;
  public
    procedure EncryptFile(const AFilePath: string);
    procedure DecryptFile(const AFilePath: string);

    constructor Create(const AKey: string);
    destructor Destroy;
  end;

implementation

uses
  FileLatchMain;

{ TEncryptor }

constructor TEncryptor.Create(const AKey: string);
begin
  FKey := AKey;
end;

procedure TEncryptor.DecryptFile(const AFilePath: string);
begin

end;

destructor TEncryptor.Destroy;
begin

end;

procedure TEncryptor.EncryptFile(const AFilePath: string);
var
  Cryw: TCryw;
begin
  Cryw := TCryw.Create(AFilePath, FKey);
  Cryw.Start;
end;

{ TCryw }

constructor TCryw.Create(const AFileName: string; const AKey: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FFileName := AFileName;
  FKey := AKey;
end;

destructor TCryw.Destroy;
begin

  inherited;
end;

procedure TCryw.Execute;
var
  ByteStream: TMemoryStream;
  Encrypter: TCipher_Rijndael;
  Destination: string;
begin
  try
    Destination := ExtractFileName(FFileName);
    Destination := Destination + '.lch';

    Encrypter := TCipher_Rijndael.Create;
    Encrypter.Init(FKey);

    Synchronize(procedure begin
//      FileLatchMain.Main.pbCryw.;
    end);
  finally
    FreeAndNil(Encrypter);
  end;
end;

{ TCrywStream }

constructor TCrywStream.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
end;

destructor TCrywStream.Destroy;
begin
  FreeAndNil(FStream);
  inherited;
end;

procedure TCrywStream.DoProgress(Writing: Boolean);
begin

end;

function TCrywStream.Read(var Buffer; Count: Integer): Longint;
begin

end;

function TCrywStream.Seek(Offset: Integer; Origin: Word): Longint;
begin

end;

procedure TCrywStream.SetSize(NewSize: Integer);
begin
  inherited;

end;

function TCrywStream.Write(const Buffer; Count: Integer): Longint;
begin

end;

end.
