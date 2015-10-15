unit FastHTTP;

interface

uses
  SysUtils, Classes, IOUtils,
  IdHttp, IdIOHandler, IdSSLOpenSSL, IdSSLOpenSSLHeaders, IdCTypes;

type
  TFastHTTPClient = class(TIdCustomHTTP)
  private
    FSSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;

    procedure OnStatusInfoEx(ASender: TObject;
      const AsslSocket: PSSL;
      const AWhere, Aret: TIdC_INT;
      const AType, AMsg: String);
  public
    constructor Create(AAntiCloudFlare: Boolean = False);
    destructor Destroy; override;
  end;

const
  DEFAULT_USER_AGENT:
    String = 'Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3';

implementation

{ THttpClient }

constructor TFastHTTPClient.Create(AAntiCloudFlare: Boolean = False);
begin
  inherited Create;
  HandleRedirects := True;

  FSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create;
//  if AAntiCloudFlare then
//    FSSLIOHandler.OnStatusInfoEx := OnStatusInfoEx;
//  FSSLIOHandler.SSLOptions.Method := sslvSSLv23;
//  FSSLIOHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IOHandler := FSSLIOHandler;

  Request.UserAgent := DEFAULT_USER_AGENT;
end;


destructor TFastHTTPClient.Destroy;
begin
  FreeAndNil(FSSLIOHandler);
  inherited;
end;

procedure TFastHTTPClient.OnStatusInfoEx(ASender: TObject;
  const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT; const AType,
  AMsg: String);
begin
    SSL_set_tlsext_host_name(AsslSocket, Request.Host);
end;

end.
