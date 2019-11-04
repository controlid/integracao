unit RepCid_TLB;

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
// File generated on 12/02/2015 16:45:43 from Type Library described below.

// ************************************************************************  //
// Type Lib: W:\Gerenciador_REP\RepCid\RepCid\bin\Release\RepCid.tlb (1)
// LIBID: {2E6553EC-AA8B-40CC-AAB3-7C5314781D63}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v2.0 mscorlib, (C:\Windows\Microsoft.NET\Framework\v2.0.50727\mscorlib.tlb)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: TypeInfo 'RepCid' changed to 'RepCid_'
//   Error creating palette bitmap of (TRepCid) : Server mscoree.dll contains no icons
//   Error creating palette bitmap of (TRepCidUsb) : Server mscoree.dll contains no icons
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
  RepCidMajorVersion = 1;
  RepCidMinorVersion = 4;

  LIBID_RepCid: TGUID = '{2E6553EC-AA8B-40CC-AAB3-7C5314781D63}';

  IID_IRepCid: TGUID = '{D2F17A98-059A-4AB3-B025-2A29845F0016}';
  CLASS_RepCid_: TGUID = '{52A5E378-4F45-42AC-93B1-2941BAEC4519}';
  IID_IRepCidUsb: TGUID = '{F2DA474B-1048-4E74-88F5-8CB1CA699783}';
  CLASS_RepCidUsb: TGUID = '{D4498B68-74D6-46BA-883A-0BD0C4ED9B1D}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum ErrosRep
type
  ErrosRep = TOleEnum;
const
  ErrosRep_OK = $00000001;
  ErrosRep_ErroConexao = $00000002;
  ErrosRep_ErroAutenticacao = $00000003;
  ErrosRep_ErroNaoOcioso = $00000004;
  ErrosRep_ErroOutro = $00000005;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IRepCid = interface;
  IRepCidDisp = dispinterface;
  IRepCidUsb = interface;
  IRepCidUsbDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RepCid_ = IRepCid;
  RepCidUsb = IRepCidUsb;


