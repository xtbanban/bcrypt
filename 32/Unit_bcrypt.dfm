object Form1: TForm1
  Left = 205
  Top = 230
  Width = 717
  Height = 292
  Caption = 'Bcrypt use dll'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    701
    254)
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
    Left = 48
    Top = 200
    Width = 32
    Height = 16
    Caption = 'tips'
  end
  object Bevel1: TBevel
    Left = 24
    Top = 176
    Width = 649
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 232
    Top = 36
    Width = 56
    Height = 16
    Caption = 'rounds:'
  end
  object Edit_key: TEdit
    Left = 96
    Top = 32
    Width = 121
    Height = 24
    TabOrder = 0
  end
  object Edit_output: TEdit
    Left = 96
    Top = 80
    Width = 569
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
    Left = 296
    Top = 32
    Width = 49
    Height = 24
    TabOrder = 4
    Text = '8'
  end
end
