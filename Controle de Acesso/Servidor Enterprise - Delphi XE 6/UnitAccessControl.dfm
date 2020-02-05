object FormControleAcesso: TFormControleAcesso
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Controle Acesso'
  ClientHeight = 486
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
        Width = 755
        Height = 185
        Caption = 'Login'
        TabOrder = 0
        object LabelDeviceHostname: TLabel
          Left = 384
          Top = 18
          Width = 138
          Height = 13
          Caption = 'Endere'#231'o IP do equipamento'
        end
        object LabelDeviceLogin: TLabel
          Left = 290
          Top = 68
          Width = 36
          Height = 13
          Caption = 'Usu'#225'rio'
        end
        object LabelDevicePassword: TLabel
          Left = 432
          Top = 68
          Width = 30
          Height = 13
          Caption = 'Senha'
        end
        object LabelDevicePort: TLabel
          Left = 250
          Top = 18
          Width = 106
          Height = 13
          Caption = 'Porta do equipamento'
        end
        object Label1: TLabel
          Left = 112
          Top = 18
          Width = 115
          Height = 13
          Caption = 'Endere'#231'o IP do servidor'
        end
        object Label2: TLabel
          Left = 112
          Top = 68
          Width = 83
          Height = 13
          Caption = 'Porta do servidor'
        end
        object ButtonDeviceLogin: TButton
          Left = 314
          Top = 128
          Width = 121
          Height = 41
          Caption = '2) Iniciar Sess'#227'o'
          TabOrder = 4
          OnClick = ButtonDeviceLoginClick
        end
        object EditDeviceLogin: TEdit
          Left = 250
          Top = 87
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'admin'
        end
        object EditDevicePassword: TEdit
          Left = 384
          Top = 87
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'admin'
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
          TabOrder = 3
        end
        object DevicePort: TEdit
          Left = 250
          Top = 37
          Width = 121
          Height = 21
          TabOrder = 0
          Text = '80'
        end
        object ButtonOnline: TButton
          Left = 568
          Top = 128
          Width = 121
          Height = 41
          Caption = '3) Ativar Modo Online'
          TabOrder = 5
          OnClick = ButtonOnlineClick
        end
        object DeviceIP: TEdit
          Left = 384
          Top = 37
          Width = 121
          Height = 21
          TabOrder = 6
          Text = '192.168.111.65'
        end
        object ServerIP: TEdit
          Left = 112
          Top = 37
          Width = 121
          Height = 21
          TabOrder = 7
          Text = '192.168.126.184'
        end
        object ServerPort: TEdit
          Left = 112
          Top = 87
          Width = 121
          Height = 21
          TabOrder = 8
          Text = '8080'
        end
        object Button1: TButton
          Left = 112
          Top = 128
          Width = 121
          Height = 41
          Caption = '1) Iniciar servidor Web'
          TabOrder = 9
          OnClick = Button1Click
        end
      end
      object GroupBoxResponse: TGroupBox
        Left = 3
        Top = 191
        Width = 761
        Height = 226
        Caption = 'Resposta'
        TabOrder = 1
        object MemoResponse: TMemo
          Left = 3
          Top = 24
          Width = 755
          Height = 193
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 446
    Width = 770
    Height = 40
    Panels = <>
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    Left = 628
    Top = 64
  end
end
