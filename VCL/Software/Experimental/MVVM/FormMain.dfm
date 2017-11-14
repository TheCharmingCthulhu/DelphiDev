object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MVVM'
  ClientHeight = 316
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnNew: TBitBtn
    Left = 5
    Top = 8
    Width = 75
    Height = 25
    Caption = 'New Track'
    TabOrder = 0
    OnClick = btnNewClick
  end
  object lvSoundTracks: TListView
    AlignWithMargins = True
    Left = 5
    Top = 36
    Width = 590
    Height = 275
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    Columns = <
      item
        Caption = 'Track'
        Width = -1
        WidthType = (
          -1)
      end
      item
        Caption = 'Artist'
        Width = -1
        WidthType = (
          -1)
      end
      item
        Caption = 'Album'
        Width = -1
        WidthType = (
          -1)
      end
      item
        Caption = 'Duration'
        Width = 150
      end
      item
        Caption = 'Date'
        Width = 100
      end>
    TabOrder = 1
    ViewStyle = vsReport
  end
end
