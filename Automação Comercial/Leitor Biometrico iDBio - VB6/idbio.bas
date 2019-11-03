Attribute VB_Name = "Module1"
'FUNÇÕES IMPORTADAS PARA APOIO
Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
    ByVal Destination As Any, _
    ByVal Source As Any, _
    ByVal length As Long)
Declare Sub CopyMem Lib "kernel32" Alias "RtlMoveMemory" ( _
    ByRef Destination As Any, _
    ByRef Source As Any, _
    ByVal lSize As Long)
Declare Function lstrlenW Lib "kernel32" ( _
    ByVal lpString As Long _
) As Long
Declare Function lstrlenA Lib "kernel32" ( _
    ByVal lpString As Long _
) As Long

'FUNÇÕES IMPORTADAS DE LIBCIDBIO.DLL
'Habilitação do dispositivo
Declare Function CIDBIO_Init Lib "libcidbio.dll" () As Integer
Declare Function CIDBIO_Terminate Lib "libcidbio.dll" () As Integer

'Captura
Declare Function CIDBIO_CaptureImage Lib "libcidbio.dll" ( _
    ByRef imagebuf As Long, _
    ByRef width As Long, _
    ByRef height As Long _
    ) As Integer
    
'Liberação de memória
Declare Function CIDBIO_FreeByteArray Lib "libcidbio.dll" ( _
    ByRef byteArray As Long _
) As Integer
Declare Function CIDBIO_FreeString Lib "libcidbio.dll" ( _
    ByRef str _
) As Integer
Declare Function CIDBIO_FreeIDArray Lib "libcidbio.dll" ( _
    ByRef ids As Long _
) As Integer
Declare Function CIDBIO_GetDeviceInfo Lib "libcidbio.dll" ( _
    ByRef version As Long, _
    ByRef serialNumber As Long, _
    ByRef model As Long _
) As Integer

'Funções de cadastro
Declare Function CIDBIO_CaptureAndEnroll Lib "libcidbio.dll" ( _
    ByVal id As Currency _
) As Integer

Declare Function CIDBIO_CaptureAndIdentify Lib "libcidbio.dll" ( _
    ByRef id As Long, _
    ByRef score As Long, _
    ByRef quality As Long _
) As Integer

Declare Function CIDBIO_GetTemplateIDs Lib "libcidbio.dll" ( _
    ByRef ids As Long, _
    ByRef length As Long _
) As Integer

Declare Function CIDBIO_DeleteAllTemplates Lib "libcidbio.dll" () As Integer
