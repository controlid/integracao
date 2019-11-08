# Documentation Print iD

## `Instalação`

Para adicionar a biblioteca da Print iD ao projeto Android é necessário configurar
algumas dependência ao projeto.


#### 1. Biblioteca Print iD
O primeiro passo é fazer download do arquivo `printid-release-xxx.aar`
ao finalizar o download mova o arquivo para dentro do seu projeto Android, na maioria dos
casos basta adicionar o arquivo na pasta `pasta_projeto/app/libs/`.


#### 2. Dependências
No arquivo `app:build.gradle` adicionar os imports
 ```groovy
// import iDBio
implementation 'br.com.controlid.printid:printid-release-xxx@aar'

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
PrintID.config(getApplicationContext());
```

Logo em seguida iniciamos o processo de escutar a porta USB do device
```java
PrintID.getInstance().startConnection();
onNewIntent(getIntent());
```

O método `onNewIntent` deve ser subscrito para detectar conexão USB pós iniciação
```java
@Override
protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);

    if(intent.getAction().equals(UsbManager.ACTION_USB_DEVICE_ATTACHED)) {
        PrintID.getInstance().startConnection();
    }
}
```

Para chamar os métodos da Print iD o ideal é executar esses métodos dentro de métodos
assíncrona. Ex.:
```java
Handler handler = new Handler(Looper.getMainLooper());
handler.post(new Runnable() {
    @Override
    public void run() {
        PrintID.getInstance().ImprimirFormatado("Hello PrintId\n", false, false, true, true);
    }
});
```
