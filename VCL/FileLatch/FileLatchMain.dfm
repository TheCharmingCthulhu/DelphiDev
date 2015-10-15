object Main: TMain
  Left = 0
  Top = 0
  Caption = 'FileLatch'
  ClientHeight = 352
  ClientWidth = 505
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
  object lvFileList: TListView
    Left = 16
    Top = 136
    Width = 473
    Height = 177
    Columns = <>
    TabOrder = 0
  end
  object pnlFileInfo: TPanel
    Left = 16
    Top = 8
    Width = 473
    Height = 122
    TabOrder = 1
    object lblInfFileName: TLabel
      Left = 21
      Top = 8
      Width = 50
      Height = 13
      Caption = 'File Name:'
    end
    object lblInfEncryption: TLabel
      Left = 16
      Top = 24
      Width = 55
      Height = 13
      Caption = 'Encryption:'
    end
    object lblInfFileSize: TLabel
      Left = 29
      Top = 40
      Width = 42
      Height = 13
      Caption = 'File Size:'
    end
    object lblFileName: TLabel
      Left = 77
      Top = 8
      Width = 25
      Height = 13
      Caption = 'None'
    end
    object lblEncryption: TLabel
      Left = 77
      Top = 24
      Width = 25
      Height = 13
      Caption = 'None'
    end
    object lblFileSize: TLabel
      Left = 77
      Top = 40
      Width = 21
      Height = 13
      Caption = '0 KB'
    end
    object lblCrywProgress: TLabel
      Left = 208
      Top = 98
      Width = 100
      Height = 13
      Caption = 'Encryption Progress:'
    end
  end
  object btnCreateLatch: TButton
    Left = 16
    Top = 319
    Width = 81
    Height = 25
    Caption = 'Create Latch'
    TabOrder = 2
  end
  object btnRevokeLatch: TButton
    Left = 103
    Top = 319
    Width = 75
    Height = 25
    Caption = 'Revoke Latch'
    TabOrder = 3
  end
  object pbCryw: TProgressBar
    Left = 328
    Top = 104
    Width = 150
    Height = 17
    Position = 100
    Smooth = True
    TabOrder = 4
  end
  object tiFileLatchTray: TTrayIcon
    AnimateInterval = 500
    BalloonTimeout = 5000
    BalloonFlags = bfInfo
    Left = 432
    Top = 16
  end
end
