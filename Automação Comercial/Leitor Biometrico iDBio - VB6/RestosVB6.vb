Private Sub EnrollCommand_Click()
    Dim id As Long
    Dim returnCode As Integer
    Dim idByteArray() As Byte
    Dim j As Integer
    Dim id_64 As Currency
    
    Dim byteData(8) As Byte
    Dim ids() As Long
    id = CLng(Val(IDText.Text))
    
    If (id = 0) Then
        IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastro: Insira um ID válido para cadastro." + vbCrLf
    Else
        
        IdentificationMsgText.Text = IdentificationMsgText.Text + "ID recebido (Long): " + str(id) + vbCrLf
        
        id_64 = CCur(id / 10000)
        
        IdentificationMsgText.Text = IdentificationMsgText.Text + "ID conv1(Currency): " + str(id_64) + vbCrLf
        
        ReDim ids(1)
        CopyMemory VarPtr(byteData(0)), VarPtr(id_64), 8
        ids = LongArrayFromInt_64ByteArray(byteData, 1)
        
        IdentificationMsgText.Text = IdentificationMsgText.Text + vbCrLf + "ID convertido(Long): " + str(ids(0)) + vbCrLf
        
        
        'returnCode = CIDBIO_CaptureAndEnroll(idByteArray)
    
        'If (returnCode < 0) Then
        '    IdentificationMsgText.Text = IdentificationMsgText.Text + "Falha no cadastro: " + returnMessage(returnCode) + vbCrLf
        'Else
        '    IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastro realizado: " + returnMessage(returnCode) + ". Usuário com ID: " + str(id) + vbCrLf
        'End If
    End If
End Sub

Private Function StrFromPtr(ByVal lPtr As Long) As String
    Dim lLen As Long
    Dim abytBuf() As Byte

    'Get the length of the string at the memory location
    lLen = lstrlenW(lPtr) * 2 - 1   'Unicode string (must double the buffer size)
    
    If lLen > 0 Then
        ReDim abytBuf(lLen)
        'Copy the memory contents
        'into a they byte buffer
        Call CopyMem(abytBuf(0), ByVal lPtr, lLen)
        'convert and return the buffer
        StrFromPtr = abytBuf
    End If
End Function

Private Function PointerToString(lngPtr As Long) As String
'--------------------------------------------------------
'RETURNS A STRING FROM IT'S POINTER
'EXAMPLE:
'-- Generate pointer for demo purposes

'Dim l As Long
'Dim s As String
's = "THIS IS A TEST"
'l = StrPtr(s)

'--We have the pointer, call the function

'MsgBox PointerToString(l)

'NOTE: THE ASSUMPTION IS THAT THE POINTER IS TO A UNICODE STRING
'IF NOT, CHANGE THE FUNCTION AS FOLLOWS (UNTESTED)
'-- Change lstrlenW to lStrLena
'-- Get rid of the * 2
'-- The replace statement should not be necessary, just return strTemp
'----------------------------------------------------------
   
   Dim strTemp As String
   Dim lngLen As Long
       
   If lngPtr Then
      lngLen = lstrlenA(lngPtr) ' * 2
      CaptureMsgText.Text = CaptureMsgText.Text + "Ponteiro: " + str(lngPtr) + vbCrLf
      CaptureMsgText.Text = CaptureMsgText.Text + "Tamanho: " + str(lngLen) + vbCrLf
      If lngLen Then
         strTemp = Space(lngLen)
         CopyMemory ByVal strTemp, ByVal lngPtr, lngLen
         PointerToString = strTemp ', Chr(0), "")
      End If
   End If
End Function

Private Sub EnrollCommand_Click()
    Dim id As Long
    Dim returnCode As Integer
    'Dim id_64 As Currency
 
    id = CLng(Val(IDText.Text))
    
    '__________________________________________________________________________________________________
    Dim idsPtr As Long
    Dim length As Long
    Dim idData() As Byte
    Dim ids() As Long
    Dim id_64 As Long
    returnCode = CIDBIO_GetTemplateIDs(idsPtr, length)
    ReDim idData(8 * length)
    CopyMemory VarPtr(idData(0)), idsPtr, 8 * length
    ids = LongArrayFromInt_64ByteArray(idData, length)
    
    'id_64 = CCur(id / 10000)
    id_64 = id
    ReDim idData(8)
    CopyMemory VarPtr(idData(0)), VarPtr(id_64), 8
    ids = LongArrayFromInt_64ByteArray(idData, 1)
    '__________________________________________________________________________________________________
    
    'If (id = 0) Then
    '    IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastro: Insira um ID válido para cadastro." + vbCrLf
    'Else
    '    id_64 = CCur(id / 10000)
    '
    '    returnCode = CIDBIO_CaptureAndEnroll(id_64)
    '
    '    If (returnCode < 0) Then
    '        IdentificationMsgText.Text = IdentificationMsgText.Text + "Falha no cadastro: " + returnMessage(returnCode) + vbCrLf
    '    Else
    '        IdentificationMsgText.Text = IdentificationMsgText.Text + "Cadastro realizado: " + returnMessage(returnCode) + ". Usuário com ID: " + str(id) + vbCrLf
    '    End If
    'End If
End Sub


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
        IdentificationMsgText.Text = IdentificationMsgText.Text + vbCrLf + "Byte[" + str(i) + "] ="
        For j = 0 To 7 'O limite de 3 corta os 32 bits mais significativos
            longItem = longItem + byteList(j + i * 8) * 10 ^ j
            IdentificationMsgText.Text = IdentificationMsgText.Text + "  " + str(byteList(j + i * 8))
        Next
        longList(i) = longItem
    Next
    LongArrayFromInt_64ByteArray = longList
End Function


