object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo de integra'#231#227'o CIDPrinter.dll'
  ClientHeight = 197
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 364
    Height = 41
    Caption = '1) Inicializar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 57
    Width = 364
    Height = 41
    Caption = '2) Imprimir'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 104
    Width = 364
    Height = 41
    Caption = '3) Abrir Gaveta'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 151
    Width = 364
    Height = 41
    Caption = '4) Finalizar'
    TabOrder = 3
    OnClick = Button4Click
  end
end
