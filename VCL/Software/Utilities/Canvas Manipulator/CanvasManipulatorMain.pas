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
    btnSaveToFile: TsButton;
    procedure btnLoadImageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCopyRectClick(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
  private
    FSaveDialog: TSaveDialog;
    FOpenDialog: TOpenDialog;
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
        B1:=TBitmap.Create;
        B1.Assign(imgOriginal.Picture.Graphic);

        CustomRect:=TRect.Create(StrToInt(edtX.Text), StrToInt(edtY.Text), StrToInt(edtX.Text) + StrToInt(edtWidth.Text),
          StrToInt(edtY.Text) + StrToInt(edtHeight.Text));
        B1.Canvas.CopyRect(imgFinal.Canvas.ClipRect, imgOriginal.Canvas, CustomRect);

        imgFinal.Picture.Assign(B1);
        imgFinal.Picture.Bitmap.SetSize(StrToInt(edtWidth.Text), StrToInt(edtHeight.Text));
        imgFinal.Picture.Bitmap.Canvas.Refresh;
      finally
        FreeAndNil(B1);
      end;
    end;
  end;
end;

procedure TForm1.btnLoadImageClick(Sender: TObject);
begin
  if FOpenDialog.Execute then
  begin
    imgOriginal.Picture.LoadFromFile(FOpenDialog.FileName);
    FLoaded:=True;
  end else
    FLoaded:=False;
end;

procedure TForm1.btnSaveToFileClick(Sender: TObject);
begin
  if (FSaveDialog.Execute) then
    imgFinal.Picture.SaveToFile(FSaveDialog.FileName);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FOpenDialog);
  FreeAndNil(FSaveDialog);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FOpenDialog:=TOpenDialog.Create(Self);
  FOpenDialog.Filter:='PNGs|*.png|Bitmaps|*.bmp|JPEGs|*.jpg;*.jpeg|GIFs|*.gif';

  FSaveDialog:=TSaveDialog.Create(Self);
  FSaveDialog.Filter:='PNGs|*.png|Bitmaps|*.bmp|JPEGs|*.jpg;*.jpeg|GIFs|*.gif';
end;

end.
