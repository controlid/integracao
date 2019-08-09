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
      object GroupBoxLogin: TGroupBox
        Left = 3
        Top = 0
        Width = 366
        Height = 150
        Caption = 'Login'
        TabOrder = 0
        object LabelDeviceHostname: TLabel
          Left = 96
          Top = 18
          Width = 45
          Height = 13
          Caption = 'Endere'#231'o'
        end
        object LabelDeviceLogin: TLabel
          Left = 96
          Top = 71
          Width = 25
          Height = 13
          Caption = 'Login'
        end
        object LabelDevicePassword: TLabel
          Left = 235
          Top = 71
          Width = 46
          Height = 13
          Caption = 'Password'
        end
        object LabelDevicePort: TLabel
          Left = 235
          Top = 18
          Width = 26
          Height = 13
          Caption = 'Porta'
        end
        object EditDeviceHostname: TEdit
          Left = 96
          Top = 37
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object ButtonDeviceLogin: TButton
          Left = 299
          Top = 114
          Width = 57
          Height = 25
          Caption = 'Logar'
          TabOrder = 5
          OnClick = ButtonDeviceLoginClick
        end
        object EditDeviceLogin: TEdit
          Left = 96
          Top = 87
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object EditDevicePassword: TEdit
          Left = 235
          Top = 87
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object RadioGroupProtocol: TRadioGroup
          Left = 8
          Top = 15
          Width = 74
          Height = 93
          Caption = 'Protocolo'
          ItemIndex = 0
          Items.Strings = (
            'HTTP'
            'HTTPS')
          TabOrder = 4
        end
        object EditDevicePort: TEdit
          Left = 235
          Top = 37
          Width = 57
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBoxUser: TGroupBox
        Left = 3
        Top = 156
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
        Top = 156
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
        Top = 284
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
        Top = 284
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
      object GroupBoxBiometry: TGroupBox
        Left = 483
        Top = 284
        Width = 278
        Height = 120
        Caption = 'Biometria'
        TabOrder = 5
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
      object GroupBoxResponse: TGroupBox
        Left = 0
        Top = 410
        Width = 761
        Height = 262
        Caption = 'Resposta'
        TabOrder = 6
        object MemoResponse: TMemo
          Left = 3
          Top = 16
          Width = 755
          Height = 243
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object GroupBoxSyncronization: TGroupBox
        Left = 375
        Top = 0
        Width = 383
        Height = 150
        Caption = 'Sincroniza'#231#227'o'
        TabOrder = 7
        object LabelSyncronizationHostname: TLabel
          Left = 96
          Top = 18
          Width = 45
          Height = 13
          Caption = 'Endere'#231'o'
        end
        object LabelSyncronizationLogin: TLabel
          Left = 96
          Top = 71
          Width = 25
          Height = 13
          Caption = 'Login'
        end
        object LabelSyncronizationPassword: TLabel
          Left = 243
          Top = 71
          Width = 46
          Height = 13
          Caption = 'Password'
        end
        object LabelSyncronizationPort: TLabel
          Left = 240
          Top = 18
          Width = 26
          Height = 13
          Caption = 'Porta'
        end
        object EditSyncronizationHostname: TEdit
          Left = 96
          Top = 37
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object ButtonSyncUsers: TButton
          Left = 11
          Top = 114
          Width = 60
          Height = 25
          Caption = 'Usu'#225'rios'
          TabOrder = 5
          OnClick = ButtonSyncUsersClick
        end
        object EditSyncronizationLogin: TEdit
          Left = 96
          Top = 87
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object EditSyncronizationPassword: TEdit
          Left = 243
          Top = 87
          Width = 126
          Height = 21
          TabOrder = 3
        end
        object RadioGroupSyncronizationProtocol: TRadioGroup
          Left = 11
          Top = 15
          Width = 73
          Height = 93
          Caption = 'Protocolo'
          ItemIndex = 0
          Items.Strings = (
            'HTTP'
            'HTTPS')
          TabOrder = 4
        end
        object EditSyncronizationPort: TEdit
          Left = 240
          Top = 37
          Width = 57
          Height = 21
          TabOrder = 1
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
