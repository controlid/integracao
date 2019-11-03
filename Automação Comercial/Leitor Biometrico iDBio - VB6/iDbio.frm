VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form iDBio_Exemplo 
   Caption         =   "iDBio_Exemplo"
   ClientHeight    =   8790
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   7575
   LinkTopic       =   "Form1"
   ScaleHeight     =   8790
   ScaleWidth      =   7575
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CloseCommand 
      Caption         =   "Fechar"
      Height          =   495
      Left            =   5520
      TabIndex        =   28
      Top             =   8040
      Width           =   1695
   End
   Begin VB.Frame Frame1 
      Caption         =   "Cadastro:  "
      Height          =   7335
      Index           =   1
      Left            =   360
      TabIndex        =   13
      Top             =   600
      Width           =   6855
      Begin VB.CommandButton ClearEnrollmentsCommand 
         Caption         =   "Limpar cadastros"
         Height          =   495
         Left            =   3960
         TabIndex        =   26
         Top             =   4440
         Width           =   2055
      End
      Begin VB.Frame Frame4 
         Caption         =   "Identificação:  "
         Height          =   2775
         Left            =   3600
         TabIndex        =   22
         Top             =   360
         Width           =   3015
         Begin VB.TextBox IdentifiedText 
            Height          =   285
            Left            =   600
            Locked          =   -1  'True
            TabIndex        =   25
            Top             =   1680
            Width           =   1815
         End
         Begin VB.CommandButton IdentifyCommand 
            Caption         =   "Identificar"
            Height          =   495
            Left            =   480
            TabIndex        =   23
            Top             =   480
            Width           =   2055
         End
         Begin VB.Label Label5 
            Caption         =   "Identificado:  "
            Height          =   255
            Left            =   600
            TabIndex        =   24
            Top             =   1440
            Width           =   975
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "IDs:  "
         Height          =   975
         Left            =   240
         TabIndex        =   20
         Top             =   3240
         Width           =   6375
         Begin VB.TextBox IDListText 
            Height          =   375
            Left            =   240
            Locked          =   -1  'True
            ScrollBars      =   1  'Horizontal
            TabIndex        =   21
            Top             =   360
            Width           =   5895
         End
      End
      Begin VB.CommandButton ReadIDsCommand 
         Caption         =   "Ler IDs"
         Height          =   495
         Left            =   840
         TabIndex        =   19
         Top             =   4440
         Width           =   2055
      End
      Begin VB.Frame Frame3 
         Caption         =   "Cadastro: "
         Height          =   2775
         Left            =   240
         TabIndex        =   15
         Top             =   360
         Width           =   3015
         Begin VB.TextBox IDText 
            Height          =   285
            Left            =   600
            TabIndex        =   17
            Top             =   600
            Width           =   1575
         End
         Begin VB.CommandButton EnrollCommand 
            Caption         =   "Cadastrar"
            Height          =   495
            Left            =   480
            TabIndex        =   16
            Top             =   1560
            Width           =   2055
         End
         Begin VB.Label Label4 
            Caption         =   "ID:"
            Height          =   255
            Left            =   600
            TabIndex        =   18
            Top             =   360
            Width           =   495
         End
      End
      Begin VB.TextBox IdentificationMsgText 
         Height          =   1815
         Left            =   240
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   14
         Top             =   5160
         Width           =   6375
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Captura:  "
      Height          =   7335
      Index           =   0
      Left            =   360
      TabIndex        =   1
      Top             =   600
      Width           =   6855
      Begin VB.CommandButton CaptureCommand 
         Caption         =   "Capturar"
         Height          =   615
         Left            =   4560
         TabIndex        =   27
         Top             =   4800
         Width           =   1935
      End
      Begin VB.Frame Frame2 
         Caption         =   "Dispositivo:  "
         Height          =   3255
         Index           =   0
         Left            =   4320
         TabIndex        =   5
         Top             =   1320
         Width           =   2415
         Begin VB.CommandButton ShowDataCommand 
            Caption         =   "Exibir dados"
            Height          =   495
            Left            =   240
            TabIndex        =   12
            Top             =   360
            Width           =   1815
         End
         Begin VB.TextBox DeviceModelText 
            Height          =   285
            Left            =   960
            Locked          =   -1  'True
            TabIndex        =   11
            Top             =   2400
            Width           =   1335
         End
         Begin VB.TextBox DeviceSerialNumberText 
            Height          =   285
            Left            =   960
            Locked          =   -1  'True
            TabIndex        =   10
            Top             =   1800
            Width           =   1335
         End
         Begin VB.TextBox DeviceVersionText 
            Height          =   285
            Left            =   960
            Locked          =   -1  'True
            TabIndex        =   9
            Top             =   1200
            Width           =   1335
         End
         Begin VB.Label Label3 
            Caption         =   "Modelo:  "
            Height          =   255
            Left            =   120
            TabIndex        =   8
            Top             =   2400
            Width           =   1095
         End
         Begin VB.Label Label2 
            Caption         =   "Nº Serial:  "
            Height          =   255
            Left            =   120
            TabIndex        =   7
            Top             =   1800
            Width           =   975
         End
         Begin VB.Label Label1 
            Caption         =   "Versão: "
            Height          =   255
            Left            =   120
            TabIndex        =   6
            Top             =   1200
            Width           =   1095
         End
      End
      Begin VB.TextBox CaptureMsgText 
         Height          =   1455
         Left            =   240
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   4
         Top             =   5640
         Width           =   6375
      End
      Begin VB.CommandButton ReInitDeviceCommand 
         Caption         =   "Reinicializar leitor"
         Height          =   615
         Left            =   4560
         TabIndex        =   3
         Top             =   480
         Width           =   1935
      End
      Begin VB.PictureBox Picture1 
         AutoSize        =   -1  'True
         HasDC           =   0   'False
         Height          =   4575
         Left            =   240
         ScaleHeight     =   301
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   261
         TabIndex        =   2
         Top             =   480
         Width           =   3975
      End
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   8535
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7335
      _ExtentX        =   12938
      _ExtentY        =   15055
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   2
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Captura"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Identificação"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "iDBio_Exemplo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'################
'FUNÇÕES DE APOIO
'################


