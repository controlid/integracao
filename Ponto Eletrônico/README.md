![Screenshot](https://www.controlid.com.br/assets/images/content/products/relogio-de-ponto/repidclass_f.jpg)

** Antes de prosseguir, entre em contato com a Control iD (integracao@controlid.com.br), realize seu cadastro e solicite a RepCID.dll **

A Control iD com o intuito de facilitar o desenvolvimento da integração com os softwares de nossos parceiros, desenvolvemos uma documentação completa e facil de utilizar com exemplos em uma variada quantidade de linguagens de programação. 

Atualmente existem duas formas de integrar com o REP iDClass e iDClass 373, utilizando a API Rest que o equipamento possui e que está disponivel [aqui.]( https://www.controlid.com.br/suporte/api_idclass_latest.html#50_introduction)
ou utilizando a DLL **RepCid** essa DLL implementa as principais funções que o equipamento possui e facilita o desenvolvimento da integração, entretanto está disponivel somente para C# e Delphi10.

Para utiliza-la o processo é bem simples,e consiste em um passo a passo de duas tarefas: 

 * Referenciar a dll no projeto;
 * Acessar o namespace;
 
Em C# para acessar o namespace basta utilizar o [using](https://docs.microsoft.com/pt-br/dotnet/csharp/programming-guide/namespaces/using-namespaces)

** Registrando DLL e TLB **

jsallaberry-controlid edited this page on 18 Feb 2016 · 2 revisions
Utilização em outros ambientes (objeto COM)
Como qualquer objeto COM, é necessário registrar o objeto no sistema antes que possa ser utilizado. Entretanto, por se tratar de um objeto COM que utiliza a plataforma Microsoft .NET, o .NET Framework 4.0 (ou superior) deverá estar instalado no computador. Além disso, o processo de registro do objeto COM é diferenciado.

Copie o arquivo RepCid.dll para um local em seu computador.
É importante escolher um local que não precisará ser alterado pois, caso seja alterado, o processo de registro precisará ser refeito.

Encontre o programa RegAsm.exe
(este é instalado como parte do .NET Framework SDK). Em geral, ele fica localizado em uma das localidades abaixo, escolha a mais adequada para seu sistema. Os passos seguintes utilizarão como exemplo o caminho da versão de 32 bits.

Versão 32 bits: C:\Windows\Microsoft.NET\Framework\v4.0.30319\
Versão 64 bits: C:\Windows\Microsoft.NET\Framework64\v4.0.30319\
Registre o objeto COM no Windows:
Abra um terminal MS-DOS como administrador, e mude para a pasta do RegAsm.exe:

cd C:\Windows\Microsoft.NET\Framework\v4.0.30319\

Registre os tipos exportados pela biblioteca:

RegAsm.exe "C:\Caminho\Da\Pasta\RepCid.dll" /tlb

Registre o objeto da bilbioteca:

RegAsm.exe "C:\Caminho\Da\Pasta\RepCid.dll" /codebase

Note que nesse ponto deve surgir um alerta, que é esperado e não implica em nenhum problema:

RegAsm : warning RA0000 : Registering anunsigned assembly with /codebase can cause your assembly (…)

Adicione uma referência ao objeto COM em seu ambiente de desenvolvimento.

Microsoft© Visual Studio 2010, C++: Use o projeto de demonstração TesteRepCidCpp como exemplo. Ele mostra como utilizar a biblioteca RepCid através do Visual C++. O mais importante a ser notado é o uso das diretivas #import no arquivo TesteRepCidCpp.cpp daquele exemplo.

Borland© Delphi 2005 – 2006: Com um projeto aberto, abra o Menu Project e selecione o item Import Type Library. Na tela que se abre, selecione o item RepCid. (se não encontrar esse item, clique no botão Abrir e encontre o arquivo RepCid.tlb). Pressione Create Unit e o componente deve estar pronto para utilização.

Outros: siga as instruções oferecidas no ambiente de desenvolvimento para incluir uma referência ao objeto RepCid.

** Criando Templates de Digitais ** 

Definições iniciais:
Equipamento - Hardware que contém algoritmo biométrico Innovatrics
Digital - É uma foto de uma impressão digital (um bitmap)
Template - É o conjunto de bytes obtidos pelo algoritmo innovatrics existente dentro do equipamento que representa uma digital
Para criar templates biométrico usando um equipamento iDClass, é necessário realizar as etapas abaixo:

Conectar ao equipamento Com os dados de IP, Usuário, Senha e Porta, deve ser realizado uma conexão no equipamento para obter uma sessão válida, que será usada nas próximas etapas

Extrair 3 templates individuais de 3 imagens de digitais Após obter a imagem de uma digital por meio de algum leitor biométrico (por exemplo um FS-80h), é necessário enviar essa imagem para o equipamento, onde este irá retornar o template correspondente, juntamente com a informação da qualidade relativa a extração, recomendamos que essa qualidade seja de no mínimo 50% para evitar problemas de identificação

Juntar os 3 templates Após executar a etapa anterior 3 vezes, enviar os 3 templates de volta para o equipamento, para que este junte e valide os 3 templates, onde será tratado:

Se os 3 templates são válidos
Se os 3 templates representam a mesma digital
Formas disponíveis para extrair templates
Via SDK (DLL fornecido para control iD)
Usando a REPCID.DLL (compatível com iDClass e iDX fornecido pela control iD) há o projeto de testes disponível em https://github.com/controlid/RepCid/tree/master/test-CS no arquivo “Templates.cs” tem apenas a extração individual do template (extract) e a junção (merge) que segue exatamente a mesma logica via API, mas desta vez as imagens estão previarmente salvas em arquivos BMP, para não ser necessário o uso do leitor

public void Template_ExtractJoin()
{
    RepCid rep = Config.ConectarREP(); // Cria a conexão padrão
    byte[][] btResult = new byte[3][];
    for (int i = 1; i <= 3; i++)
    {
        Bitmap digital = new System.Drawing.Bitmap(@"..\..\dedo" + i + ".bmp");
        byte[] btRequest = RepCid.GetBytes(digital); // transforme o bitmap em bytes no padrão necessário para ser enviado ao equipamento

        if (!rep.ExtractTemplate(btRequest, digital.Width, digital.Height, out btResult[i - 1]))
        {
            Console.WriteLine(rep.LastLog());
            Assert.Fail("Erro ao extrair Template " + i);
        }
        Console.WriteLine("LastQuality: " + RestJSON.LastQuality);
        Console.WriteLine("Template: " + Convert.ToBase64String(btResult[i - 1]));
    }
    byte[] btJoin;
    rep.JoinTemplates(btResult[0], btResult[1], btResult[2], out btJoin);
    Console.WriteLine("Template: " + Convert.ToBase64String(btJoin));
    //Console.WriteLine(string.Format("Código: {0}\nErro: {1}\nQualidade: {2}\nTemplate: {3}", tr.code, tr.error, tr.Qualidate, tr.Template));  
}
Do exemplo acima se destacam as seguinte linhas:

RepCid rep: Instância de conexão com o equipamento
RepCid.GetBytes: Método estático que converte Bitmap .Net em um array de bytes raw requerido pelo equipamento
rep.ExtractTemplate : Dado o array de bytes da digital, será criado um template
rep.JoinTemplates: Dado 3 arrays de bytes, será gerado o template final
Via API (open source)
Por meio do exemplo “test-CS-Futronic” é mostrado de forma básica, sem dependência externa de DLL proprietárias, como fazer toda a captura de digitais e extração de template, baixe esse exemplo em: https://github.com/controlid/RepCid/tree/master/test-CS-Futronic

Requisitos

Tem um leitor FS-80h conectado e com o driver instalado
Tem um equipamento iDClass ou iDAccess
Configurar no método “Window_Load” os dados de conexão
Com as classes fornecidas neste exemplo os comandos mínimos necessários para criar um template são:

Login
var equip = new Equipamento(); // variável que conterá a instância de toda conexão
equip.Login("https://192.168.0.19"); // Efetua o login no equipamento, opcionalmente pode ser informado usuário e senha
Extraindo Template
int qualidade; // variável que receberá o retorno da qualidade da extração do template
string templateDigital = equip.ExtractTemplate(bmp, out qualidade); // onde bmp é um bitmap com uma digital
Esta rotina retorna uma string base64 com o template obtido

Juntando os templates
var templates = new string[3]; // dada as 3 strings do procedimento anterior
string info; // retorna “OK”, ou alguma informação de erro
string templateFinal = equip.MergeTemplate(templates, out info);
Retorna uma string base64 com o template final

Exemplo das string JSON
Veja no código exemplo as string JSON e a implementação das classes que representam os DataContract e DataMember.