// *********************************************************************//
// Interface: IRepCid
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2F17A98-059A-4AB3-B025-2A29845F0016}
// *********************************************************************//
  IRepCid = interface(IDispatch)
    ['{D2F17A98-059A-4AB3-B025-2A29845F0016}']
    function LerConfigRede(out ip: WideString; out netmask: WideString; out gateway: WideString; 
                           out porta: Word): WordBool; safecall;
    function LerConfigRede_vb6(out ip: WideString; out netmask: WideString; 
                               out gateway: WideString; out porta: Integer): WordBool; safecall;
    function GravarConfigRede(const ip: WideString; const netmask: WideString; 
                              const gateway: WideString; porta: Word; out gravou: WordBool): WordBool; safecall;
    function GravarConfigRede_vb6(const ip: WideString; const netmask: WideString; 
                                  const gateway: WideString; porta: Integer; out gravou: WordBool): WordBool; safecall;
    function LerInfo(out sn: WideString; out tam_bobina: LongWord; out restante_bobina: LongWord; 
                     out uptime: LongWord; out cortes: LongWord; out papel_acumulado: LongWord; 
                     out nsr_atual: LongWord): WordBool; safecall;
    function LerInfo_vb6(out sn: WideString; out tam_bobina: WideString; 
                         out restante_bobina: WideString; out uptime: WideString; 
                         out cortes: WideString; out papel_acumulado: WideString; 
                         out nsr_atual: WideString): WordBool; safecall;
    function LerDataHora(out ano: Integer; out mes: Integer; out dia: Integer; out hora: Integer; 
                         out minuto: Integer; out segundo: Integer): WordBool; safecall;
    function GravarDataHora(ano: Integer; mes: Integer; dia: Integer; hora: Integer; 
                            minuto: Integer; segundo: Integer; out gravou: WordBool): WordBool; safecall;
    function LerConfigHVerao(out iAno: Integer; out iMes: Integer; out iDia: Integer; 
                             out fAno: Integer; out fMes: Integer; out fDia: Integer): WordBool; safecall;
    function GravarConfigHVerao(iAno: Integer; iMes: Integer; iDia: Integer; fAno: Integer; 
                                fMes: Integer; fDia: Integer; out gravou: WordBool): WordBool; safecall;
    function ProcurarREPs: WideString; safecall;
    function LerEmpregador(out documento: WideString; out tipoDocumento: Integer; 
                           out cei: WideString; out razaoSocial: WideString; 
                           out endereco: WideString): WordBool; safecall;
    function GravarEmpregador(const documento: WideString; tipoDocumento: Integer; 
                              const cei: WideString; const razaoSocial: WideString; 
                              const endereco: WideString; out gravou: WordBool): WordBool; safecall;
    function ApagarTemplatesUsuario(pis: Int64; out apagou: WordBool): WordBool; safecall;
    function ApagarTemplatesUsuario_vb6(const pis: WideString; out apagou: WordBool): WordBool; safecall;
    function GravarTemplateUsuario(pis: Int64; template_bin: PSafeArray; out gravou: WordBool): WordBool; safecall;
    function GravarTemplateUsuario_vb6(const pis: WideString; template_bin: PSafeArray; 
                                       out gravou: WordBool): WordBool; safecall;
    function GravarTemplateUsuarioStr(pis: Int64; const template_base64: WideString; 
                                      out gravou: WordBool): WordBool; safecall;
    function GravarTemplateUsuarioStr_vb6(const pis: WideString; const template_base64: WideString; 
                                          out gravou: WordBool): WordBool; safecall;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool; safecall;
    function CarregarTemplatesUsuario_vb6(const pis: WideString; out num_templates: Integer): WordBool; safecall;
    function LerTemplate(out template_bin: PSafeArray): WordBool; safecall;
    function LerTemplateStr(out template_base64: WideString): WordBool; safecall;
    function ExtractTemplate(bytes: PSafeArray; width: Integer; height: Integer; 
                             out template_bin: PSafeArray): WordBool; safecall;
    function JoinTemplates(template1_bin: PSafeArray; template2_bin: PSafeArray; 
                           template3_bin: PSafeArray; out resultado_bin: PSafeArray): WordBool; safecall;
    function CarregarUsuarios(incluir_ndig: WordBool; out num_usuarios: Integer): WordBool; safecall;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: Integer; 
                        out senha: WideString; out barras: WideString; out rfid: Integer; 
                        out privilegios: Integer; out ndig: Integer): WordBool; safecall;
    function LerUsuario_vb6(out pis: WideString; out nome: WideString; out codigo: Integer; 
                            out senha: WideString; out barras: WideString; out rfid: Integer; 
                            out privilegios: Integer; out ndig: Integer): WordBool; safecall;
    function LerDadosUsuario(pis: Int64; out nome: WideString; out codigo: Integer; 
                             out senha: WideString; out barras: WideString; out rfid: Integer; 
                             out privilegios: Integer): WordBool; safecall;
    function LerDadosUsuario_vb6(const pis: WideString; out nome: WideString; out codigo: Integer; 
                                 out senha: WideString; out barras: WideString; out rfid: Integer; 
                                 out privilegios: Integer): WordBool; safecall;
    function GravarUsuario(pis: Int64; const nome: WideString; codigo: Integer; 
                           const senha: WideString; const barras: WideString; rfid: Integer; 
                           privilegios: Integer; out gravou: WordBool): WordBool; safecall;
    function GravarUsuario_vb6(const pis: WideString; const nome: WideString; codigo: Integer; 
                               const senha: WideString; const barras: WideString; rfid: Integer; 
                               privilegios: Integer; out gravou: WordBool): WordBool; safecall;
    function RemoverUsuario(pis: Int64; out removeu: WordBool): WordBool; safecall;
    function RemoverUsuario_vb6(const pis: WideString; out removeu: WordBool): WordBool; safecall;
    function ApagarAdmins(out ok: WordBool): WordBool; safecall;
    function BuscarAFD(nsr: Integer): WordBool; safecall;
    function LerAFD(out linha: WideString): WordBool; safecall;
    function Conectar(const ip: WideString; port: Integer; passcode: LongWord): ErrosRep; safecall;
    function Conectar_vb6(const ip: WideString; port: Integer; const passcode: WideString): ErrosRep; safecall;
    procedure Desconectar; safecall;
    function GetModeloVersao(out modelo: WideString): WordBool; safecall;
    function GetLastLog(out log: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRepCidDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D2F17A98-059A-4AB3-B025-2A29845F0016}
