var ref = require('ref-napi');
var ffi = require('ffi-napi');

var platform = process.platform;

var libcidbioLoc = null;

if (platform === "win32") {
    libcidbioLoc = "./win64/libcidbio.dll"
  } else if (platform === "linux") {
    libcidbioLoc = "./linux_x64/libcidbio.so"
  } else {
    throw new Error("Plataforma não suportada para libcidbio")
  }

// typedef
var bytePtr = ref.refType('uint8');
var bytePrtPtr = ref.refType(bytePtr);
var uint32Ptr = ref.refType('uint32');
var int64Ptr = ref.refType('int64');
var in64PtrPtr = ref.refType(int64Ptr);
var charPtr = ref.refType('char');
var charPrtPtr = ref.refType(charPtr);
var int32Ptr = ref.refType('int32');

// binding
var libcidbio = ffi.Library(libcidbioLoc, {
    'CIDBIO_SetSerialCommPort': ['int32', ['string']],
    'CIDBIO_Init': [ 'int32', [ ]],
    'CIDBIO_Terminate' : ['int32', [ ]],
    'CIDBIO_CaptureImage' : ['int32', [bytePrtPtr, uint32Ptr, uint32Ptr]],
    'CIDBIO_CheckFingerprint' : ['int32', [bytePrtPtr, uint32Ptr, uint32Ptr]],
    'CIDBIO_CaptureImageAndTemplate' : ['int32', [charPrtPtr, bytePrtPtr, uint32Ptr, uint32Ptr, uint32Ptr]],
    'CIDBIO_CaptureAndEnroll' : ['int32', ['int64']],
    'CIDBIO_CaptureAndIdentify' : ['int32', [int64Ptr, int32Ptr, int32Ptr]],
    'CIDBIO_CaptureAndMatch' : ['int32', [int64Ptr, int32Ptr, int32Ptr]],
    'CIDBIO_ExtractTemplateFromImage' : ['int32', ['uint32', 'uint32', bytePtr, charPrtPtr, int32Ptr]],
    'CIDBIO_MergeTemplates' : ['int32', [charPtr, charPtr, charPtr, charPrtPtr]],
    'CIDBIO_MatchTemplates' : ['int32', [charPtr, charPtr, int32Ptr]],
    'CIDBIO_MatchTemplateByID' : ['int32', ['int64', charPtr, int32Ptr]],
    'CIDBIO_GetTemplateIDs' : ['int32', [in64PtrPtr, uint32Ptr]],
    'CIDBIO_GetTemplate' : ['int32', ['int64', charPrtPtr]],
    'CIDBIO_SaveTemplate' : ['int32', ['int64', charPtr]],
    'CIDBIO_DeleteTemplate' : ['int32', ['int64']],
    'CIDBIO_DeleteAllTemplates' : ['int32', []],
    'CIDBIO_SetParameter' : ['int32', ['int32', charPtr]],
    'CIDBIO_GetParameter' : ['int32', ['int32', charPrtPtr]],
    'CIDBIO_GetDeviceInfo' : ['int32', [charPrtPtr, charPrtPtr, charPrtPtr]],
    'CIDBIO_UpdateFirmware' : ['int32', [charPtr]],
    'CIDBIO_CancelCapture' : ['int32', [ ]],
    'CIDBIO_SetSerialBaudrate' : ['int32', ['int32']],
    'CIDBIO_GetErrorMessage' : ['int32', ['int32', charPrtPtr]],
    'CIDBIO_FreeByteArray' : ['int32', [bytePtr]],
    'CIDBIO_FreeString' : ['int32', [charPtr]],
    'CIDBIO_FreeIDArray' : ['int32', [int64Ptr]]
});

module.exports = libcidbio