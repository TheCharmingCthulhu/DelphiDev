object NotifyForm: TNotifyForm
  Left = 0
  Top = 0
  Caption = 'NotifyForm'
  ClientHeight = 132
  ClientWidth = 405
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
  object lblItemName: TLabel
    Left = 16
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object lblItemAmount: TLabel
    Left = 16
    Top = 51
    Width = 41
    Height = 13
    Caption = 'Amount:'
  end
  object lblDefaultPrice: TLabel
    Left = 160
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Price:'
  end
  object lblCosts: TLabel
    Left = 160
    Top = 51
    Width = 26
    Height = 13
    Caption = 'Cost:'
  end
  object btnAccept: TButton
    Left = 16
    Top = 99
    Width = 75
    Height = 25
    Caption = 'Accept'
    TabOrder = 0
    OnClick = btnAcceptClick
  end
  object edtItemName: TEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object edtItemAmount: TEdit
    Left = 16
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtItemPrice: TEdit
    Left = 160
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtItemCost: TEdit
    Left = 160
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 4
  end
end