// *********************************************************************//
  IRepCidDisp = dispinterface
    ['{D2F17A98-059A-4AB3-B025-2A29845F0016}']
    function LerConfigRede(out ip: WideString; out netmask: WideString; out gateway: WideString; 
                           out porta: Word): WordBool; dispid 1610743808;
    function LerConfigRede_vb6(out ip: WideString; out netmask: WideString; 
                               out gateway: WideString; out porta: Integer): WordBool; dispid 1610743809;
    function GravarConfigRede(const ip: WideString; const netmask: WideString; 
                              const gateway: WideString; porta: Word; out gravou: WordBool): WordBool; dispid 1610743810;
    function GravarConfigRede_vb6(const ip: WideString; const netmask: WideString; 
                                  const gateway: WideString; porta: Integer; out gravou: WordBool): WordBool; dispid 1610743811;
    function LerInfo(out sn: WideString; out tam_bobina: LongWord; out restante_bobina: LongWord; 
                     out uptime: LongWord; out cortes: LongWord; out papel_acumulado: LongWord; 
                     out nsr_atual: LongWord): WordBool; dispid 1610743812;
    function LerInfo_vb6(out sn: WideString; out tam_bobina: WideString; 
                         out restante_bobina: WideString; out uptime: WideString; 
                         out cortes: WideString; out papel_acumulado: WideString; 
                         out nsr_atual: WideString): WordBool; dispid 1610743813;
    function LerDataHora(out ano: Integer; out mes: Integer; out dia: Integer; out hora: Integer; 
                         out minuto: Integer; out segundo: Integer): WordBool; dispid 1610743814;
    function GravarDataHora(ano: Integer; mes: Integer; dia: Integer; hora: Integer; 
                            minuto: Integer; segundo: Integer; out gravou: WordBool): WordBool; dispid 1610743815;
    function LerConfigHVerao(out iAno: Integer; out iMes: Integer; out iDia: Integer; 
                             out fAno: Integer; out fMes: Integer; out fDia: Integer): WordBool; dispid 1610743816;
    function GravarConfigHVerao(iAno: Integer; iMes: Integer; iDia: Integer; fAno: Integer; 
                                fMes: Integer; fDia: Integer; out gravou: WordBool): WordBool; dispid 1610743817;
    function ProcurarREPs: WideString; dispid 1610743818;
    function LerEmpregador(out documento: WideString; out tipoDocumento: Integer; 
                           out cei: WideString; out razaoSocial: WideString; 
                           out endereco: WideString): WordBool; dispid 1610743819;
    function GravarEmpregador(const documento: WideString; tipoDocumento: Integer; 
                              const cei: WideString; const razaoSocial: WideString; 
                              const endereco: WideString; out gravou: WordBool): WordBool; dispid 1610743820;
    function ApagarTemplatesUsuario(pis: Int64; out apagou: WordBool): WordBool; dispid 1610743821;
    function ApagarTemplatesUsuario_vb6(const pis: WideString; out apagou: WordBool): WordBool; dispid 1610743822;
    function GravarTemplateUsuario(pis: Int64; template_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant; 
                                   out gravou: WordBool): WordBool; dispid 1610743823;
    function GravarTemplateUsuario_vb6(const pis: WideString; 
                                       template_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant; 
                                       out gravou: WordBool): WordBool; dispid 1610743824;
    function GravarTemplateUsuarioStr(pis: Int64; const template_base64: WideString; 
                                      out gravou: WordBool): WordBool; dispid 1610743825;
    function GravarTemplateUsuarioStr_vb6(const pis: WideString; const template_base64: WideString; 
                                          out gravou: WordBool): WordBool; dispid 1610743826;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool; dispid 1610743827;
    function CarregarTemplatesUsuario_vb6(const pis: WideString; out num_templates: Integer): WordBool; dispid 1610743828;
    function LerTemplate(out template_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant): WordBool; dispid 1610743829;
    function LerTemplateStr(out template_base64: WideString): WordBool; dispid 1610743830;
    function ExtractTemplate(bytes: {NOT_OLEAUTO(PSafeArray)}OleVariant; width: Integer; 
                             height: Integer; out template_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant): WordBool; dispid 1610743831;
    function JoinTemplates(template1_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant; 
                           template2_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant; 
                           template3_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant; 
                           out resultado_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant): WordBool; dispid 1610743832;
    function CarregarUsuarios(incluir_ndig: WordBool; out num_usuarios: Integer): WordBool; dispid 1610743833;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: Integer; 
                        out senha: WideString; out barras: WideString; out rfid: Integer; 
                        out privilegios: Integer; out ndig: Integer): WordBool; dispid 1610743834;
    function LerUsuario_vb6(out pis: WideString; out nome: WideString; out codigo: Integer; 
                            out senha: WideString; out barras: WideString; out rfid: Integer; 
                            out privilegios: Integer; out ndig: Integer): WordBool; dispid 1610743835;
    function LerDadosUsuario(pis: Int64; out nome: WideString; out codigo: Integer; 
                             out senha: WideString; out barras: WideString; out rfid: Integer; 
                             out privilegios: Integer): WordBool; dispid 1610743836;
    function LerDadosUsuario_vb6(const pis: WideString; out nome: WideString; out codigo: Integer; 
                                 out senha: WideString; out barras: WideString; out rfid: Integer; 
                                 out privilegios: Integer): WordBool; dispid 1610743837;
    function GravarUsuario(pis: Int64; const nome: WideString; codigo: Integer; 
                           const senha: WideString; const barras: WideString; rfid: Integer; 
                           privilegios: Integer; out gravou: WordBool): WordBool; dispid 1610743838;
    function GravarUsuario_vb6(const pis: WideString; const nome: WideString; codigo: Integer; 
                               const senha: WideString; const barras: WideString; rfid: Integer; 
                               privilegios: Integer; out gravou: WordBool): WordBool; dispid 1610743839;
    function RemoverUsuario(pis: Int64; out removeu: WordBool): WordBool; dispid 1610743840;
    function RemoverUsuario_vb6(const pis: WideString; out removeu: WordBool): WordBool; dispid 1610743841;
    function ApagarAdmins(out ok: WordBool): WordBool; dispid 1610743842;
    function BuscarAFD(nsr: Integer): WordBool; dispid 1610743843;
    function LerAFD(out linha: WideString): WordBool; dispid 1610743844;
    function Conectar(const ip: WideString; port: Integer; passcode: LongWord): ErrosRep; dispid 1610743845;
    function Conectar_vb6(const ip: WideString; port: Integer; const passcode: WideString): ErrosRep; dispid 1610743846;
    procedure Desconectar; dispid 1610743847;
    function GetModeloVersao(out modelo: WideString): WordBool; dispid 1610743848;
    function GetLastLog(out log: WideString): WordBool; dispid 1610743849;
  end;

