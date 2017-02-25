object Form1: TForm1
  Left = 586
  Top = 200
  Width = 352
  Height = 429
  Caption = 'Parseur logique'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 41
    Height = 390
    Align = alLeft
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 296
    Top = 0
    Width = 40
    Height = 390
    Align = alRight
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 41
    Top = 0
    Width = 255
    Height = 390
    Align = alClient
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 181
      Top = 19
      Width = 49
      Height = 33
      Caption = '-->'
      Enabled = False
      Visible = False
      OnClick = SpeedButton1Click
    end
    object Edit1: TEdit
      Left = 8
      Top = 21
      Width = 169
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnClick = Edit1Click
    end
    object ListBox1: TListBox
      Left = 192
      Top = 88
      Width = 57
      Height = 209
      ItemHeight = 13
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 8
      Top = 48
      Width = 169
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'A . (/B+C)'
      Visible = False
    end
    object Button1: TButton
      Left = 8
      Top = 352
      Width = 89
      Height = 33
      Caption = 'D'#233'marrer'
      TabOrder = 3
      Visible = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 160
      Top = 352
      Width = 89
      Height = 33
      Caption = 'Arr'#234'ter'
      TabOrder = 4
      Visible = False
      OnClick = Button2Click
    end
    object ListBox2: TListBox
      Left = 8
      Top = 88
      Width = 169
      Height = 209
      ItemHeight = 13
      Items.Strings = (
        'S = 1'
        'S = 0'
        'S = A'
        'S = /A'
        'S = A . B'
        'S = A & B'
        'S = A + B'
        'S = A | B'
        'S = /(A.B)'
        'S= /A+/B'
        'S=/(A+B)'
        'S=/A./B'
        'S=/A.B+/B.A'
        'S = /S'
        'S = /B . (A + S)')
      TabOrder = 5
      OnClick = ListBox2Click
    end
    object Memo1: TMemo
      Left = 8
      Top = 304
      Width = 241
      Height = 41
      ReadOnly = True
      TabOrder = 6
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 297
    Top = 296
  end
end
