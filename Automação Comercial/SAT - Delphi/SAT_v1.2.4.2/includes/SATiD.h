/**
 ******************************************************************************
 * @file    SATiD.h
 * @author  Dimitri Marques - dimitri@controlid.com.br
 * @version v0.0.0
 * @date    31 de ago de 2017
 * @brief   Cabeçalho com as rotinas da biblioteca dinâmica de comandos do SAT.
 ******************************************************************************
 * @attention
 *
 * <h2><center> COPYRIGHT &copy; 2017 Control iD </center></h2>
 * <h2><center>            All Rights Reserved &reg;          </center></h2>
 *
 * Licensed under Control iD Firmware License Agreement, (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *
 *        http://www.controlid.com.br/licenses
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ******************************************************************************
 */

#ifndef SATID_H_
#define SATID_H_

#include <satidlibconf.h>

/**
 * @defgroup SATID_Module
 * @{
 */

/*
   SATLIB_VERSION is (major << 24) + (minor << 16) + releases.
*/
#define SATLIB_VERSION_INT      SATLIB_VERSION_CHECK(SATLIB_MAJOR_VERSION, SATLIB_MINOR_VERSION, SATLIB_REVISION_VERSION)

/*
   can be used like #if (SATLIB_VERSION >= SATLIB_VERSION_CHECK(4, 4, 0))
*/
#define SATLIB_VERSION_CHECK(major, minor, releases) ((major<<24)|(minor<<16)|(releases))

/** X.x.xx: Major version of the project */
#define SATLIB_MAJOR_VERSION                1
/** x.X.xx: Minor version of the project */
#define SATLIB_MINOR_VERSION                2
/** x.x.XX: Revision of the project */
#define SATLIB_REVISION_VERSION             1
/** x.x.x-r(n): Release of the project */
#define SATLIB_RELEASE_VERSION              2

/** Provides the version of the project example 1.0.1048 */
#define SATLIB_VERSION                      (SATLIB_MAJOR_VERSION << 24 | \
                                             SATLIB_MINOR_VERSION << 16 | \
                                             SATLIB_REVISION_VERSION << 8 |\
                                             SATLIB_RELEASE_VERSION)

//! Converter para String
#define SATLIB_VERSION_CONV_STR(X)          #X

//! Formatar a versão em String
#define SATLIB_VERSION_STRX(A, B, C, D)     SATLIB_VERSION_CONV_STR(A) "." SATLIB_VERSION_CONV_STR(B) "." SATLIB_VERSION_CONV_STR(C) "." SATLIB_VERSION_CONV_STR(D)

//! Retorna a String da Versão
#define SATLIB_VERSION_STRING()             SATLIB_VERSION_STRX(SATLIB_MAJOR_VERSION,SATLIB_MINOR_VERSION,SATLIB_REVISION_VERSION, SATLIB_RELEASE_VERSION)

//! Versão da aplicação
#define SATLIB_VERSION_STR                  SATLIB_VERSION_STRING()