// *********************************************************************//
// Interface: IRepCidUsb
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2DA474B-1048-4E74-88F5-8CB1CA699783}
// *********************************************************************//
  IRepCidUsb = interface(IDispatch)
    ['{F2DA474B-1048-4E74-88F5-8CB1CA699783}']
    function GetLastError: WideString; safecall;
    function CarregarUsuarios(const fileNameUsuarios: WideString; 
                              const fileNameDigitais: WideString; out numUsrs: Integer; 
                              out leuDigitais: WordBool): WordBool; safecall;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: LongWord; 
                        out senha: WideString; out barras: WideString; out rfid: LongWord; 
                        out privilegios: Integer; out num_templates: Integer): WordBool; safecall;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool; safecall;
    function LerTemplate(out template_bin: PSafeArray): WordBool; safecall;
    function LerTemplateStr(out template_base64: WideString): WordBool; safecall;
    procedure IniciaGravacao; safecall;
    function AdicionarUsuario(pis: Int64; const nome: WideString; codigo: LongWord; 
                              const senha: WideString; const barras: WideString; rfid: LongWord; 
                              privilegios: Integer): WordBool; safecall;
    function AdicionarTemplate(pis: Int64; template_bin: PSafeArray): WordBool; safecall;
    function AdicionarTemplateStr(pis: Int64; const template_base64: WideString): WordBool; safecall;
    function FinalizarGravacao(const fileNameUsuarios: WideString; 
                               const fileNameDigitais: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IRepCidUsbDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F2DA474B-1048-4E74-88F5-8CB1CA699783}
// *********************************************************************//
  IRepCidUsbDisp = dispinterface
    ['{F2DA474B-1048-4E74-88F5-8CB1CA699783}']
    function GetLastError: WideString; dispid 1610743808;
    function CarregarUsuarios(const fileNameUsuarios: WideString; 
                              const fileNameDigitais: WideString; out numUsrs: Integer; 
                              out leuDigitais: WordBool): WordBool; dispid 1610743809;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: LongWord; 
                        out senha: WideString; out barras: WideString; out rfid: LongWord; 
                        out privilegios: Integer; out num_templates: Integer): WordBool; dispid 1610743810;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool; dispid 1610743811;
    function LerTemplate(out template_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant): WordBool; dispid 1610743812;
    function LerTemplateStr(out template_base64: WideString): WordBool; dispid 1610743813;
    procedure IniciaGravacao; dispid 1610743814;
    function AdicionarUsuario(pis: Int64; const nome: WideString; codigo: LongWord; 
                              const senha: WideString; const barras: WideString; rfid: LongWord; 
                              privilegios: Integer): WordBool; dispid 1610743815;
    function AdicionarTemplate(pis: Int64; template_bin: {NOT_OLEAUTO(PSafeArray)}OleVariant): WordBool; dispid 1610743816;
    function AdicionarTemplateStr(pis: Int64; const template_base64: WideString): WordBool; dispid 1610743817;
    function FinalizarGravacao(const fileNameUsuarios: WideString; 
                               const fileNameDigitais: WideString): WordBool; dispid 1610743818;
  end;

// *********************************************************************//
// The Class CoRepCid_ provides a Create and CreateRemote method to          
// create instances of the default interface IRepCid exposed by              
// the CoClass RepCid_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRepCid_ = class
    class function Create: IRepCid;
    class function CreateRemote(const MachineName: string): IRepCid;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRepCid
