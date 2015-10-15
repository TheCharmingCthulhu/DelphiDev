object VersionSelector: TVersionSelector
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Version Selector'
  ClientHeight = 277
  ClientWidth = 267
  Color = clBtnFace
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
  object lboxVersions: TJvListBox
    Left = 8
    Top = 8
    Width = 249
    Height = 233
    ItemHeight = 13
    Background.FillMode = bfmTile
    Background.Visible = False
    TabOrder = 0
  end
  object btnSelectVersion: TButton
    Left = 8
    Top = 247
    Width = 97
    Height = 25
    Caption = 'Select Version'
    TabOrder = 1
    OnClick = btnSelectVersionClick
  end
end
