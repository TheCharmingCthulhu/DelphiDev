object LInvoker: TLInvoker
  Left = 0
  Top = 0
  Caption = 'Latch Invoker'
  ClientHeight = 316
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfFileName: TLabel
    Left = 16
    Top = 16
    Width = 50
    Height = 13
    Caption = 'File Name:'
  end
  object lblInfFilePath: TLabel
    Left = 40
    Top = 45
    Width = 26
    Height = 13
    Caption = 'Path:'
  end
  object lblFileName: TLabel
    Left = 72
    Top = 16
    Width = 25
    Height = 13
    Caption = 'None'
  end
  object edtPath: TEdit
    Left = 72
    Top = 42
    Width = 226
    Height = 21
    TabOrder = 0
  end
  object btnFilePath: TButton
    Left = 223
    Top = 69
    Width = 75
    Height = 25
    Caption = 'Select File'
    TabOrder = 1
  end
  object btnOk: TButton
    Left = 142
    Top = 283
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 223
    Top = 283
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
  end
end
