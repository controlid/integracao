unit ControliD;

interface
  uses  Classes, Forms, dialogs, Sysutils, windows;

 Type

   TCIDBIO_SetSerialCommPort = Function (commPort : PAnsiChar): Integer; cdecl;
   TCIDBIO_Init = Function(): Integer; cdecl;
   TCIDBIO_Terminate = Function() : Integer; cdecl;

   TCIDBIO_CaptureImage = Function(Out imageBuf : PByte; Out width : Integer; Out height : Integer): Integer; cdecl;
   TCIDBIO_CaptureImageAndTemplate = Function(Out t : PAnsiChar; Out imageBuf : PByte; Out width : Integer; Out height : Integer; Out quality : Integer): Integer; cdecl;
   TCIDBIO_CaptureAndEnroll = Function(id : Int64): Integer; cdecl;
   TCIDBIO_CaptureAndIdentify = Function(Out id : Int64; Out score : Integer; Out quality : Integer): Integer; cdecl;
   TCIDBIO_CaptureAndMatch = Function(id : Int64; Out score : Integer; Out quality : Integer): Integer; cdecl;
   TCIDBIO_CheckFingerprint = Function(Out imageBuf : PByte; Out width : Integer; Out height : Integer): Integer; cdecl;
   TCIDBIO_CancelCapture = Function(): Integer; cdecl;

   TCIDBIO_ExtractTemplateFromImage = Function(width : Integer; height : Integer; imageBuf : PByte; Out t : PAnsiChar; Out quality : Integer): Integer; cdecl;
   TCIDBIO_MergeTemplates = Function(t1 : PAnsiChar; t2 : PAnsiChar; t3 : PAnsiChar; Out tFinal : PAnsiChar): Integer; cdecl;
   TCIDBIO_MatchTemplates = Function(t1 : PAnsiChar; t2 : PAnsiChar; Out score : Integer): Integer; cdecl;
   TCIDBIO_MatchTemplateByID = Function(id : Int64; t : PAnsiChar; Out score : Integer): Integer; cdecl;

   TCIDBIO_GetTemplateIDs = Function(Out ids : PInt64; Out len : Integer): Integer; cdecl;
   TCIDBIO_GetTemplate = Function(id : Int64; Out t : PAnsiChar): Integer; cdecl;
   TCIDBIO_SaveTemplate = Function(id : Int64; t : PAnsiChar): Integer; cdecl;
   TCIDBIO_DeleteTemplate = Function(id : Int64): Integer; cdecl;
   TCIDBIO_DeleteAllTemplates = Function(): Integer; cdecl;

   TCIDBIO_SetParameter = Function(config : Integer; value : PAnsiChar): Integer; cdecl;
   TCIDBIO_GetParameter = Function(config : Integer; Out value : PAnsiChar): Integer; cdecl;
   TCIDBIO_GetDeviceInfo = Function(Out version : PAnsiChar; Out serialNumber : PAnsiChar; Out model : PAnsiChar): Integer; cdecl;
   TCIDBIO_UpdateFirmware = Function(filePath : PAnsiChar): Integer; cdecl;
   TCIDBIO_GetErrorMessage = Function(error : Integer; Out msg : PAnsiChar): Integer; cdecl;
   TCIDBIO_FreeByteArray = Function(ptr : PByte): Integer; cdecl;
   TCIDBIO_FreeString = Function(ptr : PAnsiChar): Integer; cdecl;
   TCIDBIO_FreeIDArray = Function(ptr : PInt64): Integer; cdecl;


  const
    MIN_VAR = 1;
    SIMILIARITY_THRESHOLD = 2;
    BUZZER_ON = 4 ;
    TEMPLATE_FORMAT = 5;
    ROTATION = 6;
    DETECT_TIMEOUT = 7;

    WARNING_OVERWRITING_TEMPLATE = 3;
    WARNING_NO_IDS_ON_DEVICE = 2;
    WARNING_ALREADY_INIT = 1;
    SUCCESS = 0;
    ERROR_UNKNOWN = -1;
    ERROR_NO_DEVICE = -2;
    ERROR_NULL_ARGUMENT = -3 ;
    ERROR_INVALID_ARGUMENT = -4;
    ERROR_CAPTURE = -5;
    ERROR_CAPTURE_TIMEOUT = -6;
    ERROR_COMM_USB = -7;
    ERROR_IO_ON_HOST = -8;
    ERROR_TEMPLATE_ALREADY_ENROLLED = -9;
    ERROR_MERGING = -10;
    ERROR_MATCHING = -11;
    ERROR_INVALID_FW_FILE = -12;
    ERROR_NO_SPACE_LEFT_ON_DEVICE = -13  ;
    ERROR_NO_TEMPLATE_WITH_ID = -14;
    ERROR_INVALID_ERRNO = -15;
    ERROR_UNAVAILABLE_FEATURE = -16;
    ERROR_PREVIOUS_FW_VERSION = -17;
    ERROR_NOT_IDENTIFIED = -18;
    ERROR_BUSY = -19;
    ERROR_CAPTURE_CANCELED = -20;
    ERROR_NO_FINGER_DETECTED = -21;


  type
    ByteArray = array of byte;
    Int64Array = array of Int64;

  CIDBio = Class(TObject)
    Public
      MyLibC: THandle;
      Path : String;

      CIDBIO_SetSerialCommPort : TCIDBIO_SetSerialCommPort;
      CIDBIO_Init : TCIDBIO_Init;
      CIDBIO_Terminate : TCIDBIO_Terminate;
      CIDBIO_CaptureImage : TCIDBIO_CaptureImage;
      CIDBIO_CaptureImageAndTemplate : TCIDBIO_CaptureImageAndTemplate;
      CIDBIO_CaptureAndEnroll : TCIDBIO_CaptureAndEnroll;
      CIDBIO_CaptureAndIdentify : TCIDBIO_CaptureAndIdentify;
      CIDBIO_CaptureAndMatch : TCIDBIO_CaptureAndMatch;
      CIDBIO_CheckFingerprint : TCIDBIO_CheckFingerprint;
      CIDBIO_CancelCapture : TCIDBIO_CancelCapture;
      CIDBIO_ExtractTemplateFromImage : TCIDBIO_ExtractTemplateFromImage;
      CIDBIO_MergeTemplates : TCIDBIO_MergeTemplates;
      CIDBIO_MatchTemplates : TCIDBIO_MatchTemplates;
      CIDBIO_MatchTemplateByID : TCIDBIO_MatchTemplateByID;
      CIDBIO_GetTemplateIDs : TCIDBIO_GetTemplateIDs;
      CIDBIO_GetTemplate : TCIDBIO_GetTemplate;
      CIDBIO_SaveTemplate : TCIDBIO_SaveTemplate;
      CIDBIO_DeleteTemplate : TCIDBIO_DeleteTemplate;
      CIDBIO_DeleteAllTemplates : TCIDBIO_DeleteAllTemplates;
      CIDBIO_SetParameter : TCIDBIO_SetParameter;
      CIDBIO_GetParameter : TCIDBIO_GetParameter;
      CIDBIO_GetDeviceInfo : TCIDBIO_GetDeviceInfo;
      CIDBIO_UpdateFirmware : TCIDBIO_UpdateFirmware;
      CIDBIO_GetErrorMessage : TCIDBIO_GetErrorMessage;
      CIDBIO_FreeString : TCIDBIO_FreeString;
      CIDBIO_FreeByteArray : TCIDBIO_FreeByteArray;
      CIDBIO_FreeIDArray : TCIDBIO_FreeIDArray;

      Function SetSerialCommPort(commPort : String): Integer; 
      Function Init: Integer;
      Function Terminate: Integer;

      Function CaptureImage(Out imageBuf : ByteArray; out width, height : Integer): Integer;
      Function CaptureImageAndTemplate(Out t : String ; Out imageBuf : ByteArray;
        out width, height, quality : Integer): Integer;
      Function CaptureAndEnroll(id : Int64): Integer;
      Function CaptureAndIdentify(Out id : Int64; Out score, quality : Integer): Integer;
      Function CaptureAndMatch(id : Int64; Out score, quality : Integer): Integer;
      Function CheckFingerprint(Out imageBuf : ByteArray; out width, height : Integer): Integer;
      Function CancelCapture: Integer;

      Function ExtractTemplateFromImage(width, height : Integer; image : ByteArray;
        Out t : String; Out quality : Integer): Integer;
      Function MergeTemplates(t1, t2, t3 : String; Out tFinal : String): Integer;
      Function MatchTemplates(t1, t2 : String; Out score : Integer): Integer;
      Function MatchTemplateByID(id : Int64; t : String; Out score : Integer): Integer;

      Function GetTemplateIDs(Out ids : Int64Array): Integer;
      Function GetTemplate(id : Int64; Out t : String): Integer;
      Function SaveTemplate(id : Int64; t : String): Integer;
      Function DeleteTemplate(id : Int64): Integer;
      Function DeleteAllTemplates: Integer;

      Function SetParameter(config : Integer; value: String): Integer;
      Function GetParameter(config : Integer; Out value : String): Integer;
      Function GetDeviceInfo(out version, serialNumber, model : String): Integer;
      Function UpdateFirmware(filePath : String): Integer;

      Function GetErrorMessage(error : Integer): String;

      Constructor Create();
      Destructor Destroy;

    Private
      Function CopyAndDeleteString(ptr : PAnsiChar): String;
      Function CopyAndDeleteBytes(ptr : PByte; length : Integer): ByteArray;
      Function CopyAndDeleteIds(ptr : PInt64; length : Integer): Int64Array;

  end;