// Help String      : 
// Default Interface: IRepCid
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRepCid = class(TOleServer)
  private
    FIntf: IRepCid;
    function GetDefaultInterface: IRepCid;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IRepCid);
    procedure Disconnect; override;
    function LerConfigRede(out ip: WideString; out netmask: WideString; out gateway: WideString; 
                           out porta: Word): WordBool;
    function LerConfigRede_vb6(out ip: WideString; out netmask: WideString; 
                               out gateway: WideString; out porta: Integer): WordBool;
    function GravarConfigRede(const ip: WideString; const netmask: WideString; 
                              const gateway: WideString; porta: Word; out gravou: WordBool): WordBool;
    function GravarConfigRede_vb6(const ip: WideString; const netmask: WideString; 
                                  const gateway: WideString; porta: Integer; out gravou: WordBool): WordBool;
    function LerInfo(out sn: WideString; out tam_bobina: LongWord; out restante_bobina: LongWord; 
                     out uptime: LongWord; out cortes: LongWord; out papel_acumulado: LongWord; 
                     out nsr_atual: LongWord): WordBool;
    function LerInfo_vb6(out sn: WideString; out tam_bobina: WideString; 
                         out restante_bobina: WideString; out uptime: WideString; 
                         out cortes: WideString; out papel_acumulado: WideString; 
                         out nsr_atual: WideString): WordBool;
    function LerDataHora(out ano: Integer; out mes: Integer; out dia: Integer; out hora: Integer; 
                         out minuto: Integer; out segundo: Integer): WordBool;
    function GravarDataHora(ano: Integer; mes: Integer; dia: Integer; hora: Integer; 
                            minuto: Integer; segundo: Integer; out gravou: WordBool): WordBool;
    function LerConfigHVerao(out iAno: Integer; out iMes: Integer; out iDia: Integer; 
                             out fAno: Integer; out fMes: Integer; out fDia: Integer): WordBool;
    function GravarConfigHVerao(iAno: Integer; iMes: Integer; iDia: Integer; fAno: Integer; 
                                fMes: Integer; fDia: Integer; out gravou: WordBool): WordBool;
    function ProcurarREPs: WideString;
    function LerEmpregador(out documento: WideString; out tipoDocumento: Integer; 
                           out cei: WideString; out razaoSocial: WideString; 
                           out endereco: WideString): WordBool;
    function GravarEmpregador(const documento: WideString; tipoDocumento: Integer; 
                              const cei: WideString; const razaoSocial: WideString; 
                              const endereco: WideString; out gravou: WordBool): WordBool;
    function ApagarTemplatesUsuario(pis: Int64; out apagou: WordBool): WordBool;
    function ApagarTemplatesUsuario_vb6(const pis: WideString; out apagou: WordBool): WordBool;
    function GravarTemplateUsuario(pis: Int64; template_bin: PSafeArray; out gravou: WordBool): WordBool;
    function GravarTemplateUsuario_vb6(const pis: WideString; template_bin: PSafeArray; 
                                       out gravou: WordBool): WordBool;
    function GravarTemplateUsuarioStr(pis: Int64; const template_base64: WideString; 
                                      out gravou: WordBool): WordBool;
    function GravarTemplateUsuarioStr_vb6(const pis: WideString; const template_base64: WideString; 
                                          out gravou: WordBool): WordBool;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool;
    function CarregarTemplatesUsuario_vb6(const pis: WideString; out num_templates: Integer): WordBool;
    function LerTemplate(out template_bin: PSafeArray): WordBool;
    function LerTemplateStr(out template_base64: WideString): WordBool;
    function ExtractTemplate(bytes: PSafeArray; width: Integer; height: Integer; 
                             out template_bin: PSafeArray): WordBool;
    function JoinTemplates(template1_bin: PSafeArray; template2_bin: PSafeArray; 
                           template3_bin: PSafeArray; out resultado_bin: PSafeArray): WordBool;
    function CarregarUsuarios(incluir_ndig: WordBool; out num_usuarios: Integer): WordBool;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: Integer; 
                        out senha: WideString; out barras: WideString; out rfid: Integer; 
                        out privilegios: Integer; out ndig: Integer): WordBool;
    function LerUsuario_vb6(out pis: WideString; out nome: WideString; out codigo: Integer; 
                            out senha: WideString; out barras: WideString; out rfid: Integer; 
                            out privilegios: Integer; out ndig: Integer): WordBool;
    function LerDadosUsuario(pis: Int64; out nome: WideString; out codigo: Integer; 
                             out senha: WideString; out barras: WideString; out rfid: Integer; 
                             out privilegios: Integer): WordBool;
    function LerDadosUsuario_vb6(const pis: WideString; out nome: WideString; out codigo: Integer; 
                                 out senha: WideString; out barras: WideString; out rfid: Integer; 
                                 out privilegios: Integer): WordBool;
    function GravarUsuario(pis: Int64; const nome: WideString; codigo: Integer; 
                           const senha: WideString; const barras: WideString; rfid: Integer; 
                           privilegios: Integer; out gravou: WordBool): WordBool;
    function GravarUsuario_vb6(const pis: WideString; const nome: WideString; codigo: Integer; 
                               const senha: WideString; const barras: WideString; rfid: Integer; 
                               privilegios: Integer; out gravou: WordBool): WordBool;
    function RemoverUsuario(pis: Int64; out removeu: WordBool): WordBool;
    function RemoverUsuario_vb6(const pis: WideString; out removeu: WordBool): WordBool;
    function ApagarAdmins(out ok: WordBool): WordBool;
    function BuscarAFD(nsr: Integer): WordBool;
    function LerAFD(out linha: WideString): WordBool;
    function Conectar(const ip: WideString; port: Integer; passcode: LongWord): ErrosRep;
    function Conectar_vb6(const ip: WideString; port: Integer; const passcode: WideString): ErrosRep;
    procedure Desconectar;
    function GetModeloVersao(out modelo: WideString): WordBool;
    function GetLastLog(out log: WideString): WordBool;
    property DefaultInterface: IRepCid read GetDefaultInterface;
  published
  end;

// *********************************************************************//
// The Class CoRepCidUsb provides a Create and CreateRemote method to          
// create instances of the default interface IRepCidUsb exposed by              
// the CoClass RepCidUsb. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRepCidUsb = class
    class function Create: IRepCidUsb;
    class function CreateRemote(const MachineName: string): IRepCidUsb;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TRepCidUsb
