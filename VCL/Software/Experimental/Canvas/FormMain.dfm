object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 300
  ClientWidth = 210
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnsMainMenu: TButtonGroup
    Left = 0
    Top = 0
    Width = 210
    Height = 300
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    ButtonHeight = 25
    ButtonOptions = [gboFullSize, gboShowCaptions]
    Items = <
      item
        Caption = 'Form : Timebar'
      end
      item
      end
      item
      end
      item
      end>
    TabOrder = 0
    OnButtonClicked = btnsMainMenuButtonClicked
    ExplicitWidth = 225
  end
end
