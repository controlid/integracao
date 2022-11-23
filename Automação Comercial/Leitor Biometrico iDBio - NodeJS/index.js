var ref = require('ref-napi');
var ffi = require('ffi-napi');
var libcidbio = require("./libcidbio")

// typedef
var bytePtr = ref.refType('uint8');
var bytePrtPtr = ref.refType(bytePtr);
var uint32Ptr = ref.refType('uint32');
var int64Ptr = ref.refType('int64');
var in64PtrPtr = ref.refType(int64Ptr);
var charPtr = ref.refType('char');
var charPrtPtr = ref.refType(charPtr);
var int32Ptr = ref.refType('int32');

const RetCode =
{
    WARNING_OVERWRITING_TEMPLATE: 3,
    WARNING_NO_IDS_ON_DEVICE: 2,
    WARNING_ALREADY_INIT: 1,
    SUCCESS: 0,
    ERROR_UNKNOWN: -1,
    ERROR_NO_DEVICE: -2,
    ERROR_NULL_ARGUMENT: -3,
    ERROR_INVALID_ARGUMENT: -4,
    ERROR_CAPTURE: -5,
    ERROR_CAPTURE_TIMEOUT: -6,
    ERROR_COMM_USB: -7,
    ERROR_IO_ON_HOST: -8,
    ERROR_TEMPLATE_ALREADY_ENROLLED: -9,
    ERROR_MERGING: -10,
    ERROR_MATCHING: -11,
    ERROR_INVALID_FW_FILE: -12,
    ERROR_NO_SPACE_LEFT_ON_DEVICE: -13,
    ERROR_NO_TEMPLATE_WITH_ID: -14,
    ERROR_INVALID_ERRNO: -15,
    ERROR_UNAVAILABLE_FEATURE: -16,
    ERROR_PREVIOUS_FW_VERSION: -17,
    ERROR_NOT_IDENTIFIED: -18,
    ERROR_BUSY: -19,
    ERROR_CAPTURE_CANCELED: -20,
    ERROR_NO_FINGER_DETECTED: -21,
    ERROR_INVALID_TEMPLATE: -22
}

function getError(retCode) {
    for (let x in RetCode) {
        if (RetCode[x] == retCode) {
            return String(x);
        }
      } 
}

function Init() {
    console.log("** Executando método Init() **");
    let res = libcidbio.CIDBIO_Init();

    if (res == RetCode.SUCCESS) {
        console.log("iDBio inicializado com sucesso");
    } else {
        console.log("Falha ao inicializar iDBio");
        console.log(getError(res));
    }
}

function SetSerialCommPort(commPort) {
    console.log("** Executando método SetSerialCommPort() **");
    let res = libcidbio.CIDBIO_SetSerialCommPort(commPort);

    if (res == RetCode.SUCCESS) {
        console.log("Sucesso na definição da porta");
    } else {
        console.log("Falha ao configurar porta");
        console.log(getError(res));
    }
}

function Terminate() {
    console.log("** Executando método Terminate() **");
    let res = libcidbio.CIDBIO_Terminate();
    if (res == RetCode.SUCCESS) {
        console.log("iDBio terminado com sucesso");
    } else {
        console.log("Falha ao terminar iDBio");
        console.log(getError(res));
    }
}

function CaptureImage() {
    console.log("** Executando método CaptureImage() **");
    var imageBufPtrPtr = ref.alloc(bytePtr);
    var widthPtr = ref.alloc('uint32');
    var heightPtr = ref.alloc('uint32');
    var res = libcidbio.CIDBIO_CaptureImage(imageBufPtrPtr, widthPtr, heightPtr);

    var width = widthPtr.deref();
    var heigth = heightPtr.deref();
    var size = width*heigth;

    if(ref.isNull(imageBufPtrPtr.deref())) {
        console.log("Retornado ponteiro vazio");
        console.log("width: " + width);
        console.log("heigth: " + heigth);
        console.log(getError(res));
        return;
    }

    var imageBufTmp = ref.reinterpret(imageBufPtrPtr.deref(), size);

    var imageBuf = new Buffer.alloc(size);

    imageBufTmp.copy(imageBuf, 0);

    var res2 = libcidbio.CIDBIO_FreeByteArray(imageBufTmp);

    if (res2 == RetCode.SUCCESS) {
        console.log("Sucesso ao liberar memória deste parâmetro");
    } else {
        console.log("Falha ao liberar memória deste parâmetro");
        getError(res2);
    }

    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao capturar imagem");
        console.log(imageBuf);
        console.log("width: " + width);
        console.log("heigth: " + heigth);
    } else {
        console.log("Falha ao capturar imagem");
        console.log(getError(res));
    }
}

function CaptureAndEnroll(id) {
    console.log("** Executando método CaptureAndEnroll() **");
    var res = libcidbio.CIDBIO_CaptureAndEnroll(id);
    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao cadastrar");
    } else {
        console.log("Falha ao cadastrar");
        console.log(getError(res));
    }
}

function DeleteAllTemplates() {
    console.log("** Executando método DeleteAllTemplates() **");
    var res = libcidbio.CIDBIO_DeleteAllTemplates();
    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao deletar todos os templates");
    } else {
        console.log("Falha ao deletar todos os templates");
        console.log(getError(res));
    }
}

