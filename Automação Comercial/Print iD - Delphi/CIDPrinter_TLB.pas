unit CIDPrinter_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 09/11/2019 22:24:06 from Type Library described below.

// ************************************************************************  //
// Type Lib: CIDPrinter.tlb (1)
// LIBID: {9893D786-8A02-4CDF-8D0F-12E16F5EE548}
// LCID: 0
// Helpfile: 
// HelpString: Biblioteca de comunica��o com a Print iD
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v2.4 mscorlib, (C:\Windows\Microsoft.NET\Framework\v4.0.30319\mscorlib.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, mscorlib_TLB, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CIDPrinterMajorVersion = 1;
  CIDPrinterMinorVersion = 0;

  LIBID_CIDPrinter: TGUID = '{9893D786-8A02-4CDF-8D0F-12E16F5EE548}';

  IID_ICIDPrint: TGUID = '{1E44C7E9-16C3-42B9-9A7A-7644C272645C}';
  CLASS_CIDPrintiD: TGUID = '{3BF4267D-7EEC-49EF-8428-55BE5B04704B}';
  IID__RawPrinterHelper: TGUID = '{E3C3A40F-4C5C-38C2-928A-7801F3599B14}';
  CLASS_RawPrinterHelper: TGUID = '{B5182881-69B7-39D2-8569-89990FA44EE1}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TipoCorte
type
  TipoCorte = TOleEnum;
const
  TipoCorte_TOTAL = $00000000;
  TipoCorte_PARCIAL = $00000001;

// Constants for enum StatusGaveta
type
  StatusGaveta = TOleEnum;
const
  StatusGaveta_FECHADA = $00000000;
  StatusGaveta_ABERTA = $00000001;

// Constants for enum StatusPapel
type
  StatusPapel = TOleEnum;
const
  StatusPapel_SEM_PAPEL = $00000000;
  StatusPapel_POUCO_PAPEL = $00000001;
  StatusPapel_PAPEL_PRESENTE = $00000002;

// Constants for enum PosicaoCaracteresBarras
type
  PosicaoCaracteresBarras = TOleEnum;
const
  PosicaoCaracteresBarras_SEM_CARACTERES = $00000000;
  PosicaoCaracteresBarras_CARACTERES_ABAIXO = $00000002;

// Constants for enum TipoCodigoBarras
type
  TipoCodigoBarras = TOleEnum;
const
  TipoCodigoBarras_UPC_A = $00000000;
  TipoCodigoBarras_EAN13 = $00000002;
  TipoCodigoBarras_EAN8 = $00000003;
  TipoCodigoBarras_CODE39 = $00000004;
  TipoCodigoBarras_ITF = $00000005;
  TipoCodigoBarras_CODABAR = $00000006;
  TipoCodigoBarras_CODE93 = $00000048;
  TipoCodigoBarras_CODE128 = $00000049;

// Constants for enum QRModelo
type
  QRModelo = TOleEnum;
const
  QRModelo_MODELO_1 = $00000031;
  QRModelo_MODELO_2 = $00000032;
  QRModelo_MICRO = $00000033;

// Constants for enum QRCorrecaoErro
type
  QRCorrecaoErro = TOleEnum;
const
  QRCorrecaoErro_BAIXO = $00000030;
  QRCorrecaoErro_MEDIO_BAIXO = $00000031;
  QRCorrecaoErro_MEDIO_ALTO = $00000032;
  QRCorrecaoErro_ALTO = $00000033;

// Constants for enum PinoGaveta
type
  PinoGaveta = TOleEnum;
const
  PinoGaveta_PINO2_RJ12 = $00000000;
  PinoGaveta_PINO5_RJ12 = $00000001;

// Constants for enum Alinhamento
type
  Alinhamento = TOleEnum;
const
  Alinhamento_ESQUERDA = $00000000;
  Alinhamento_CENTRAL = $00000001;
  Alinhamento_DIREITA = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICIDPrint = interface;
  ICIDPrintDisp = dispinterface;
  _RawPrinterHelper = interface;
  _RawPrinterHelperDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CIDPrintiD = ICIDPrint;
  RawPrinterHelper = _RawPrinterHelper;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  StatusImpressora = record
    Online: Integer;
    Erro: Integer;
    SemPapel: Integer;
  end;

  InfoImpressora = record
    Fabricante: PAnsiChar;
    Model: PAnsiChar;
    VersaoFirmware: PAnsiChar;
    Serial: PAnsiChar;
  end;

  DOCINFOA = record
    pDocName: PAnsiChar;
    pOutputFile: PAnsiChar;
    pDataType: PAnsiChar;
  end;


// *********************************************************************//
// Interface: ICIDPrint
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1E44C7E9-16C3-42B9-9A7A-7644C272645C}
// *********************************************************************//
  ICIDPrint = interface(IDispatch)
    ['{1E44C7E9-16C3-42B9-9A7A-7644C272645C}']
    procedure Iniciar; safecall;
    procedure IniciarRede(const IP: WideString; porta: Integer); safecall;
    procedure IniciarSerial(const porta: WideString); safecall;
    procedure Finalizar; safecall;
    procedure AtivarGuilhotina(tipo: TipoCorte); safecall;
    procedure Imprimir(const texto: WideString); safecall;
    procedure ImprimirFormatado(const texto: WideString; italico: WordBool; sublinhado: WordBool; 
                                expandido: WordBool; negrito: WordBool; condensado: WordBool); safecall;
    procedure EnviarComando(dado: PSafeArray); safecall;
    procedure ImprimirTeste; safecall;
    procedure Reset; safecall;
    function LerStatus: StatusImpressora; safecall;
    function LerStatusGaveta: StatusGaveta; safecall;
    function LerStatusPapel: StatusPapel; safecall;
    function LerInformacoes: InfoImpressora; safecall;
    procedure ConfigurarCodigoDeBarras(altura: Integer; largura: Integer; 
                                       caracteres: PosicaoCaracteresBarras); safecall;
    procedure ImprimirCodigoDeBarras(const dados: WideString; tipo: TipoCodigoBarras); safecall;
    procedure ImprimirCodigoQR(const dados: WideString; module: Integer; correcao: QRCorrecaoErro; 
                               modelo: QRModelo); safecall;
    procedure AbrirGaveta(pino: PinoGaveta; timeOn: Integer; timeOff: Integer); safecall;
    procedure ImprimirLogo(key: Integer; code: Integer); safecall;
    procedure AlinharEsquerda; safecall;
    procedure AlinharCentral; safecall;
    procedure AlinharDireita; safecall;
    procedure Alinhar(Alinhamento: Alinhamento); safecall;
  end;

