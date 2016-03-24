object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 458
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object imgOriginal: TsImage
    Left = 0
    Top = 0
    Width = 363
    Height = 432
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = True
    Center = True
    Picture.Data = {07544269746D617000000000}
    SkinData.SkinSection = 'CHECKBOX'
    ExplicitHeight = 392
  end
  object imgFinal: TsImage
    Left = 363
    Top = 0
    Width = 366
    Height = 432
    Align = alClient
    AutoSize = True
    Center = True
    Picture.Data = {07544269746D617000000000}
    SkinData.SkinSection = 'CHECKBOX'
    ExplicitLeft = 600
    ExplicitTop = 40
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object p1: TsPanel
    Left = 0
    Top = 432
    Width = 729
    Height = 26
    Align = alBottom
    TabOrder = 0
    object btnLoadImage: TsButton
      Left = 1
      Top = 1
      Width = 75
      Height = 24
      Align = alLeft
      Caption = 'Load Image'
      TabOrder = 0
      OnClick = btnLoadImageClick
    end
    object btnCopyRect: TsButton
      Left = 352
      Top = 1
      Width = 75
      Height = 24
      Align = alLeft
      Caption = 'Copy Image'
      TabOrder = 1
      OnClick = btnCopyRectClick
    end
    object edtX: TsEdit
      Left = 145
      Top = 1
      Width = 69
      Height = 24
      Align = alLeft
      TabOrder = 2
      TextHint = 'Y'
      ExplicitHeight = 21
    end
    object edtY: TsEdit
      Left = 76
      Top = 1
      Width = 69
      Height = 24
      Align = alLeft
      TabOrder = 3
      TextHint = 'X'
      ExplicitHeight = 21
    end
    object edtHeight: TsEdit
      Left = 214
      Top = 1
      Width = 69
      Height = 24
      Align = alLeft
      TabOrder = 4
      TextHint = 'Width'
      ExplicitHeight = 21
    end
    object edtWidth: TsEdit
      Left = 283
      Top = 1
      Width = 69
      Height = 24
      Align = alLeft
      TabOrder = 5
      TextHint = 'Height'
      BoundLabel.Caption = 'edtWidth'
      ExplicitHeight = 21
    end
  end
end