function GetTemplateIDs() {
    console.log("** Executando método GetTemplateIDs() **");
    var idsBufPtrPtr = ref.alloc(int64Ptr);
    var lenPtr = ref.alloc('uint32');
    var res = libcidbio.CIDBIO_GetTemplateIDs(idsBufPtrPtr, lenPtr);

    var len = lenPtr.deref();

    if(ref.isNull(idsBufPtrPtr.deref())) {
        console.log("Retornado ponteiro vazio");
        console.log("len: " + len);
        console.log(getError(res));
        return;
    }
    var idsTmp = ref.reinterpret(idsBufPtrPtr.deref(), len*8);
    var ids = new Buffer.alloc(len*8);

    idsTmp.copy(ids, 0);

    var res2 = libcidbio.CIDBIO_FreeIDArray(idsTmp);

    if (res2 == RetCode.SUCCESS) {
        console.log("Sucesso ao liberar memória deste parâmetro");
    } else {
        console.log("Falha ao liberar memória deste parâmetro");
        getError(res2);
    }

    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao coletar os ids de todos os templates");
        console.log(ids);
        console.log("len: " + len);
    } else {
        console.log("Falha ao coletar os ids de todos os templates");
        console.log(getError(res));
    }
}

function CaptureAndIdentify() {
    console.log("** Executando método CaptureAndIdentify() **");
    var idPtr = ref.alloc('int64');
    var scorePtr = ref.alloc('int32');
    var qualityPtr = ref.alloc('int32');
    var res = libcidbio.CIDBIO_CaptureAndIdentify(idPtr, scorePtr, qualityPtr);

    var id = idPtr.deref();
    var score = scorePtr.deref();
    var quality = qualityPtr.deref();

    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao capturar e identificar");
        console.log("id: " + id);
        console.log("score: " + score);
        console.log("quality: " + quality);
    } else {
        console.log("Falha ao capturar e identificar");
        console.log(getError(res));
    }
}

function GetTemplate(id) {
    console.log("** Executando método GetTemplate() **");
    var tPtrPtr = ref.alloc(charPtr);
    var res = libcidbio.CIDBIO_GetTemplate(id, tPtrPtr);

    if(ref.isNull(tPtrPtr.deref())) {
        console.log("Retornado ponteiro vazio");
        console.log(getError(res));
        return;
    }
    var tTmp = tPtrPtr.deref();

    var t = ref.readCString(tTmp, 0);
    var res2 = libcidbio.CIDBIO_FreeString(tTmp);

    if (res2 == RetCode.SUCCESS) {
        console.log("Sucesso ao liberar memória deste parâmetro");
    } else {
        console.log("Falha ao liberar memória deste parâmetro");
        getError(res2);
    }

    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao coletar template");
        console.log("t: " + t);
    } else {
        console.log("Falha ao coletar templates");
        console.log(getError(res));
    }

}

function DeleteTemplate(id) {
    console.log("** Executando método DeleteTemplate() **");
    var res = libcidbio.CIDBIO_DeleteTemplate(id);
    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao deletar template");
    } else {
        console.log("Falha ao deletar templates");
        console.log(getError(res));
    }
}

function GetDeviceInfo() {
    console.log("** Executando método GetDeviceInfo() **");
    var versionPtrPtr = ref.alloc(charPtr);
    var serialNumberPtrPtr = ref.alloc(charPtr);
    var modelPtrPtr = ref.alloc(charPtr);
    var res = libcidbio.CIDBIO_GetDeviceInfo(versionPtrPtr, serialNumberPtrPtr, modelPtrPtr);
    if(ref.isNull(versionPtrPtr.deref()) || ref.isNull(serialNumberPtrPtr.deref()) || ref.isNull(modelPtrPtr.deref())) {
        console.log("Retornado ponteiro vazio");
        console.log(getError(res));
        return;
    }

    var versionTmp = versionPtrPtr.deref();

    var version = ref.readCString(versionTmp, 0);
    var res2 = libcidbio.CIDBIO_FreeString(versionTmp);

    if (res2 == RetCode.SUCCESS) {
        console.log("Sucesso ao liberar memória deste parâmetro");
    } else {
        console.log("Falha ao liberar memória deste parâmetro");
        getError(res2);
    }

    var serialNumberTmp = serialNumberPtrPtr.deref();

    var serialNumber = ref.readCString(serialNumberTmp, 0);
    var res3 = libcidbio.CIDBIO_FreeString(serialNumberTmp);

    if (res3 == RetCode.SUCCESS) {
        console.log("Sucesso ao liberar memória deste parâmetro");
    } else {
        console.log("Falha ao liberar memória deste parâmetro");
        getError(res3);
    }

    var modelTmp = modelPtrPtr.deref();

    var model = ref.readCString(modelTmp, 0);
    var res4 = libcidbio.CIDBIO_FreeString(modelTmp);

    if (res4 == RetCode.SUCCESS) {
        console.log("Sucesso ao liberar memória deste parâmetro");
    } else {
        console.log("Falha ao liberar memória deste parâmetro");
        getError(res4);
    }

    if (res == RetCode.SUCCESS) {
        console.log("Sucesso ao coletar template");
        console.log("version: " + version);
        console.log("serialNumber: " + serialNumber);
        console.log("model: " + model);
    } else {
        console.log("Falha ao coletar templates");
        console.log(getError(res));
    }
}

Init();
GetDeviceInfo();
DeleteAllTemplates();
CaptureAndEnroll(1);
CaptureAndIdentify();
GetTemplateIDs();
GetTemplate(1);
DeleteTemplate(1);
Terminate();