object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Exemplo de integra'#231#227'o com iDBio'
  ClientHeight = 566
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 90
    Width = 104
    Height = 19
    Caption = 'Iniciar Captura'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 346
    Width = 149
    Height = 18
    Caption = 'Informa'#231#245'es do Leitor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 474
    Width = 107
    Height = 18
    Caption = 'Codigos de Erro:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 89
    Top = 31
    Width = 452
    Height = 24
    Caption = 'Exemplo de integra'#231#227'o com leitor biometrico iDBio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Image1: TImage
    Left = 466
    Top = 208
    Width = 135
    Height = 132
    Center = True
    Proportional = True
    Stretch = True
  end
  object mmoDedo: TMemo
    Left = 8
    Top = 115
    Width = 452
    Height = 225
    Lines.Strings = (
      'Log de comunica'#231#227'o com o dispositivo iDBio.')
    TabOrder = 0
  end
  object btn3: TButton
    Left = 466
    Top = 115
    Width = 128
    Height = 25
    Caption = 'Capturar Template'
    TabOrder = 1
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 89
    Top = 511
    Width = 185
    Height = 25
    Caption = 'Identificador de Erros'
    TabOrder = 2
    OnClick = btn4Click
  end
  object se1: TSpinEdit
    Left = 8
    Top = 511
    Width = 75
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object btn6: TButton
    Left = 466
    Top = 146
    Width = 128
    Height = 25
    Caption = 'Validar Digital'
    TabOrder = 4
    OnClick = btn5Click
  end
  object pnl1: TPanel
    Left = 4
    Top = 376
    Width = 274
    Height = 81
    TabOrder = 5
    object lblLeitor: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 266
      Height = 73
      Align = alClient
      AutoSize = False
      Caption = 'lblLeitor'
      WordWrap = True
      ExplicitTop = 0
      ExplicitHeight = 175
    end
  end
  object btn1: TButton
    Left = 284
    Top = 377
    Width = 176
    Height = 81
    Caption = 'Coletar informa'#231#245'es do Leitor'
    TabOrder = 6
    OnClick = btn1Click
  end
  object btn_CaptureImage: TButton
    Left = 466
    Top = 177
    Width = 128
    Height = 25
    Caption = 'Capturar Imagem'
    TabOrder = 7
    OnClick = btn_CaptureImageClick
  end
end
