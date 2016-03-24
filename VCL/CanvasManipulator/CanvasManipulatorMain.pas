unit CanvasManipulatorMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, acImage, sPanel, Vcl.StdCtrls, sButton, Vcl.Mask, sMaskEdit, sEdit;

type
  TForm1 = class(TForm)
    btnLoadImage: TsButton;
    p1: TsPanel;
    imgOriginal: TsImage;
    imgFinal: TsImage;
    btnCopyRect: TsButton;
    edtX: TsEdit;
    edtY: TsEdit;
    edtWidth: TsEdit;
    edtHeight: TsEdit;
    procedure btnLoadImageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCopyRectClick(Sender: TObject);
  private
    FOpenImageDialog: TOpenDialog;
    FLoaded: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnCopyRectClick(Sender: TObject);
var
  B1, B2: TBitmap;
  CustomRect: TRect;
begin
  if FLoaded then
  begin
    if (Trim(edtX.Text) <> '') AND (Trim(edtY.Text) <> '') AND (Trim(edtWidth.Text) <> '') AND (Trim(edtHeight.Text) <> '') then
    begin
      try
        imgFinal.Canvas.Refresh;
        imgFinal.Picture.Graphic.SetSize(32, 32);

        B1:=TBitmap.Create;
        B1.Assign(imgOriginal.Picture.Graphic);

        CustomRect:=TRect.Create(StrToInt(edtX.Text), StrToInt(edtY.Text), StrToInt(edtX.Text) + StrToInt(edtWidth.Text),
          StrToInt(edtY.Text) + StrToInt(edtHeight.Text));
        B1.Canvas.CopyRect(imgFinal.Canvas.ClipRect, imgOriginal.Canvas, CustomRect);

        imgFinal.Picture.Assign(B1);

      finally
        FreeAndNil(B1);
      end;
    end;
  end;
end;

procedure TForm1.btnLoadImageClick(Sender: TObject);
begin
  if FOpenImageDialog.Execute then
  begin
    imgOriginal.Picture.LoadFromFile(FOpenImageDialog.FileName);
    FLoaded:=True;
  end else
    FLoaded:=False;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FOpenImageDialog);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FOpenImageDialog:=TOpenDialog.Create(Self);
  FOpenImageDialog.Filter:='Bitmaps|*.bmp|JPEGs|*.jpg;*.jpeg|PNGs|*.png|GIFs|*.gif';
end;

end.
