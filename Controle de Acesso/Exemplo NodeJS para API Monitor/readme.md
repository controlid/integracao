# Exemplo NodeJS para API Monitor

O programa implementa exemplos simples de operação do Monitor.
Esse exemplo implementa os endpoints do Monitor de acordo com a API.
Para executá-lo, basta ter uma versão recente do Node.Js e NPM instalados na máquina.

Uma vez clonado o repositório, execute os seguintes comandos para instalar os recursos necessários e iniciar a aplicação:
```
npm install
npm run
node app
```

Um exemplo de requisição recebida quando há abertura de SecBox é visto abaixo:

```
{
  secbox: { id: 122641794704911600, open: true },
  device_id: 4408955728035889,
  time: 1658155691
}
```