// Help String      : 
// Default Interface: IRepCidUsb
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TRepCidUsb = class(TOleServer)
  private
    FIntf: IRepCidUsb;
    function GetDefaultInterface: IRepCidUsb;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IRepCidUsb);
    procedure Disconnect; override;
    function GetLastError: WideString;
    function CarregarUsuarios(const fileNameUsuarios: WideString; 
                              const fileNameDigitais: WideString; out numUsrs: Integer; 
                              out leuDigitais: WordBool): WordBool;
    function LerUsuario(out pis: Int64; out nome: WideString; out codigo: LongWord; 
                        out senha: WideString; out barras: WideString; out rfid: LongWord; 
                        out privilegios: Integer; out num_templates: Integer): WordBool;
    function CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool;
    function LerTemplate(out template_bin: PSafeArray): WordBool;
    function LerTemplateStr(out template_base64: WideString): WordBool;
    procedure IniciaGravacao;
    function AdicionarUsuario(pis: Int64; const nome: WideString; codigo: LongWord; 
                              const senha: WideString; const barras: WideString; rfid: LongWord; 
                              privilegios: Integer): WordBool;
    function AdicionarTemplate(pis: Int64; template_bin: PSafeArray): WordBool;
    function AdicionarTemplateStr(pis: Int64; const template_base64: WideString): WordBool;
    function FinalizarGravacao(const fileNameUsuarios: WideString; 
                               const fileNameDigitais: WideString): WordBool;
    property DefaultInterface: IRepCidUsb read GetDefaultInterface;
  published
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses System.Win.ComObj;

class function CoRepCid_.Create: IRepCid;
begin
  Result := CreateComObject(CLASS_RepCid_) as IRepCid;
end;

class function CoRepCid_.CreateRemote(const MachineName: string): IRepCid;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RepCid_) as IRepCid;
end;

procedure TRepCid.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{52A5E378-4F45-42AC-93B1-2941BAEC4519}';
    IntfIID:   '{D2F17A98-059A-4AB3-B025-2A29845F0016}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRepCid.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IRepCid;
  end;
end;

procedure TRepCid.ConnectTo(svrIntf: IRepCid);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRepCid.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRepCid.GetDefaultInterface: IRepCid;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRepCid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRepCid.Destroy;
begin
  inherited Destroy;
end;

function TRepCid.LerConfigRede(out ip: WideString; out netmask: WideString; 
                               out gateway: WideString; out porta: Word): WordBool;
begin
  Result := DefaultInterface.LerConfigRede(ip, netmask, gateway, porta);
end;

function TRepCid.LerConfigRede_vb6(out ip: WideString; out netmask: WideString; 
                                   out gateway: WideString; out porta: Integer): WordBool;
begin
  Result := DefaultInterface.LerConfigRede_vb6(ip, netmask, gateway, porta);
end;