Function returnMessage(ByVal returnCode As Integer) As String
    Select Case returnCode
    Case 0 'CIDBIO_SUCCESS
    returnMessage = "Operação realizada com sucesso"
    Case 1 'CIDBIO_WARNING_ALREADY_INIT
    returnMessage = "Biblioteca já inicializada."
    Case 2 'CIDBIO_WARNING_NO_IDS_ON_DEVICE
    returnMessage = "Nenhum Template cadastrado."
    Case 3 'CIDBIO_WARNING_OVERWRITING_TEMPLATE
    returnMessage = "Template foi sobrescrito."
    Case -1 'CIDBIO_ERROR_UNKNOWN
    returnMessage = "Erro desconhecido."
    Case -2 'CIDBIO_ERROR_NO_DEVICE
    returnMessage = "Dispositivo não encontrado."
    Case -3 'CIDBIO_ERROR_NULL_ARGUMENT
    returnMessage = "Argumento nulo."
    Case -4 'CIDBIO_ERROR_INVALID_ARGUMENT
    returnMessage = "Argumento inválido."
    Case -5 'CIDBIO_ERROR_CAPTURE
    returnMessage = "Erro durante a captura."
    Case -6 'CIDBIO_ERROR_CAPTURE_TIMEOUT
    returnMessage = "Tempo de captura expirado."
    Case -7 'CIDBIO_ERROR_COMM_USB
    returnMessage = "Erro de comunicação USB."
    Case -8 'CIDBIO_ERROR_IO_ON_HOST
    returnMessage = "Erro de comunicação do Host."
    Case -9 'CIDBIO_ERROR_TEMPLATE_ALREADY_ENROLLED
    returnMessage = "Template já cadastrado."
    Case -10 'CIDBIO_ERROR_MERGING
    returnMessage = "Falha no Merge."
    Case -11 'CIDBIO_ERROR_MATCHING
    returnMessage = "Falha no Match."
    Case -12 'CIDBIO_ERROR_INVALID_FW_FILE
    returnMessage = "Arquivo de Firmware inválido."
    Case -13 'CIDBIO_ERROR_NO_SPACE_LEFT_ON_DEVICE
    returnMessage = "Espaço no dispositivo esgotado."
    Case -14 'CIDBIO_ERROR_NO_TEMPLATE_WITH_ID
    returnMessage = "Template não cadastrado."
    Case -15 'CIDBIO_ERROR_INVALID_ERRNO
    returnMessage = "Código de erro inválido."
    Case -16 'CIDBIO_ERROR_UNAVAILABLE_FEATURE
    returnMessage = "Funcionalidade não disponível."
    Case -17 'CIDBIO_ERROR_PREVIOUS_FW_VERSION
    returnMessage = "Versão do firmware é anterior à atual."
    Case -18 'CIDBIO_ERROR_NOT_IDENTIFIED
    returnMessage = "Template não identificado."
    End Select
