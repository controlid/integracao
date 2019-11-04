VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4980
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4710
   LinkTopic       =   "Form1"
   ScaleHeight     =   4980
   ScaleWidth      =   4710
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   3375
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   3
      Text            =   "Form1.frx":0000
      Top             =   1440
      Width           =   4335
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Ler AFD"
      Enabled         =   0   'False
      Height          =   495
      Left            =   3000
      TabIndex        =   2
      Top             =   240
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Conectar"
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   960
      Width           =   4215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim rep As New RepCid.RepCid

Private Sub Command1_Click()
Dim er As ErrosRep
'rep.iDClass_ConfigurePort 4433
er = rep.Conectar_vb6("192.168.2.104", 443, 0)
Label1.Caption = er

If er = ErrosRep_OK Then
    Dim doc As String
    Dim tipo As Long
    Dim cei As String
    Dim razao As String
    Dim endereco As String

    If rep.LerEmpregador(doc, tipo, cei, razao, endereco) Then
        Label1.Caption = "OK empregador Lido: " + doc + " - " + razao
        Command2.Enabled = True
    Else
        Label1.Caption = "Erro ao ler empregador"
    End If
    
End If

End Sub

Private Sub Command2_Click()
Text1.Text = rep.ObterCompletoAFD()
End Sub
