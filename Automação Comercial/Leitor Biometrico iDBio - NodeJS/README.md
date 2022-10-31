# Descrição

Este exemplo apresenta as funcionalidades básicas do iDBio através de um exemplo simples em NodeJS. É implementado um *wrapper* da bibloteca dinâmica do iDBio em NodeJS e seu uso básico é demonstrado. O dispositivo deve estar conectado para o funcionamento do exemplo.

# Notas

Para a execução do exemplo, é necessário ter instalado na máquina servidor uma versão recente do NPM e NodeJS. Em uma distribuição Ubuntu/Debian, basta executar:

```
sudo apt install nodejs
sudo apt install npm
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