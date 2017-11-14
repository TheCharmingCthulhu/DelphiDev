unit FormSqMul;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, smController, Vcl.Buttons;

type
  TFormSquarenMulti = class(TForm)
    lboxBinary: TListBox;
    edtBasis: TEdit;
    edtExponent: TEdit;
    edtRest: TEdit;
    btnDebug: TBitBtn;
    lboxValues: TListBox;
    procedure edtBasisChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDebugClick(Sender: TObject);
    procedure edtExponentChange(Sender: TObject);
    procedure edtRestChange(Sender: TObject);
  private
    FSqMul: TsmSquarenMultiply;

    procedure Update;
  public
  end;

var
  FormSquarenMulti: TFormSquarenMulti;

implementation

{$R *.dfm}

procedure TFormSquarenMulti.btnDebugClick(Sender: TObject);
begin
  FSqMul.BinaryArray;
end;

procedure TFormSquarenMulti.edtBasisChange(Sender: TObject);
begin
  Update;
end;

procedure TFormSquarenMulti.edtExponentChange(Sender: TObject);
begin
  Update;
end;

procedure TFormSquarenMulti.edtRestChange(Sender: TObject);
begin
  Update;
end;

procedure TFormSquarenMulti.FormCreate(Sender: TObject);
begin
  FSqMul:=TsmSquarenMultiply.Create;
end;

procedure TFormSquarenMulti.Update;
var
  I: Integer;
  BinaryArray: TArray<Boolean>;
  Values: TArray<Extended>;
begin
  with FSqMul do
  begin
    if Trim(edtBasis.Text) <> '' then
      Basis:=Extended.Parse(edtBasis.Text);
    if Trim(edtExponent.Text) <> '' then
      Exponent:=Extended.Parse(edtExponent.Text);
    if Trim(edtRest.Text) <> '' then
      Rest:=Extended.Parse(edtRest.Text);
  end;

  lboxBinary.Items.Clear;
  BinaryArray:=FSqMul.BinaryArray;
  for I := 0 to Length(BinaryArray)-1 do
    lboxBinary.Items.Add(IfThen(BinaryArray[I], '1', '0'));

  lboxValues.Items.Clear;
  Values:=FSqMul.Values;
  for I := 0 to Length(Values)-1 do
    lboxValues.Items.Add(Values[I].ToString);
end;

end.
