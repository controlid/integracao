object FormCreateUser: TFormCreateUser
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Control iD PDV Biom'#233'trico - Cadastro usu'#225'rio'
  ClientHeight = 331
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelAdminPassword: TLabel
    Left = 184
    Top = 208
    Width = 113
    Height = 13
    Caption = 'Senha de administrador'
  end
  object LabelUsername: TLabel
    Left = 184
    Top = 37
    Width = 80
    Height = 13
    Caption = 'Nome de usu'#225'rio'
  end
  object EditAdminPassword: TEdit
    Left = 184
    Top = 227
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object ButtonCreateUser: TButton
    Left = 207
    Top = 273
    Width = 75
    Height = 25
    Caption = 'Criar usu'#225'rio'
    TabOrder = 1
    OnClick = ButtonCreateUserClick
  end
  object EditUsername: TEdit
    Left = 184
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object ButtonEnroll: TButton
    Left = 184
    Top = 128
    Width = 121
    Height = 25
    Caption = 'Cadastrar dedo'
    TabOrder = 3
    OnClick = ButtonEnrollClick
  end
end
