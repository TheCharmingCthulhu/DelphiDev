object Main: TMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Unit Clock'
  ClientHeight = 483
  ClientWidth = 759
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
  object pcUnitClock: TJvPageControl
    Left = 0
    Top = 0
    Width = 759
    Height = 483
    ActivePage = tsProjectManager
    Align = alClient
    TabOrder = 0
    object tsUnitUtilities: TTabSheet
      Caption = 'Unit Utilities'
      DoubleBuffered = False
      ParentDoubleBuffered = False
      ExplicitLeft = 8
      ExplicitTop = 28
      object grpMoneyCalc: TJvGroupBox
        Left = 255
        Top = 3
        Width = 202
        Height = 121
        Caption = 'Cash Monitor'
        TabOrder = 0
        object lblCashInfo: TJvLabel
          Left = 67
          Top = 24
          Width = 30
          Height = 13
          Caption = 'Cash:'
          Transparent = True
        end
        object lblDaysInfo: TJvLabel
          Left = 14
          Top = 51
          Width = 83
          Height = 13
          Caption = 'Number of Days:'
          Transparent = True
        end
        object lblRemainingCashInfo: TJvLabel
          Left = 16
          Top = 74
          Width = 82
          Height = 13
          Caption = 'Remaining Cash:'
          Transparent = True
        end
        object lblRemainingCash: TJvLabel
          Left = 104
          Top = 74
          Width = 47
          Height = 13
          Caption = '0.00 EUR'
          Transparent = True
        end
        object lblPossibleSavingsInfo: TJvLabel
          Left = 14
          Top = 93
          Width = 84
          Height = 13
          Caption = 'Possible Savings:'
          Transparent = True
        end
        object lblPossibleSavings: TJvLabel
          Left = 104
          Top = 93
          Width = 47
          Height = 13
          Caption = '0.00 EUR'
          Transparent = True
        end
        object edtSpCash: TJvSpinEdit
          Left = 103
          Top = 20
          Width = 90
          Height = 21
          Alignment = taRightJustify
          ShowButton = False
          ValueType = vtFloat
          TabOrder = 0
          OnChange = CashAnalyzer_SetValues
        end
        object edtSpDays: TJvSpinEdit
          Left = 103
          Top = 47
          Width = 90
          Height = 21
          ButtonKind = bkClassic
          Value = 1.000000000000000000
          TabOrder = 1
          OnChange = CashAnalyzer_SetValues
        end
      end
      object grpFixCostsMgr: TJvGroupBox
        Left = 3
        Top = 3
        Width = 246
        Height = 369
        Caption = 'Monthly Fix Costs Manager'
        TabOrder = 1
        object lblMonthInfo: TJvLabel
          Left = 41
          Top = 24
          Width = 36
          Height = 13
          Caption = 'Month:'
          Transparent = True
        end
        object lblMonth: TJvLabel
          Left = 83
          Top = 24
          Width = 27
          Height = 13
          Caption = 'None'
          Transparent = True
        end
        object lblStillToPayInfo: TJvLabel
          Left = 19
          Top = 43
          Width = 58
          Height = 13
          Caption = 'Still To Pay:'
          Transparent = True
        end
        object lblStillToPay: TJvLabel
          Left = 83
          Top = 43
          Width = 47
          Height = 13
          Caption = '0.00 EUR'
          Transparent = True
        end
        object lblFixCostsInfo: TJvLabel
          Left = 19
          Top = 82
          Width = 46
          Height = 13
          Caption = 'Fix Costs'
          Transparent = True
        end
        object lblItemNameInfo: TJvLabel
          Left = 20
          Top = 279
          Width = 33
          Height = 13
          Caption = 'Name:'
          Transparent = True
        end
        object lblItemCostInfo: TJvLabel
          Left = 24
          Top = 306
          Width = 28
          Height = 13
          Caption = 'Cost:'
          Transparent = True
        end
        object edtItemName: TJvEdit
          Left = 58
          Top = 276
          Width = 175
          Height = 21
          TabOrder = 0
          Text = ''
        end
        object edtItemCost: TJvEdit
          Left = 58
          Top = 303
          Width = 175
          Height = 21
          TabOrder = 1
          Text = ''
        end
        object btnInsert: TJvBitBtn
          Left = 152
          Top = 330
          Width = 81
          Height = 25
          Caption = 'Insert'
          TabOrder = 2
          OnClick = btnInsertClick
        end
        object btnRemove: TJvBitBtn
          Left = 58
          Top = 330
          Width = 80
          Height = 25
          Caption = 'Remove'
          Enabled = False
          TabOrder = 3
          OnClick = btnRemoveClick
        end
        object lvFixCosts: TJvListView
          Left = 18
          Top = 96
          Width = 215
          Height = 174
          Checkboxes = True
          Columns = <
            item
              AutoSize = True
              Caption = 'Name'
            end
            item
              AutoSize = True
              Caption = 'Pay'
            end>
          RowSelect = True
          TabOrder = 4
          ViewStyle = vsReport
          OnSelectItem = lvFixCostsSelectItem
          OnItemChecked = lvFixCostsItemChecked
          ColumnsOrder = '0=125,1=80'
          ReturnKeyTriggersItemDblClick = False
          ExtendedColumns = <
            item
            end
            item
            end>
        end
      end
    end
    object tsProjectManager: TTabSheet
      Caption = 'Project Manager'
      ImageIndex = 1
      object lblProjectListInfo: TJvLabel
        Left = 3
        Top = 3
        Width = 59
        Height = 13
        Caption = 'Project List:'
        Transparent = True
      end
      object lvProjectManager: TJvListView
        Left = 3
        Top = 22
        Width = 745
        Height = 363
        Columns = <
          item
            AutoSize = True
            Caption = 'Project Name'
          end
          item
            Caption = 'Priority'
          end
          item
            Alignment = taCenter
            Caption = 'Division'
            Width = 200
          end
          item
            Caption = 'Status'
            Width = 150
          end>
        ColumnClick = False
        Ctl3D = True
        Items.ItemData = {
          05630000000100000000000000FFFFFFFFFFFFFFFF03000000FFFFFFFF000000
          00074900740065006D00580030003100013000B0D720220B500072006F006700
          720061006D006D0069006E00670058D820220753007400610072007400650064
          0020D82022FFFFFFFFFFFF}
        TabOrder = 0
        ViewStyle = vsReport
        ColumnsOrder = '0=200,1=50,2=200,3=150'
        ExtendedColumns = <
          item
          end
          item
          end
          item
          end
          item
          end>
      end
      object pnlTools: TJvPanel
        Left = 3
        Top = 391
        Width = 745
        Height = 61
        BevelInner = bvSpace
        BevelOuter = bvLowered
        TabOrder = 1
      end
    end
  end
  object imglstStatus: TJvImageList
    Items = <>
    Left = 704
    Top = 360
  end
end
