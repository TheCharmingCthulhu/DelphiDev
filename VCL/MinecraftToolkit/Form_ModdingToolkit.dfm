object ModdingToolkit: TModdingToolkit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Minecraft Toolkit'
  ClientHeight = 590
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gboxMinecraftModList: TJvGroupBox
    Left = 8
    Top = 8
    Width = 627
    Height = 459
    Caption = 'Minecraft Modding Toolkit'
    TabOrder = 1
    object lblModListInfo: TJvLabel
      Left = 16
      Top = 20
      Width = 45
      Height = 13
      Caption = 'Mod List:'
      Transparent = True
    end
    object lvModList: TJvListView
      Left = 6
      Top = 43
      Width = 616
      Height = 411
      Columns = <>
      TabOrder = 0
      ExtendedColumns = <>
    end
    object btnNextPage: TJvBitBtn
      Left = 557
      Top = 14
      Width = 62
      Height = 25
      Caption = 'Next'
      TabOrder = 1
    end
    object btnLastPage: TJvBitBtn
      Left = 483
      Top = 14
      Width = 63
      Height = 25
      Caption = 'Last'
      TabOrder = 2
    end
    object btnLoad: TJvBitBtn
      Left = 240
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 3
      OnClick = btnLoadClick
    end
  end
  object gboxTools: TJvGroupBox
    Left = 8
    Top = 473
    Width = 627
    Height = 90
    Caption = 'Toolset'
    TabOrder = 0
    object lblModName: TJvLabel
      Left = 72
      Top = 23
      Width = 33
      Height = 13
      Caption = 'Name:'
      Transparent = True
    end
    object lblModVersion: TJvLabel
      Left = 16
      Top = 42
      Width = 89
      Height = 13
      Caption = 'Minecraft Version:'
      Transparent = True
    end
    object lblAuthor: TJvLabel
      Left = 43
      Top = 61
      Width = 62
      Height = 13
      Caption = 'Mod Author:'
      Transparent = True
    end
    object btnDownload: TJvBitBtn
      Left = 547
      Top = 58
      Width = 75
      Height = 25
      Caption = 'Download'
      TabOrder = 0
    end
  end
  object cboxModList: TJvComboBox
    Left = 75
    Top = 24
    Width = 168
    Height = 21
    TabOrder = 2
    Text = ''
    OnChange = cboxModListChange
  end
  object sbarMinecraftInfo: TJvStatusBar
    Left = 0
    Top = 571
    Width = 650
    Height = 19
    Panels = <
      item
        Text = 'Current Version:'
        Width = 95
      end
      item
        Text = 'None'
        Width = 70
      end>
    ParentShowHint = False
    ShowHint = False
  end
end
