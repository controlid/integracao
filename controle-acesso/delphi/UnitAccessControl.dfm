object FormControleAcesso: TFormControleAcesso
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Controle Acesso'
  ClientHeight = 721
  ClientWidth = 770
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControlControleAcesso: TPageControl
    Left = 0
    Top = 0
    Width = 777
    Height = 705
    ActivePage = TabSheetDevice
    TabOrder = 0
    object TabSheetDevice: TTabSheet
      Caption = 'Teste'
      object LabelResponse: TLabel
        Left = 3
        Top = 405
        Width = 49
        Height = 13
        Caption = 'Resposta:'
      end
      object GroupBoxLogin: TGroupBox
        Left = 3
        Top = 0
        Width = 758
        Height = 145
        Caption = 'Login'
        TabOrder = 0
        object LabelDeviceHostname: TLabel
          Left = 16
          Top = 24
          Width = 45
          Height = 13
          Caption = 'Endere'#231'o'
        end
        object LabelDeviceLogin: TLabel
          Left = 217
          Top = 24
          Width = 25
          Height = 13
          Caption = 'Login'
        end
        object LabelDevicePassword: TLabel
          Left = 353
          Top = 24
          Width = 46
          Height = 13
          Caption = 'Password'
        end
        object LabelDeviceStatusTestConnection: TLabel
          Left = 584
          Top = 46
          Width = 42
          Height = 13
          Caption = 'Status: -'
        end
        object LabelDevicePort: TLabel
          Left = 144
          Top = 24
          Width = 26
          Height = 13
          Caption = 'Porta'
        end
        object EditDeviceHostname: TEdit
          Left = 16
          Top = 43
          Width = 113
          Height = 21
          TabOrder = 0
        end
        object ButtonDeviceLogin: TButton
          Left = 657
          Top = 109
          Width = 90
          Height = 25
          Caption = 'Efetuar login'
          TabOrder = 6
          OnClick = ButtonDeviceLoginClick
        end
        object EditDeviceLogin: TEdit
          Left = 217
          Top = 43
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object EditDevicePassword: TEdit
          Left = 353
          Top = 43
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object ButtonTestConnection: TButton
          Left = 480
          Top = 41
          Width = 98
          Height = 25
          Caption = 'Testar conex'#227'o'
          TabOrder = 4
          OnClick = ButtonTestConnectionClick
        end
        object RadioGroupProtocol: TRadioGroup
          Left = 16
          Top = 70
          Width = 178
          Height = 59
          Caption = 'Protocolo'
          Items.Strings = (
            'HTTP'
            'HTTPS')
          TabOrder = 5
        end
        object EditDevicePort: TEdit
          Left = 144
          Top = 43
          Width = 57
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBoxUser: TGroupBox
        Left = 3
        Top = 151
        Width = 409
        Height = 122
        Caption = 'Usu'#225'rio'
        TabOrder = 1
        object LabelUsername: TLabel
          Left = 80
          Top = 23
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object LabelUserID: TLabel
          Left = 16
          Top = 23
          Width = 50
          Height = 13
          Caption = 'ID Usu'#225'rio'
        end
        object EditUsername: TEdit
          Left = 80
          Top = 42
          Width = 121
          Height = 21
          TabOrder = 1
        end
        object EditUserID: TEdit
          Left = 16
          Top = 42
          Width = 50
          Height = 21
          TabOrder = 0
        end
        object ButtonCreateUser: TButton
          Left = 16
          Top = 80
          Width = 57
          Height = 25
          Caption = 'Criar'
          TabOrder = 2
          OnClick = ButtonCreateUserClick
        end
        object ButtonListUser: TButton
          Left = 79
          Top = 80
          Width = 57
          Height = 25
          Caption = 'Listar'
          TabOrder = 3
          OnClick = ButtonListUserClick
        end
        object ButtonDeleteUser: TButton
          Left = 142
          Top = 80
          Width = 57
          Height = 25
          Caption = 'Apagar'
          TabOrder = 4
          OnClick = ButtonDeleteUserClick
        end
        object ButtonUpdateUser: TButton
          Left = 205
          Top = 80
          Width = 57
          Height = 25
          Caption = 'Alterar'
          TabOrder = 5
          OnClick = ButtonUpdateUserClick
        end
      end
      object GroupBoxGroup: TGroupBox
        Left = 418
        Top = 151
        Width = 343
        Height = 122
        Caption = 'Grupo'
        TabOrder = 2
        object LabelGroupName: TLabel
          Left = 79
          Top = 24
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object LabelGroupID: TLabel
          Left = 16
          Top = 24
          Width = 43
          Height = 13
          Caption = 'ID Grupo'
        end
        object ButtonListGroup: TButton
          Left = 74
          Top = 78
          Width = 57
          Height = 25
          Caption = 'Listar'
          TabOrder = 2
          OnClick = ButtonListGroupClick
        end
        object ButtonCreateGroup: TButton
          Left = 11
          Top = 78
          Width = 57
          Height = 25
          Caption = 'Criar'
          TabOrder = 1
          OnClick = ButtonCreateGroupClick
        end
        object EditGroupName: TEdit
          Left = 80
          Top = 43
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object EditGroupID: TEdit
          Left = 16
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 3
        end
        object ButtonDeleteGroup: TButton
          Left = 137
          Top = 78
          Width = 57
          Height = 25
          Caption = 'Apagar'
          TabOrder = 4
          OnClick = ButtonDeleteGroupClick
        end
      end
      object GroupBoxUserGroup: TGroupBox
        Left = 3
        Top = 279
        Width = 182
        Height = 120
        Caption = 'Adicionar usu'#225'rio ao grupo'
        TabOrder = 3
        object LabelUserGroupGroupID: TLabel
          Left = 16
          Top = 24
          Width = 43
          Height = 13
          Caption = 'ID Grupo'
        end
        object LabelUserGroupUserID: TLabel
          Left = 72
          Top = 24
          Width = 50
          Height = 13
          Caption = 'ID Usu'#225'rio'
        end
        object ButtonCreateUserGroup: TButton
          Left = 16
          Top = 81
          Width = 57
          Height = 25
          Caption = 'Criar'
          TabOrder = 2
          OnClick = ButtonCreateUserGroupClick
        end
        object EditUserGroupGroupID: TEdit
          Left = 16
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 0
        end
        object EditUserGroupUserID: TEdit
          Left = 72
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 1
        end
        object ButtonListUserGroup: TButton
          Left = 79
          Top = 80
          Width = 57
          Height = 25
          Caption = 'Listar'
          TabOrder = 3
          OnClick = ButtonListUserGroupClick
        end
      end
      object GroupBoxCard: TGroupBox
        Left = 191
        Top = 279
        Width = 286
        Height = 120
        Caption = 'Cart'#227'o de acesso'
        TabOrder = 4
        object LabelCardUserID: TLabel
          Left = 16
          Top = 24
          Width = 50
          Height = 13
          Caption = 'ID Usu'#225'rio'
        end
        object LabelCardID: TLabel
          Left = 80
          Top = 24
          Width = 47
          Height = 13
          Caption = 'ID Cart'#227'o'
        end
        object EditCardUserID: TEdit
          Left = 16
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 0
        end
        object ButtonRegisterCard: TButton
          Left = 16
          Top = 81
          Width = 84
          Height = 25
          Caption = 'Registrar'
          TabOrder = 1
          OnClick = ButtonRegisterCardClick
        end
        object ButtonListCard: TButton
          Left = 106
          Top = 80
          Width = 57
          Height = 25
          Caption = 'Listar'
          TabOrder = 2
          OnClick = ButtonListCardClick
        end
        object EditCardID: TEdit
          Left = 80
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 3
        end
        object ButtonDeleteCard: TButton
          Left = 169
          Top = 80
          Width = 57
          Height = 25
          Caption = 'Apagar'
          TabOrder = 4
          OnClick = ButtonDeleteCardClick
        end
      end
      object MemoResponse: TMemo
        Left = 3
        Top = 424
        Width = 758
        Height = 244
        ScrollBars = ssVertical
        TabOrder = 5
      end
      object GroupBoxBiometry: TGroupBox
        Left = 483
        Top = 279
        Width = 278
        Height = 120
        Caption = 'Biometria'
        TabOrder = 6
        object LabelBiometryUserID: TLabel
          Left = 16
          Top = 24
          Width = 50
          Height = 13
          Caption = 'ID Usu'#225'rio'
        end
        object LabelTemplateID: TLabel
          Left = 80
          Top = 24
          Width = 58
          Height = 13
          Caption = 'ID Biometria'
        end
        object EditTemplateUserID: TEdit
          Left = 16
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 0
        end
        object ButtonTemplateRegister: TButton
          Left = 16
          Top = 84
          Width = 84
          Height = 25
          Caption = 'Registrar'
          TabOrder = 1
          OnClick = ButtonTemplateRegisterClick
        end
        object CheckBoxPanicFinger: TCheckBox
          Left = 144
          Top = 43
          Width = 97
          Height = 17
          Caption = 'Dedo do p'#226'nico'
          TabOrder = 2
        end
        object ButtonListTemplate: TButton
          Left = 106
          Top = 84
          Width = 57
          Height = 25
          Caption = 'Listar'
          TabOrder = 3
          OnClick = ButtonListTemplateClick
        end
        object EditTemplateID: TEdit
          Left = 80
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 4
        end
        object ButtonDeleteTemplate: TButton
          Left = 169
          Top = 84
          Width = 57
          Height = 25
          Caption = 'Apagar'
          TabOrder = 5
          OnClick = ButtonDeleteTemplateClick
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 702
    Width = 770
    Height = 19
    Panels = <>
  end
end
