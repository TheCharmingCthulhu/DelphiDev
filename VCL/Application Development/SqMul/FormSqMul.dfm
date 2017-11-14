object FormSquarenMulti: TFormSquarenMulti
  Left = 0
  Top = 0
  Caption = 'Square'#39'N'#39'Multiply'
  ClientHeight = 300
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lboxBinary: TListBox
    Left = 71
    Top = 89
    Width = 58
    Height = 203
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 0
  end
  object edtBasis: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '72'
    TextHint = 'Basis'
    OnChange = edtBasisChange
  end
  object edtExponent: TEdit
    Left = 8
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 2
    TextHint = 'Exponent'
    OnChange = edtExponentChange
  end
  object edtRest: TEdit
    Left = 8
    Top = 62
    Width = 121
    Height = 21
    TabOrder = 3
    TextHint = 'Rest'
    OnChange = edtRestChange
  end
  object btnDebug: TBitBtn
    Left = 402
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Debug'
    TabOrder = 4
    OnClick = btnDebugClick
  end
  object lboxValues: TListBox
    Left = 8
    Top = 89
    Width = 57
    Height = 203
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 5
  end
end