implementation

  constructor CIDBio.Create();
  begin
     path :=  ExtractFilePath(application.ExeName);
     path :=  path + 'libcidbio.dll';
     MyLibC := LoadLibrary(pchar(path));

     if MyLibC = 0 then
     begin
        Application.MessageBox(pchar('Não carregou a DLL '),'Atenção', MB_ICONWARNING);
        Exit;  //DLL was not loaded successfully
     end;

     CIDBIO_SetSerialCommPort := TCIDBIO_SetSerialCommPort(GetProcAddress(MyLibC, 'CIDBIO_SetSerialCommPort'));
     CIDBIO_Init := TCIDBIO_Init(GetProcAddress(MyLibC, 'CIDBIO_Init'));
     CIDBIO_Terminate := TCIDBIO_Terminate(GetProcAddress(MyLibC, 'CIDBIO_Terminate'));
     CIDBIO_CaptureImage := TCIDBIO_CaptureImage(GetProcAddress(MyLibC, 'CIDBIO_CaptureImage'));
     CIDBIO_CaptureImageAndTemplate := TCIDBIO_CaptureImageAndTemplate(GetProcAddress(MyLibC, 'CIDBIO_CaptureImageAndTemplate'));
     CIDBIO_CaptureAndEnroll := TCIDBIO_CaptureAndEnroll(GetProcAddress(MyLibC, 'CIDBIO_CaptureAndEnroll'));
     CIDBIO_CaptureAndIdentify := TCIDBIO_CaptureAndIdentify (GetProcAddress(MyLibC, 'CIDBIO_CaptureAndIdentify'));
     CIDBIO_CaptureAndMatch := TCIDBIO_CaptureAndMatch (GetProcAddress(MyLibC, 'CIDBIO_CaptureAndMatch'));
     CIDBIO_CheckFingerprint := TCIDBIO_CheckFingerprint (GetProcAddress(MyLibC, 'CIDBIO_CheckFingerprint'));
     CIDBIO_CancelCapture := TCIDBIO_CancelCapture (GetProcAddress(MyLibC, 'CIDBIO_CancelCapture'));
     CIDBIO_ExtractTemplateFromImage := TCIDBIO_ExtractTemplateFromImage (GetProcAddress(MyLibC, 'CIDBIO_ExtractTemplateFromImage'));
     CIDBIO_MergeTemplates := TCIDBIO_MergeTemplates (GetProcAddress(MyLibC, 'CIDBIO_MergeTemplates'));
     CIDBIO_MatchTemplates := TCIDBIO_MatchTemplates (GetProcAddress(MyLibC, 'CIDBIO_MatchTemplates'));
     CIDBIO_MatchTemplateByID := TCIDBIO_MatchTemplateByID (GetProcAddress(MyLibC, 'CIDBIO_MatchTemplateByID'));
     CIDBIO_GetTemplateIDs := TCIDBIO_GetTemplateIDs (GetProcAddress(MyLibC, 'CIDBIO_GetTemplateIDs'));
     CIDBIO_GetTemplate := TCIDBIO_GetTemplate (GetProcAddress(MyLibC, 'CIDBIO_GetTemplate'));
     CIDBIO_SaveTemplate := TCIDBIO_SaveTemplate (GetProcAddress(MyLibC, 'CIDBIO_SaveTemplate'));
     CIDBIO_DeleteTemplate := TCIDBIO_DeleteTemplate (GetProcAddress(MyLibC, 'CIDBIO_DeleteTemplate'));
     CIDBIO_DeleteAllTemplates := TCIDBIO_DeleteAllTemplates (GetProcAddress(MyLibC, 'CIDBIO_DeleteAllTemplates'));
     CIDBIO_SetParameter := TCIDBIO_SetParameter (GetProcAddress(MyLibC, 'CIDBIO_SetParameter'));
     CIDBIO_GetParameter := TCIDBIO_GetParameter (GetProcAddress(MyLibC, 'CIDBIO_GetParameter'));
     CIDBIO_GetDeviceInfo := TCIDBIO_GetDeviceInfo (GetProcAddress(MyLibC, 'CIDBIO_GetDeviceInfo'));
     CIDBIO_UpdateFirmware := TCIDBIO_UpdateFirmware (GetProcAddress(MyLibC, 'CIDBIO_UpdateFirmware'));
     CIDBIO_GetErrorMessage := TCIDBIO_GetErrorMessage (GetProcAddress(MyLibC, 'CIDBIO_GetErrorMessage'));
     CIDBIO_FreeString := TCIDBIO_FreeString (GetProcAddress(MyLibC, 'CIDBIO_FreeString'));
     CIDBIO_FreeByteArray := TCIDBIO_FreeByteArray (GetProcAddress(MyLibC, 'CIDBIO_FreeByteArray'));
     CIDBIO_FreeIDArray := TCIDBIO_FreeIDArray (GetProcAddress(MyLibC, 'CIDBIO_FreeIDArray'));
  end;

  destructor CIDBio.Destroy;
  begin
     if MyLibC <> 0 then
       if FreeLibrary(MyLibC) then
         MyLibC := 0;  //Unload the lib, if already loaded
     inherited Destroy;
  end;

  Function CIDBio.SetSerialCommPort(commPort : String) : Integer;
  begin
    result := CIDBIO_SetSerialCommPort(PAnsiChar(AnsiString(commPort)));
  end;

  Function CIDBio.Init: Integer;
  begin
    Result := CIDBIO_Init();
  end;

  Function CIDBio.Terminate: Integer;
  begin
    Result := CIDBIO_Terminate();
  end;

  Function CIDBio.CaptureImage(Out imageBuf : ByteArray; out width, height : Integer): Integer;
  var
    pImage : PByte;
    ret : Integer;
  begin
    ret := CIDBIO_CaptureImage(pImage, width, height);
    imageBuf := CopyAndDeleteBytes(pImage, width*height);
    Result := ret;
  end;

  Function CIDBio.CaptureImageAndTemplate(Out t : String ; Out imageBuf : ByteArray;
    out width, height, quality : Integer): Integer;
  var
    pImage : PByte;
    pTemplate : PAnsiChar;
    ret : Integer;
  begin
    ret := CIDBIO_CaptureImageAndTemplate(pTemplate, pImage, width, height, quality);
    t := CopyAndDeleteString(pTemplate);
    imageBuf := CopyAndDeleteBytes(pImage, width*height);
    Result := ret;
  end;

  Function CIDBio.CaptureAndEnroll(id : Int64): Integer;
  begin
    Result := CIDBIO_CaptureAndEnroll(id);
  end;

  Function CIDBio.CaptureAndIdentify(Out id : Int64; Out score, quality : Integer) : Integer;
  begin
    Result := CIDBIO_CaptureAndIdentify(id, score, quality);
  end;

  Function CIDBio.CaptureAndMatch(id : Int64; Out score, quality : Integer) : Integer;
  begin
    Result := CIDBIO_CaptureAndMatch(id, score, quality);
  end;

  Function CIDBio.CheckFingerprint(Out imageBuf : ByteArray; out width, height : Integer): Integer;
  var
    pImage : PByte;
    ret : Integer;
  begin
    ret := CIDBIO_CheckFingerprint(pImage, width, height);
    imageBuf := CopyAndDeleteBytes(pImage, width*height);
    Result := ret;
  end;

  Function CIDBio.CancelCapture: Integer;
  begin
    Result := CIDBIO_CancelCapture();
  end;

  Function CIDBio.ExtractTemplateFromImage(width, height : Integer; image : ByteArray;
        Out t : String; Out quality : Integer) : Integer;
  var
    pTemplate : PAnsiChar;
    ret : Integer;
  begin
    ret := CIDBIO_ExtractTemplateFromImage(width, height, PByte(image), pTemplate, quality);
    t := CopyAndDeleteString(pTemplate);
    Result := ret;
  end;

  Function CIDBio.MergeTemplates(t1, t2, t3 : String; Out tFinal : String) : Integer;
  var
    pTemplate : PAnsiChar;
    ret : Integer;
  begin
    ret := CIDBIO_MergeTemplates(PAnsiChar(AnsiString(t1)), PAnsiChar(AnsiString(t2)), PAnsiChar(AnsiString(t3)), pTemplate);
    tFinal := CopyAndDeleteString(pTemplate);
    Result := ret;
  end;

  Function CIDBio.MatchTemplates(t1, t2 : String; Out score : Integer): Integer;
  begin
    Result := CIDBIO_MatchTemplates(PAnsiChar(AnsiString(t1)), PAnsiChar(AnsiString(t2)), score);
  end;

  Function CIDBio.MatchTemplateByID(id : Int64; t : String; Out score : Integer): Integer;
  begin
    Result := CIDBIO_MatchTemplateByID(id, PAnsiChar(AnsiString(t)), score);
  end;

  Function CIDBio.GetTemplateIDs(Out ids : Int64Array): Integer;
  var
    pIds : PInt64;
    len : Integer;
    ret : Integer;
  begin
    ret := CIDBIO_GetTemplateIDs(pIds, len);
    ids := CopyAndDeleteIds(pIds, len);
    Result := ret;
  end;

  Function CIDBio.GetTemplate(id : Int64; Out t : String): Integer;
  var
    pTemplate : PAnsiChar;
    ret : Integer;
  begin
    ret := CIDBIO_GetTemplate(id, pTemplate);
    t := CopyAndDeleteString(pTemplate);
    Result := ret;
  end;

  Function CIDBio.SaveTemplate(id : Int64; t : String): Integer;
  begin
    Result := CIDBIO_SaveTemplate(id, PAnsiChar(AnsiString(t)));
  end;

  Function CIDBio.DeleteTemplate(id : Int64): Integer;
  begin
    Result := CIDBIO_DeleteTemplate(id);
  end;

  Function CIDBio.DeleteAllTemplates(): Integer;
  begin
    Result := CIDBIO_DeleteAllTemplates();
  end;

  Function CIDBio.SetParameter(config : Integer; value : String): Integer;
  begin
    Result := CIDBIO_SetParameter(Ord(config), PAnsiChar(AnsiString(value)));
  end;

  Function CIDBio.GetParameter(config : Integer; out value : String): Integer;
  var
    pValue : PAnsiChar;
    ret : Integer;
  begin
    ret := CIDBIO_GetParameter(Ord(config), pValue);
    value := CopyAndDeleteString(pValue);
    Result := ret;
  end;

  Function CIDBio.GetDeviceInfo(out version, serialNumber, model : String): Integer;
  var
    pVersion, pSerialNumber, pModel : PAnsiChar;
    ret : Integer;
  begin
    ret := CIDBIO_GetDeviceInfo(pVersion, pSerialNumber, pModel);
    version := CopyAndDeleteString(pVersion);
    serialNumber := CopyAndDeleteString(pSerialNumber);
    model := CopyAndDeleteString(pModel);
    Result := ret;
  end;

  Function CIDBio.UpdateFirmware(filePath : String): Integer;
  begin
    Result := CIDBIO_UpdateFirmware(PAnsiChar(AnsiString(filePath)));
  end;

  Function CIDBio.GetErrorMessage(error : Integer): String;
  var
    pMessage: PAnsiChar;
    ret : Integer;
  begin
    ret := CIDBIO_GetErrorMessage(Ord(error), pMessage);
    if ret < SUCCESS then
      Result := ''
    else
      Result := CopyAndDeleteString(pMessage)
    end;


  Function CIDBio.CopyAndDeleteString(ptr : PAnsiChar): String;
  var
    str : string;
  begin
    if ptr = Nil then
      Result := ''
    else begin
      str := Copy(String(AnsiString(ptr)), 1, MaxInt);
      CIDBIO_FreeString(ptr);
      Result := str;
    end;
  end;

  Function CIDBio.CopyAndDeleteBytes(ptr : PByte; length : Integer): ByteArray;
  var
    vec : ByteArray;
  begin
    if ptr = Nil then
      Result := nil
    else begin
      SetLength(vec, length);
      Move(ptr^, vec[0], SizeOf(Byte) * length);
      CIDBIO_FreeByteArray(ptr);
      Result := vec;
    end;
  end;

  Function CIDBio.CopyAndDeleteIds(ptr : PInt64; length : Integer): Int64Array;
  var
    vec : Int64Array;
  begin
    if ptr = Nil then
      Result := nil
    else begin
      SetLength(vec, length);
      Move(ptr^, vec[0], SizeOf(Int64) * length);
      CIDBIO_FreeIDArray(ptr);
      Result := vec;
    end;
  end;

end.
