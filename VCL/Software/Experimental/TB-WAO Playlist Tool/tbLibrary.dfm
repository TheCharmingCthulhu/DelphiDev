object MediaLibrary: TMediaLibrary
  Left = 0
  Top = 0
  Caption = 'Media Library'
  ClientHeight = 339
  ClientWidth = 445
  Color = clBtnFace
  DockSite = True
  DoubleBuffered = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lvMediaLibrary: TJvListView
    Left = 0
    Top = 0
    Width = 445
    Height = 339
    Align = alClient
    Columns = <>
    TabOrder = 0
    ViewStyle = vsTile
    ExtendedColumns = <>
  end
  object dckcltLibrary: TJvDockClient
    DirectDrag = False
    DockStyle = Main.dckstlVIDStyle
    Left = 32
    Top = 288
  end
end
