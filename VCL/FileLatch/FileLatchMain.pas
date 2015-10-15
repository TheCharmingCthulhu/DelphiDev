unit FileLatchMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  EncryptionUtils;

type
  TMain = class(TForm)
    lvFileList: TListView;
    pnlFileInfo: TPanel;
    btnCreateLatch: TButton;
    btnRevokeLatch: TButton;
    tiFileLatchTray: TTrayIcon;
    lblInfFileName: TLabel;
    lblInfEncryption: TLabel;
    lblInfFileSize: TLabel;
    lblFileName: TLabel;
    lblEncryption: TLabel;
    lblFileSize: TLabel;
    pbCryw: TProgressBar;
    lblCrywProgress: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.FormCreate(Sender: TObject);
var
  enc: TEncryptor;
begin
  enc := TEncryptor.Create('test');
  enc.EncryptFile('music.mp3');
end;

end.
