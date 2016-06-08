object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object vst1: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 635
    Height = 260
    Align = alTop
    Header.AutoSizeIndex = 1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDrag, hoOwnerDraw, hoVisible, hoDisableAnimatedResize, hoAutoColumnPopupMenu]
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toShowButtons, toShowRoot, toThemeAware, toUseBlendedImages]
    OnDrawText = vst1DrawText
    OnGetText = vst1GetText
    Columns = <
      item
        Position = 0
        WideText = 'Id'
      end
      item
        Position = 1
        Width = 200
        WideText = 'Items'
      end>
  end
  object Button1: TButton
    Left = 8
    Top = 266
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end
