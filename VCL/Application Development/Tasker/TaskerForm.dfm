object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Tasker'
  ClientHeight = 322
  ClientWidth = 727
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
  object lvTasks: TListView
    Left = 0
    Top = 0
    Width = 727
    Height = 289
    Align = alTop
    Columns = <
      item
        Caption = 'ID'
      end
      item
        Caption = 'Name'
      end>
    TabOrder = 0
    ExplicitWidth = 552
  end
  object edtMessage: TEdit
    Left = 255
    Top = 295
    Width = 367
    Height = 21
    TabOrder = 1
  end
  object btnNewTask: TButton
    Left = 628
    Top = 294
    Width = 91
    Height = 23
    Caption = 'Create Task'
    TabOrder = 2
    OnClick = btnNewTaskClick
  end
  object edtName: TEdit
    Left = 127
    Top = 295
    Width = 122
    Height = 21
    TabOrder = 3
  end
  object cboxTaskType: TComboBox
    Left = 8
    Top = 295
    Width = 113
    Height = 21
    Style = csDropDownList
    TabOrder = 4
  end
end
