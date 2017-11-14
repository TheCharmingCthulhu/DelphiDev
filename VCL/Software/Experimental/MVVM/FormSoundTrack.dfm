object SoundTrackForm: TSoundTrackForm
  Left = 0
  Top = 0
  Caption = 'Sound Track'
  ClientHeight = 140
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 143
    Top = 56
    Width = 23
    Height = 13
    Caption = 'Date'
  end
  object btnOK: TBitBtn
    Left = 8
    Top = 107
    Width = 58
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object edtTitle: TLabeledEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 20
    EditLabel.Height = 13
    EditLabel.Caption = 'Title'
    TabOrder = 1
    OnChange = edtTitleChange
  end
  object edtArtist: TLabeledEdit
    Left = 143
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'Artist'
    TabOrder = 2
    OnChange = edtArtistChange
  end
  object edtAlbum: TLabeledEdit
    Left = 279
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'Album'
    TabOrder = 3
    OnChange = edtAlbumChange
  end
  object edtDuration: TLabeledEdit
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Duration'
    TabOrder = 4
    OnChange = edtDurationChange
  end
  object dtpDate: TDateTimePicker
    Left = 143
    Top = 72
    Width = 257
    Height = 21
    Date = 42597.923712141200000000
    Time = 42597.923712141200000000
    TabOrder = 5
    OnChange = dtpDateChange
  end
  object btnCancel: TBitBtn
    Left = 72
    Top = 107
    Width = 57
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
end
