object Main: TMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Terminal'
  ClientHeight = 339
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmExplicit
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object editTerminal: TEdit
    Left = 0
    Top = 318
    Width = 592
    Height = 21
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    OnKeyDown = editTerminalKeyDown
    OnKeyPress = editTerminalKeyPress
  end
  object memoConsole: TMemo
    Left = 0
    Top = 0
    Width = 592
    Height = 321
    TabStop = False
    Align = alTop
    BevelEdges = [beLeft, beRight, beBottom]
    BevelKind = bkFlat
    BevelOuter = bvSpace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WantReturns = False
  end
end