#ifdef __cplusplus
extern "C" {
#endif

/**
 * Função de Inicialização
 * @return
 *      @arg true   : Inicializou com sucesso
 *      @arg false  : Falhou a inicialização
 */
IDSALIB_INIT bool STDCALL SATiDlibInit(void);

/**
 * Função de Finalização
 * @return
 *      @arg true   : Finalizou com sucesso
 *      @arg false  : Falhou a Finalização
 */
IDSALIB_FINIT bool STDCALL SATiDlibDeInit(void);


/**
 * Função para indicar se existe um S@T-iD Conectado ao Computador
 * @return
 *      @retval true    : Existe um SAT conectado ao computador
 *      @retval false   : Não existe um SAT conectado ao computador
 */
SATIDLIB_API bool STDCALL DispositivoConectado(void);

/**
 * @brief Configura porta erial
 * @param[in]    commPort        :   Path da porta serial ("\\.\COM3" | "/dev/ttyACMx")
 * @return
 *      @retval true    : Porta configurada com sucesso
 *      @retval false   : Erro ao configurar porta
 */
SATIDLIB_API bool STDCALL ConfigurarPortaSerial(const char*const commPort);

/**
	AtivarSAT
	Efetuar o processo de ativa��o do Equipamento SAT e ser� respons�vel por enviar ao SAT qual o tipo de ativa��o ser� efetuada pelo Contribuinte.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	subComando: Identificador do tipo de Certificado - Inteiro, sendo:
							1 - Tipo de Certificado = AC-SAT/SEFAZ.
							2 - Tipo de Certificado = ICP-BRASIL - N�o suportado pelo iDS@T.
							3 - Renova��o do Certificado ICP-BRASIL - N�o suportado iDS@T.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	CNPJ: CNPJ do contribuinte - Const char pointer, somente n�meros, com 14 caracteres.
	@param	cUF: C�digo do Estado da Federa��o, segundo tabela do IBGE, onde o SAT ser� ativado - Inteiro.
	
	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ|CSR"
*/

SATIDLIB_API const char* STDCALL AtivarSAT (int32_t numeroSessao, int32_t subComando, const char *codigoDeAtivacao, const char *CNPJ, int32_t cUF);

/**
	AssociarAssinatura
	O contribuinte dever� associar a assinatura do Aplicativo Comercial com o SAT atrav�s da fun��o AssociarAssinatura.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	CNPJvalue: CNPJ da empresa desenvolvedora do Aplicativo Comercial + CNPJ do Emitente - Const char pointer, somente numeros, com 28 caracteres.
	@param	assinaturaCNPJs: Assinatura digital conjunto �CNPJ Software House� + �CNPJ do estabelecimento comercial - Const char pointer, de tamanho livre e n�o nulo.
	
	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL AssociarAssinatura (int32_t numeroSessao, const char *codigoDeAtivacao, const char *CNPJvalue, const char *assinaturaCNPJs);

/**
	EnviarDadosVenda
	Esta fun��o faz parte do processo de envio dos dados de venda do Apliativo Comerncial para o Equipamento SAT.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	dadosVenda: Refere-se aos dados de venda gerados pelo AC e utilizados para compor o CF-e-SAT - Const char pointer, de tamanho livre e n�o nulo.

	@return "numeroSessao|EEEEE|CCCC|mensagem|cod|mensagemSEFAZ|arquivoCFeBase64|timeStamp|chaveConsulta|valorTotalCFe|CPFCNPJValue|assinaturaQRCODE"
*/
SATIDLIB_API const char* STDCALL EnviarDadosVenda (int32_t numeroSessao, const char *codigoDeAtivacao, const char *dadosVenda);

/**
	CancelarUltimaVenda
	O envio dos dados de cancelamento da venda ocorrer� de acordo com as defini��es a seguir.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	chave: Chave de acesso do CF-e-SAT a ser cancelado precedida do literal 'CFe' - Const char pointer, 47 caracteres.
	@dadosCancelamento: Refere-se aos dados da venda gerados pelo Aplicativo Comercial e utilizados para compor o CF-e-SAT de cancelamento - Const char pointer, de tamanho livre e n�o nulo.

	@return "numeroSessao|EEEEE|CCCC|mensagem|cod|mensagemSEFAZ|arquivoCFeBase64|timeStamp|chaveConsulta|valorTotalCFe|CPFCNPJValue|assinaturaQRCODE"
*/
SATIDLIB_API const char* STDCALL CancelarUltimaVenda (int32_t numeroSessao, const char *codigoDeAtivacao, const char *chave, const char *dadosCancelamento);

/**
	ConsultarSAT
	Esta fun��o � usada para testes de comunica��o entre o Aplicativo Comercial e o Equipamento SAT.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL ConsultarSAT (int32_t numeroSessao);

/**
	TesteFimAFim
	Esta fun��o consiste em um teste de comunica��o entre o Aplicativo Comercial, o Equipamento SAT e a SEFAZ.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	dadosVenda: Refere-se aos dados de venda fict�cios gerados pelo Aplicativo Comercial e utilizados para compor o CF-e-SAT de teste - Const char pointer, de tamanho livre e n�o nulo.
	
	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ|arquivoCFeBase64|timeStamp|numDocFiscal|chaveConsulta"
*/
SATIDLIB_API const char* STDCALL TesteFimAFim (int32_t numeroSessao, const char *codigoDeAtivacao, const char *dadosVenda);

/**
	ConsultarStatusOperacional
	Essa fun��o � respons�vel por verificar a situa��o de funcionamento do Equipamento SAT.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ|ConteudoRetorno"
*/
SATIDLIB_API const char* STDCALL ConsultarStatusOperacional (int32_t numeroSessao, const char *codigoDeAtivacao);

/**
	ConsultarNumeroSessao
	O Aplicativo Comercial poder� verificar se a �ltima sess�o requisitada foi processada em caso de n�o recebimento do retorno da opera��o. 
	O equipamento SAT-CF-e retornar� exatamente o resultado da sess�o consultada.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	cNumeroDeSessao: N�mero de sess�o a ser consultado no SAT-CF-e - Inteiro.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL ConsultarNumeroSessao (int32_t numeroSessao, const char *codigoDeAtivacao, int32_t cNumeroDeSessao);

/**
	ConfigurarInterfaceDeRede
	Configurar a interface de comunica��o do Equipamento SAT com a rede local do estabelecimento comercial atrav�s do envio de um arquivo de configura��o no padr�o XML.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	dadosConfiguracao: Arquivo de configura��o no formato XML - Const char pointer, de tamanho livre e n�o nulo.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL ConfigurarInterfaceDeRede (int32_t numeroSessao, const char *codigoDeAtivacao, const char *dadosConfiguracao);

/**
	AtualizarSoftwareSAT
	O Contribuinte utilizar� a fun��o AtualizarSoftwareSAT para a atualiza��o imediata do software b�sico do Equipamento SAT.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL AtualizarSoftwareSAT (int32_t numeroSessao, const char *codigoDeAtivacao);

/**
	ExtrairLogs
	A extra��o dos logs do SAT ser� realizada atrav�s da fun��o ExtrairLogs e deve receber um valor do tipo string contendo os dados separados por pipe "|".

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ|Arquivo de log em base64"
*/
SATIDLIB_API const char* STDCALL ExtrairLogs (int32_t numeroSessao, const char *codigoDeAtivacao);

/**
	BloquearSAT
	Realizar o bloqueio operacional do Equipamento SAT.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL BloquearSAT (int32_t numeroSessao, const char *codigoDeAtivacao);

/**
	DesbloquearSAT
	Realizar o desbloqueio operacional do Equipamento SAT.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL DesbloquearSAT (int32_t numeroSessao, const char *codigoDeAtivacao);

/**
	TrocarCodigoDeAtivacao
	Realizar a troca do c�digo de ativa��o a qualquer momento.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	opcao: Refere-se a op��o do conte�do do par�metro �codigoDeAtivacao� - Inteiro, sendo:
					1 � C�digo de Ativa��o
					2 � C�digo de Ativa��o de Emerg�ncia
	@param	novoCodigo: Novo c�digo de ativa��o escolhido pelo contribuinte - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	confNovoCodigo: Confirma��o do novo c�digo de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL TrocarCodigoDeAtivacao (int32_t numeroSessao, const char *codigoDeAtivacao, int32_t opcao, const char *novoCodigo, const char *confNovoCodigo);

/**
	ComunicarCertificadoICPBRASIL
	Esta fun��o faz parte do processo de ativa��o do Equipamento SAT e ser� respons�vel por
	enviar ao SAT o certificado recebido da Autoridade Certificadora ICP-Brasil.

	@param	numeroSessao: N�mero aleat�rio gerado pelo Aplicativo Comercial para controle da comunica��o - Inteiro, 6 d�gitos.
	@param	codigoDeAtivacao: Senha definida pelo contribuinte no software de ativa��o - Const char pointer, m�nimo 8 e m�ximo 32 caracteres.
	@param	opcao: Refere-se a op��o do conte�do do par�metro �codigoDeAtivacao� - Inteiro, sendo:
		1 � C�digo de Ativa��o
		2 � C�digo de Ativa��o de Emerg�ncia
	@param	certificado: Certificado Digital ICP-Brasil

	@return "numeroSessao|EEEEE|mensagem|cod|mensagemSEFAZ"
*/
SATIDLIB_API const char* STDCALL ComunicarCertificadoICPBRASIL (int32_t numeroSessao, const char *codigoDeAtivacao, const char *certificado);

#ifdef __cplusplus
}
#endif

/**
 * @}
 */
#endif /* SATID_H_ */
