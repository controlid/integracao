object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 270
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 176
    Top = 45
    Width = 68
    Height = 13
    Caption = 'Desconectado'
  end
  object Label2: TLabel
    Left = 176
    Top = 117
    Width = 50
    Height = 13
    Caption = 'Deslogado'
  end
  object Label4: TLabel
    Left = 488
    Top = 72
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object Button1: TButton
    Left = 72
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 72
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 72
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Generate AFD'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 368
    Top = 64
    Width = 97
    Height = 25
    Caption = 'Add AFD to Memo'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Memo1: TMemo
    Left = 368
    Top = 136
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
end
