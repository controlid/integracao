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

Os testes implementados podem ser definidos através da variável `teste`. Os exemplos são:

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

1.`Cadastramento remoto`: Cadastra um usuário com ID 1000 e faz o cadastro facial de forma remota do usuário. 

8 e 9.`Testes de QR Code`: Cadastra um código pré-determinado a um usuário com ID 1000 cadastrado anteriormente.

10.`Teste de cadastramento de cartão`: Cadastra um cartão pré-determinado a um usuário com ID 1000 cadastrado anteriormente.

11.`Teste de cadastramento de PIN`: Cadastra um PIN pré-determinado a um usuário com ID 1000 cadastrado anteriormente.

12.`Teste de cadastramento biométrico remoto`: Cadastro biométrico remoto de um usuário com ID 1000 cadastrado anteriormente.

13.`Teste de cadastramento de acesso ID + senha`: Cadastra um usuário com ID 1000 e senha de acesso pré-determinada.