End Function

Private Function LongArrayFromInt_64ByteArray(ByRef byteList() As Byte, ByVal longListSize) As Long()
    Dim i As Integer
    Dim j As Integer
    Dim longItem As Long
    Dim longList() As Long
    
    ReDim longList(longListSize)
    
    'Para cada elemento Long que será produzido
    For i = 0 To (longListSize - 1)
        'Para cada byte na fatia do array correspondente àquele elemento Long
        longItem = 0
        For j = 0 To 7 'O limite de 3 corta os 32 bits mais significativos
            longItem = longItem + byteList(j + i * 8) * 256 ^ j
        Next
        longList(i) = longItem
    Next
    LongArrayFromInt_64ByteArray = longList
End Function

Private Function PointerToString(lngPtr As Long) As String
   Dim strTemp As String
   Dim lngLen As Long
       
   If lngPtr Then
      lngLen = lstrlenA(lngPtr)
      If lngLen Then
         strTemp = Space(lngLen)
         CopyMemory ByVal strTemp, ByVal lngPtr, lngLen
         PointerToString = strTemp
      End If
   End If
End Function



'##########################
'HABILITAÇÃO DO DISPOSITIVO
'##########################


Public Sub InitDevice()
    Dim returnCode As Integer
    Dim codeMessage As String
    
    CaptureMsgText.Text = CaptureMsgText.Text + "Inicializando... "
    
    returnCode = CIDBIO_Init()
    If returnCode = 0 Then
        CaptureMsgText.Text = CaptureMsgText.Text + "iDBio conectado" + vbCrLf
    Else
        CaptureMsgText.Text = CaptureMsgText.Text + "Falha ao conectar-se ao iDBio: " + returnMessage(returnCode) + vbCrLf
    End If
    DoEvents
    
End Sub

Private Sub TerminateDevice()
    Dim returnCode As Integer
    
    returnCode = CIDBIO_Terminate()
    If (returnCode < 0) Then
        CaptureMsgText.Text = CaptureMsgText.Text + "Falha ao encerrar dispositivo: " + returnMessage(returnCode) + vbCrLf
    Else
        CaptureMsgText.Text = CaptureMsgText.Text + "iDBio desconectado: " + returnMessage(returnCode) + vbCrLf
        DoEvents
    End If
End Sub


Private Sub ReInitDeviceCommand_Click()
    TerminateDevice
    InitDevice
End Sub

'#######
'CAPTURA
'#######

