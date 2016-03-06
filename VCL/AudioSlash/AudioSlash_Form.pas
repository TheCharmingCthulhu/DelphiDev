unit AudioSlash_Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls, JvListBox,
  JvEdit, Vcl.Buttons, JvExButtons, JvBitBtn, JvPlaylist, YoutubeAPI,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer;

type
  TMain = class(TForm)
    btnDownload: TJvBitBtn;
    edStreamUrl: TJvEdit;
    lsbMediaFiles: TJvListBox;
    wsRedirectURL: TIdHTTPServer;
    procedure btnDownloadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.btnDownloadClick(Sender: TObject);
var
  YoutubeVideo: TVideo;
begin
  try
    YoutubeVideo := TVideo.Create(edStreamUrl.Text);
    YoutubeVideo.Download;
  finally
    FreeAndNil(YoutubeVideo);
  end;
end;

end.
