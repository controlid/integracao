# Exemplo de Servidor Online - NodeJS

## Descrição

O programa implementa exemplos simples de operação em modo online para todos os equipamentos de acesso da linha V5 e V6.

## Execução

Para executá-lo, basta ter uma versão recente do Node.Js e NPM instalados na máquina. 
Caso não possua, em uma distribuição Ubuntu/Debian, basta executar:

```
sudo apt install nodejs
sudo apt install npm
```

Em seguida execute:
```
npm install
npm run
node app
```

## Testes

Para realizar os testes, alguns argumentos podem ser passados via terminal, usando `--nomeDoArgumento`. Caso deseje, não passe estes parâmetros para que seja usado valores padrões.
Para selecionar o IP do dispositivo e o teste a ser executado, utilize as tags `--ip` e `--test`, tais como `--ip=192.168.0.129` e `--test=1`.
Os exemplos de teste são:

1. Cadastramento remoto
2. Criação de múltiplos usuários
3. Ativa modo online
4. Desativa modo online
5. Destruir fotos de usuários
6. Destruir todos os usários
7. Carregar usuários
8. Teste de QR Code no modo alfanumérico
9. Teste de QR Code no modo somente numérico
10. Teste de cadastramento de cartão
11. Teste de cadastramento de PIN
12. Teste de cadastramento biométrico remoto
13. Teste de cadastramento de acesso ID + senha

### Descrição dos testes de cadastramento das formas de acesso

1.`Cadastramento remoto`: Cadastra um usuário com ID 1000 e faz o cadastro facial de forma remota do usuário. Argumentos: `--userId` : número, `--userName` : texto.

8 e 9.`Testes de QR Code`: Cadastra um código pré-determinado a um usuário com ID 1000 cadastrado anteriormente. Argumentos: `--userId` : número, `--qrCodeValueAlphaNumeric` : texto ou número, `--qrCodeValueNumeric` : número.

10.`Teste de cadastramento de cartão`: Cadastra um cartão pré-determinado a um usuário com ID 1000 cadastrado anteriormente. Argumentos: `--userId` : número, `--cardNumber` : número.

11.`Teste de cadastramento de PIN`: Cadastra um PIN pré-determinado a um usuário com ID 1000 cadastrado anteriormente. Argumentos: `--userId` : número, `--pinId` : número, `--pinValue` : número.

12.`Teste de cadastramento biométrico remoto`: Cadastro biométrico remoto de um usuário com ID 1000 cadastrado anteriormente. Argumentos: `--userId` : número, `--bioId` : número.

13.`Teste de cadastramento de acesso ID + senha`: Cadastra um usuário com ID 1000 e senha de acesso pré-determinada. Argumentos: `--userId` : número, `--password` : número.

