object frmBoardEdit: TfrmBoardEdit
  Left = 320
  Top = 200
  Width = 620
  Height = 480
  Caption = '게시글 편집'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Gulim'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 12
  object lblTitle: TLabel
    Left = 20
    Top = 20
    Width = 36
    Height = 12
    Caption = '제목:'
  end
  object lblWriter: TLabel
    Left = 20
    Top = 55
    Width = 48
    Height = 12
    Caption = '작성자:'
  end
  object lblContent: TLabel
    Left = 20
    Top = 90
    Width = 36
    Height = 12
    Caption = '내용:'
  end
  object edtTitle: TEdit
    Left = 75
    Top = 16
    Width = 505
    Height = 21
    TabOrder = 0
  end
  object edtWriterName: TEdit
    Left = 75
    Top = 51
    Width = 200
    Height = 21
    TabOrder = 1
  end
  object chkIsNotice: TCheckBox
    Left = 300
    Top = 53
    Width = 150
    Height = 17
    Caption = '공지사항 설정'
    TabOrder = 2
  end
  object mmoContent: TMemo
    Left = 75
    Top = 86
    Width = 505
    Height = 300
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 401
    Width = 604
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 4
    object btnSave: TButton
      Left = 420
      Top = 8
      Width = 75
      Height = 25
      Caption = '저장'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 505
      Top = 8
      Width = 75
      Height = 25
      Caption = '취소'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
end