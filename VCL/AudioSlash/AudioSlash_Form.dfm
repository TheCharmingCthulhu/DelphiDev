object Main: TMain
  Left = 0
  Top = 0
  Caption = 'AudioSlash'
  ClientHeight = 470
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnDownload: TJvBitBtn
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Download'
    TabOrder = 0
    OnClick = btnDownloadClick
  end
  object edStreamUrl: TJvEdit
    Left = 89
    Top = 10
    Width = 296
    Height = 21
    TabOrder = 1
    Text = ''
  end
  object lsbMediaFiles: TJvListBox
    Left = 8
    Top = 39
    Width = 377
    Height = 423
    ItemHeight = 13
    Background.FillMode = bfmTile
    Background.Visible = False
    TabOrder = 2
  end
  object wsRedirectURL: TIdHTTPServer
    Active = True
    Bindings = <>
    DefaultPort = 6400
    AutoStartSession = True
    Left = 656
    Top = 416
  end
end
