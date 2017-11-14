unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Autohotkey;

type
  TFormBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEngine: TAutohotkeyEngine;
  public
    procedure Initialize;
    procedure Finalize;
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

procedure TFormBase.Finalize;
begin
  FreeAndNil(FEngine);
end;

procedure TFormBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Finalize;
end;

procedure TFormBase.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TFormBase.Initialize;
begin
  FEngine:=TAutohotkeyEngine.Create;
end;

end.
