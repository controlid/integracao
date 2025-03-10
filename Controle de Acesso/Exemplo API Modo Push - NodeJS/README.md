# Descrição

Este exemplo apresenta as funcionalidades básicas do modo push através de um exemplo simples em NodeJS.

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

# Modo push em lotes

Para executar o exemplo do modo push em lotes de comandos, é necessário utilizar o argumento via terminal `--batch`.

```
node index.js --batch
```

O exemplo descrito aguarda requisições _push_ do equipamento e, através de um contador, alterna entre as mensagens que o servidor envia como resposta, alternando a linguagem do equipamente entre português, espanhol e inglês. No exemplo do modo push em lote o processo ocorre em sequência: primeiro, é criado um usuário; em seguida, adiciona-se um cartão a esse usuário; depois, é configurada a regra "sempre autorizado"; e, por fim, o NTP é habilitado. Espera-se que o equipamento esteja com IP, login e senha padrões, a saber:

- IP: 192.168.0.129
- login: admin
- senha: admin