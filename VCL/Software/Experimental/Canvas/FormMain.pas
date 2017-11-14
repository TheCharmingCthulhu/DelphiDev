unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ButtonGroup, FormTimebar;

type
  TMain = class(TForm)
    btnsMainMenu: TButtonGroup;
    procedure btnsMainMenuButtonClicked(Sender: TObject; Index: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FTimebar: TTimebar;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

procedure TMain.btnsMainMenuButtonClicked(Sender: TObject; Index: Integer);
begin
  case Index of
    0:
    begin
      FTimebar.ShowModal;
    end;
  end;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  FTimebar:=TTimebar.Create(Self);
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FTimebar);
end;

end.


