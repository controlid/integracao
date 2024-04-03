# Documentation iDBio

## `Instalação`

Para adicionar a biblioteca do iDBio ao projeto Android é necessário configurar
algumas dependência ao projeto.


#### 1. Biblioteca Bio
O primeiro passo é fazer download do arquivo `idbio-release-xxx.aar`. Para isso, baixe nossa SDK disponível no [link](https://www.controlid.com.br/idbio/IDBIO_SDK.zip). Recomenda-se usar a versão mais recente, o `idbio-release.aar`. Ao finalizar o download mova o arquivo para dentro do seu projeto Android. Na maioria dos
casos basta criar a pasta `pasta_projeto/app/libs/` e adicionar o arquivo neste diretório.


#### 2. Dependências
No arquivo `app:build.gradle` adicionar os imports
 ```groovy
// import iDBio
implementation 'br.com.controlid.printid:idbio-release-xxx@aar'

// Import USB Support dependency
implementation 'com.github.felHR85:UsbSerial:4.5.2'
 ```


#### 3. Permissões
Adicionar ao arquivo `AndroidManifest.xml`
```xml
<uses-permission android:name="android.permission.USB_PERMISSION" />
<uses-feature android:name="android.hardware.usb.host" />
```


#### 4. Detectar usb
Para detectar quando o usb foi conectado é preciso seguir alguns passos:
 - Criar o arquivo `devices.xml` dentro da pasta `res` do app em um package chamado `xml`:
  - res
    - xml
      - devices.xml

 - Dentro do arquivo `devices.xml` devemos adicionar a identificação do iDBio:
  ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <resources>
        <usb-device vendor-id="3036" product-id="2" />
    </resources>
  ```

 - No arquivo `AndroidManifest.xml` dentro do escopo da activity principal Adicionar
 a referencia do device e a action que vai verificar Ex.:
 ```xml
 <activity android:name=".MainActivity" android:launchMode="singleTask">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <action android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>

    <meta-data
        android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED"
        android:resource="@xml/devices" />
</activity>
 ```



______________

## `Uso`
Dentro do método `onCreate` na activity principal, devemos dar start na biblioteca:
```java
IDBio.config(getApplicationContext());
```

Logo em seguida iniciamos o processo de escutar a porta USB do device
```java
IDBio.getInstance().startConnection();
onNewIntent(getIntent());
```

O método `onNewIntent` deve ser subscrito para detectar conexão USB pós iniciação
```java
@Override
protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);

    if(intent.getAction().equals(UsbManager.ACTION_USB_DEVICE_ATTACHED)) {
        IDBio.getInstance().startConnection();
    }
}
```

Para chamar os métodos do iDBio o ideal é executar esses métodos dentro de métodos
assíncrona. Ex.:
```java
Handler handler = new Handler(Looper.getMainLooper());
handler.post(new Runnable() {
    @Override
    public void run() {
        ImageTemplateData response = IDBio.getInstance().CIDBIO_CaptureImageAndTemplate();
    }
});
```

______________

## `class IDBio`

Singleton Class to controller iDBio

 * **Author:** Control iD
 * **Version:** 1.0.4
 * **Since:** Release 10/19

##### `public static synchronized IDBio getInstance()`

return SATiD instance.

 * **Returns:** SATiD instance
 * **Since:** 1.0.0



##### `public static void config(Context context)`

Config library and start variables.

 * **Parameters:** `context` — Context - application context
 * **Since:** 1.0.0



##### `public boolean isConnected()`

Check usb is attached and connected

 * **Returns:** boolean
 * **Since:** 1.0.3



##### `public boolean isProcessing()`

Check if the command is running

 * **Returns:** boolean
 * **Since:** 1.0.3




##### `public ImageData CIDBIO_CaptureImage()`

CIDBIO_CaptureImage

 * **Returns:** ImageData
 * **Since:** 1.0.0



##### `public ImageData CIDBIO_CheckFingerprint()`

CIDBIO_CheckFingerprint

 * **Returns:** ImageData
 * **Since:** 1.0.0

##### `public ImageData CIDBIO_CaptureRawImage()`

CIDBIO_CaptureRawImage

 * **Returns:** ImageData
 * **Since:** 1.0.0

##### `public ImageData CIDBIO_CaptureAdjustedImage()`

CIDBIO_CaptureAdjustedImage

 * **Returns:** ImageData
 * **Since:** 1.0.0

##### `public BaseReturn CIDBIO_CaptureAndEnroll(long id)`

CIDBIO_CaptureAndEnroll

 * **Parameters:** `id` — long
 * **Returns:** BaseReturn
 * **Since:** 1.0.0

##### `public ImageTemplateData CIDBIO_CaptureImageAndTemplate()`

CIDBIO_CaptureImageAndTemplate

 * **Returns:** ImageTemplateData
 * **Since:** 1.0.0

##### `public MathData CIDBIO_CaptureAndMatch(long id)`

CIDBIO_CaptureAndMatch

 * **Parameters:** `id` — long 
 * **Returns:** MathData
 * **Since:** 1.0.0

##### `public TemplateData CIDBIO_GetTemplate(long id)`

CIDBIO_GetTemplate

 * **Parameters:** `id` — long 
 * **Returns:** TemplateData
 * **Since:** 1.0.0

##### `public BaseReturn CIDBIO_GetTemplateIDs()`

CIDBIO_GetTemplateIDs

 * **Returns:** BaseReturn
 * **Since:** 1.0.0

##### `public BaseReturn CIDBIO_DeleteTemplate(long id)`

CIDBIO_DeleteTemplate

 * **Parameters:** `id` — long 
 * **Returns:** BaseReturn
 * **Since:** 1.0.0

##### `public BaseReturn CIDBIO_DeleteAllTemplates()`

CIDBIO_DeleteAllTemplates

 * **Returns:** BaseReturn
 * **Since:** 1.0.0

##### `public TemplateData CIDBIO_MergeTemplates(String t1, String t2, String t3)`

CIDBIO_MergeTemplates

 * **Parameters:**
   * `t1` — String
   * `t2` — String
   * `t3` — String
 * **Returns:** TemplateData
 * **Since:** 1.0.0

##### `public ScoreData CIDBIO_MatchTemplates(String t1, String t2)`

CIDBIO_MatchTemplates

 * **Parameters:**
   * `t1` — String
   * `t2` — String
 * **Returns:** ScoreData
 * **Since:** 1.0.0

##### `public ScoreData CIDBIO_MatchTemplateByID(long id, String template)`

CIDBIO_MatchTemplateByID

 * **Parameters:**
   * `id` — long 
   * `template` — String
 * **Returns:** ScoreData
 * **Since:** 1.0.0

##### `public IdentifyBioData CIDBIO_CaptureAndIdentify()`

CIDBIO_CaptureAndIdentify

 * **Returns:** IdentifyBioData
 * **Since:** 1.0.0

##### `public TemplateQualityData CIDBIO_ExtractTemplateFromImage(long width, long height, byte[] image)`

CIDBIO_ExtractTemplateFromImage

 * **Parameters:**
   * `width` — long
   * `height` — long
   * `image` — byte[]
 * **Returns:** TemplateQualityData
 * **Since:** 1.0.0

##### `public BaseReturn CIDBIO_SaveTemplate(long id, String template)`

CIDBIO_SaveTemplate

 * **Parameters:**
   * `id` — long 
   * `template` — String
 * **Returns:** BaseReturn
 * **Since:** 1.0.0

##### `public DeviceIdentificationData CIDBIO_GetDeviceInfo()`

CIDBIO_GetDeviceInfo

 * **Returns:** DeviceIdentificationData
 * **Since:** 1.0.0