function TRepCid.GravarConfigRede(const ip: WideString; const netmask: WideString; 
                                  const gateway: WideString; porta: Word; out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarConfigRede(ip, netmask, gateway, porta, gravou);
end;

function TRepCid.GravarConfigRede_vb6(const ip: WideString; const netmask: WideString; 
                                      const gateway: WideString; porta: Integer; 
                                      out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarConfigRede_vb6(ip, netmask, gateway, porta, gravou);
end;

function TRepCid.LerInfo(out sn: WideString; out tam_bobina: LongWord; 
                         out restante_bobina: LongWord; out uptime: LongWord; out cortes: LongWord; 
                         out papel_acumulado: LongWord; out nsr_atual: LongWord): WordBool;
begin
  Result := DefaultInterface.LerInfo(sn, tam_bobina, restante_bobina, uptime, cortes, 
                                     papel_acumulado, nsr_atual);
end;

function TRepCid.LerInfo_vb6(out sn: WideString; out tam_bobina: WideString; 
                             out restante_bobina: WideString; out uptime: WideString; 
                             out cortes: WideString; out papel_acumulado: WideString; 
                             out nsr_atual: WideString): WordBool;
begin
  Result := DefaultInterface.LerInfo_vb6(sn, tam_bobina, restante_bobina, uptime, cortes, 
                                         papel_acumulado, nsr_atual);
end;

function TRepCid.LerDataHora(out ano: Integer; out mes: Integer; out dia: Integer; 
                             out hora: Integer; out minuto: Integer; out segundo: Integer): WordBool;
begin
  Result := DefaultInterface.LerDataHora(ano, mes, dia, hora, minuto, segundo);
end;

function TRepCid.GravarDataHora(ano: Integer; mes: Integer; dia: Integer; hora: Integer; 
                                minuto: Integer; segundo: Integer; out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarDataHora(ano, mes, dia, hora, minuto, segundo, gravou);
end;

function TRepCid.LerConfigHVerao(out iAno: Integer; out iMes: Integer; out iDia: Integer; 
                                 out fAno: Integer; out fMes: Integer; out fDia: Integer): WordBool;
begin
  Result := DefaultInterface.LerConfigHVerao(iAno, iMes, iDia, fAno, fMes, fDia);
end;

function TRepCid.GravarConfigHVerao(iAno: Integer; iMes: Integer; iDia: Integer; fAno: Integer; 
                                    fMes: Integer; fDia: Integer; out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarConfigHVerao(iAno, iMes, iDia, fAno, fMes, fDia, gravou);
end;

function TRepCid.ProcurarREPs: WideString;
begin
  Result := DefaultInterface.ProcurarREPs;
end;

function TRepCid.LerEmpregador(out documento: WideString; out tipoDocumento: Integer; 
                               out cei: WideString; out razaoSocial: WideString; 
                               out endereco: WideString): WordBool;
begin
  Result := DefaultInterface.LerEmpregador(documento, tipoDocumento, cei, razaoSocial, endereco);
end;

function TRepCid.GravarEmpregador(const documento: WideString; tipoDocumento: Integer; 
                                  const cei: WideString; const razaoSocial: WideString; 
                                  const endereco: WideString; out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarEmpregador(documento, tipoDocumento, cei, razaoSocial, endereco, 
                                              gravou);
end;

function TRepCid.ApagarTemplatesUsuario(pis: Int64; out apagou: WordBool): WordBool;
begin
  Result := DefaultInterface.ApagarTemplatesUsuario(pis, apagou);
end;

function TRepCid.ApagarTemplatesUsuario_vb6(const pis: WideString; out apagou: WordBool): WordBool;
begin
  Result := DefaultInterface.ApagarTemplatesUsuario_vb6(pis, apagou);
end;

function TRepCid.GravarTemplateUsuario(pis: Int64; template_bin: PSafeArray; out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarTemplateUsuario(pis, template_bin, gravou);
end;

function TRepCid.GravarTemplateUsuario_vb6(const pis: WideString; template_bin: PSafeArray; 
                                           out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarTemplateUsuario_vb6(pis, template_bin, gravou);
end;

function TRepCid.GravarTemplateUsuarioStr(pis: Int64; const template_base64: WideString; 
                                          out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarTemplateUsuarioStr(pis, template_base64, gravou);
end;

function TRepCid.GravarTemplateUsuarioStr_vb6(const pis: WideString; 
                                              const template_base64: WideString; 
                                              out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarTemplateUsuarioStr_vb6(pis, template_base64, gravou);
end;

function TRepCid.CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool;
begin
  Result := DefaultInterface.CarregarTemplatesUsuario(pis, num_templates);
end;

function TRepCid.CarregarTemplatesUsuario_vb6(const pis: WideString; out num_templates: Integer): WordBool;
begin
  Result := DefaultInterface.CarregarTemplatesUsuario_vb6(pis, num_templates);
end;

function TRepCid.LerTemplate(out template_bin: PSafeArray): WordBool;
begin
  Result := DefaultInterface.LerTemplate(template_bin);
end;

function TRepCid.LerTemplateStr(out template_base64: WideString): WordBool;
begin
  Result := DefaultInterface.LerTemplateStr(template_base64);
end;

function TRepCid.ExtractTemplate(bytes: PSafeArray; width: Integer; height: Integer; 
                                 out template_bin: PSafeArray): WordBool;
begin
  Result := DefaultInterface.ExtractTemplate(bytes, width, height, template_bin);
end;

function TRepCid.JoinTemplates(template1_bin: PSafeArray; template2_bin: PSafeArray; 
                               template3_bin: PSafeArray; out resultado_bin: PSafeArray): WordBool;
begin
  Result := DefaultInterface.JoinTemplates(template1_bin, template2_bin, template3_bin, 
                                           resultado_bin);
end;

function TRepCid.CarregarUsuarios(incluir_ndig: WordBool; out num_usuarios: Integer): WordBool;
begin
  Result := DefaultInterface.CarregarUsuarios(incluir_ndig, num_usuarios);
end;

function TRepCid.LerUsuario(out pis: Int64; out nome: WideString; out codigo: Integer; 
                            out senha: WideString; out barras: WideString; out rfid: Integer; 
                            out privilegios: Integer; out ndig: Integer): WordBool;
begin
  Result := DefaultInterface.LerUsuario(pis, nome, codigo, senha, barras, rfid, privilegios, ndig);
end;

function TRepCid.LerUsuario_vb6(out pis: WideString; out nome: WideString; out codigo: Integer; 
                                out senha: WideString; out barras: WideString; out rfid: Integer; 
                                out privilegios: Integer; out ndig: Integer): WordBool;
begin
  Result := DefaultInterface.LerUsuario_vb6(pis, nome, codigo, senha, barras, rfid, privilegios, 
                                            ndig);
end;

function TRepCid.LerDadosUsuario(pis: Int64; out nome: WideString; out codigo: Integer; 
                                 out senha: WideString; out barras: WideString; out rfid: Integer; 
                                 out privilegios: Integer): WordBool;
begin
  Result := DefaultInterface.LerDadosUsuario(pis, nome, codigo, senha, barras, rfid, privilegios);
end;

function TRepCid.LerDadosUsuario_vb6(const pis: WideString; out nome: WideString; 
                                     out codigo: Integer; out senha: WideString; 
                                     out barras: WideString; out rfid: Integer; 
                                     out privilegios: Integer): WordBool;
begin
  Result := DefaultInterface.LerDadosUsuario_vb6(pis, nome, codigo, senha, barras, rfid, privilegios);
end;

function TRepCid.GravarUsuario(pis: Int64; const nome: WideString; codigo: Integer; 
                               const senha: WideString; const barras: WideString; rfid: Integer; 
                               privilegios: Integer; out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarUsuario(pis, nome, codigo, senha, barras, rfid, privilegios, 
                                           gravou);
end;

function TRepCid.GravarUsuario_vb6(const pis: WideString; const nome: WideString; codigo: Integer; 
                                   const senha: WideString; const barras: WideString; 
                                   rfid: Integer; privilegios: Integer; out gravou: WordBool): WordBool;
begin
  Result := DefaultInterface.GravarUsuario_vb6(pis, nome, codigo, senha, barras, rfid, privilegios, 
                                               gravou);
end;

function TRepCid.RemoverUsuario(pis: Int64; out removeu: WordBool): WordBool;
begin
  Result := DefaultInterface.RemoverUsuario(pis, removeu);
end;

function TRepCid.RemoverUsuario_vb6(const pis: WideString; out removeu: WordBool): WordBool;
begin
  Result := DefaultInterface.RemoverUsuario_vb6(pis, removeu);
end;

function TRepCid.ApagarAdmins(out ok: WordBool): WordBool;
begin
  Result := DefaultInterface.ApagarAdmins(ok);
end;

function TRepCid.BuscarAFD(nsr: Integer): WordBool;
begin
  Result := DefaultInterface.BuscarAFD(nsr);
end;

function TRepCid.LerAFD(out linha: WideString): WordBool;
begin
  Result := DefaultInterface.LerAFD(linha);
end;

function TRepCid.Conectar(const ip: WideString; port: Integer; passcode: LongWord): ErrosRep;
begin
  Result := DefaultInterface.Conectar(ip, port, passcode);
end;

function TRepCid.Conectar_vb6(const ip: WideString; port: Integer; const passcode: WideString): ErrosRep;
begin
  Result := DefaultInterface.Conectar_vb6(ip, port, passcode);
end;

procedure TRepCid.Desconectar;
begin
  DefaultInterface.Desconectar;
end;

function TRepCid.GetModeloVersao(out modelo: WideString): WordBool;
begin
  Result := DefaultInterface.GetModeloVersao(modelo);
end;

function TRepCid.GetLastLog(out log: WideString): WordBool;
begin
  Result := DefaultInterface.GetLastLog(log);
end;

class function CoRepCidUsb.Create: IRepCidUsb;
begin
  Result := CreateComObject(CLASS_RepCidUsb) as IRepCidUsb;
end;

class function CoRepCidUsb.CreateRemote(const MachineName: string): IRepCidUsb;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RepCidUsb) as IRepCidUsb;
end;

procedure TRepCidUsb.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{D4498B68-74D6-46BA-883A-0BD0C4ED9B1D}';
    IntfIID:   '{F2DA474B-1048-4E74-88F5-8CB1CA699783}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TRepCidUsb.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IRepCidUsb;
  end;
end;

procedure TRepCidUsb.ConnectTo(svrIntf: IRepCidUsb);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TRepCidUsb.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TRepCidUsb.GetDefaultInterface: IRepCidUsb;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TRepCidUsb.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TRepCidUsb.Destroy;
begin
  inherited Destroy;
end;

function TRepCidUsb.GetLastError: WideString;
begin
  Result := DefaultInterface.GetLastError;
end;

function TRepCidUsb.CarregarUsuarios(const fileNameUsuarios: WideString; 
                                     const fileNameDigitais: WideString; out numUsrs: Integer; 
                                     out leuDigitais: WordBool): WordBool;
begin
  Result := DefaultInterface.CarregarUsuarios(fileNameUsuarios, fileNameDigitais, numUsrs, 
                                              leuDigitais);
end;

function TRepCidUsb.LerUsuario(out pis: Int64; out nome: WideString; out codigo: LongWord; 
                               out senha: WideString; out barras: WideString; out rfid: LongWord; 
                               out privilegios: Integer; out num_templates: Integer): WordBool;
begin
  Result := DefaultInterface.LerUsuario(pis, nome, codigo, senha, barras, rfid, privilegios, 
                                        num_templates);
end;

function TRepCidUsb.CarregarTemplatesUsuario(pis: Int64; out num_templates: Integer): WordBool;
begin
  Result := DefaultInterface.CarregarTemplatesUsuario(pis, num_templates);
end;

function TRepCidUsb.LerTemplate(out template_bin: PSafeArray): WordBool;
begin
  Result := DefaultInterface.LerTemplate(template_bin);
end;

function TRepCidUsb.LerTemplateStr(out template_base64: WideString): WordBool;
begin
  Result := DefaultInterface.LerTemplateStr(template_base64);
end;

procedure TRepCidUsb.IniciaGravacao;
begin
  DefaultInterface.IniciaGravacao;
end;

function TRepCidUsb.AdicionarUsuario(pis: Int64; const nome: WideString; codigo: LongWord; 
                                     const senha: WideString; const barras: WideString; 
                                     rfid: LongWord; privilegios: Integer): WordBool;
begin
  Result := DefaultInterface.AdicionarUsuario(pis, nome, codigo, senha, barras, rfid, privilegios);
end;

function TRepCidUsb.AdicionarTemplate(pis: Int64; template_bin: PSafeArray): WordBool;
begin
  Result := DefaultInterface.AdicionarTemplate(pis, template_bin);
end;

function TRepCidUsb.AdicionarTemplateStr(pis: Int64; const template_base64: WideString): WordBool;
begin
  Result := DefaultInterface.AdicionarTemplateStr(pis, template_base64);
end;

function TRepCidUsb.FinalizarGravacao(const fileNameUsuarios: WideString; 
                                      const fileNameDigitais: WideString): WordBool;
begin
  Result := DefaultInterface.FinalizarGravacao(fileNameUsuarios, fileNameDigitais);
end;

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TRepCid, TRepCidUsb]);
end;

end.
