object FormControleAcesso: TFormControleAcesso
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Controle Acesso'
  ClientHeight = 720
  ClientWidth = 775
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
    Height = 721
    ActivePage = TabSheetDevice
    TabOrder = 0
    object TabSheetDevice: TTabSheet
      Caption = 'Teste'
      object LabelResponse: TLabel
        Left = 3
        Top = 391
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
          Width = 82
          Height = 25
          Caption = 'Criar usu'#225'rio'
          TabOrder = 2
          OnClick = ButtonCreateUserClick
        end
        object ButtonListUser: TButton
          Left = 104
          Top = 80
          Width = 90
          Height = 25
          Caption = 'Listar usu'#225'rios'
          TabOrder = 3
          OnClick = ButtonListUserClick
        end
        object ButtonDeleteUser: TButton
          Left = 200
          Top = 80
          Width = 99
          Height = 25
          Caption = 'Apagar usu'#225'rios'
          TabOrder = 4
          OnClick = ButtonDeleteUserClick
        end
        object ButtonUpdateUser: TButton
          Left = 305
          Top = 80
          Width = 88
          Height = 25
          Caption = 'Alterar usu'#225'rio'
          TabOrder = 5
        end
      end
      object GroupBoxGroup: TGroupBox
        Left = 418
        Top = 151
        Width = 191
        Height = 122
        Caption = 'Grupo'
        TabOrder = 2
        object LabelGroupName: TLabel
          Left = 16
          Top = 21
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object ButtonListGroup: TButton
          Left = 98
          Top = 75
          Width = 81
          Height = 25
          Caption = 'Listar grupos'
          TabOrder = 2
        end
        object ButtonCreateGroup: TButton
          Left = 17
          Top = 75
          Width = 75
          Height = 25
          Caption = 'Criar grupo'
          TabOrder = 1
        end
        object EditGroupName: TEdit
          Left = 16
          Top = 40
          Width = 121
          Height = 21
          TabOrder = 0
        end
      end
      object GroupBoxUserGroup: TGroupBox
        Left = 615
        Top = 151
        Width = 146
        Height = 122
        Caption = 'Adicionar usu'#225'rio ao grupo'
        TabOrder = 3
        object LabelUserGroupGroupID: TLabel
          Left = 16
          Top = 24
          Width = 43
          Height = 13
          Caption = 'Grupo ID'
        end
        object LabelUserGroupUserID: TLabel
          Left = 72
          Top = 24
          Width = 50
          Height = 13
          Caption = 'Usu'#225'rio ID'
        end
        object ButtonCreateUserGroup: TButton
          Left = 16
          Top = 80
          Width = 75
          Height = 25
          Caption = 'Adicionar'
          TabOrder = 2
        end
        object EditUserGroupGrupoID: TEdit
          Left = 16
          Top = 43
          Width = 41
          Height = 21
          TabOrder = 0
        end
        object EditUserGroupUserID: TEdit
          Left = 72
          Top = 43
          Width = 49
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBoxCard: TGroupBox
        Left = 3
        Top = 279
        Width = 409
        Height = 106
        Caption = 'Cart'#227'o de acesso'
        TabOrder = 4
        object LabelCardUserID: TLabel
          Left = 16
          Top = 24
          Width = 50
          Height = 13
          Caption = 'ID Usu'#225'rio'
        end
        object LabelStatusCardRegistration: TLabel
          Left = 16
          Top = 70
          Width = 42
          Height = 13
          Caption = 'Status: -'
        end
        object EditCardUserID: TEdit
          Left = 16
          Top = 43
          Width = 50
          Height = 21
          TabOrder = 0
        end
        object ButtonCardRegister: TButton
          Left = 296
          Top = 70
          Width = 97
          Height = 25
          Caption = 'Registrar cart'#227'o'
          TabOrder = 1
        end
      end
      object MemoResponse: TMemo
        Left = 3
        Top = 410
        Width = 758
        Height = 280
        TabOrder = 5
      end
    end
  end
end
