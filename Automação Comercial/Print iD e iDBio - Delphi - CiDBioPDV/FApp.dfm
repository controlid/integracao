object FormApp: TFormApp
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Control iD PDV Biom'#233'trico'
  ClientHeight = 460
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelProduct: TLabel
    Left = 8
    Top = 77
    Width = 38
    Height = 13
    Caption = 'Produto'
  end
  object LabelProductQuantity: TLabel
    Left = 184
    Top = 77
    Width = 22
    Height = 13
    Caption = 'Qtd.'
  end
  object LabelCart: TLabel
    Left = 7
    Top = 165
    Width = 41
    Height = 13
    Caption = 'Carrinho'
  end
  object LabelProductPrice: TLabel
    Left = 247
    Top = 99
    Width = 72
    Height = 13
    Caption = 'Pre'#231'o: R$ 0,00'
  end
  object LabelTotalPrice: TLabel
    Left = 8
    Top = 351
    Width = 69
    Height = 13
    Caption = 'Total: R$ 0,00'
  end
  object LabelGreeting: TLabel
    Left = 8
    Top = 48
    Width = 3
    Height = 13
  end
  object ButtonUnlock: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Desbloquear'
    TabOrder = 0
    OnClick = ButtonUnlockClick
  end
  object ComboBoxProduct: TComboBox
    Left = 8
    Top = 96
    Width = 161
    Height = 21
    TabOrder = 1
    Text = 'Selecione o produto...'
    OnClick = ComboBoxProductClick
  end
  object EditProductQuantity: TEdit
    Left = 184
    Top = 96
    Width = 49
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Text = '1'
    OnExit = EditProductQuantityExit
    OnKeyUp = EditProductQuantityKeyUp
  end
  object ButtonAddToCart: TButton
    Left = 8
    Top = 123
    Width = 121
    Height = 25
    Caption = 'Adicionar ao carrinho'
    TabOrder = 3
    OnClick = ButtonAddToCartClick
  end
  object CheckListBoxCart: TCheckListBox
    Left = 7
    Top = 184
    Width = 376
    Height = 161
    ItemHeight = 13
    TabOrder = 4
  end
  object ButtonRemoveCartItem: TButton
    Left = 8
    Top = 385
    Width = 185
    Height = 25
    Caption = 'Remover selecionados'
    TabOrder = 5
    OnClick = ButtonRemoveCartItemClick
  end
  object ButtonCheckout: TButton
    Left = 8
    Top = 416
    Width = 185
    Height = 25
    Caption = 'Enviar para SAT iD'
    TabOrder = 6
  end
  object ButtonLock: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Bloquear'
    TabOrder = 7
    OnClick = ButtonLockClick
  end
  object ButtonCreateUser: TButton
    Left = 308
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 8
    OnClick = ButtonCreateUserClick
  end
  object ButtonPrintTicket: TButton
    Left = 199
    Top = 417
    Width = 184
    Height = 25
    Caption = 'Imprimir cupom'
    TabOrder = 9
  end
end
