object Form1: TForm1
  Left = 1152
  Top = 157
  Width = 738
  Height = 605
  Caption = 'Bcrypt use dll $ use unit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    722
    567)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 32
    Top = 36
    Width = 32
    Height = 16
    Caption = 'key:'
  end
  object Label2: TLabel
    Left = 32
    Top = 84
    Width = 56
    Height = 16
    Caption = 'Bcrypt:'
  end
  object Label_tip: TLabel
    Left = 40
    Top = 184
    Width = 32
    Height = 16
    Caption = 'Note'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 24
    Top = 248
    Width = 670
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 368
    Top = 36
    Width = 56
    Height = 16
    Caption = 'rounds:'
  end
  object Label4: TLabel
    Left = 32
    Top = 284
    Width = 32
    Height = 16
    Caption = 'key:'
  end
  object Label5: TLabel
    Left = 32
    Top = 380
    Width = 56
    Height = 16
    Caption = 'Bcrypt:'
  end
  object Label6: TLabel
    Left = 384
    Top = 284
    Width = 56
    Height = 16
    Caption = 'rounds:'
  end
  object Bevel2: TBevel
    Left = 32
    Top = 176
    Width = 670
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Bevel3: TBevel
    Left = 24
    Top = 256
    Width = 670
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label_tip_1: TLabel
    Left = 40
    Top = 488
    Width = 32
    Height = 16
    Caption = 'Note'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Bevel4: TBevel
    Left = 24
    Top = 480
    Width = 670
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label7: TLabel
    Left = 528
    Top = 24
    Width = 120
    Height = 27
    Caption = 'Use Dll.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -27
    Font.Name = #23435#20307
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Bevel5: TBevel
    Left = 158
    Top = 104
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Bevel6: TBevel
    Left = 326
    Top = 104
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Bevel7: TBevel
    Left = 334
    Top = 104
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Bevel8: TBevel
    Left = 575
    Top = 104
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Bevel9: TBevel
    Left = 158
    Top = 400
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Bevel10: TBevel
    Left = 326
    Top = 400
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Bevel11: TBevel
    Left = 334
    Top = 400
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Bevel12: TBevel
    Left = 575
    Top = 400
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object SpeedButton_up: TSpeedButton
    Left = 552
    Top = 424
    Width = 129
    Height = 33
    Caption = 'DLL Check'
    OnClick = SpeedButton_upClick
  end
  object Label8: TLabel
    Left = 32
    Top = 348
    Width = 40
    Height = 16
    Caption = 'salt:'
  end
  object Bevel13: TBevel
    Left = 222
    Top = 264
    Width = 9
    Height = 16
    Shape = bsLeftLine
  end
  object Label9: TLabel
    Left = 32
    Top = 316
    Width = 32
    Height = 16
    Caption = 'org:'
  end
  object Label10: TLabel
    Left = 320
    Top = 316
    Width = 64
    Height = 16
    Caption = '(16byte)'
  end
  object Label11: TLabel
    Left = 320
    Top = 348
    Width = 64
    Height = 16
    Caption = '(22byte)'
  end
  object Label12: TLabel
    Left = 608
    Top = 380
    Width = 64
    Height = 16
    Caption = '(60byte)'
  end
  object SpeedButton_getsalt: TSpeedButton
    Left = 392
    Top = 313
    Width = 23
    Height = 22
    OnClick = SpeedButton_getsaltClick
  end
  object Label13: TLabel
    Left = 536
    Top = 280
    Width = 135
    Height = 27
    Caption = 'Use Unit.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -27
    Font.Name = #23435#20307
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object SpeedButton_down: TSpeedButton
    Left = 560
    Top = 128
    Width = 129
    Height = 33
    Caption = 'Unit Check'
    OnClick = SpeedButton_downClick
  end
  object Edit_key: TEdit
    Left = 96
    Top = 32
    Width = 241
    Height = 24
    TabOrder = 0
  end
  object Edit_output: TEdit
    Left = 96
    Top = 80
    Width = 505
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object BitBtn_bcrypt: TBitBtn
    Left = 96
    Top = 128
    Width = 161
    Height = 33
    Caption = 'Bcrypt_output'
    TabOrder = 2
    OnClick = BitBtn_bcryptClick
  end
  object BitBtn_check: TBitBtn
    Left = 304
    Top = 128
    Width = 161
    Height = 33
    Caption = 'BitBtn_check'
    TabOrder = 3
    OnClick = BitBtn_checkClick
  end
  object Edit_rounds: TEdit
    Left = 432
    Top = 32
    Width = 49
    Height = 24
    TabOrder = 4
    Text = '8'
  end
  object Edit_key_1: TEdit
    Left = 96
    Top = 280
    Width = 233
    Height = 24
    TabOrder = 5
  end
  object Edit_output_1: TEdit
    Left = 96
    Top = 376
    Width = 505
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object BitBtn_outpuy_1: TBitBtn
    Left = 96
    Top = 424
    Width = 161
    Height = 33
    Caption = 'Bcrypt_output'
    TabOrder = 7
    OnClick = BitBtn_outpuy_1Click
  end
  object BitBtn_check_1: TBitBtn
    Left = 304
    Top = 424
    Width = 161
    Height = 33
    Caption = 'BitBtn_check'
    TabOrder = 8
    OnClick = BitBtn_check_1Click
  end
  object Edit_round1: TEdit
    Left = 448
    Top = 280
    Width = 49
    Height = 24
    TabOrder = 9
    Text = '8'
  end
  object Edit_salt: TEdit
    Left = 96
    Top = 344
    Width = 217
    Height = 24
    TabOrder = 10
  end
  object Edit_org_1: TEdit
    Left = 96
    Top = 312
    Width = 217
    Height = 24
    TabOrder = 11
  end
end
