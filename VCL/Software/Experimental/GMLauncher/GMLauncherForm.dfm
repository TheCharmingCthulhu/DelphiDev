object Main: TMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Game Mode Launcher'
  ClientHeight = 270
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 24
    Top = 21
    Width = 84
    Height = 14
    Caption = 'Server Name:'
  end
  object Label2: TLabel
    Left = 79
    Top = 47
    Width = 28
    Height = 14
    Caption = 'Map:'
  end
  object Label3: TLabel
    Left = 15
    Top = 76
    Width = 91
    Height = 14
    Caption = 'Network Mode:'
  end
  object Label4: TLabel
    Left = 15
    Top = 102
    Width = 91
    Height = 14
    Caption = 'Max. Players:'
  end
  object Label6: TLabel
    Left = 8
    Top = 155
    Width = 98
    Height = 14
    Caption = 'RCON Password:'
  end
  object Label5: TLabel
    Left = 43
    Top = 128
    Width = 63
    Height = 14
    Caption = 'UDP Port:'
  end
  object Label7: TLabel
    Left = 43
    Top = 184
    Width = 63
    Height = 14
    Caption = 'Gamemode:'
  end
  object editServerName: TEdit
    Left = 108
    Top = 17
    Width = 172
    Height = 22
    TabOrder = 0
    Text = 'Garry'#39's Mod dedicated server'
  end
  object editUDPPort: TEdit
    Left = 108
    Top = 124
    Width = 73
    Height = 22
    NumbersOnly = True
    TabOrder = 1
    Text = '27015'
  end
  object editRCONPassword: TEdit
    Left = 108
    Top = 152
    Width = 172
    Height = 22
    TabOrder = 2
  end
  object cboxMap: TComboBox
    Left = 108
    Top = 44
    Width = 172
    Height = 22
    Style = csDropDownList
    TabOrder = 3
  end
  object cboxNetworkMode: TComboBox
    Left = 108
    Top = 71
    Width = 172
    Height = 22
    Style = csDropDownList
    TabOrder = 4
  end
  object cboxMaxPlayers: TComboBox
    Left = 108
    Top = 98
    Width = 73
    Height = 22
    Style = csDropDownList
    TabOrder = 5
  end
  object btnRun: TButton
    Left = 8
    Top = 231
    Width = 272
    Height = 25
    Caption = 'Run Server'
    TabOrder = 6
    OnClick = btnRunClick
  end
  object cboxGamemodes: TComboBox
    Left = 108
    Top = 180
    Width = 172
    Height = 22
    Style = csDropDownList
    TabOrder = 7
  end
  object chBoxSecured: TCheckBox
    Left = 79
    Top = 208
    Width = 201
    Height = 17
    Caption = 'Secured (Valve Anti-Cheat)'
    TabOrder = 8
  end
end
