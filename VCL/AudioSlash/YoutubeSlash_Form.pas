unit YoutubeSlash_Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw;

type
  TYoutubeLogin = class(TForm)
    wbLoginBrowser: TWebBrowser;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  YoutubeLogin: TYoutubeLogin;

implementation

{$R *.dfm}

end.