Private Sub CaptureCommand_Click()
    Dim width As Long
    Dim height As Long
    Dim imagebufPtr As Long
    Dim arrBytes(1048576) As Byte
    Dim returnCode As Integer
    
    CaptureMsgText.Text = CaptureMsgText.Text + "Coloque o dedo. Aguardando..." + vbCrLf
    DoEvents
    
    returnCode = CIDBIO_CaptureImage(imagebufPtr, width, height)
    If returnCode <> 0 Then
        CaptureMsgText.Text = CaptureMsgText.Text + returnMessage(returnCode) + vbCrLf
    End If
    
    CaptureMsgText.Text = CaptureMsgText.Text + "Largura: " + str(width) + "    " + "Altura: " + str(height) + "    " + "Tamanho da imagem: " + str(width * height) + vbCrLf
    CopyMemory VarPtr(arrBytes(0)), imagebufPtr, width * height
    
    Dim i, j As Long
    For i = 0 To width
        For j = 0 To height
            Picture1.PSet (i, j), RGB(arrBytes(i + j * width), arrBytes(i + j * width), arrBytes(i + j * width))
        Next
    Next
    
    returnCode = CIDBIO_FreeByteArray(imagebufPtr)
    If returnCode < 0 Then
        CaptureMsgText.Text = CaptureMsgText.Text + returnMessage(returnCode) + vbCrLf
    End If
    
End Sub

Private Sub ShowDataCommand_Click()
    Dim versionPtr As Long
    Dim serialNumberPtr As Long
    Dim modelPtr As Long
    Dim version As String
    Dim serialNumber As String
    Dim model As String
    Dim returnCode As Integer
    
    returnCode = CIDBIO_GetDeviceInfo(versionPtr, serialNumberPtr, modelPtr)
    
    version = PointerToString(versionPtr)
    serialNumber = PointerToString(serialNumberPtr)
    model = PointerToString(modelPtr)
    
    DeviceVersionText.Text = version
    DeviceSerialNumberText.Text = serialNumber
    DeviceModelText.Text = model
    
    'Liberando ponteiro de string versionPtr
    returnCode = CIDBIO_FreeString(versionPtr)
    If returnCode < 0 Then
        CaptureMsgText.Text = CaptureMsgText.Text + "Erro ao liberar string (versionPtr): " + returnMessage(returnCode) + vbCrLf
    End If
    'Liberando ponteiro de string serialNumberPtr
    returnCode = CIDBIO_FreeString(serialNumberPtr)
    If returnCode < 0 Then
        CaptureMsgText.Text = CaptureMsgText.Text + "Erro ao liberar string (serialNumberPtr): " + returnMessage(returnCode) + vbCrLf
    End If
    'Liberando ponteiro de string modelPtr
    returnCode = CIDBIO_FreeString(modelPtr)
    If returnCode < 0 Then
        CaptureMsgText.Text = CaptureMsgText.Text + "Erro ao liberar string (modelPtr): " + returnMessage(returnCode) + vbCrLf
    End If
End Sub



'########################
'CADASTRO E IDENTIFICAÇÃO
'########################



Private Sub EnrollCommand_Click()
    Dim id As Long
    Dim returnCode As Integer
    Dim id_64 As Currency 'Eu sei, é meio estranho usar Currency. Mas era preciso um tipo de 64 bits e esse pareceu o mais prático de usar
 
    id = CLng(Val(IDText.Text))
    
    If (id = 0) Then
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastro: Insira um ID válido para cadastro." + vbCrLf
    Else
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastro: Pressione seu dedo 3 vezes sobre o dispositivo." + vbCrLf
        DoEvents
        
        id_64 = CCur(id / 10000)
    
        returnCode = CIDBIO_CaptureAndEnroll(id_64)
    
        If (returnCode < 0) Then
            IdentificationMsgText.Text = IdentificationMsgText.Text + "Falha no cadastro: " + returnMessage(returnCode) + vbCrLf
        Else
            IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastro realizado! " + "Usuário com ID: " + str(id) + vbCrLf
            If (returnCode > 0) Then
                IdentificationMsgText.Text = IdentificationMsgText.Text + "Aviso: " + returnMessage(returnCode) + vbCrLf
            End If
        End If
    End If