// *********************************************************************//
// DispIntf:  ICIDPrintDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1E44C7E9-16C3-42B9-9A7A-7644C272645C}
// *********************************************************************//
  ICIDPrintDisp = dispinterface
    ['{1E44C7E9-16C3-42B9-9A7A-7644C272645C}']
    procedure Iniciar; dispid 1610743808;
    procedure IniciarRede(const IP: WideString; porta: Integer); dispid 1610743809;
    procedure IniciarSerial(const porta: WideString); dispid 1610743810;
    procedure Finalizar; dispid 1610743811;
    procedure AtivarGuilhotina(tipo: TipoCorte); dispid 1610743812;
    procedure Imprimir(const texto: WideString); dispid 1610743813;
    procedure ImprimirFormatado(const texto: WideString; italico: WordBool; sublinhado: WordBool; 
                                expandido: WordBool; negrito: WordBool; condensado: WordBool); dispid 1610743814;
    procedure EnviarComando(dado: {NOT_OLEAUTO(PSafeArray)}OleVariant); dispid 1610743815;
    procedure ImprimirTeste; dispid 1610743816;
    procedure Reset; dispid 1610743817;
    function LerStatus: {NOT_OLEAUTO(StatusImpressora)}OleVariant; dispid 1610743818;
    function LerStatusGaveta: StatusGaveta; dispid 1610743819;
    function LerStatusPapel: StatusPapel; dispid 1610743820;
    function LerInformacoes: {NOT_OLEAUTO(InfoImpressora)}OleVariant; dispid 1610743821;
    procedure ConfigurarCodigoDeBarras(altura: Integer; largura: Integer; 
                                       caracteres: PosicaoCaracteresBarras); dispid 1610743822;
    procedure ImprimirCodigoDeBarras(const dados: WideString; tipo: TipoCodigoBarras); dispid 1610743823;
    procedure ImprimirCodigoQR(const dados: WideString; module: Integer; correcao: QRCorrecaoErro; 
                               modelo: QRModelo); dispid 1610743824;
    procedure AbrirGaveta(pino: PinoGaveta; timeOn: Integer; timeOff: Integer); dispid 1610743825;
    procedure ImprimirLogo(key: Integer; code: Integer); dispid 1610743826;
    procedure AlinharEsquerda; dispid 1610743827;
    procedure AlinharCentral; dispid 1610743828;
    procedure AlinharDireita; dispid 1610743829;
    procedure Alinhar(Alinhamento: Alinhamento); dispid 1610743830;
  end;

// *********************************************************************//
// Interface: _RawPrinterHelper
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E3C3A40F-4C5C-38C2-928A-7801F3599B14}
// *********************************************************************//
  _RawPrinterHelper = interface(IDispatch)
    ['{E3C3A40F-4C5C-38C2-928A-7801F3599B14}']
  end;

// *********************************************************************//
// DispIntf:  _RawPrinterHelperDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E3C3A40F-4C5C-38C2-928A-7801F3599B14}
// *********************************************************************//
  _RawPrinterHelperDisp = dispinterface
    ['{E3C3A40F-4C5C-38C2-928A-7801F3599B14}']
  end;

// *********************************************************************//
// The Class CoCIDPrintiD provides a Create and CreateRemote method to          
// create instances of the default interface ICIDPrint exposed by              
// the CoClass CIDPrintiD. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCIDPrintiD = class
    class function Create: ICIDPrint;
    class function CreateRemote(const MachineName: string): ICIDPrint;
  end;

// *********************************************************************//
// The Class CoRawPrinterHelper provides a Create and CreateRemote method to          
// create instances of the default interface _RawPrinterHelper exposed by              
// the CoClass RawPrinterHelper. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRawPrinterHelper = class
    class function Create: _RawPrinterHelper;
    class function CreateRemote(const MachineName: string): _RawPrinterHelper;
  end;

implementation

uses System.Win.ComObj;

class function CoCIDPrintiD.Create: ICIDPrint;
begin
  Result := CreateComObject(CLASS_CIDPrintiD) as ICIDPrint;
end;

class function CoCIDPrintiD.CreateRemote(const MachineName: string): ICIDPrint;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CIDPrintiD) as ICIDPrint;
end;

class function CoRawPrinterHelper.Create: _RawPrinterHelper;
begin
  Result := CreateComObject(CLASS_RawPrinterHelper) as _RawPrinterHelper;
end;

class function CoRawPrinterHelper.CreateRemote(const MachineName: string): _RawPrinterHelper;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RawPrinterHelper) as _RawPrinterHelper;
end;

end.
