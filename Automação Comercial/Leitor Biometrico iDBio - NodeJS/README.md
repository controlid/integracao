# Descrição

Este exemplo apresenta as funcionalidades básicas do iDBio com o uso de NodeJS. É implementado um *wrapper* da bibloteca dinâmica do iDBio em NodeJS e seu uso básico é demonstrado. O dispositivo deve estar conectado para o funcionamento do exemplo.

# Notas

Para a execução do exemplo, é necessário ter instalado na máquina uma versão recente do NPM e NodeJS. Em uma distribuição Ubuntu/Debian, basta executar:

```
sudo apt install nodejs
sudo apt install npm
```

Numa distribuição Windows, recomenda-se utilizar o [instalador](https://nodejs.org/en/download/) apropriado.

As dependências do módulo [node-gyp](https://github.com/nodejs/node-gyp#installation) devem ser observadas, a depender do sistema operacional.

```
npm install -g node-gyp
```

Para Windows, é necessário ter instalado [Visual Studio Build Tools](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools) e executar no cmd:

```
npm config set msvs_version 2017
```

O projeto tem como dependências os módulos [ref-napi](https://github.com/node-ffi-napi/ref-napi) e [ffi-napi](https://github.com/node-ffi-napi/node-ffi-napi), os quais devem ser instalados. Recomenda-se fazê-lo em um diretório cujo caminho não possua espaços ou acentos.

```
npm install ref-napi
npm install ffi-napi
```

Uma vez instalados, execute o comando no diretório que contém os arquivos index.js e package.json:

```
npm install
```

Após isso, execute o exemplo com

```
node index.js
```

# Funcionamento

Como exemplo, o programa inicializa o dispositivo, solicita a realização de um cadastro, faz uma identificação, coleta o template e deleta os dados em seguida.