End Sub

Private Sub IdentifyCommand_Click()
    Dim id As Long
    Dim score As Long
    Dim quality As Long
    Dim returnCode As Integer
    
    IdentificationMsgText.Text = IdentificationMsgText.Text + "Identificando... pressione o dedo sobre o dispositivo." + vbCrLf
    DoEvents
    
    returnCode = CIDBIO_CaptureAndIdentify(id, score, quality)
    
    If (returnCode < 0) Then
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Falha na identificação: " + returnMessage(returnCode) + vbCrLf
    Else
        IdentifiedText.Text = str(id)
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Usuário identificado! ID: " + str(id) + Chr(9) + "(Pontuação: " + str(score) + ", Qualidade: " + str(quality) + ")" + vbCrLf
        If (returnCode > 0) Then
            IdentificationMsgText.Text = IdentificationMsgText.Text + "Aviso: " + returnMessage(returnCode) + vbCrLf
        End If
    End If
End Sub

Private Sub ClearEnrollmentsCommand_Click()
    Dim returnCode As Integer
        
    returnCode = CIDBIO_DeleteAllTemplates()
    If (returnCode < 0) Then
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Falha ao apagar dados: " + returnMessage(returnCode) + vbCrLf
    Else
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastros apagados. " + vbCrLf
        If (returnCode > 0) Then
            IdentificationMsgText.Text = IdentificationMsgText.Text + "Aviso: " + returnMessage(returnCode) + vbCrLf
        End If
        IDListText.Text = ""
    End If
End Sub

Private Sub ReadIDsCommand_Click()
    Dim length As Long
    Dim idsPtr As Long
    Dim ids() As Long
    Dim idData() As Byte
    Dim returnCode As Integer
    Dim i As Integer
    
    
    returnCode = CIDBIO_GetTemplateIDs(idsPtr, length)
    If (returnCode < 0) Then
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Falha na leitura: " + returnMessage(returnCode) + vbCrLf
    Else
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Leitura dos IDs cadastrados: " + returnMessage(returnCode) + vbCrLf
    End If
    
    ReDim idData(8 * length)
    CopyMemory VarPtr(idData(0)), idsPtr, 8 * length
        
    ReDim ids(length)
    
    ids = LongArrayFromInt_64ByteArray(idData, length)
    
    IDListText.Text = ""
    For i = 0 To length - 1
        IDListText.Text = IDListText.Text + str(ids(i))
    Next
    
    returnCode = CIDBIO_FreeIDArray(idsPtr)
    If (returnCode < 0) Then
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Falha ao liberar dados: " + returnMessage(returnCode) + vbCrLf
    ElseIf (returnCode > 0) Then
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Liberar dados de idsPtr: " + returnMessage(returnCode) + vbCrLf
    End If
End Sub


'##########################
'FUNCIONALIDADE DO PROGRAMA
'##########################


Private Sub Form_Load()
    Frame1(0).ZOrder
    InitDevice
End Sub

Private Sub TabStrip1_Click()
    Dim i As Integer
    
    i = TabStrip1.SelectedItem.Index
    
    Frame1(i - 1).ZOrder
    
End Sub

Private Sub CloseCommand_Click()
    TerminateDevice
    Unload Me
End Sub

Private Sub IdentificationMsgText_Change()
     
    IdentificationMsgText.SelStart = Len(IdentificationMsgText.Text)
 
End Sub

Private Sub CaptureMsgText_Change()
     
    CaptureMsgText.SelStart = Len(CaptureMsgText.Text)
 
End Sub
