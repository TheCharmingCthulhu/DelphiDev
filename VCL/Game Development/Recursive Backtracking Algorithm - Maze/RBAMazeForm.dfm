object Main: TMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Recursive Backtracking'
  ClientHeight = 795
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dgMap: TDrawGrid
    Left = 0
    Top = 0
    Width = 796
    Height = 795
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 32
    Align = alClient
    ColCount = 12
    DefaultRowHeight = 64
    DoubleBuffered = True
    FixedCols = 0
    RowCount = 12
    FixedRows = 0
    GridLineWidth = 2
    ParentDoubleBuffered = False
    TabOrder = 0
    OnDrawCell = dgMapDrawCell
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
  end
end
