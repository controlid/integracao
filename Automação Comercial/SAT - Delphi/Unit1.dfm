object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Aplicativo SAT'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 368
    Top = 104
    Width = 104
    Height = 15
    Caption = 'C'#243'digo de Ativa'#231#227'o'
  end
  object Button1: TButton
    Left = 160
    Top = 112
    Width = 177
    Height = 34
    Caption = 'Consultar SAT'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 160
    Top = 152
    Width = 177
    Height = 33
    Caption = 'Consultar Status Operacional'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 368
    Top = 125
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object Button3: TButton
    Left = 160
    Top = 191
    Width = 177
    Height = 33
    Caption = 'Enviar Venda'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button5: TButton
    Left = 160
    Top = 72
    Width = 177
    Height = 34
    Caption = 'Teste Fim a Fim'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 160
    Top = 32
    Width = 177
    Height = 34
    Caption = 'Extrair Logs'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Panel1: TPanel
    Left = 120
    Top = 280
    Width = 257
    Height = 137
    TabOrder = 6
    object Label2: TLabel
      Left = 52
      Top = 63
      Width = 146
      Height = 15
      Caption = 'Nome do Arquivo de Venda'
    end
    object Button4: TButton
      Left = 40
      Top = 24
      Width = 177
      Height = 33
      Caption = 'Ler Arquivo de Venda'
      TabOrder = 0
      OnClick = Button4Click
    end
    object Edit2: TEdit
      Left = 64
      Top = 84
      Width = 121
      Height = 23
      TabOrder = 1
    end
  end
end
