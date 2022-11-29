{ superobject.pas } // version: 2021.0116.1915
(*
 *                         Super Object Toolkit
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Embarcadero Technologies Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 *     -https://code.google.com/p/superobject/
 *     -http://www.progdigy.com
 *     +https://github.com/hgourvest/superobject
 *     +https://github.com/cHullaert/superobject
 *     +https://github.com/fOCUSVRN/TJsonSerializer
 *     TODO: new urls for github contributors
 * Web site   : http://www.progdigy.com
 *
 * This unit is inspired from the json c lib:
 *   Michael Clark <michael@metaparadigm.com>
 *     +https://github.com/json-c/json-c
 *     -http://oss.metaparadigm.com/json-c/
 *
 *  CHANGES:
 *  v1.2
 *   + support of currency data type
 *   + right trim unquoted string
 *   + read Unicode Files and streams (Litle Endian with BOM)
 *   + Fix bug on javadate functions + windows nt compatibility
 *   + Now you can force to parse only the canonical syntax of JSON using the stric parameter
 *   + Delphi 2010 RTTI marshalling
 *   + Delphi 10.4 Sydney RTTI marshalling of "Managed Records"
 *
 *   . . .
 *)

{$IFDEF FPC}
  {.$mode objfpc} { not suppoter }
  {$mode delphi}
  {.$mode delphiunicode} { optional }
  {$asmmode intel}
  {$h+} // long AnsiString (not ShortString)
  //{$interfaces com}
{$ENDIF}

{+}
(*

*
* TODO: need check/fix issues:
*
   - Parsing ShortStrings
     https://code.google.com/p/superobject/issues/detail?id=56
     https://code.google.com/p/superobject/issues/detail?id=55
   - superxmlparser.XMLParseString
     https://code.google.com/p/superobject/issues/detail?id=52
   - check: mem leak objects
     https://code.google.com/p/superobject/issues/detail?id=34
   - parset ignore spares
     https://code.google.com/p/superobject/issues/detail?id=28
   - double serialized as NaN without quotes
     https://code.google.com/p/superobject/issues/detail?id=21
   - delphi rtti error for record string[?]
     https://code.google.com/p/superobject/issues/detail?id=17
   - parse path
     https://code.google.com/p/superobject/issues/detail?id=8
   - parse ':' in names
     https://code.google.com/p/superobject/issues/detail?id=6
*)
{+.}

{+} // Compiler directives move up for access to CompilerVersion
unit superobject;
{+.}

{+}
{$warnings on}
{$hints on}
{$ifdef FPC}
  {$notes on}
  //{$POINTERMATH ON}
  {$warn 6058 off} // -vm6058 Note: * inlie not inlined
{$endif}

{$T+} // Typed Pointer

{$B-} // Complete boolean eval OFF
{$A+} // Directive controls alignment of fields in record types
{$RANGECHECKS OFF}
{$OVERFLOWCHECKS OFF}
//{$if (not defined(FPC)) and defined(CBUILDER))
//  {$OBJEXPORTALL ON} { optional }
//{$ifend}

{$IFNDEF FPC}{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 24}
    {$LEGACYIFEND ON} // Allow old style mixed $endif $ifend
  {$IFEND}
  //{$IF CompilerVersion >= 17.00} // Delphi 2005
  //  {$define HAVE_FOR_IN}
  //{$IFEND}
  //{$IF CompilerVersion >= 20.00} // Delphi 2009
  //  {$define HAVE_GENERICS}
  //{$IFEND}
  //{$IF CompilerVersion >= 23.00}  // XE2 Up; XE(22.00) partial implement "Unit Scope"
  //  {$define HAVE_UNITSCOPE}
  //{$IFEND}
  //{$IF CompilerVersion >= 25.00}  // XE4 Up
  //  {$define DEPRECATED_SYSUTILS_ANSISTRINGS}
  //{$IFEND}
{$ENDIF}{$ENDIF}
{+.}
//
{+} // https://code.google.com/p/superobject/issues/detail?id=57
{$IFDEF FPC}
  {$define HAVE_INLINE}
  {$define NEED_FORMATSETTINGS}
  {$IFDEF UNICODE} // for "{$mode delphiunicode}"
    {$define FPC_UNICODE}
  {$ENDIF}
  {$define HAVE_RTTI} // optional
  {$define NEED_FORMATSETTINGS} // optional
  //?{$POINTERMATH OFF}
  //{$define HAVE_FOR_IN}
{$ELSE !FPC}
  {$undef NEED_FORMATSETTINGS}
  {$IFDEF CONDITIONALEXPRESSIONS}
    {$if CompilerVersion >= 17} // Delphi 2005
      {$define HAVE_INLINE}
    {$ifend}
    {$IF CompilerVersion >= 23} // XE2
      {$define HAVE_RTTI}
    {$ifend}
    {$if CompilerVersion > 18} // Delphi 2007 Up (18.50)
      {$define NEED_FORMATSETTINGS} // TODO: check for prev versions
    {$ifend}
  {$ENDIF}
  {$IFDEF UNICODE}
    {$define DELPHI_UNICODE}
  {$ENDIF}
{$ENDIF !FPC}
{$IFDEF AUTOREFCOUNT}
  {$define HAVE_RTTI}
{$ENDIF}
{+.}
{+} // https://code.google.com/p/superobject/issues/detail?id=16
{$undef USE_REFLECTION}
{$IFDEF HAVE_RTTI}
  {$define USE_REFLECTION} { optional: for TRttiObjectHelper }
  // Imported class: "TRttiObjectHelper" from DSharp [ https://bitbucket.org/sglienke/dsharp ]
{$ENDIF}
{+.}
{+}
// Allow next code without AV:
// ---
//   for item in (TSuperObject.ParseFile('123-empty.json', true, true) as ISuperObject)['stroka'] do ...
// ---
{$undef EXTEND_FORIN}
{$define EXTEND_FORIN} { optional } // TODO: "pult": need check any combination
{+.}
//
{+}
{$IFDEF IOS}
  {$IFDEF CPUARM}
    {$IFNDEF CPUARM64}
       {$ALIGN 8} // workaround on ALIGN for IOS32 (define CPUARM32 is unknown in XE7 and low)
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
//
{$IFDEF NEXTGEN}
  {$ZEROBASEDSTRINGS OFF}
{$ENDIF}
//
{$IFDEF DELPHI_UNICODE}
  {$HIGHCHARUNICODE ON}  {make all #nn char constants Wide for better portability}
{$ENDIF}
{+.}
//
{$undef SUPER_METHOD}
{$define SUPER_METHOD} { optional }
//
{+}
{$IFDEF RELEASE}
  {$undef DEBUG}
{$ELSE}
  {.$define DEBUG} { optional } // track memory leack
  {$IFDEF DEBUG_SUPEROBJECT}
    {$define DEBUG} { optional } // track memory leack
  {$ENDIF}
{$ENDIF}
//
{$IFDEF RELEASE}
  {$C-} // Assertions OFF
{$ELSE}
  {$IFDEF DEBUG}
    { <optional> }
      {$D+,L+,Y+} // Debug info ON; Local symbols ON; Reference info ON
      {$O-} // Optimization OFF
      {$R+} // Range checking ON
      {$Q+} // Overflow checking ON
      {$C+} // Assertions ON
    { <\optional> }
  {$ELSE}
    { <optional> }
      {.$D+,L+,Y+}
      {.$O-}
      {.$C+}
    { <\optional> }
  {$ENDIF}
{$ENDIF}
{+.}

interface

uses
  {+}
  sysutils,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  {+.}
  Classes, supertypes
{$IFDEF HAVE_RTTI}
  {$IFDEF FPC}
  ,Generics.Collections, Generics.Defaults
  {$ELSE !FPC}
  {$IF CompilerVersion >= 23} // XE2 Up
  ,System.Generics.Collections
  {$ELSE}
  ,Generics.Collections       // Only XE
  {$IFEND}
  {$ENDIF !FPC}
  ,{%H-}Rtti // FPC: Warning: Unit "Rtti" is experimental
  ,TypInfo
{$ENDIF}
  ;

const
  SuperObjectVersion = 202101161915;
  {$EXTERNALSYM SuperObjectVersion}
  SuperObjectVerInfo = 'contributor: pult';
  {$EXTERNALSYM SuperObjectVerInfo}

  // Sample for checking version of "superobject" library:
  // <sample>
  {$IFDEF CONDITIONALEXPRESSIONS}{$define SOCONDEXPR}{$ELSE}
    {$IFDEF FPC}{$define SOCONDEXPR}{$ELSE}{$undef SOCONDEXPR}{$ENDIF}
  {$ENDIF}
  {$IFDEF SOCONDEXPR} // FPC or Delphi6 Up
    //{$ifndef FPC}{$warn comparison_true off}{$endif}
    {$if declared(SuperObjectVersion)} {$if SuperObjectVersion < 202101161915}
      {$MESSAGE FATAL 'Required update of "superobject" library'} {$ifend}
    {$else}
      {$MESSAGE FATAL 'Unknown version of "superobject" library'}
    {$ifend}
  {$ELSE}
    //{$ifndef FPC}{$warn message_directive on}{$endif}{$MESSAGE WARN 'Cannot check version of "superobject" library'}
  {$ENDIF}
  // <\sample>

  SUPER_ARRAY_LIST_DEFAULT_SIZE = 32;
  SUPER_TOKENER_MAX_DEPTH = 32;

  SUPER_AVL_MAX_DEPTH = sizeof(longint) * 8;
  SUPER_AVL_MASK_HIGH_BIT = not ((not longword(0)) shr 1);

const  { not change values }
  CP_ANSI    = 0;      // == windows.CP_ACP
  CP_UTF7    = 65000;  // == windows.CP_UTF7
  CP_UTF8    = 65001;  // == windows.CP_UTF8
  CP_UTF16LE = 1200;   // == Unicode (UTF-16) = (Unicode Default)
  CP_UTF16BE = 1201;   // == Unicode (UTF-16)
  CP_1250    = 1250;   // == CP_ANSI_LATIN_2 = Central European (Windows Latin 2)
  CP_1251    = 1251;   // == CP_ANSI_CYRILLIC
  CP_1252    = 1252;   // == CP_ANSI_LATIN_1 = Western (Windows Latin 1)
  CP_437     = 437;    // == Latin-US (DOS)
  CP_850     = 850;    // == Western (DOS Latin 1)
  CP_866     = 866;    // == CP_OEM_CYRILLIC
  CP_KOI8R   = 20866;  // == CP_KOI8R
  CP_KOI8U   = 21866;  // == CP_KOI8U
  // Logical OEM (like windows.CP_OEMCP):
  CP_OEM     = -437;   // == (-CP_437) not change sign "-"  - logical system OEM codepage
  CP_UNICODE = 1200;   // == CP_UTF16LE  - unicode codepage
  CP_DEFAULT = -1200;  // == -CP_UNICODE - default unicode codepage
  CP_UNKNOWN = -65001; // == -CP_UTF8

type
  {+}
  ESuperObject = class(Exception);
  {+.}
  // forward declarations
  TSuperObject = class;
  ISuperObject = interface;
  TSuperArray = class;
  {+} // https://code.google.com/p/superobject/issues/detail?id=24
  ISuperArray = interface;
  {+.}

(* AVL Tree
 *  This is a "special" autobalanced AVL tree
 *  It use a hash value for fast compare
 *)

{$IFDEF SUPER_METHOD}
  TSuperMethod = procedure(const AThis, AParams: ISuperObject; var AResult: ISuperObject);
{$ENDIF}

  TSuperAvlBitArray = set of 0..SUPER_AVL_MAX_DEPTH - 1;

  TSuperAvlSearchType = (stEQual, stLess, stGreater);
  TSuperAvlSearchTypes = set of TSuperAvlSearchType;
  TSuperAvlIterator = class;

  TSuperAvlEntry = class
  private
    FGt, FLt: TSuperAvlEntry;
    FBf: integer;
    FHash: Cardinal;
    FName: SOString;
    FPtr: Pointer;
    function GetValue: ISuperObject;
    procedure SetValue(const val: ISuperObject);
  public
    class function Hash(const k: SOString): Cardinal; virtual;
    constructor Create(const AName: SOString; Obj: Pointer); virtual;
    property Name: SOString read FName;
    property Ptr: Pointer read FPtr;
    property Value: ISuperObject read GetValue write SetValue;
  end;

  TSuperAvlTree = class
  private
    FRoot: TSuperAvlEntry;
    FCount: Integer;
    function balance(bal: TSuperAvlEntry): TSuperAvlEntry;
  protected
    procedure doDeleteEntry(Entry: TSuperAvlEntry; {%H-}all: boolean); virtual;
    function CompareNodeNode(node1, node2: TSuperAvlEntry): integer; virtual;
    function CompareKeyNode(const k: SOString; h: TSuperAvlEntry): integer; virtual;
    function Insert(h: TSuperAvlEntry): TSuperAvlEntry; virtual;
    function Search(const k: SOString; st: TSuperAvlSearchTypes = [stEqual]): TSuperAvlEntry; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function IsEmpty: boolean;
    procedure Clear(all: boolean = false); virtual;
    procedure Pack(all: boolean);
    function Delete(const k: SOString): ISuperObject;
    function GetEnumerator: TSuperAvlIterator;
    property count: Integer read FCount;
  end;

  TSuperTableString = class(TSuperAvlTree)
  protected
    procedure doDeleteEntry(Entry: TSuperAvlEntry; all: boolean); override;
    procedure PutO(const k: SOString; const value: ISuperObject);
    function GetO(const k: SOString): ISuperObject;
    procedure PutS(const k: SOString; const value: SOString);
    function GetS(const k: SOString): SOString;
    procedure PutI(const k: SOString; value: SuperInt);
    function GetI(const k: SOString): SuperInt;
    procedure PutD(const k: SOString; value: Double);
    function GetD(const k: SOString): Double;
    procedure PutB(const k: SOString; value: Boolean);
    function GetB(const k: SOString): Boolean;
{$IFDEF SUPER_METHOD}
    procedure PutM(const k: SOString; value: TSuperMethod);
    function GetM(const k: SOString): TSuperMethod;
{$ENDIF}
    procedure PutN(const k: SOString; const value: ISuperObject);
    function GetN(const k: SOString): ISuperObject;
    procedure PutC(const k: SOString; value: Currency);
    function GetC(const k: SOString): Currency;
  public
    property O[const k: SOString]: ISuperObject read GetO write PutO; default;
    property S[const k: SOString]: SOString read GetS write PutS;
    property I[const k: SOString]: SuperInt read GetI write PutI;
    property D[const k: SOString]: Double read GetD write PutD;
    property B[const k: SOString]: Boolean read GetB write PutB;
{$IFDEF SUPER_METHOD}
    property M[const k: SOString]: TSuperMethod read GetM write PutM;
{$ENDIF}
    property N[const k: SOString]: ISuperObject read GetN write PutN;
    property C[const k: SOString]: Currency read GetC write PutC;

    function GetValues: ISuperObject;
    function GetNames: ISuperObject;
    function Find(const k: SOString; var value: ISuperObject): Boolean;
    function Exists(const k: SOString): Boolean;
  end;

  TSuperAvlIterator = class
  private
    FTree: TSuperAvlTree;
    FBranch: TSuperAvlBitArray;
    FDepth: LongInt;
    FPath: array[0..SUPER_AVL_MAX_DEPTH - 2] of TSuperAvlEntry;
  public
    constructor Create(tree: TSuperAvlTree); virtual;
    procedure Search(const k: SOString; st: TSuperAvlSearchTypes = [stEQual]);
    procedure First;
    procedure Last;
    function GetIter: TSuperAvlEntry;
    procedure Next;
    procedure Prior;
    // delphi enumerator
    function MoveNext: Boolean;
    property Current: TSuperAvlEntry read GetIter;
  end;

  TSuperObjectArray = array[0..(high({$IFDEF FPC}PtrInt{$ELSE}Integer{$ENDIF}) div sizeof(TSuperObject))-1] of ISuperObject;
  PSuperObjectArray = ^TSuperObjectArray;

  {+}
  {$if declared(TInterfacedObject)}
    {$define HAVE_INTERFACED_OBJECT} // Delphi 6 Up and FPC implemented it
  {$ifend}
  {$IFNDEF HAVE_INTERFACED_OBJECT}
  TInterfacedObject = class(TObject, IUnknown)
  protected
    FRefCount: Integer;
    {$IFDEF FPC}
    function QueryInterface({$IFDEF FPC_HAS_CONSTREF}constref{$ELSE}const{$ENDIF} iid: tguid; out obj): longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    function _AddRef: longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    function _Release: longint;{$IFNDEF WINDOWS}cdecl{$ELSE}stdcall{$ENDIF};
    {$ELSE !FPC}
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {$ENDIF !FPC}
  public
    class function NewInstance: TObject; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property RefCount: Integer read FRefCount;
  end;
  {$ENDIF !HAVE_INTERFACED_OBJECT}
  {+.}

  {+}
  TSuperArrayEnumerator = class
  private
    FObj: ISuperArray;
    FCount: Integer;
  public
    constructor Create(const obj: ISuperArray); virtual;
    function MoveNext: Boolean;
    function GetCurrent: ISuperObject;
    property Current: ISuperObject read GetCurrent;{}
  end;
  {+.}

  {+} // https://code.google.com/p/superobject/issues/detail?id=24
  ISuperArray = interface
  ['{BA685F30-ADD9-4817-9347-60C13B7176DD}']
    {+}
    function GetEnumerator: TSuperArrayEnumerator;
    {+.}
    function GetO(const index: integer): ISuperObject;
    procedure PutO(const index: integer; const Value: ISuperObject);
    function GetB(const index: integer): Boolean;
    procedure PutB(const index: integer; Value: Boolean);
    function GetI(const index: integer): SuperInt;
    procedure PutI(const index: integer; Value: SuperInt);
    function GetD(const index: integer): Double;
    procedure PutD(const index: integer; Value: Double);
    function GetC(const index: integer): Currency;
    procedure PutC(const index: integer; Value: Currency);
    function GetS(const index: integer): SOString;
    procedure PutS(const index: integer; const Value: SOString);
{$IFDEF SUPER_METHOD}
    function GetM(const index: integer): TSuperMethod;
    procedure PutM(const index: integer; Value: TSuperMethod);
{$ENDIF}
    function GetN(const index: integer): ISuperObject;
    procedure PutN(const index: integer; const Value: ISuperObject);
    function Add(const Data: ISuperObject): Integer;
    function Delete(index: Integer): ISuperObject;
    procedure Insert(index: Integer; const value: ISuperObject);
    procedure Clear(all: boolean = false);
    procedure Pack(all: boolean);
    function  Length: Integer;

    property N[const index: integer]: ISuperObject read GetN write PutN;
    property O[const index: integer]: ISuperObject read GetO write PutO; default;
    property B[const index: integer]: boolean read GetB write PutB;
    property I[const index: integer]: SuperInt read GetI write PutI;
    property D[const index: integer]: Double read GetD write PutD;
    property C[const index: integer]: Currency read GetC write PutC;
    property S[const index: integer]: SOString read GetS write PutS;
{$IFDEF SUPER_METHOD}
    property M[const index: integer]: TSuperMethod read GetM write PutM;
{$ENDIF}
  end;
  {+.}

  TSuperArray = class({+}TInterfacedObject{+.}, ISuperArray)
  private
    FArray: PSuperObjectArray;
    FLength: Integer;
    FSize: Integer;
    procedure Expand(max: Integer);
  protected
    function GetO(const index: integer): ISuperObject;
    procedure PutO(const index: integer; const Value: ISuperObject);
    function GetB(const index: integer): Boolean;
    procedure PutB(const index: integer; Value: Boolean);
    function GetI(const index: integer): SuperInt;
    procedure PutI(const index: integer; Value: SuperInt);
    function GetD(const index: integer): Double;
    procedure PutD(const index: integer; Value: Double);
    function GetC(const index: integer): Currency;
    procedure PutC(const index: integer; Value: Currency);
    function GetS(const index: integer): SOString;
    procedure PutS(const index: integer; const Value: SOString);
{$IFDEF SUPER_METHOD}
    function GetM(const index: integer): TSuperMethod;
    procedure PutM(const index: integer; Value: TSuperMethod);
{$ENDIF}
    function GetN(const index: integer): ISuperObject;
    procedure PutN(const index: integer; const Value: ISuperObject);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    {+}
    function GetEnumerator: TSuperArrayEnumerator;
    {+.}
    function Add(const Data: ISuperObject): Integer; overload;
    function Add(Data: SuperInt): Integer; overload;
    function Add(const Data: SOString): Integer; overload;
    function Add(Data: Boolean): Integer; overload;
    function Add(Data: Double): Integer; overload;
    function AddC(const Data: Currency): Integer;
    function Delete(index: Integer): ISuperObject;
    procedure Insert(index: Integer; const value: ISuperObject);
    procedure Clear(all: boolean = false);
    procedure Pack(all: boolean);
    {+} // https://code.google.com/p/superobject/issues/detail?id=24
    //property Length: Integer read FLength;
    function  Length: Integer;
    {+.}

    property N[const index: integer]: ISuperObject read GetN write PutN;
    property O[const index: integer]: ISuperObject read GetO write PutO; default;
    property B[const index: integer]: boolean read GetB write PutB;
    property I[const index: integer]: SuperInt read GetI write PutI;
    property D[const index: integer]: Double read GetD write PutD;
    property C[const index: integer]: Currency read GetC write PutC;
    property S[const index: integer]: SOString read GetS write PutS;
{$IFDEF SUPER_METHOD}
    property M[const index: integer]: TSuperMethod read GetM write PutM;
{$ENDIF}
  end;

  TSuperWriter = class
  public
    // abstact methods to overide
    function Append(buf: PSOChar; Size: Integer): Integer; overload; virtual; abstract;
    function Append(buf: PSOChar): Integer; overload; virtual; abstract;
    procedure Reset; virtual; abstract;
  end;

  TSuperWriterString = class(TSuperWriter)
  private
    FBuf: PSOChar;
    FBPos: integer;
    FSize: integer;
  public
    function Append(buf: PSOChar; Size: Integer): Integer; overload; override;
    function Append(buf: PSOChar): Integer; overload; override;
    procedure Reset; override;
    procedure TrimRight;
    constructor Create; virtual;
    destructor Destroy; override;
    function GetString: SOString;
    property Data: PSOChar read FBuf;
    property Size: Integer read FSize;
    property Position: integer read FBPos;
  end;

  TSuperWriterStream = class(TSuperWriter)
  private
    FStream: TStream;
  public
    function Append(buf: PSOChar): Integer; override;
    procedure Reset; override;
    constructor Create(AStream: TStream); reintroduce; virtual;
  end;

  TSuperUnicodeWriterStream = class(TSuperWriterStream)
  public
    function Append(buf: PSOChar; Size: Integer): Integer; override;
  end;

  TSuperEscapedWriterStream = class(TSuperWriterStream)
  public
    function Append(buf: PSOChar; Size: Integer): Integer; override;
  end;

  TSuperUTF8WriterStream = class(TSuperWriterStream)
  public
    function Append(buf: PSOChar; Size: Integer): Integer; override;
  end;

  TSuperAnsiWriterStream = class(TSuperWriterStream)
  public
    function Append(buf: PSOChar; Size: Integer): Integer; override;
  end;

(*
  //TODO: TSuperOEMWriterStream - console codepage stream writer
  //TSuperUTF8WriterStream = class(TSuperWriterStream)
  //TMBCSEncoding TSuperMBCSEncodingiWriterStream
  TSuperMBCSEncodingiWriterStream = class(TSuperWriterStream)
  private
    FCodePage: Cardinal;
    {$IFDEF DELPHI_UNICODE}
    FEncoding: TMBCSEncoding;
    {$ENDIF}
  public
    function Append(buf: PSOChar; Size: Integer): Integer; override;
    constructor Create(codepage: cardinal); reintroduce;
  end;//*)

  TSuperWriterFake = class(TSuperWriter)
  private
    FSize: Integer;
  public
    function Append({%H-}buf: PSOChar; Size: Integer): Integer; override;
    function Append(buf: PSOChar): Integer; override;
    procedure Reset; override;
    constructor Create; reintroduce; virtual;
    property size: integer read FSize;
  end;

  TSuperWriterSock = class(TSuperWriter)
  private
    FSocket: longint;
    FSize: Integer;
    {+}
    //TODO: add constructor parameter escaped data
    FEscaped: boolean;
    function SendBuffer(buf: Pointer; size: Integer): Integer; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
    {+.}
  public
    function Append(buf: PSOChar; Size: Integer): Integer; override;
    function Append(buf: PSOChar): Integer; override;
    procedure Reset; override;
    constructor Create(ASocket: longint; {+}escaped: boolean{+.}); reintroduce; virtual;
    property Socket: longint read FSocket;
    property Size: Integer read FSize;
  end;

  TSuperTokenizerError = (
    teSuccess,
    teContinue,
    teDepth,
    teParseEof,
    teParseUnexpected,
    teParseNull,
    teParseBoolean,
    teParseNumber,
    teParseArray,
    teParseObjectKeyName,
    teParseObjectKeySep,
    teParseObjectValueSep,
    teParseString,
    teParseComment,
    teEvalObject,
    teEvalArray,
    teEvalMethod,
    teEvalInt
  );

  TSuperTokenerState = (
    tsEatws,
    tsStart,
    tsFinish,
    tsNull,
    tsCommentStart,
    tsComment,
    tsCommentEol,
    tsCommentEnd,
    tsString,
    tsStringEscape,
    tsIdentifier,
    tsEscapeUnicode,
    tsEscapeHexadecimal,
    tsBoolean,
    tsNumber,
    tsArray,
    tsArrayAdd,
    tsArraySep,
    tsObjectFieldStart,
    tsObjectField,
    tsObjectUnquotedField,
    tsObjectFieldEnd,
    tsObjectValue,
    tsObjectValueAdd,
    tsObjectSep,
    tsEvalProperty,
    tsEvalArray,
    tsEvalMethod,
    tsParamValue,
    tsParamPut,
    tsMethodValue,
    tsMethodPut
  );

  PSuperTokenerSrec = ^TSuperTokenerSrec;
  TSuperTokenerSrec = record
    state, saved_state: TSuperTokenerState;
    obj: ISuperObject;
    current: ISuperObject;
    field_name: SOString;
    parent: ISuperObject;
    gparent: ISuperObject;
  end;

  TSuperTokenizer = class
  public
    str: PSOChar;
    pb: TSuperWriterString;
    depth, is_double, floatcount, st_pos, char_offset: Integer;
    err:  TSuperTokenizerError;
    ucs_char: Word;
    quote_char: SOChar;
    stack: array[0..SUPER_TOKENER_MAX_DEPTH-1] of TSuperTokenerSrec;
    line, col: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ResetLevel(adepth: integer);
    procedure Reset;
  end;

  // supported object types
  TSuperType = (
    stNull,
    stBoolean,
    stDouble,
    stCurrency,
    stInt,
    stObject,
    stArray,
    stString
{$IFDEF SUPER_METHOD}
    ,stMethod
{$ENDIF}
  );

  TSuperValidateError = (
    veRuleMalformated,
    veFieldIsRequired,
    veInvalidDataType,
    veFieldNotFound,
    veUnexpectedField,
    veDuplicateEntry,
    veValueNotInEnum,
    veInvalidLength,
    veInvalidRange
  );

  TSuperFindOption = (
    foCreatePath,
    foPutValue,
    foDelete
{$IFDEF SUPER_METHOD}
    ,foCallMethod
{$ENDIF}
  );

  TSuperFindOptions = set of TSuperFindOption;
  TSuperCompareResult = (cpLess, cpEqu, cpGreat, cpError);
  TSuperOnValidateError = procedure(sender: Pointer; error: TSuperValidateError; const objpath: SOString);

  {+}
  TSuperValidatorCBOnError = procedure(error: TSuperValidateError; const objpath: SOString) of object;
  TSuperValidatorCB = class(TComponent)
  private
    FOnError: TSuperValidatorCBOnError;
  published
    property OnError: TSuperValidatorCBOnError read FOnError write FOnError;
  end;
  {+.}

  TSuperEnumerator = class
  private
    FObj: ISuperObject;
    FObjEnum: TSuperAvlIterator;
    FCount: Integer;
  public
    constructor Create(const obj: ISuperObject); virtual;
    destructor Destroy; override;
    function MoveNext: Boolean;
    function GetCurrent: ISuperObject;
    property Current: ISuperObject read GetCurrent;
  end;

  ISuperObject = interface
  ['{4B86A9E3-E094-4E5A-954A-69048B7B6327}']
    function GetEnumerator: TSuperEnumerator;
    function GetDataType: TSuperType;
    function GetProcessing: boolean;
    procedure SetProcessing(value: boolean);
    function ForcePath(const path: SOString; dataType: TSuperType = stObject): ISuperObject;
    function Format(const str: SOString; BeginSep: SOChar = '%'; EndSep: SOChar = '%'): SOString;

    {+} // https://code.google.com/p/superobject/issues/detail?id=62
    function GetV(const path: SOString): Variant;
    procedure PutV(const path: SOString; Value: Variant);
    {+.}
    function GetO(const path: SOString): ISuperObject;
    procedure PutO(const path: SOString; const Value: ISuperObject);
    function GetB(const path: SOString): Boolean;
    procedure PutB(const path: SOString; Value: Boolean);
    function GetI(const path: SOString): SuperInt;
    procedure PutI(const path: SOString; Value: SuperInt);
    function GetD(const path: SOString): Double;
    procedure PutC(const path: SOString; Value: Currency);
    function GetC(const path: SOString): Currency;
    procedure PutD(const path: SOString; Value: Double);
    function GetS(const path: SOString): SOString;
    procedure PutS(const path: SOString; const Value: SOString);
{$IFDEF SUPER_METHOD}
    function GetM(const path: SOString): TSuperMethod;
    procedure PutM(const path: SOString; Value: TSuperMethod);
{$ENDIF}
    function GetA(const path: SOString): {+}ISuperArray{+.}; // https://code.google.com/p/superobject/issues/detail?id=24

    // Null Object Design patern
    function GetN(const path: SOString): ISuperObject;
    procedure PutN(const path: SOString; const Value: ISuperObject);

    // Writers
    function Write(writer: TSuperWriter; indent: boolean; escape: boolean; level: integer): Integer;

    function SaveTo(stream: TStream; indent: boolean = false; escape: boolean = true; codepage: integer = CP_DEFAULT; writebom: boolean = true): integer; overload;
    function SaveTo(const FileName: string; indent: boolean = false; escape: boolean = true; codepage: integer = CP_DEFAULT; writebom: boolean = true): integer; overload;
    function SaveTo(socket: longint; indent: boolean = false; escape: boolean = true): integer; overload;
    function CalcSize(indent: boolean = false; escape: boolean = true): integer;

    // convert
    {+} // https://code.google.com/p/superobject/issues/detail?id=62
    function AsVariant: Variant;
    property Value: Variant read AsVariant;
    {+.}
    function AsBoolean: Boolean;
    function AsInteger: SuperInt;
    function AsDouble: Double;
    function AsCurrency: Currency;
    function AsString: SOString;
    function AsArray: {+}ISuperArray{+.}; // https://code.google.com/p/superobject/issues/detail?id=24
    function AsObject: TSuperTableString;
{$IFDEF SUPER_METHOD}
    function AsMethod: TSuperMethod;
{$ENDIF}
    function AsJSon(indent: boolean = false; escape: boolean = true): SOString;

    procedure Clear(all: boolean = false);
    procedure Pack(all: boolean = false);

    {+} // https://code.google.com/p/superobject/issues/detail?id=62
    property V[const path: SOString]: Variant read GetV write PutV;
    {+.}
    property N[const path: SOString]: ISuperObject read GetN write PutN;
    property O[const path: SOString]: ISuperObject read GetO write PutO; default;
    property B[const path: SOString]: boolean read GetB write PutB;
    property I[const path: SOString]: SuperInt read GetI write PutI;
    property D[const path: SOString]: Double read GetD write PutD;
    property C[const path: SOString]: Currency read GetC write PutC;
    property S[const path: SOString]: SOString read GetS write PutS;
{$IFDEF SUPER_METHOD}
    property M[const path: SOString]: TSuperMethod read GetM write PutM;
{$ENDIF}
    property A[const path: SOString]: {+}ISuperArray{+.} read GetA;

{$IFDEF SUPER_METHOD}
    function call(const path: SOString; const param: ISuperObject = nil): ISuperObject; overload;
    function call(const path, param: SOString): ISuperObject; overload;
{$ENDIF}

    // clone a node
    function Clone: ISuperObject;
    function Delete(const path: SOString): ISuperObject;
    // merges tow objects of same type, if reference is true then nodes are not cloned
    procedure Merge(const obj: ISuperObject; reference: boolean = false); overload;
    procedure Merge(const str: SOString); overload;

    // validate methods
    function Validate(const rules: SOString; const defs: SOString = ''; callback: TSuperOnValidateError = nil; sender: Pointer = nil): boolean; overload;
    function Validate(const rules: ISuperObject; const defs: ISuperObject = nil; callback: TSuperOnValidateError = nil; sender: Pointer = nil): boolean; overload;
    {+} // TODO: sample: https://github.com/hgourvest/superobject/blob/master/tests/test_validate.dpr
    function ValidateCB(const rules: ISuperObject; const defs: ISuperObject = nil; callback: TSuperValidatorCB = nil): boolean; overload;
    function ValidateCB(const rules: SOString; const defs: SOString = ''; callback: TSuperValidatorCB = nil): boolean; overload;
    {+.}

    // compare
    function Compare(const obj: ISuperObject): TSuperCompareResult; overload;
    function Compare(const str: SOString): TSuperCompareResult; overload;

    // the data type
    function IsType(AType: TSuperType): boolean;
    property DataType: TSuperType read GetDataType;
    property Processing: boolean read GetProcessing write SetProcessing;

    function GetDataPtr: Pointer;
    procedure SetDataPtr(const AValue: Pointer);
    property DataPtr: Pointer read GetDataPtr write SetDataPtr;

    {+}
    {$IFDEF EXTEND_FORIN}
    function GetSafeForIn: Boolean;
    procedure SetSafeForIn(const AValue: Boolean);
    property SafeForIn: Boolean read GetSafeForIn write SetSafeForIn;
    function GetJsonIsEmpty: Boolean;
    property JsonIsEmpty: Boolean read GetJsonIsEmpty;
    {$ENDIF}
    {+.}
  end;

  TSuperObject = class({+}TInterfacedObject{+.}, ISuperObject)
  private
    FProcessing: boolean;
    FDataType: TSuperType;
    FDataPtr: Pointer;
{.$if true}
    FO: record
      {+}
      {$IFDEF NEXTGEN}
        //stObject:
        c_object: TSuperTableString;
        //stArray:
        c_array: TSuperArray;
      {$ENDIF NEXTGEN}
      {+.}
      case TSuperType of
        stBoolean: (c_boolean: boolean);
        stDouble: (c_double: double);
        stCurrency: (c_currency: Currency);
        stInt: (c_int: SuperInt);
        {+}
        {$IFNDEF NEXTGEN}
        stObject: (c_object: TSuperTableString);
        stArray: (c_array: TSuperArray);
        {$ENDIF !NEXTGEN}
        {+.}
{$IFDEF SUPER_METHOD}
        stMethod: (c_method: TSuperMethod);
{$ENDIF}
      end;
{.$ifend}
    FOString: SOString;
    {+}
    {$IFDEF EXTEND_FORIN}
    FSafeForIn: Boolean;
    FJsonIsEmpty: Boolean;
    function GetSafeForIn: Boolean;
    procedure SetSafeForIn(const AValue: Boolean);
    function GetJsonIsEmpty: Boolean;
    {$ENDIF}
    {+.}
    function GetDataType: TSuperType;
    function GetDataPtr: Pointer;
    procedure SetDataPtr(const AValue: Pointer);
  protected

    {+} // https://code.google.com/p/superobject/issues/detail?id=62
    function GetV(const path: SOString): Variant;
    procedure PutV(const path: SOString; Value: Variant);
    {+.}

    function GetO(const path: SOString): ISuperObject;
    procedure PutO(const path: SOString; const Value: ISuperObject);
    function GetB(const path: SOString): Boolean;
    procedure PutB(const path: SOString; Value: Boolean);
    function GetI(const path: SOString): SuperInt;
    procedure PutI(const path: SOString; Value: SuperInt);
    function GetD(const path: SOString): Double;
    procedure PutD(const path: SOString; Value: Double);
    procedure PutC(const path: SOString; Value: Currency);
    function GetC(const path: SOString): Currency;
    function GetS(const path: SOString): SOString;
    procedure PutS(const path: SOString; const Value: SOString);
{$IFDEF SUPER_METHOD}
    function GetM(const path: SOString): TSuperMethod;
    procedure PutM(const path: SOString; Value: TSuperMethod);
{$ENDIF}
    function GetA(const path: SOString): {+}ISuperArray{+.}; // https://code.google.com/p/superobject/issues/detail?id=24
    function Write(writer: TSuperWriter; indent: boolean; escape: boolean; level: integer): Integer; virtual;
  public
    function GetEnumerator: TSuperEnumerator;

    function GetProcessing: boolean;
    procedure SetProcessing(value: boolean);

    // Writers
    function SaveTo(stream: TStream; indent: boolean = false; escape: boolean = true; codepage: integer = CP_DEFAULT; writebom: boolean = true): integer; overload;
    function SaveTo(const FileName: string; indent: boolean = false; escape: boolean = true; codepage: integer = CP_DEFAULT; writebom: boolean = true): integer; overload;
    function SaveTo(socket: longint; indent: boolean = false; escape: boolean = true): integer; overload;
    function CalcSize(indent: boolean = false; escape: boolean = true): integer;
    function AsJSon(indent: boolean = false; escape: boolean = true): SOString;

    // parser  ... owned!
    class function ParseString(s: PSOChar; strict: Boolean {+}= false{+.}; partial: boolean = true; const athis: ISuperObject = nil; options: TSuperFindOptions = [];
       const put: ISuperObject = nil; dt: TSuperType = stNull): ISuperObject;
    class function ParseStream(stream: TStream; ACodePage: Integer; strict: Boolean{+}= false{+.}; partial: boolean = true; const athis: ISuperObject = nil; options: TSuperFindOptions = [];
       const put: ISuperObject = nil; dt: TSuperType = stNull): ISuperObject overload;
    class function ParseStream(stream: TStream; strict: Boolean{+}= false{+.}; partial: boolean = true; const athis: ISuperObject = nil; options: TSuperFindOptions = [];
       const put: ISuperObject = nil; dt: TSuperType = stNull): ISuperObject overload;
    class function ParseFile(const FileName: string; ACodePage: Integer; strict: Boolean{+}= false{+.}; partial: boolean = true; const athis: ISuperObject = nil; options: TSuperFindOptions = [];
       const put: ISuperObject = nil; dt: TSuperType = stNull): ISuperObject; overload;
    class function ParseFile(const FileName: string; strict: Boolean{+}= false{+.}; partial: boolean = true; const athis: ISuperObject = nil; options: TSuperFindOptions = [];
       const put: ISuperObject = nil; dt: TSuperType = stNull): ISuperObject; overload;
    class function ParseEx(tok: TSuperTokenizer; str: PSOChar; len: integer; strict: Boolean{+}= false{+.}; const athis: ISuperObject = nil;
      options: TSuperFindOptions = []; const put: ISuperObject = nil; dt: TSuperType = stNull): ISuperObject;

    // constructors / destructor
    constructor Create(jt: TSuperType = stObject); overload; virtual;
    constructor Create(b: boolean); overload; virtual;
    constructor Create(i: SuperInt); overload; virtual;
    constructor Create(d: double); overload; virtual;
    constructor CreateCurrency(c: Currency); overload; virtual;
    constructor Create(const s: SOString); overload; virtual;
{$IFDEF SUPER_METHOD}
    constructor Create(m: TSuperMethod); overload; virtual;
{$ENDIF}
    destructor Destroy; override;

    // convert
    {+} // https://code.google.com/p/superobject/issues/detail?id=62
    function AsVariant: Variant; virtual;
    property Value: Variant read AsVariant;
    {+.}
    function AsBoolean: Boolean; virtual;
    function AsInteger: SuperInt; virtual;
    function AsDouble: Double; virtual;
    function AsCurrency: Currency; virtual;
    function AsString: SOString; virtual;
    function AsArray: {+}ISuperArray{+.}; virtual; // https://code.google.com/p/superobject/issues/detail?id=24
    function AsObject: TSuperTableString; virtual;
{$IFDEF SUPER_METHOD}
    function AsMethod: TSuperMethod; virtual;
{$ENDIF}
    procedure Clear(all: boolean = false); virtual;
    procedure Pack(all: boolean = false); virtual;
    function GetN(const path: SOString): ISuperObject;
    procedure PutN(const path: SOString; const AValue: ISuperObject);
    function ForcePath(const path: SOString; dataType: TSuperType = stObject): ISuperObject;
    function Format(const str: SOString; BeginSep: SOChar = '%'; EndSep: SOChar = '%'): SOString;

    {+} // https://code.google.com/p/superobject/issues/detail?id=62
    property V[const path: SOString]: Variant read GetV write PutV;
    {+.}
    property N[const path: SOString]: ISuperObject read GetN write PutN;
    property O[const path: SOString]: ISuperObject read GetO write PutO; default;
    property B[const path: SOString]: boolean read GetB write PutB;
    property I[const path: SOString]: SuperInt read GetI write PutI;
    property D[const path: SOString]: Double read GetD write PutD;
    property C[const path: SOString]: Currency read GetC write PutC;
    property S[const path: SOString]: SOString read GetS write PutS;
{$IFDEF SUPER_METHOD}
    property M[const path: SOString]: TSuperMethod read GetM write PutM;
{$ENDIF}
    property A[const path: SOString]: {+}ISuperArray{+.} read GetA;

    {$IFDEF SUPER_METHOD}
    function call(const path: SOString; const param: ISuperObject = nil): ISuperObject; overload; virtual;
    function call(const path, param: SOString): ISuperObject; overload; virtual;
{$ENDIF}
    // clone a node
    function Clone: ISuperObject; virtual;
    function Delete(const path: SOString): ISuperObject;
    // merges tow objects of same type, if reference is true then nodes are not cloned
    procedure Merge(const obj: ISuperObject; reference: boolean = false); overload;
    procedure Merge(const str: SOString); overload;

    // validate methods
    function Validate(const rules: ISuperObject; const defs: ISuperObject = nil; callback: TSuperOnValidateError = nil; sender: Pointer = nil): boolean; overload;
    function Validate(const rules: SOString; const defs: SOString = ''; callback: TSuperOnValidateError = nil; sender: Pointer = nil): boolean; overload;
    {+}
    function ValidateCB(const rules: ISuperObject; const defs: ISuperObject = nil; callback: TSuperValidatorCB = nil): boolean; overload;
    function ValidateCB(const rules: SOString; const defs: SOString = ''; callback: TSuperValidatorCB = nil): boolean; overload;
    {+.}

    // compare
    function Compare(const obj: ISuperObject): TSuperCompareResult; overload;
    function Compare(const str: SOString): TSuperCompareResult; overload;

    // the data type
    function IsType(AType: TSuperType): boolean;
    property DataType: TSuperType read GetDataType;
    // a data pointer to link to something ele, a treeview for example
    property DataPtr: Pointer read GetDataPtr write SetDataPtr;
    property Processing: boolean read GetProcessing;
    {+}
    {$IFDEF EXTEND_FORIN}
    property SafeForIn: Boolean read FSafeForIn write FSafeForIn;
    {$ENDIF}
    {+.}
  end;

{$IFDEF HAVE_RTTI}
  TSuperRttiContext = class;
  TSuperRttiContextClass = class of TSuperRttiContext;

  TSerialFromJson = function(ctx: TSuperRttiContext; const obj: ISuperObject; var Value: TValue): Boolean;
  TSerialToJson = function(ctx: TSuperRttiContext; var value: TValue; const index: ISuperObject): ISuperObject;

  TSuperIgnoreAttribute = class(TCustomAttribute);

  TSuperAttribute = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(const AName: string);
    property Name: string read FName;
  end;

  {+}
  TClassElement = (ceField, ceProperty); // https://github.com/hgourvest/superobject/pull/13/
  TClassElements = set of TClassElement;

  TClassAttribute = class(TCustomAttribute)
  strict private
    FElements: TClassElements;
    FIgnoredName: string;
  public
    constructor Create(const AElements: TClassElements; const AIgnoredName: string = ''); overload;
    constructor Create(const AElements: Cardinal; const AIgnoredName: string = ''); overload;

    function IsIgnoredName(const AName: string): Boolean;

    property Elements: TClassElements read FElements;
  end;
  TArrayAttribute = class(TCustomAttribute);

  SOElements = TClassAttribute;
  {+.}
  SOIgnore = TSuperIgnoreAttribute; // https://code.google.com/p/superobject/issues/detail?id=16
  SOName = class(TSuperAttribute);
  SODefault = class(TSuperAttribute);
  SOArray = TArrayAttribute;

  TSuperTypeMap = class(TCustomAttribute)
  protected
    FTypeInfo: PTypeInfo;
  public
    constructor Create(ATypeInfo: PTypeInfo);
  end;
  SOType = TSuperTypeMap;

  SOTypeMap<T> = class(TSuperTypeMap) // DX ERROR: Failed call attribute constructor for generic attribute class
  public
    constructor Create();
  end;

  TSuperDateTimeZoneHandling = (sdzLOCAL, sdzUTC);
  TSuperDateFormatHandling = (sdfJava, sdfISO, sdfUnix, sdfFormatSettings);

  TMREWSyncHandle = type Pointer;

  {$if declared(TMREWSync) and declared(TMonitor)}
  TSuperMREWSync = class(TMREWSync)
  private
    FObj: Pointer; // ref to type <T>
    FLocks: Integer;
  public
    constructor Create(AObj: Pointer);

    procedure BeginRead;
    function EndRead: Integer; // return Locks

    function BeginWrite: Boolean;
    function EndWrite: Integer;

    property Obj: Pointer read FObj; // ref to type <T>
    property Locks: Integer read FLocks; // return Locks
  end;
  {$ifend} // declared(TMREWSync)

  TSuperRttiContext = class
  protected
    FForceDefault: Boolean;
    FForceSet: Boolean;
    FForceEnumeration: Boolean;
    FForceBaseType: Boolean;
    FForceTypeMap: Boolean;
    FForceSerializer: Boolean; // https://code.google.com/p/superobject/issues/detail?id=64
    {$if declared(TSuperMREWSync)}
    FMREWSyncLocks: TObjectDictionary<{Key: @<T>}Pointer, {Value:}TSuperMREWSync>;
    {$ifend}
    FRWSynchronize: Boolean;
    // https://github.com/hgourvest/superobject/pull/13/
    class function IsArrayExportable(const aMember: TRttiMember): Boolean;
    class function IsExportable(const aType: TRttiType; const Element: TClassElement): Boolean;
    class function IsIgnoredName(const aType: TRttiType; const aMember: TRttiMember): Boolean;
    class function IsIgnoredObject(r: TRttiObject): Boolean;
    class function GetObjectTypeInfo(r: TRttiObject; aDef: PTypeInfo): PTypeInfo; overload;
    function GetObjectTypeInfo(aType: PTypeInfo): PTypeInfo; overload;
    class function GetObjectName(r: TRttiNamedObject): string;
    class function GetObjectDefault(r: TRttiObject; const obj: ISuperObject): ISuperObject;
    {$IFDEF USE_REFLECTION} // https://code.google.com/p/superobject/issues/detail?id=16
    class function GetPropertyDefault(r: TRttiProperty; const obj: ISuperObject): ISuperObject;
    class function GetPropertyName(r: TRttiProperty): string;
    function Array2Class(const Value: TValue; const index: ISuperObject): TSuperObject;
    {$ENDIF USE_REFLECTION}
  protected // ToJson
    function jToInt64(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToChar(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToInteger(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToFloat(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToString(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToClass(var Value: TValue; const index: ISuperObject = nil): ISuperObject; virtual;
    function jToWChar(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToEnumeration(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToSet(var Value: TValue; const index: ISuperObject = nil): ISuperObject; virtual;
    function jToVariant(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToRecord(var {%H-}Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToArray(var Value: TValue; const index: ISuperObject = nil): ISuperObject; virtual;
    function jToDynArray(var Value: TValue; const index: ISuperObject = nil): ISuperObject; virtual;
    function jToClassRef(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
    function jToInterface(var Value: TValue; const {%H-}index: ISuperObject = nil): ISuperObject; virtual;
  protected // FromJson
    function jFromChar({%H-}ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromWideChar({%H-}ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromInt64(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromInt(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromEnumeration(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromSet(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromFloat(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromString({%H-}ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromClass(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromRecord({%H-}ATypeInfo: PTypeInfo; const {%H-}obj: ISuperObject; var {%H-}Value: TValue): Boolean; virtual;
    function jFromDynArray(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromArray(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromClassRef({%H-}ATypeInfo: PTypeInfo; const {%H-}obj: ISuperObject; var {%H-}Value: TValue): Boolean; virtual;
    function jFromUnknown({%H-}ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function jFromInterface(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
  public // RWSynchronize
    procedure BeginRead({%H-}Obj: Pointer; var L: TMREWSyncHandle); overload;
    procedure BeginRead<T>(const obj: T; var L: TMREWSyncHandle); overload;
    procedure EndRead(var L: TMREWSyncHandle);

    procedure BeginWrite({%H-}Obj: Pointer; var L: TMREWSyncHandle); overload;
    procedure BeginWrite<T>(const obj: T; var L: TMREWSyncHandle); overload;
    procedure EndWrite(var L: TMREWSyncHandle);
  public
    Context: TRttiContext;
    SerialFromJson: TDictionary<PTypeInfo, TSerialFromJson>;
    SerialToJson: TDictionary<PTypeInfo, TSerialToJson>;
    {$IFDEF USE_REFLECTION} // https://code.google.com/p/superobject/issues/detail?id=16
    FieldsVisibility: set of TMemberVisibility; // default: [mvPrivate, mvProtected, mvPublic, mvPublished]
    PropertiesVisibility: set of TMemberVisibility; // default: []
    {$ENDIF}
    SuperDateTimeZoneHandling: TSuperDateTimeZoneHandling; // default: sdzUTC
    SuperDateFormatHandling: TSuperDateFormatHandling; // default: sdfISO

    constructor Create; virtual;
    destructor Destroy; override;

    function FromJson(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean; virtual;
    function ToJson(var Value: TValue; const index: ISuperObject = nil): ISuperObject; virtual;
    function AsType<T>(const obj: ISuperObject): T;
    function AsJson<T>(const obj: T; const index: ISuperObject = nil): ISuperObject;

    property ForceDefault: Boolean read FForceDefault write FForceDefault; // default True;
    property ForceBaseType: Boolean read FForceBaseType write FForceBaseType; // default True;
    property ForceTypeMap: Boolean read FForceTypeMap write FForceTypeMap; // default False;
    property ForceSet: Boolean read FForceSet write FForceSet; // default True;
    property ForceEnumeration: Boolean read FForceEnumeration write FForceEnumeration; // default True;
    property ForceSerializer: Boolean read FForceSerializer write FForceSerializer; // default False;
    // RWSynchronize - multithreaded protected access to rtti object
    property RWSynchronize: Boolean read FRWSynchronize write FRWSynchronize; // default False;
  end;

  TSuperObjectHelper = class helper for TObject
  public
    function ToJson(ctx: TSuperRttiContext = nil): ISuperObject;
    constructor FromJson(const obj: ISuperObject; ctx: TSuperRttiContext = nil); overload;
    constructor FromJson(const str: string; ctx: TSuperRttiContext = nil); overload;
  end;
{$ENDIF HAVE_RTTI}

  TSuperObjectIter = record
    key: SOString;
    val: ISuperObject;
    Ite: TSuperAvlIterator;
  end;

  {$if not declared(TStringDynArray)}
    {$IFDEF HAVE_RTTI}
  TStringDynArray       = TArray<string>;
    {$ELSE}
  TStringDynArray       = array of string;
    {$ENDIF}
  {$ifend}

const
  cst_ce_field = 1;
  cst_ce_property = 2;

{$IFDEF HAVE_RTTI}
var
  SuperRttiContextClassDefault: TSuperRttiContextClass = TSuperRttiContext;
  SuperRttiContextDefault: TSuperRttiContext;
{$ENDIF HAVE_RTTI}
function ObjectIsError(obj: TSuperObject): boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
function ObjectIsType(const obj: ISuperObject; typ: TSuperType): boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
function ObjectGetType(const obj: ISuperObject): TSuperType; {$IFNDEF FPC}{$IFDEF HAVE_INLINE}inline;{$ENDIF}{$ENDIF}
function ObjectIsNull(const obj: ISuperObject): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}

function ObjectFindFirst(const obj: ISuperObject; var F: TSuperObjectIter): boolean;
function ObjectFindNext(var F: TSuperObjectIter): boolean;
procedure ObjectFindClose(var F: TSuperObjectIter);

function SO(const s: SOString = '{}'): ISuperObject; overload;
function SO(const value: Variant): ISuperObject; overload;
function SO(const Args: array of const): ISuperObject; overload;
{+}
function soStream(stream: TStream; ACodePage: Integer = CP_UNKNOWN): ISuperObject;
function soFile(const FileName: string; ACodePage: Integer = CP_UNKNOWN): ISuperObject;
{+.}
function SA(const Args: array of const): ISuperObject; overload;
function SA(const AStrings: TStringDynArray): ISuperObject; overload;
{+}
function SA(const s: SOString = '[]'): ISuperObject; overload;
{+.}

function TryObjectToDate(const obj: ISuperObject; var dt: TDateTime): Boolean;
function UUIDToString(const g: TGUID): SOString;
function StringToUUID(const str: SOString; var g: TGUID): Boolean;

{$IFDEF HAVE_RTTI}

type
  TSuperInvokeResult = (
    irSuccess,
    irMethothodError,  // method don't exist
    irParamError,     // invalid parametters
    irError            // other error
  );

function TrySOInvoke(var ctx: TSuperRttiContext; const obj: TValue; const method: string; const params: ISuperObject; var Return: ISuperObject): TSuperInvokeResult; overload;
function SOInvoke(const obj: TValue; const method: string; const params: ISuperObject; ctx: TSuperRttiContext = nil): ISuperObject; overload;
function SOInvoke(const obj: TValue; const method: string; const params: string; ctx: TSuperRttiContext = nil): ISuperObject; overload;

{+} // https://code.google.com/p/superobject/issues/detail?id=39
function IsGenericType(ATypeInfo: PTypeInfo): Boolean;
function GetDeclaredGenericType({%H-}RttiContext: TRttiContext; {%H-}ATypeInfo: PTypeInfo): TRttiType;
function IsList(RttiContext: TRttiContext; ATypeInfo: PTypeInfo): Boolean;

var
  SuperTypeInfoDictionary: TDictionary<Pointer, Pointer>;

procedure SuperRegisterCustomTypeInfo(CustomType, BaseType: PTypeInfo);
procedure SuperUnRegisterCustomTypeInfo(CustomType: PTypeInfo);
function  SuperBaseTypeInfo(CustomType: PTypeInfo): PTypeInfo; {$IFDEF HAVE_INLINE}inline;{$ENDIF}

function SuperSetToString(ATypeInfo: PTypeInfo; const ASetValue: Pointer; Brackets: Boolean): string; overload;
function SuperSetToString(ATypeInfo: PTypeInfo; const ASetValue; Brackets: Boolean): string; overload;
function SuperStringToSet(TypeInfo: PTypeInfo; const Value: string): Integer; // Safe "StringToSet(PTypeInfo...)"
{+.}
{$ENDIF HAVE_RTTI}

{+}
{$IFDEF EXTEND_FORIN}
var
  SafeForInDefault: Boolean = False;
procedure soSetSafeForIn(ASafeForInDefault: Boolean);
{$ENDIF}
var
  SuperDefaultStreamCodePage: Integer = CP_UTF8; // Required when stream cannot autodetected encoding
  // Allow only two values for "!FPC and !UNICODE": CP_ANSI, CP_UTF8
procedure soSetStreamCodePage(ADefaultStreamCodePage: Integer);
{+.}

{+}
procedure dbgraw(const s: SOString); overload;
procedure dbg(const s: SOString); overload;
{$IFNDEF NEXTGEN}
procedure dbgraw(const s: AnsiString); overload;
procedure dbg(const s: AnsiString); overload;
{$ENDIF}
procedure _dbgTraceError(E: Exception = nil);
type
  TdbgTraceError = procedure (E: Exception = nil);
var
  dbgTraceError: TdbgTraceError = {$ifdef FPC}@{$endif}_dbgTraceError;
{+.}

implementation
uses
  {+}
  {$IFDEF FPC}
  strutils, // +PosEx
  {$ENDIF}
  DateUtils, superdate
  {+.}
  {+},variants{+.} // https://code.google.com/p/superobject/issues/detail?id=62
  {+}
  {$IFDEF DEBUG}
  //,superdbg { optional }
  {$ENDIF}
  {+.}
{$IFDEF FPC}
  ,sockets
  //{$IFDEF UNIX}
  //sockets, baseunix, unix, netdb,
  //{$ENDIF}
{$ELSE}
  {+}
  {$IFDEF MSWINDOWS}
  ,WinSock, Registry
  {$ENDIF}
  {+.}
  {+} // https://code.google.com/p/superobject/issues/detail?id=54
  {$IF CompilerVersion >= 23.00} // XE2 Up
  ,Data.SqlTimSt
  {$ELSE}
  ,SqlTimSt
  {$IFEND}
  {+.}
  {+}
  //{$IFDEF NEXTGEN}
  ,StrUtils
  //{$ENDIF}
  {.$IFDEF NEXTGEN}
  {$IFDEF LINUX} // Kylix3
  ,Libc
  {$ELSE}
    {$IFDEF POSIX}
    ,Posix.SysTypes
    ,Posix.SysSocket
    {$ENDIF}
  {$ENDIF}
  {.$ELSE !NEXTGEN}
    //{$IFDEF UNIX}
    //,sockets, baseunix, unix, netdb
    //{$ENDIF}
  {.$ENDIF !NEXTGEN}
  {+.}
{$ENDIF}
  ;

const
  dbg_prefix = 'dbg:> ';
//
{$IFDEF MSWINDOWS}{$IF (not defined(FPC)) and (CompilerVersion < 23)} // Less then Delphi XE2. TODO: check console output for XE2 (CompilerVersion==23)
function AnsiToOEM(const S: AnsiString): AnsiString; overload; begin
  SetLength(Result, Length(S));
  if Length(S) > 0 then
    Windows.CharToOemA(PAnsiChar(S), PAnsiChar(Result));
end;{$IFDEF UNICODE}
function AnsiToOEM(const S: string): string; overload; inline; begin
  Result := string(AnsiToOem(AnsiString(S)));
end;
{$ENDIF}{$IFEND}{$ENDIF}
//
procedure dbgraw(const s: SOString); overload;
begin
  {$IFDEF MSWINDOWS}
  {$warnings off}
  OutputDebugStringW(PWideChar(
    // for OutputDebugString(...) and "Event Viewer"(or dbgview.exe)
    WideString(StringReplace(s, #9, #32#32#32#32, [rfReplaceAll]))
  ));
  {$warnings on}
  {$ENDIF}
  if IsConsole then // TODO: write to stderror
    writeln({$IFDEF MSWINDOWS}{$IF (not defined(FPC)) and (CompilerVersion < 23)}AnsiToOEM{$IFEND}{$ENDIF}(s));
end;
//
{$IFNDEF NEXTGEN}
procedure dbgraw(const s: AnsiString); overload;
begin
  {$IFDEF MSWINDOWS}
  {$warnings off}
  OutputDebugStringA(PAnsiChar(
    // for OutputDebugString(...) and "Event Viewer"(or dbgview.exe)
    AnsiString(StringReplace(s, #9, #32#32#32#32, [rfReplaceAll]))
  ));
  {$warnings on}
  {$ENDIF}
  if IsConsole then // TODO: write to stderror
    writeln({$IFDEF MSWINDOWS}{$IF (not defined(FPC)) and (CompilerVersion < 23)}AnsiToOEM{$IFEND}{$ENDIF}(s));
end;
{$ENDIF}
//
procedure dbg(const s: SOString);
var L: TStringList; i: integer;
begin
  if Length(s) > 0 then begin
    L := TStringList.Create;
    try
      {$warnings off}
      L.Text := S;
      for i := 0 to L.Count-1 do
        dbgraw(dbg_prefix+L[i]);
      {$warnings on}
    finally
      L.Free;
    end;
  end
  else
    dbgraw(dbg_prefix);
end;
//
{$IFNDEF NEXTGEN}
procedure dbg(const s: AnsiString); overload;
var L: TStringList; i: integer;
begin
  if Length(s) > 0 then begin
    L := TStringList.Create;
    try
      {$warnings off}
      L.Text := S;
      for i := 0 to L.Count-1 do
        dbgraw(dbg_prefix+L[i]);
      {$warnings on}
    finally
      L.Free;
    end;
  end
  else
    dbgraw(dbg_prefix);
end;
{$ENDIF}
//
procedure _dbgTraceError(E: Exception = nil);
begin
  if (e = nil) then
    dbg('ERROR: (unknown)')
  else if (e.ClassType = nil) then
    dbg('ERROR: (internal)')
  else if (e.ClassType <> EAbort) then
  try
    //if not (e is EAbort) then
    dbg(Format('EXCEPTION(%s): %s', [e.ClassName, E.Message]))
  except
  end;
end;

{+}
{$IFDEF EXTEND_FORIN}
procedure soSetSafeForIn(ASafeForInDefault: Boolean);
begin
  SafeForInDefault := ASafeForInDefault;
end;
{$ENDIF}
procedure soSetStreamCodePage(ADefaultStreamCodePage: Integer);
begin
  SuperDefaultStreamCodePage := ADefaultStreamCodePage;
end;
{+.}

{$IFDEF DEBUG}
var
  debugcount: integer = 0;
{$ENDIF}

const
  ESC_BS: PSOChar = '\b';
  ESC_LF: PSOChar = '\n';
  ESC_CR: PSOChar = '\r';
  ESC_TAB: PSOChar = '\t';
  ESC_FF: PSOChar = '\f';
  ESC_QUOT: PSOChar = '\"';
  ESC_SL: PSOChar = '\\';
  ESC_SR: PSOChar = '\/';
  ESC_ZERO: PSOChar = '\u0000';

  {$IFDEF MSWINDOWS}
  TOK_CRLF: PSOChar = #13#10;
  {$ENDIF}
  TOK_SP: PSOChar = #32;
  TOK_BS: PSOChar = #8;
  TOK_TAB: PSOChar = #9;
  TOK_LF: PSOChar = #10;
  TOK_FF: PSOChar = #12;
  TOK_CR: PSOChar = #13;
//  TOK_SL: PSOChar = '\';
//  TOK_SR: PSOChar = '/';
  TOK_NULL: PSOChar = 'null';
  TOK_CBL: PSOChar = '{'; // curly bracket left
  TOK_CBR: PSOChar = '}'; // curly bracket right
  TOK_ARL: PSOChar = '[';
  TOK_ARR: PSOChar = ']';
  TOK_ARRAY: PSOChar = '[]';
  TOK_OBJ: PSOChar = '{}'; // empty object
  TOK_COM: PSOChar = ','; // Comma
  TOK_DQT: PSOChar = '"'; // Double Quote
  TOK_TRUE: PSOChar = 'true';
  TOK_FALSE: PSOChar = 'false';

{+}
function MakeSOString(buf: PSOChar; Size: Integer): SOString; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin
  if (Size > 0) {and Assigned(buf)} then
    SetString(Result, buf, Size);
end;
//
function MakeSOBytes(buf: PSOChar; Size: Integer): TBytes; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin
  {%H-}Result := nil;
  if (Size > 0) {and Assigned(buf)} then begin
    SetLength({%H-}Result, Size*SizeOf(WideChar));
    Move(buf^, PWideChar(Result)^, Length(Result));
  end;
end;
//
{$IFNDEF UNICODE}
function CharInSet(AC: AnsiChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin Result := AC in CharSet; end;
//
function CharInSet(WC: WideChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin Result := (Ord(WC) <= $FF) and (AnsiChar(WC) in CharSet); end;
{$ENDIF}
//
{$IFDEF NEXTGEN}
type
  TListOfPtr = TList<Pointer>;
  TList = TListOfPtr;
//
function IsCharInDiapasone(x, min, max: Char): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin Result := (Ord(x) >= Ord(min)) and (Ord(x) <= Ord(max)); end;
//
(*function IsCharInStr(x: Char; const SomeChars: string): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
var
  i: Integer;
  p: PChar;
begin
  //Result := (Pos(x, SomeChars) > 0); // slowly

  {for i := Low(SomeChars) to High(SomeChars) do begin
    if SomeChars[i] = x then
      Exit(True);
  end;
  Result := False;{}

  i := Length(SomeChars);
  p := PChar(SomeChars);
  while i > 0 do begin
    if p^ = x then
      Exit(True);
    inc(p);
    dec(i);
  end;
  Result := False;
end;//*)
{$ENDIF NEXTGEN}
{+.}

{$if (sizeof(Char) = 1)}
function StrLComp(const Str1, Str2: PSOChar; MaxLen: Cardinal): Integer;
var
  P1, P2: PWideChar;
  I: Cardinal;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do begin
    C1 := P1^;
    C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;

function StrComp(const Str1, Str2: PSOChar): Integer;
var
  P1, P2: PWideChar;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do begin
    C1 := P1^;
    C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then begin
      Result := Ord(C1) - Ord(C2);
      Exit;
    end;

    Inc(P1);
    Inc(P2);
  end;
end;

function StrLen(const Str: PSOChar): Cardinal;
var
  p: PSOChar;
begin
  Result := 0;
  if Str <> nil then begin
    p := Str;
    while p^ <> #0 do inc(p);
    Result := (p - Str);
  end;
end;
{$ifend}

{+}
{$IFDEF NEED_FORMATSETTINGS}
var
  SOFormatSettings: TFormatSettings;
{$ENDIF}
{+.}
function FloatToJson(const value: Double): SOString;
{+} // https://code.google.com/p/superobject/issues/detail?id=15
{$IFDEF NEED_FORMATSETTINGS}
{$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin
  Result := SOString(SysUtils.FloatToStr(value, SOFormatSettings));
end;
{$ELSE !NEED_FORMATSETTINGS}
var
  p: PSOChar;
  //SysDecimalSeparator: SOChar;
begin
  //SysDecimalSeparator := SOChar({$IFDEF NEED_FORMATSETTINGS}FormatSettings.{$ENDIF}DecimalSeparator);
  Result := FloatToStr(value);
  //if SysDecimalSeparator <> '.' then // ! NB: No thread safe: separator can changed in another thread !
  begin
    p := PSOChar(Result);
    while p^ <> #0 do
      //if p^ <> SysDecimalSeparator then
      //inc(p) else
      //begin
      //  p^ := '.';
      //  Exit;
      //end;
      if CharInSet(p^, ['0'..'9']) then
        inc(p)
      else begin
        //if (p^ <> '.') then
        p^ := '.';
        Exit;
      end;
  end;
end;
{$ENDIF !NEED_FORMATSETTINGS}
{+.}

function CurrToJson(const value: Currency): SOString;
{+} // https://code.google.com/p/superobject/issues/detail?id=15
{$IFDEF NEED_FORMATSETTINGS}
{$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin
  Result := SOString(SysUtils.FloatToStr(value, SOFormatSettings));
end;
{$ELSE NEED_FORMATSETTINGS}
var
  p: PSOChar;
  //SysDecimalSeparator: SOChar;
begin
  //SysDecimalSeparator := SOChar({$IFDEF NEED_FORMATSETTINGS}FormatSettings.{$ENDIF}DecimalSeparator);
  Result := CurrToStr(value);
  //if SysDecimalSeparator <> '.' then // ! NB: No thread safe: separator can changed in another thread !
  begin
    p := PSOChar(Result);
    while p^ <> #0 do
      //if p^ <> SysDecimalSeparator then
      //inc(p) else
      //begin
      //  p^ := '.';
      //  Exit;
      //end;
      if CharInSet(p^, ['0'..'9']) then
        inc(p)
      else begin
        //if (p^ <> '.') then
        p^ := '.';
        Exit;
      end;
  end;
end;
{$ENDIF NEED_FORMATSETTINGS}
{+.}

function TryObjectToDate(const obj: ISuperObject; var dt: TDateTime): Boolean;
var
  typ: TSuperType;
  i: Int64;
  SValue: SOString;
begin
  typ := ObjectGetType(obj);
  case typ of
  stInt:
    begin
      dt := JavaToDelphiDateTime(obj.AsInteger);
      Result := True;
    end;
  stString:
    begin
      SValue := obj.AsString;
      {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
      {$warnings off}//FPC: Warning: Implicit string type conversion with potential data loss from "UnicodeString" to "AnsiString"
      if ISO8601DateToJavaDateTime(SValue, i) then
      {$warnings on}
      {$hints on}
      begin
        dt := JavaToDelphiDateTime(i);
        Result := True;
      end else
        {$warnings off}
        Result := TryStrToDateTime(SValue, dt);
        {$warnings on}
    end;
  else
    Result := False;
  end;
end;

function SO(const s: SOString): ISuperObject; overload;
begin
  Result := TSuperObject.ParseString(PSOChar(s), False);
end;

function SA(const Args: array of const): ISuperObject; overload;
//type
//  TByteArray = array[0..sizeof(integer) - 1] of byte;
//  PByteArray = ^TByteArray;
var
  j: Integer;
  intf: ISuperObject;
begin
  Result := TSuperObject.Create(stArray);
  for j := 0 to length(Args) - 1 do
    with Result.AsArray do
    case TVarRec(Args[j]).VType of
      vtInteger : Add(TSuperObject.Create(TVarRec(Args[j]).VInteger));
      vtInt64   : Add(TSuperObject.Create(TVarRec(Args[j]).VInt64^));
      vtBoolean : Add(TSuperObject.Create(TVarRec(Args[j]).VBoolean));
      {+.}{$IFNDEF NEXTGEN}{+.}
      vtChar    : Add(TSuperObject.Create(SOString(TVarRec(Args[j]).VChar)));
      {+.}{$ENDIF !NEXTGEN}{+.}
      vtWideChar: Add(TSuperObject.Create(SOChar(TVarRec(Args[j]).VWideChar)));
      vtExtended: Add(TSuperObject.Create(TVarRec(Args[j]).VExtended^));
      vtCurrency: Add(TSuperObject.CreateCurrency(TVarRec(Args[j]).VCurrency^));
      {+.}{$IFNDEF NEXTGEN}{+.}
      vtString  : Add(TSuperObject.Create(SOString(TVarRec(Args[j]).VString^)));
      vtPChar   : Add(TSuperObject.Create(SOString(TVarRec(Args[j]).VPChar^)));
      vtAnsiString: Add(TSuperObject.Create(SOString(AnsiString(TVarRec(Args[j]).VAnsiString))));
      {+.}{$ENDIF !NEXTGEN}{+.}
      vtWideString: Add(TSuperObject.Create(SOString(PWideChar(TVarRec(Args[j]).VWideString))));
      vtInterface:
        if TVarRec(Args[j]).VInterface = nil then
          Add(nil) else
          if IInterface(TVarRec(Args[j]).VInterface).QueryInterface(ISuperObject, intf) = 0 then
            Add(intf) else
            Add(nil);
      vtPointer :
        if TVarRec(Args[j]).VPointer = nil then
          Add(nil) else
          {$hints off} // FPC: Hint: Conversion between ordinals and pointers is not portable
          Add(TSuperObject.Create(PtrUInt(TVarRec(Args[j]).VPointer)));
          {$hints on}
      vtVariant:
        Add(SO(TVarRec(Args[j]).VVariant^));
      vtObject:
        if TVarRec(Args[j]).VPointer = nil then
          Add(nil) else
          {$hints off} // FPC: Hint: Conversion between ordinals and pointers is not portable
          Add(TSuperObject.Create(PtrUInt(TVarRec(Args[j]).VPointer)));
          {$hints on}
      vtClass:
        if TVarRec(Args[j]).VPointer = nil then
          Add(nil) else
          {$hints off} // FPC: Hint: Conversion between ordinals and pointers is not portable
          Add(TSuperObject.Create(PtrUInt(TVarRec(Args[j]).VPointer))); // TODO: ? which of the overloaded constructors ?
          {$hints on}
{$if declared(vtUnicodeString)}
      vtUnicodeString:
          Add(TSuperObject.Create(SOString(string(TVarRec(Args[j]).VUnicodeString))));
{$ifend}
    else
      assert(false);
    end;
end;

function SA(const AStrings: TStringDynArray): ISuperObject; overload;
var // https://github.com/hgourvest/superobject/pull/39
  i: integer;
begin
  Result := TSuperObject.Create(stArray);
  for i := 0 to High(AStrings) do
    Result.AsArray.Add(TSuperObject.Create(SOString(AStrings[i])));
end;

{+}
function SA(const s: SOString = '[]'): ISuperObject; overload;
var
  i: integer;
  {$IFDEF EXTEND_FORIN}
  o: TSuperObject;
  {$ENDIF}
begin
  Result := nil;
  i := Pos('[', s);
  if i <= 0 then
  begin
    {$IFDEF EXTEND_FORIN}
    if SafeForInDefault then
    begin
      o := TSuperObject.Create(stArray);
      o.FJsonIsEmpty := True;
      Result := o;
    end;
    {$ENDIF}
  end
  else if (i > 1) then
  begin
    if (TrimRight(copy(s, 1, i-1)) = '') then
      Result := SO(copy(s, i, Length(s)))
    else
    begin
      {$IFDEF EXTEND_FORIN}
      if SafeForInDefault then
      begin
        o := TSuperObject.Create(stArray);
        o.FJsonIsEmpty := True;
        Result := o;
      end;
      {$ENDIF}
    end;
  end
  else
    Result := SO(s);
end;
{+.}

function SO(const Args: array of const): ISuperObject; overload;
var
  j: Integer;
  arr: ISuperObject;
begin
  Result := TSuperObject.Create(stObject);
  arr := SA(Args);
  with arr.AsArray do
    for j := 0 to (Length div 2) - 1 do
      Result.AsObject.PutO(O[j*2].AsString, O[(j*2) + 1]);
end;

function SO(const value: Variant): ISuperObject; overload;
begin
  with TVarData(value) do
  case VType of
    varNull:     Result := nil;
    varEmpty:    Result := nil;
    varSmallInt: Result := TSuperObject.Create(VSmallInt);
    varInteger:  Result := TSuperObject.Create(VInteger);
    varSingle:   Result := TSuperObject.Create(VSingle);
    varDouble:   Result := TSuperObject.Create(VDouble);
    varCurrency: Result := TSuperObject.CreateCurrency(VCurrency);
    varDate:     Result := TSuperObject.Create(DelphiToJavaDateTime(vDate));
    varOleStr:   Result := TSuperObject.Create(SOString(VOleStr));
    varBoolean:  Result := TSuperObject.Create(VBoolean);
    varShortInt: Result := TSuperObject.Create(VShortInt);
    varByte:     Result := TSuperObject.Create(VByte);
    varWord:     Result := TSuperObject.Create(VWord);
    varLongWord: Result := TSuperObject.Create(VLongWord);
    varInt64:    Result := TSuperObject.Create(VInt64);
    {+.}{$IFNDEF NEXTGEN}{+.}
    varString:   Result := TSuperObject.Create(SOString(AnsiString(VString)));
    {+.}{$ENDIF !NEXTGEN}{+.}
{$if declared(varUString)}
   varUString:  Result := TSuperObject.Create(SOString({$IFDEF FPC}UnicodeString{$ELSE}string{$ENDIF}(VString)));
{$ifend}
    {+} // https://code.google.com/p/superobject/issues/detail?id=54
    {$IFNDEF FPC}
    else if ( VType = {$IF CompilerVersion >= 23.00}Data.{$IFEND}SqlTimSt.VarSQLTimeStamp() ) then
      Result := TSuperObject.Create(
        DelphiToJavaDateTime(
          {$IF CompilerVersion >= 23.00}Data.{$IFEND}SqlTimSt.SQLTimeStampToDateTime(
            {$IF CompilerVersion >= 23.00}Data.{$IFEND}SqlTimSt.VarToSQLTimeStamp(value)
          )
        )
      )
    {$ENDIF !FPC}
    {+.}
  else
    raise ESuperObject.CreateFmt('Unsuported variant data type: %d', [VType]);
  end;
end;

{+}
function soStream(stream: TStream; ACodePage: Integer): ISuperObject;
begin
  Result := TSuperObject.ParseStream(stream, ACodePage, {strict:}false, {partial:}true);
end;
function soFile(const FileName: string; ACodePage: Integer): ISuperObject;
begin
  Result := TSuperObject.ParseFile(FileName, ACodePage, {strict:}false, {partial:}true);
end;
{+.}

function ObjectIsError(obj: TSuperObject): boolean;
begin
  Result := PtrUInt(obj) > PtrUInt(-4000);
end;

function ObjectIsType(const obj: ISuperObject; typ: TSuperType): boolean;
begin
  if obj <> nil then
    Result := typ = obj.DataType else
    Result := typ = stNull;
end;

function ObjectGetType(const obj: ISuperObject): TSuperType;
begin
  if obj <> nil then
    Result := obj.DataType else
    Result := stNull;
end;

function ObjectIsNull(const obj: ISuperObject): Boolean;
begin
  Result := ObjectIsType(obj, stNull);
end;

function ObjectFindFirst(const obj: ISuperObject; var F: TSuperObjectIter): boolean;
var
  i: TSuperAvlEntry;
begin
  if ObjectIsType(obj, stObject) then
  begin
    F.Ite := TSuperAvlIterator.Create(obj.AsObject);
    F.Ite.First;
    i := F.Ite.GetIter;
    if i <> nil then
    begin
      F.key := i.Name;
      F.val := i.Value;
      Result := True;
    end else
    begin
      FreeAndNil(F.Ite);
      Result := False;
    end;
  end else
    Result := False;
end;

function ObjectFindNext(var F: TSuperObjectIter): boolean;
var
  i: TSuperAvlEntry;
begin
  if Assigned(F.Ite) then
  begin
    F.Ite.Next;
    i := F.Ite.GetIter;
    if i <> nil then
    begin
      F.key := i.FName;
      F.val := i.Value;
      Result := True;
    end else
      Result := False;
  end
  else
    Result := False;
end;

procedure ObjectFindClose(var F: TSuperObjectIter);
begin
  if Assigned(F.Ite) then
    FreeAndNil(F.Ite);
  F.val := nil;
end;

function UuidFromString(p: PSOChar; Uuid: PGUID): Boolean;
const
  hex2bin: array[48..102] of Byte = (
     0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0,
     0,10,11,12,13,14,15, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0,10,11,12,13,14,15);
type
  TState = (stEatSpaces, stStart, stHEX, stBracket, stEnd);
  TUUID = {+}packed{+.} record
    case byte of
      0: (guid: TGUID);
      1: (bytes: array[0..15] of Byte);
      2: (words: array[0..7] of Word);
      3: (ints: array[0..3] of Cardinal);
      {+} // https://code.google.com/p/superobject/issues/detail?id=26
      4: (i64s: array[0..1] of Int64);
      {+.}
  end;

  function ishex(const c: SOChar): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin
    result := (c < #256) and {+}
      {$IFDEF NEXTGEN}
      (IsCharInDiapasone(c, '0','9') or IsCharInDiapasone(c, 'a','z') or IsCharInDiapasone(c, 'A','Z'))
      {$ELSE}
      CharInSet(c, ['0'..'9', 'a'..'z', 'A'..'Z'])
      {$ENDIF}
    ;{+.}
  end;
var
  pos: Byte;
  state, saved: TState;
  bracket, separator: Boolean;
label
  redo;
begin
  FillChar(Uuid^, SizeOf(TGUID), 0);
  saved := stStart;
  state := stEatSpaces;
  bracket := false;
  separator := false;
  pos := 0;
  while true do
redo:
  case state of
    stEatSpaces:
      begin
        while true do
          case p^ of
            ' ', #13, #10, #9: inc(p);
          else
            state := saved;
            goto redo;
          end;
      end;
    stStart:
      case p^ of
        '{':
          begin
            bracket := true;
            inc(p);
            state := stEatSpaces;
            saved := stHEX;
            pos := 0;
          end;
      else
        state := stHEX;
      end;
    stHEX:
      case pos of
        0..7:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            Uuid^.D1 := (Uuid^.D1 * 16) + hex2bin[Ord(p^)];
            }
            Uuid^.D1 := (Uuid^.D1 * 16) + hex2bin[Byte(p^)];
            //
            // TODO: ? FPC 2.5.1: https://code.google.com/p/superobject/issues/detail?id=18
            //       ? TUUID(Uuid^).guid.D1 := (TUUID(Uuid^).guid.D1 * 16) + hex2bin[p^];
            //
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        8:
          if (p^ = '-') then
          begin
            separator := true;
            inc(p);
            inc(pos)
          end else
            inc(pos);
        13,18,23:
           if separator then
           begin
             if p^ <> '-' then
             begin
               Result := False;
               Exit;
             end;
             inc(p);
             inc(pos);
           end else
             inc(pos);
        9..12:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).words[2] := (TUUID(Uuid^).words[2] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).words[2] := (TUUID(Uuid^).words[2] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        14..17:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).words[3] := (TUUID(Uuid^).words[3] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).words[3] := (TUUID(Uuid^).words[3] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        19..20:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[8] := (TUUID(Uuid^).bytes[8] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[8] := (TUUID(Uuid^).bytes[8] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        21..22:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[9] := (TUUID(Uuid^).bytes[9] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[9] := (TUUID(Uuid^).bytes[9] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        24..25:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[10] := (TUUID(Uuid^).bytes[10] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[10] := (TUUID(Uuid^).bytes[10] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        26..27:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[11] := (TUUID(Uuid^).bytes[11] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[11] := (TUUID(Uuid^).bytes[11] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        28..29:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[12] := (TUUID(Uuid^).bytes[12] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[12] := (TUUID(Uuid^).bytes[12] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        30..31:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[13] := (TUUID(Uuid^).bytes[13] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[13] := (TUUID(Uuid^).bytes[13] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        32..33:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[14] := (TUUID(Uuid^).bytes[14] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[14] := (TUUID(Uuid^).bytes[14] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        34..35:
          if ishex(p^) then
          begin
            {+} // https://code.google.com/p/superobject/issues/detail?id=26
            {
            TUUID(Uuid^).bytes[15] := (TUUID(Uuid^).bytes[15] * 16) + hex2bin[Ord(p^)];
            }
            TUUID(Uuid^).bytes[15] := (TUUID(Uuid^).bytes[15] * 16) + hex2bin[Byte(p^)];
            {+.}
            inc(p);
            inc(pos);
          end else
          begin
            Result := False;
            Exit;
          end;
        36: if bracket then
            begin
              state := stEatSpaces;
              saved := stBracket;
            end else
            begin
              state := stEatSpaces;
              saved := stEnd;
            end;
      end;
    stBracket:
      begin
        if p^ <> '}' then
        begin
          Result := False;
          Exit;
        end;
        inc(p);
        state := stEatSpaces;
        saved := stEnd;
      end;
    stEnd:
      begin
        if p^ <> #0 then
        begin
          Result := False;
          Exit;
        end;
        Break;
      end;
  end;
  Result := True;
end;

function UUIDToString(const g: TGUID): SOString;
begin
  Result := SOString(format('%.8x%.4x%.4x%.2x%.2x%.2x%.2x%.2x%.2x%.2x%.2x',
    [g.D1, g.D2, g.D3,
     g.D4[0], g.D4[1], g.D4[2],
     g.D4[3], g.D4[4], g.D4[5],
     g.D4[6], g.D4[7]]));
end;

function StringToUUID(const str: SOString; var g: TGUID): Boolean;
begin
  Result := UuidFromString(PSOChar(str), @g);
end;

{$IFDEF HAVE_RTTI}

function SerialToBoolean({%H-}ctx: TSuperRttiContext; var value: TValue; const {%H-}index: ISuperObject): ISuperObject;
var
  LValue: Boolean;
begin
  LValue := TValueData(value).FAsSLong <> 0;
  if LValue or (ctx = nil) or ctx.FForceDefault then
    Result := TSuperObject.Create(LValue)
  else
    Result := nil;
end;

function SerialToDateTime(ctx: TSuperRttiContext; var value: TValue; const {%H-}index: ISuperObject): ISuperObject;
var
  ctxowned: Boolean;
  LValue: Double;
begin
  Result := nil;
  if Value.IsEmpty then
    Exit;
  LValue := TValueData(value).FAsDouble;

  ctxowned := False;
  if ctx = nil then begin
    ctx := SuperRttiContextDefault;
    if ctx = nil then begin
      if SuperRttiContextClassDefault = nil then
        ctx := TSuperRttiContext.Create
      else
        ctx := SuperRttiContextClassDefault.Create;
      ctxowned := True;
    end;
  end;
  try
    if (not ctx.FForceDefault) and (LValue = {DT Default:}0) then
      Exit;
    case ctx.SuperDateFormatHandling of
      //sdfJava:
      //  Result := TSuperObject.Create( DelphiToJavaDateTime(LValue) );
      sdfISO:
        Result := TSuperObject.Create( DelphiDateToISO8601(LValue, ctx.SuperDateTimeZoneHandling = sdzUTC) );
      sdfUnix:
        Result := TSuperObject.Create( DelphiDateTimeToUnix(LValue, ctx.SuperDateTimeZoneHandling = sdzUTC) );
      sdfFormatSettings:
        if ctx.SuperDateTimeZoneHandling = sdzLOCAL then
          {$if declared(TTimeZone)}
          Result := TSuperObject.Create( DateTimeToStr(TTimeZone.Local.ToLocalTime(LValue), SOFormatSettings) )
          {$else}
          Result := TSuperObject.Create( SOString(DateTimeToStr(LocalTimeToUniversal(LValue), SOFormatSettings)) )
          {$ifend}
        else
          Result := TSuperObject.Create( SOString(DateTimeToStr(LValue, SOFormatSettings)) );
      else // sdfJava
        Result := TSuperObject.Create( DelphiToJavaDateTime(LValue) );
    end; // case
  finally
    if ctxowned then
      ctx.Free;
  end;
end;

function SerialToGuid({%H-}ctx: TSuperRttiContext; var value: TValue; const {%H-}index: ISuperObject): ISuperObject;
var
  g: TGUID;
begin
  value.ExtractRawData(@g);
  Result := TSuperObject.Create(
    SOString(Format('%.8x-%.4x-%.4x-%.2x%.2x-%.2x%.2x%.2x%.2x%.2x%.2x',
              [g.D1, g.D2, g.D3,
               g.D4[0], g.D4[1], g.D4[2],
               g.D4[3], g.D4[4], g.D4[5],
               g.D4[6], g.D4[7]])
  ));
end;

function SerialFromBoolean(ctx: TSuperRttiContext; const obj: ISuperObject; var Value: TValue): Boolean;
var
  o: ISuperObject;
  S: string;
begin
  if obj = nil then // https://github.com/hgourvest/superobject/pull/46
  begin
    TValueData(Value).FAsSLong := Ord(False);
    Result := True;
    Exit;
  end;
  case ObjectGetType(obj) of
  stBoolean:
    begin
      TValueData(Value).FAsSLong := obj.AsInteger;
      Result := True;
    end;
  stInt:
    begin
      TValueData(Value).FAsSLong := ord(obj.AsInteger <> 0);
      Result := True;
    end;
  stString:
    begin
      Result := False;
      o := SO(obj.AsString);
      if not ObjectIsType(o, stString) then
        Result := SerialFromBoolean(ctx, SO(obj.AsString), Value) else
      begin // https://github.com/hgourvest/superobject/pull/46
        S := string(obj.AsString);
        if (S <> '') then begin
          if (S = '1') or (S = '-1') or SameText(S, 'True') then
          begin
            TValueData(Value).FAsSLong := Ord(True);
            Result := True;
          end
          else if (S = '0') or SameText(S, 'False') then
          begin
            TValueData(Value).FAsSLong := Ord(False);
            Result := True;
          end;
        end;
      end;
    end;
  else
    Result := False;
  end; // case
end;

function SerialFromDateTime({%H-}ctx: TSuperRttiContext; const obj: ISuperObject; var Value: TValue): Boolean;
var
  dt: TDateTime;
  jdt: Int64;
  s: string;
begin
  Result := False;
  {%H-}case ObjectGetType(obj) of
  stInt:
    begin
      TValueData(Value).FAsDouble := JavaToDelphiDateTime(obj.AsInteger);
      Result := True;
    end;
  stString:
    begin
      {+} // https://code.google.com/p/superobject/issues/detail?id=37
          // supports: "\/Date(939772800000)\/"
      s := string(obj.AsString);
      if (Length(s) > Length('/Date()')) then begin
        if (Copy(s,1,Length('/Date()'))='/Date(') and (S[Length(S)]='/') then
        begin
          Delete(s, Length(s)-1, 2);
          Delete(s, 1, 6);
          Result := TryStrToInt64(s, jdt);
          if Result then
            TValueData(Value).FAsDouble := JavaToDelphiDateTime(jdt);
          Exit;
        end;
      end;
      {+.}
      Result := TryISO8601ToDelphiDate(SOString(s), dt)
        or TryStrToDateTime(s, dt);
      if Result then
        TValueData(Value).FAsDouble := dt;
    end;
  end;
end;

function SerialFromGuid({%H-}ctx: TSuperRttiContext; const obj: ISuperObject; var Value: TValue): Boolean;
begin
  case ObjectGetType(obj) of
    stNull:
      begin
        FillChar(Value.GetReferenceToRawData^, SizeOf(TGUID), 0);
        Result := True;
      end;
    stString: Result := UuidFromString(PSOChar(obj.AsString), Value.GetReferenceToRawData);
  else
    Result := False;
  end;
end;

function SOInvoke(const obj: TValue; const method: string; const params: ISuperObject; ctx: TSuperRttiContext): ISuperObject; overload;
begin
  Result := nil;
  if TrySOInvoke(ctx, obj, method, params, Result) <> irSuccess then
    raise ESuperObject.Create('Invalid method call');
end;

function SOInvoke(const obj: TValue; const method: string; const params: string; ctx: TSuperRttiContext): ISuperObject; overload;
begin
  Result := SOInvoke(obj, method, so(SOString(params)), ctx)
end;

function TrySOInvoke(var ctx: TSuperRttiContext; const obj: TValue;
  const method: string; const params: ISuperObject;
  var Return: ISuperObject): TSuperInvokeResult;
var
  t: TRttiInstanceType;
  m: TRttiMethod;
  a: TArray<TValue>;
  ps: TArray<TRttiParameter>;
  v: TValue;
  index: ISuperObject;

  function GetParams: Boolean;
  var
    i: Integer;
  begin
    case ObjectGetType(params) of
      stArray:
        for i := 0 to Length(ps) - 1 do
          if (pfOut in ps[i].Flags) then
            TValue.Make(nil, ps[i].ParamType.Handle, a[i]) else
            if not ctx.FromJson(ps[i].ParamType.Handle, params.AsArray[i], a[i]) then
            begin
              Result := False;
              Exit;
            end;
      stObject:
        for i := 0 to Length(ps) - 1 do
          if (pfOut in ps[i].Flags) then
            TValue.Make(nil, ps[i].ParamType.Handle, a[i]) else
            if not ctx.FromJson(ps[i].ParamType.Handle, params.AsObject[SOString(ps[i].Name)], a[i]) then
            begin
              Result := False;
              Exit;
            end;
      stNull: ;
    else
      begin
        Result := False;
        Exit;
      end;
    end;
    Result := True;
  end;

  procedure SetParams;
  var
    i: Integer;
  begin
    {%H-}case ObjectGetType(params) of
      stArray:
        for i := 0 to Length(ps) - 1 do
          if (ps[i].Flags * [pfVar, pfOut]) <> [] then
            params.AsArray[i] := ctx.ToJson(a[i], index);
      stObject:
        for i := 0 to Length(ps) - 1 do
          if (ps[i].Flags * [pfVar, pfOut]) <> [] then
            params.AsObject[SOString(ps[i].Name)] := ctx.ToJson(a[i], index);
    end;
  end;

var
  ctxowned: Boolean;
begin
  Result := irSuccess;
  index := SO;

  ctxowned := False;
  if ctx = nil then begin
    ctx := SuperRttiContextDefault;
    if ctx = nil then begin
      if SuperRttiContextClassDefault = nil then
        ctx := TSuperRttiContext.Create
      else
        ctx := SuperRttiContextClassDefault.Create;
      ctxowned := True;
    end;
  end;
  try
    case obj.Kind of
      tkClass:
        begin
          t := TRttiInstanceType(ctx.Context.GetType(obj.AsObject.ClassType));
          m := t.GetMethod(method);
          if m = nil then
          begin
            Result := irMethothodError;
            Exit;
          end;
          ps := m.GetParameters;
          SetLength({%H-}a, Length(ps));
          if not GetParams then
          begin
            Result := irParamError;
            Exit;
          end;
          if m.IsClassMethod then
          begin
            v := m.Invoke(obj.AsObject.ClassType, a);
            Return := ctx.ToJson(v, index);
            SetParams;
          end else
          begin
            v := m.Invoke(obj, a);
            Return := ctx.ToJson(v, index);
            SetParams;
          end;
        end;
      tkClassRef:
        begin
          t := TRttiInstanceType(ctx.Context.GetType(obj.AsClass));
          m := t.GetMethod(method);
          if m = nil then
          begin
            Result := irMethothodError;
            Exit;
          end;
          ps := m.GetParameters;
          SetLength(a, Length(ps));

          if not GetParams then
          begin
            Result := irParamError;
            Exit;
          end;
          if m.IsClassMethod then
          begin
            v := m.Invoke(obj, a);
            Return := ctx.ToJson(v, index);
            SetParams;
          end else
          begin
            Result := irError;
            Exit;
          end;
        end;
    else
      begin
        Result := irError;
        Exit;
      end;
    end;
  finally
    if ctxowned then
      ctx.Free;
  end;
end;

{+} // https://code.google.com/p/superobject/issues/detail?id=39
function IsGenericType(ATypeInfo: PTypeInfo): Boolean;
{+}
var
  vTypeName: string;
begin
  Result := Assigned(ATypeInfo);
  if not Result then
    Exit;
  {$IFDEF NEXTGEN}
  vTypeName := ATypeInfo.NameFld.ToString;
  {$ELSE}
  vTypeName := String(ATypeInfo.Name);
  {$ENDIF}
  Result := Pos('<', vTypeName) > 0;
{+.}
end;
//
function GetDeclaredGenericType(RttiContext: TRttiContext; ATypeInfo: PTypeInfo): TRttiType;
{$IFNDEF FPC}
var
  startPos,
  endPos: Integer;
  vTypeName: string;
{$ENDIF !FPC}
begin
  Result := nil;
  {$IFDEF FPC} // TODO: FPC currently not supported
    Exit;
  {$ELSE !FPC}
  {+}
  //if ATypeInfo = nil then
  //  Exit;
  {$IFDEF NEXTGEN}
  vTypeName := ATypeInfo.NameFld.ToString;
  {$ELSE}
  vTypeName := string(ATypeInfo.Name);
  {$ENDIF}
  startPos := AnsiPos('<', vTypeName);
  if startPos > 0 then
  begin
    endPos := PosEx('>', vTypeName, startPos+1);
    if endPos > 0 then
    begin
      vTypeName := Copy(vTypeName, startPos + 1, endPos - Succ(startPos));
      Result := RttiContext.FindType(vTypeName); // TODO: FPC currently not supported
    end;
  end;
  {+.}
  {$ENDIF !FPC}
end;
//
function IsList(RttiContext: TRttiContext; ATypeInfo: PTypeInfo): Boolean;
var
  AMethod: TRttiMethod;
begin
  //if (ATypeInfo = nil) or (RttiContext = nil) then
  //  Exit;
  AMethod := RttiContext.GetType(ATypeInfo).GetMethod('Add');

  Result := (AMethod <> nil) and
            (AMethod.MethodKind = mkFunction) and
            (Length(AMethod.GetParameters) = 1)
end;
{+.}

{$ENDIF HAVE_RTTI}

{+}
{$IFNDEF HAVE_INTERFACED_OBJECT}
//
{ TInterfacedObject }
//
function TInterfacedObject.QueryInterface;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;
//
function TInterfacedObject._AddRef;
begin
  Result := InterlockedIncrement(FRefCount);
end;
//
function TInterfacedObject._Release;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;
//
class function TInterfacedObject.NewInstance;
begin
  Result := inherited NewInstance;
  TInterfacedObject(Result).FRefCount := 1;
end;
//
procedure TInterfacedObject.AfterConstruction;
begin
  InterlockedDecrement(FRefCount);
end;
//
procedure TInterfacedObject.BeforeDestruction;
begin
  if RefCount <> 0 then
    raise ESuperObject.Create('Invalid pointer');
end;
{$ENDIF !HAVE_INTERFACED_OBJECT}
{+.}

{ TSuperEnumerator }

constructor TSuperEnumerator.Create(const obj: ISuperObject);
begin
  inherited Create;
  FObj := obj;
  FCount := -1;
  if ObjectIsType(FObj, stObject) then
    FObjEnum := FObj.AsObject.GetEnumerator else
    FObjEnum := nil;
end;

destructor TSuperEnumerator.Destroy;
begin
  if Assigned(FObjEnum) then
    FreeAndNil(FObjEnum);
  inherited;
end;

function TSuperEnumerator.MoveNext: Boolean;
begin
  case ObjectGetType(FObj) of
    stObject: Result := FObjEnum.MoveNext;
    stArray:
      begin
        inc(FCount);
        if FCount < FObj.AsArray.Length then
          Result := True else
          Result := False;
      end;
  else
    Result := false;
  end;
end;

function TSuperEnumerator.GetCurrent: ISuperObject;
begin
  case ObjectGetType(FObj) of
    stObject: Result := FObjEnum.Current.Value;
    stArray: Result := FObj.AsArray.GetO(FCount);
  else
    Result := FObj;
  end;
end;

{ TSuperObject }

constructor TSuperObject.Create(jt: TSuperType);
begin
  inherited Create;
{$IFDEF DEBUG}{$IFDEF MSWINDOWS}
  InterlockedIncrement(debugcount);
{$ENDIF}{$ENDIF}
  {+}
  {$IFDEF EXTEND_FORIN}
  SafeForIn := SafeForInDefault;
  {$ENDIF}
  {+.}
  FProcessing := false;
  FDataPtr := nil;
  FDataType := jt;
  case FDataType of
    stObject: FO.c_object := TSuperTableString.Create;
    stArray:
      begin
        FO.c_array := TSuperArray.Create;
        {+} // https://code.google.com/p/superobject/issues/detail?id=24
        FO.c_array._AddRef;
        {+.}
      end;
    stString: FOString := '';
  else
    FO.c_object := nil;
  end;
end;

constructor TSuperObject.Create(b: boolean);
begin
  Create(stBoolean);
  FO.c_boolean := b;
end;

constructor TSuperObject.Create(i: SuperInt);
begin
  Create(stInt);
  FO.c_int := i;
end;

constructor TSuperObject.Create(d: double);
begin
  Create(stDouble);
  FO.c_double := d;
end;

constructor TSuperObject.CreateCurrency(c: Currency);
begin
  Create(stCurrency);
  FO.c_currency := c;
end;

destructor TSuperObject.Destroy;
begin
{$IFDEF DEBUG}{$IFDEF MSWINDOWS}
  InterlockedDecrement(debugcount);
{$ENDIF}{$ENDIF}
  {%H-}case FDataType of
    stObject:
      {+}
      if Assigned(FO.c_object) then
      begin
        FreeAndNil(FO.c_object);
      end;
      {+.}
    stArray:
      {+} // https://code.google.com/p/superobject/issues/detail?id=24
      if Assigned(FO.c_array) then
      begin
        FO.c_array._Release;
        FO.c_array := nil;
      end;
      {+.}
  end;
  inherited;
end;

function TSuperObject.Write(writer: TSuperWriter; indent: boolean; escape: boolean; level: integer): Integer;
function DoEscape(str: PSOChar; len: Integer): Integer;
{+}
const
  super_hex_chars: PSOChar = '0123456789abcdef';
{+.}
var
  pos, start_offset: Integer;
  c: SOChar;
  buf: array[0..5] of SOChar;
type
  TByteChar = {+}packed{+.} record
  case integer of
    0: (a, b: Byte);
    1: (c: WideChar);
  end;
  begin
    if str = nil then
    begin
      Result := 0;
      exit;
    end;
    pos := 0; start_offset := 0;
    with writer do
    while pos < len do
    begin
      c := str[pos];
      case c of
        #8,#9,#10,#12,#13,'"','\','/':
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);

            if(c = #8) then Append(ESC_BS, 2)
            else if (c = #9) then Append(ESC_TAB, 2)
            else if (c = #10) then Append(ESC_LF, 2)
            else if (c = #12) then Append(ESC_FF, 2)
            else if (c = #13) then Append(ESC_CR, 2)
            else if (c = '"') then Append(ESC_QUOT, 2)
            else if (c = '\') then Append(ESC_SL, 2)
            else if (c = '/') then Append(ESC_SR, 2);
            inc(pos);
            start_offset := pos;
          end;
      else
        if (SOIChar(c) > 255) then
        begin
          if(pos - start_offset > 0) then
            Append(str + start_offset, pos - start_offset);
          buf[0] := '\';
          buf[1] := 'u';
          buf[2] := super_hex_chars[TByteChar(c).b shr 4];
          buf[3] := super_hex_chars[TByteChar(c).b and $f];
          buf[4] := super_hex_chars[TByteChar(c).a shr 4];
          buf[5] := super_hex_chars[TByteChar(c).a and $f];
          Append(PSOChar(@buf), 6); // {+} compatible with $T+ {+.}
          inc(pos);
          start_offset := pos;
        end else
        if (c < #32) or (c > #127) then
        begin
          if(pos - start_offset > 0) then
            Append(str + start_offset, pos - start_offset);
          buf[0] := '\';
          buf[1] := 'u';
          buf[2] := '0';
          buf[3] := '0';
          buf[4] := super_hex_chars[ord(c) shr 4];
          buf[5] := super_hex_chars[ord(c) and $f];
          Append(buf, 6);
          inc(pos);
          start_offset := pos;
        end else
          inc(pos);
      end;
    end;
    if(pos - start_offset > 0) then
      writer.Append(str + start_offset, pos - start_offset);
    Result := 0;
  end;

function DoMinimalEscape(str: PSOChar; len: Integer): Integer;
var
  pos, start_offset: Integer;
  c: SOChar;
(*type
  TByteChar = {+}packed{+.} record
  case integer of
    0: (a, b: Byte);
    1: (c: WideChar);
  end;//*)
  begin
    if str = nil then
    begin
      Result := 0;
      exit;
    end;
    pos := 0; start_offset := 0;
    with writer do
    while pos < len do
    begin
      c := str[pos];
      case c of
        #0:
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_ZERO, 6);
            inc(pos);
            start_offset := pos;
          end;
        '"':
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_QUOT, 2);
            inc(pos);
            start_offset := pos;
          end;
        '\':
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_SL, 2);
            inc(pos);
            start_offset := pos;
          end;
        {+}
        #13:
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_CR, 2);
            inc(pos);
            start_offset := pos;
          end;
        #10:
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_LF, 2);
            inc(pos);
            start_offset := pos;
          end;
        #9:
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_TAB, 2);
            inc(pos);
            start_offset := pos;
          end;
        #8:
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_BS, 2);
            inc(pos);
            start_offset := pos;
          end;
        #12:
          begin
            if(pos - start_offset > 0) then
              Append(str + start_offset, pos - start_offset);
            Append(ESC_FF, 2);
            inc(pos);
            start_offset := pos;
          end;
        {+.}
      else
        inc(pos);
      end;
    end;
    if(pos - start_offset > 0) then
      writer.Append(str + start_offset, pos - start_offset);
    Result := 0;
  end;

  procedure _indent(i: shortint; r: boolean);
  begin
    inc(level, i);
    if r then
      with writer do
      begin
{$IFDEF MSWINDOWS}
        Append(TOK_CRLF, 2);
{$ELSE}
        Append(TOK_LF, 1);
{$ENDIF}
        for i := 0 to level - 1 do
          Append(TOK_SP, 1);
      end;
  end;
var
  k,j: Integer;
  iter: TSuperObjectIter;
  st: {+}string;//AnsiString;{+.}
  val: ISuperObject;
const
  ENDSTR_A: PSOChar = '": ';
  ENDSTR_B: PSOChar = '":';
begin

  if FProcessing then
  begin
    Result := writer.Append(TOK_NULL, 4);
    Exit;
  end;

  FProcessing := true;
  with writer do
  try
    case FDataType of
      stObject:
        if FO.c_object.FCount > 0 then
        begin
          k := 0;
          Append(TOK_CBL, 1);
          if indent then _indent(1, false);
          {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
          if ObjectFindFirst(Self, iter) then {$hints on}
          repeat
  {$IFDEF SUPER_METHOD}
            if (iter.val = nil) or not ObjectIsType(iter.val, stMethod) then
            begin
  {$ENDIF}
              if (iter.val = nil) or (not iter.val.Processing) then
              begin
                if(k <> 0) then
                  Append(TOK_COM, 1);
                if indent then _indent(0, true);
                Append(TOK_DQT, 1);
                if escape then
                  doEscape(PSOChar(iter.key), Length(iter.key)) else
                  DoMinimalEscape(PSOChar(iter.key), Length(iter.key));
                if indent then
                  Append(ENDSTR_A, 3) else
                  Append(ENDSTR_B, 2);
                if(iter.val = nil) then
                  Append(TOK_NULL, 4) else
                  iter.val.write(writer, indent, escape, level);
                inc(k);
              end;
  {$IFDEF SUPER_METHOD}
            end;
  {$ENDIF}
          until not ObjectFindNext(iter);
          ObjectFindClose(iter);
          if indent then _indent(-1, true);
          Result := Append(TOK_CBR, 1);
        end else
          Result := Append(TOK_OBJ, 2);
      stBoolean:
        begin
          if (FO.c_boolean) then
            Result := Append(TOK_TRUE, 4) else
            Result := Append(TOK_FALSE, 5);
        end;
      stInt:
        begin
          {+}{$warnings off}{+.}
          str(FO.c_int, st);
          {+}{$warnings on}{+.}
          Result := Append(PSOChar(SOString(st)));
        end;
      stDouble:
        Result := Append(PSOChar(FloatToJson(FO.c_double)));
      stCurrency:
        begin
          Result := Append(PSOChar(CurrToJson(FO.c_currency)));
        end;
      stString:
        begin
          Append(TOK_DQT, 1);
          if escape then
            doEscape(PSOChar(FOString), Length(FOString)) else
            DoMinimalEscape(PSOChar(FOString), Length(FOString));
          Append(TOK_DQT, 1);
          Result := 0;
        end;
      stArray:
        if FO.c_array.FLength > 0 then
        begin
          Append(TOK_ARL, 1);
          if indent then _indent(1, true);
          k := 0;
          j := 0;
          while k < FO.c_array.FLength do
          begin

            val :=  FO.c_array.GetO(k);
  {$IFDEF SUPER_METHOD}
            if not ObjectIsType(val, stMethod) then
            begin
  {$ENDIF}
              if (val = nil) or (not val.Processing) then
              begin
                if (j <> 0) then
                  Append(TOK_COM, 1);
                if(val = nil) then
                  Append(TOK_NULL, 4) else
                  val.write(writer, indent, escape, level);
                inc(j);
              end;
  {$IFDEF SUPER_METHOD}
            end;
  {$ENDIF}
            inc(k);
          end;
          if indent then _indent(-1, false);
          Result := Append(TOK_ARR, 1);
        end else
          Result := Append(TOK_ARRAY, 2);
      stNull:
          Result := Append(TOK_NULL, 4);
    else
      Result := 0;
    end;
  finally
    FProcessing := false;
  end;
end;

function TSuperObject.IsType(AType: TSuperType): boolean;
begin
  Result := AType = FDataType;
end;

function TSuperObject.AsBoolean: boolean;
begin
  case FDataType of
    stBoolean: Result := FO.c_boolean;
    stInt: Result := (FO.c_int <> 0);
    stDouble: Result := (FO.c_double <> 0);
    stCurrency: Result := (FO.c_currency <> 0);
    stString: Result := (Length(FOString) <> 0);
    stNull: Result := False;
  else
    Result := True;
  end;
end;

function TSuperObject.AsInteger: SuperInt;
var
  code: integer;
  cint: SuperInt;
begin
  case FDataType of
    stInt: Result := FO.c_int;
    stDouble: Result := round(FO.c_double);
    stCurrency: Result := round(FO.c_currency);
    stBoolean: Result := ord(FO.c_boolean);
    stString:
      begin
        Val(FOString, cint, code);
        if code = 0 then
          Result := cint else
          Result := 0;
      end;
  else
    Result := 0;
  end;
end;

function TSuperObject.AsDouble: Double;
var
  code: integer;
  cdouble: double;
begin
  case FDataType of
    stDouble: Result := FO.c_double;
    stCurrency: Result := FO.c_currency;
    stInt: Result := FO.c_int;
    stBoolean: Result := ord(FO.c_boolean);
    stString:
      begin
        Val(FOString, cdouble, code);
        if code = 0 then
          Result := cdouble else
          Result := 0.0;
      end;
  else
    Result := 0.0;
  end;
end;

function TSuperObject.AsCurrency: Currency;
var
  code: integer;
  cdouble: double;
begin
  case FDataType of
    stDouble: Result := FO.c_double;
    stCurrency: Result := FO.c_currency;
    stInt: Result := FO.c_int;
    stBoolean: Result := ord(FO.c_boolean);
    stString:
      begin
        Val(FOString, cdouble, code);
        if code = 0 then
          Result := cdouble else
          Result := 0.0;
      end;
  else
    Result := 0.0;
  end;
end;

function TSuperObject.AsString: SOString;
begin
  case FDataType of
    stString: Result := FOString;
    stNull: Result := '';
  else
    Result := AsJSon(false, false);
  end;
end;

function TSuperObject.GetEnumerator: TSuperEnumerator;
begin
  Result := TSuperEnumerator.Create(Self);
end;

function TSuperObject.AsArray: {+}ISuperArray{+.};
begin
  if FDataType = stArray then
    Result := FO.c_array else
    Result := nil;
end;

function TSuperObject.AsObject: TSuperTableString;
begin
  if FDataType = stObject then
    Result := FO.c_object else
    Result := nil;
end;

function TSuperObject.AsJSon(indent, escape: boolean): SOString;
var
  pb: TSuperWriterString;
begin
  {+}
  {$IFDEF EXTEND_FORIN}
  if FJsonIsEmpty then
  begin
    Result := '';
    Exit;
  end;
  {$ENDIF}
  {+.}
  pb := TSuperWriterString.Create;
  try
    if(Write(pb, indent, escape, 0) < 0) then
    begin
      Result := '';
      Exit;
    end;
    if pb.FBPos > 0 then
      Result := pb.FBuf else
      Result := '';
  finally
    pb.Free;
  end;
end;

class function TSuperObject.ParseString(s: PSOChar; strict: Boolean; partial: boolean; const athis: ISuperObject;
  options: TSuperFindOptions; const put: ISuperObject; dt: TSuperType): ISuperObject;
var
  tok: TSuperTokenizer;
  obj: ISuperObject;
begin
  tok := TSuperTokenizer.Create;
  {+}
  try
  {+.}
  obj := ParseEx(tok, s, -1, strict, athis, options, put, dt);
  if(tok.err <> teSuccess) or (not partial and (s[tok.char_offset] <> #0)) then
    Result := nil else
    Result := obj;
  {+}
  finally
    tok.Free;
  end;
  {+.}
end;

{+}
//
// <TEncoding Helpers>
//
{$IFDEF DELPHI_UNICODE} // FPC also implement TEncoding
  {$define USE_TENCODING}
  // FPC: TEncoding - implementation is not optimal for "GetChars(Bytes: PByte;" and "function GetBytes(Chars: PChar".
  // FPC: widestringmanager will be optimal for use.
{$ELSE}
  {$if declared(TEncoding)}  // FPC
    {$define USE_TENCODING}  { optional }
  {$ifend}
{$ENDIF}
{$IFDEF USE_TENCODING}
type
  {$IFDEF UNICODE}
  UnicodeChar = Char;
  {$ELSE}
  {$ENDIF}
  PUnicodeChar = PWideChar;
  TEncodingAccess = class(TEncoding)
  public
    function GetCharsEx(Bytes: PByte; ByteCount: Integer; Chars: PUnicodeChar; CharCount: Integer): Integer; inline;
    function GetBytesEx(Chars: PUnicodeChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; inline;
    function GetByteCountEx(Chars: PUnicodeChar; CharCount: Integer): Integer; inline;
  end;
function TEncodingAccess.GetCharsEx(Bytes: PByte; ByteCount: Integer; Chars: PUnicodeChar; CharCount: Integer): Integer;
begin
  Result := {vmt call:}GetChars(Bytes, ByteCount, Chars, CharCount);
end;
function TEncodingAccess.GetBytesEx(Chars: PUnicodeChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := {vmt call:}GetBytes(Chars, CharCount, Bytes, ByteCount);
end;
function TEncodingAccess.GetByteCountEx(Chars: PUnicodeChar; CharCount: Integer): Integer;
begin
  Result := {vmt call:}GetByteCount(Chars, CharCount);
end;
type
  {$IF (not defined(FPC)) and (CompilerVersion<=21)} // Less then XE
  TMBCSEncodingH = class(TEncoding) //TODO: move to private section
  private
    FCodePage: Cardinal;
  end;
  {$IFEND}
  TEncodingHelper = class helper for TEncoding
    {$IF (not defined(FPC)) and (CompilerVersion<=21)} // Less then XE
    private function GetCodePage: Integer;
    public property CodePage: Integer read GetCodePage;
    {$IFEND}
    {$IF (not defined(FPC)) and (CompilerVersion<=22)} // Less then XE2
    private class function GetANSI: TEncoding; inline; static;
    public class property ANSI: TEncoding read GetANSI;
    {$IFEND}
  public
    {$IF (not defined(FPC)) and (CompilerVersion<=21)} // Less then XE
    class function GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding; ADefaultEncoding: TEncoding): Integer; overload; static;
    {$IFEND}
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PUnicodeChar; CharCount: Integer): Integer; overload; {$IFNDEF FPC}{$IFDEF HAVE_INLINE}inline;{$ENDIF}{$ENDIF}
    function GetBytes(Chars: PUnicodeChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; {$IFNDEF FPC}{$IFDEF HAVE_INLINE}inline;{$ENDIF}{$ENDIF}
    function GetByteCount(Chars: PUnicodeChar; CharCount: Integer): Integer; overload; {$IFNDEF FPC}{$IFDEF HAVE_INLINE}inline;{$ENDIF}{$ENDIF}
    //
    class function GetEncoding(CodePage: Integer; var encnew: boolean): TEncoding; overload; {static;} // "-static" - because need access the "inherited GetEncoding". Otherwise need change name "GetEncoding".
    class function GetEncoding(CodePage: Integer): TEncoding; overload; {static;} {$IFNDEF FPC}{$IFDEF HAVE_INLINE}inline;{$ENDIF}{$ENDIF} // "-static" - because need access the "inherited GetEncoding". Otherwise need change name "GetEncoding".
  end;
{$IF (not defined(FPC)) and (CompilerVersion<=21)} // Less then XE
function TEncodingHelper.GetCodePage: Integer;
begin
  if Self = TEncoding.Default then
    Result := DefaultSystemCodePage //GetACP()
  else if Self.ClassType = TUnicodeEncoding then
    Result := CP_UTF16LE
  else if Self.ClassType = TUTF8Encoding then
    Result := CP_UTF8
  else if Self.ClassType = TBigEndianUnicodeEncoding then
    Result := CP_UTF16BE
  else if Self is TMBCSEncoding then  // !Not greater than the line for "Self.ClassType"
    Result := TMBCSEncodingH(Self).FCodePage
  // <encoding class inherits>
  else if Self is TBigEndianUnicodeEncoding then // !Not lower than the line for "is TUnicodeEncoding"
    Result := CP_UTF16BE
  else if (Self is TUnicodeEncoding) then
    Result := CP_UTF16LE
  // <\encoding class inherits>
  else
    Result := 0;
end;
{$IFEND}
{$IF (not defined(FPC)) and (CompilerVersion<=22)} // Less then XE2
class function TEncodingHelper.GetANSI: TEncoding;
begin
  Result := TEncoding.Default;
end;
{$IFEND}
{$IF (not defined(FPC)) and (CompilerVersion<=21)} // Less then XE
 class function TEncodingHelper.GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding; ADefaultEncoding: TEncoding): Integer;
 var
   IsNil: Boolean;
 begin
   IsNil := AEncoding = nil;
   Result := TEncoding.GetBufferEncoding(Buffer, AEncoding);
   if IsNil and (AEncoding = TEncoding.Default) then begin
     AEncoding := ADefaultEncoding;
     Result := 0;
   end;
 end;
{$IFEND}
function TEncodingHelper.GetChars(Bytes: PByte; ByteCount: Integer; Chars: PUnicodeChar; CharCount: Integer): Integer;
begin
  Result := TEncodingAccess(Self).GetCharsEx(Bytes, ByteCount, Chars, CharCount);
end;
function TEncodingHelper.GetBytes(Chars: PUnicodeChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := TEncodingAccess(Self).GetBytesEx(Chars, CharCount, Bytes, ByteCount);
end;
function TEncodingHelper.GetByteCount(Chars: PUnicodeChar; CharCount: Integer): Integer;
begin
  Result := TEncodingAccess(Self).GetByteCountEx(Chars, CharCount);
end;
class function TEncodingHelper.GetEncoding(CodePage: Integer; var encnew: boolean): TEncoding;
begin
  encnew := False;
  case CodePage of
    {+} // optimize: not create new object for cached encoding
    CP_UTF16LE: Result := TEncoding.Unicode;
    CP_UTF16BE: Result := TEncoding.BigEndianUnicode;
    CP_UTF7: Result := TEncoding.UTF7;
    CP_UTF8: Result := TEncoding.UTF8;
    {+.}
  else begin
    //Result := TMBCSEncoding.Create(CodePage);
    Result := inherited GetEncoding(CodePage);
    encnew := True;
  end;
 end;
end;
class function TEncodingHelper.GetEncoding(CodePage: Integer): TEncoding;
var encnew: boolean;
begin
  {$hints off} // FPC: Hint: Local variable "encnew" does not seem to be initialized
  Result := GetEncoding(CodePage, encnew);
  {$hints on}
end;
{$ENDIF USE_TENCODING}
//
// <\TEncoding Helpers>
//
// ---
//
// <Detect Stream Encoding>
//
type
  TBom = TBytes;
  TBufferA = TBytes;
  TBufferW = array of SOChar;
{$IFNDEF USE_TENCODING}
{$IFDEF MSWINDOWS}
const
  DefaultSystemCodePage = 0;
{$ENDIF}
type
  TBomInfo = record CodePage, BOMLen, BOM, BOMMask: LongWord; end;
  PBomInfo = ^TBomInfo;
  TEncoding = TBomInfo;
const
  AutoPreambles: array[0..3] of TBomInfo = (
    (CodePage: CP_ANSI;    BOMLen: 0; BOM: $00000000; BOMMask: $FFFFFFFF),
    (CodePage: CP_UTF16LE; BOMLen: 2; BOM: $FFFE0000; BOMMask: $FFFF0000),
    (CodePage: CP_UTF8;    BOMLen: 3; BOM: $EFBBBF00; BOMMask: $FFFFFF00),
    (CodePage: CP_UTF16BE; BOMLen: 2; BOM: $FEFF0000; BOMMask: $FFFF0000)
  );
  IDX_ANSI    = 0;
  IDX_UTF16LE = 1;
  IDX_UTF8    = 2;
  IDX_UTF16BE = 3;
{$ENDIF !USE_TENCODING}
var
  SYS_CP_OEM: Longword; // System OEM codepage cache
{$IFDEF MSWINDOWS}
var
  SYS_ACP: Longword;
{$ENDIF MSWINDOWS}
//
function DetectStreamEncoding(stream: TStream; var bom: TBom; out bomBuffLen, bomLen: Integer;
  out codepage: PtrInt; {$IFDEF USE_TENCODING}out encnew: boolean;{$ENDIF} ADefaultCodePage: Integer): TEncoding;
var
  i: Integer;
  {$IFNDEF USE_TENCODING}
  Signature: LongWord; bomInfo: PBomInfo; acodepage: Integer;
  {$ENDIF}
begin
  {$IFDEF USE_TENCODING}
  encnew := False;
  {$ELSE}
  Result := AutoPreambles[IDX_ANSI]; // == ANSI
  bomLen := 0;                       // == Result.BOMLen;
  codepage := 0;                     // == CP_ANSI == Result.CodePage
  {$ENDIF}

  bomBuffLen := stream.Read(bom[0], 4);

  if bomBuffLen < 2 then begin // Stream without BOM. Interpretation as ansi
    {$IFDEF USE_TENCODING}
    bomLen := 0;   // == Length(Result.GetPreamble);
    Result := nil;
    if ADefaultCodePage > 0 then
    try
      Result := TEncoding.GetEncoding(ADefaultCodePage, encnew);
      codepage := ADefaultCodePage;
    except
      encnew := False;
    end;
    if Result = nil then
    begin
      Result := TEncoding.ANSI;
      codepage := CP_ANSI; // == 0 == Result.CodePage
    end;
    {$ELSE}
    if ADefaultCodePage > 0 then
      codepage := ADefaultCodePage;
    {$ENDIF}
    Exit;
  end;

  {$IFDEF USE_TENCODING}
  Result := nil; // !!! for auto detection from (UTF8, CP_UTF16LE, CP_UTF16BE)
  codepage := 0; // == CP_ANSI
  bomLen := TEncoding.GetBufferEncoding(bom, Result, nil);
  if Assigned(Result) then // dbg: Result.ClassType
    codepage := Result.CodePage
  else begin // Unicode stream without BOM
    bomLen := 0;
    if (bom[0] <> 0) and (bom[1] = 0) then begin
      Result := TEncoding.Unicode; codepage := CP_UTF16LE;
    end else if (bom[0] = 0) and (bom[1] <> 0) then begin
      Result := TEncoding.BigEndianUnicode; codepage := CP_UTF16BE;
    end else begin
      if ADefaultCodePage > 0 then begin
        try
          Result := TEncoding.GetEncoding(ADefaultCodePage, encnew);
          codepage := ADefaultCodePage;
        except
          encnew := False;
        end;
      end;
      if Result = nil then
      begin
        case SuperDefaultStreamCodePage of
          CP_ANSI: Result := TEncoding.ANSI;
          CP_UTF8: Result := TEncoding.UTF8;
          else
          try
            if SuperDefaultStreamCodePage = CP_OEM then begin
              Result := TEncoding.GetEncoding(SYS_CP_OEM, encnew);
              codepage := SYS_CP_OEM;
            end
            else if SuperDefaultStreamCodePage <> 0 then begin
              i := SuperDefaultStreamCodePage;
              if i < 0 then i := -i;
              {$IFDEF MSWINDOWS}
              if Longword(i) = SYS_ACP then // SYS_ACP == GetACP()
                i := 0;
              if i <> 0 then
              {$ENDIF}
              begin
                Result := TEncoding.GetEncoding(i, encnew);
                codepage := i;
              end;
            end;
          except
          end;
        end; // case SuperDefaultStreamCodePage
        if Result = nil then begin
          //Result := TEncoding.ANSI;
          Result := TEncoding.UTF8;
          codepage := CP_UTF8;
        end;
      end;
    end;
  end; // if Result = nil

  {$ELSE !USE_TENCODING}

  Signature :=(LongWord(bom[0]) shl 24) or (LongWord(bom[1]) shl 16)
    or (LongWord(bom[2]) shl 8) or LongWord(bom[3]);
  // check for known BOMs first...
  for i := (IDX_ANSI+1) to High(AutoPreambles) do begin
    bomInfo := @AutoPreambles[i];
    if {(bomInfo.BOMLen > 0 then) and} ((Signature and bomInfo.BOMMask) = bomInfo.BOM) then begin
      codepage := bomInfo.CodePage;
      bomLen := bomInfo.BOMLen;
      Result := bomInfo^;
      Exit;
    end;
  end;
  // Unicode stream without BOM
  if (bom[0] <> 0) and (bom[1] = 0) then
    Result := AutoPreambles[IDX_UTF16LE]
  else if (bom[0] = 0) and (bom[1] <> 0) then
    Result := AutoPreambles[IDX_UTF16BE]
  else if SuperDefaultStreamCodePage = CP_UTF8 then
    Result := AutoPreambles[IDX_UTF8]
  else begin
    if ADefaultCodePage > 0 then
      acodepage := ADefaultCodePage
    else if (SuperDefaultStreamCodePage = CP_OEM) then
      acodepage := SYS_CP_OEM
    else
      acodepage := SuperDefaultStreamCodePage;
    //
    if (acodepage >= 0) then begin
      if acodepage < 0 then acodepage := -acodepage;
      Result.CodePage := acodepage;
      {$IFDEF MSWINDOWS}
      if Longword(acodepage) <> SYS_ACP then begin // SYS_ACP == GetACP()
        codepage := acodepage;
        Exit;
      end
      else
        Exit;
      {$ENDIF}
    {.$IFDEF MSWINDOWS}
    end else begin
      //Result.codepage := SYS_ACP; // SYS_ACP == GetACP()
      //Exit;
      Result.codepage := CP_UTF8;
     {.$ENDIF}
    end;
  end; // if SuperDefaultStreamCodePage = CP_OEM
  //
  codepage := Result.CodePage;
  {$ENDIF !USE_TENCODING}
end; // function DetectStreamEncoding
//
// <\Detect Stream Encoding>
//
{+.}
type
  TEncoderData = record
    stream: TStream;
    size: Integer;
    codepage: PtrInt;
    enc: TEncoding;
    CharMaxByteCount: Integer;
    {$IFDEF USE_TENCODING}
    encnew: boolean;
    {$ENDIF}
    bufferAP: {$IFDEF NEXTGEN}PByte{$ELSE}PAnsiChar{$ENDIF}; // == @bufferA[0] ; can use for memory writing
    bufferWP: PSOChar;                                       // == @bufferW[0] or @bufferS[1]; !!! - not use for writing !!!
    bufferA: TBufferA;
    bufferW: TBufferW;
    {$IFNDEF USE_TENCODING}{$IFNDEF MSWINDOWS}
    bufferS: SOString;
    {$ENDIF}{$ENDIF}
  end;
  //PEncoderData = ^TEncoderData;
  TBufferDecoderProc = procedure(var p: TEncoderData);
  //
procedure BufferDecoderAnsi(var p: TEncoderData);
// Convertation from ansi to unicode(UTF16LE):
{$IFNDEF USE_TENCODING}{$IFDEF MSWINDOWS}
var iLen: Integer;
{$ENDIF}{$ENDIF}
begin // dbg: p.bufferAP
//dbg('.BufferDecoderAnsi: 0; p.size='+inttostr(p.size));
  {$IFDEF USE_TENCODING}
  p.size := {TEncoding.ANSI}p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PUnicodeChar(p.bufferW), {chars:}p.size*2);
  {$ELSE !USE_TENCODING}
  {$IFNDEF MSWINDOWS} // FPC,Kylix:
  p.bufferA[p.size] := 0;
  p.bufferS := SOString(AnsiString(PAnsiChar(@p.bufferA[0]))); // excessive allocation of intermediate buffers
  p.size := length(p.bufferS);
  //move(p.bufferS[1], p.bufferw[0], p.size*SizeOf(SOChar));
  p.bufferWP := PSOChar(Pointer(p.bufferS)); // minimize memory copy/move
  {$ELSE MSWINDOWS}
  p.bufferA[p.size] := 0;
  iLen := MultiByteToWideChar(DefaultSystemCodePage, 0, PAnsiChar(p.bufferA), p.size, nil, 0);
  if iLen = 0 then begin // RaiseLastOsError();
    p.size := 0;
    exit;
  end;
  if iLen > length(p.bufferW) then begin
    SetLength(p.bufferW, iLen);
    p.bufferWP := PSOChar(p.bufferW);
  end;
  p.size := MultiByteToWideChar(DefaultSystemCodePage, 0, PAnsiChar(p.bufferA), p.size, PWideChar(p.bufferW), iLen);
  //if p.size <= 0 then // RaiseLastOsError();
  //  exit;
  {$ENDIF MSWINDOWS}
  {$ENDIF !USE_TENCODING}
end; // procedure BufferDecoderAnsi
//
procedure BufferDecoderUTF8(var p: TEncoderData);
// Convertation from UTF8 to unicode(UTF16LE):
{$IFDEF USE_TENCODING}
var iLen, iBufWBytes, iExtraBytes, iReadBytes: Integer;
{$ELSE !USE_TENCODING}
{$IFNDEF MSWINDOWS}
{$ELSE MSWINDOWS}
var iLen, iBufWBytes, iExtraBytes, iReadBytes: Integer;
{$ENDIF MSWINDOWS}
{$ENDIF !USE_TENCODING}
begin
  {$IFDEF USE_TENCODING}
  //--p.size := TEncoding.UTF8.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
  iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
  //
  // Extra bytes: check and read:
  //
  //if p.CharMaxByteCount > 1 then
  begin
    // extra bytes: check and read:
    {$IFDEF DEBUG}
    p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
    {$ENDIF}
    iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
    if iBufWBytes <> p.size then
    begin
      iExtraBytes := 0;
      while (iBufWBytes <> p.size) and (iExtraBytes < p.CharMaxByteCount) do // CharMaxByteCount == 3 == p.enc.GetMaxByteCount(0)
      begin
        iReadBytes := p.stream.Read(p.bufferA[p.size], 1);
        if iReadBytes = 0 then
          break;
        inc(p.size);
        Inc(iExtraBytes);
        iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
        {$IFDEF DEBUG}
        p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
        {$ENDIF}
        iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
      end;
    end;
  end;
  p.size := iLen;
//function TMBCSEncoding.GetByteCount(Chars: PUnicodeChar; CharCount: Integer): Integer;
//begin
//  Result := LocaleCharsFromUnicode(FCodePage, FWCharToMBFlags,
//    PUnicodeChar(Chars), CharCount, nil, 0, nil, nil);
//end;
//function LocaleCharsFromUnicode(CodePage, Flags: Cardinal;
//  UnicodeStr: PWideChar; UnicodeStrLen: Integer; LocaleStr: _PAnsiChr;
//  LocaleStrLen: Integer; DefaultChar: _PAnsiChr; UsedDefaultChar: PLongBool): Integer; overload;
//begin
//  Result := WideCharToMultiByte(CodePage, Flags, UnicodeStr, UnicodeStrLen, LocaleStr,
//    LocaleStrLen, DefaultChar, PBOOL(UsedDefaultChar));
//end;
//function TMBCSEncoding.GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar;
//  CharCount: Integer): Integer;
//begin
//  Result := UnicodeFromLocaleChars(FCodePage, FMBToWCharFlags,
//    MarshaledAString(Bytes), ByteCount, Chars, CharCount);
//end;
//function UnicodeFromLocaleChars(CodePage, Flags: Cardinal; LocaleStr: _PAnsiChr;
//  LocaleStrLen: Integer; UnicodeStr: PWideChar; UnicodeStrLen: Integer): Integer; overload;
//begin
//  Result := MultiByteToWideChar(CodePage, Flags, LocaleStr, LocaleStrLen,
//    UnicodeStr, UnicodeStrLen);
//end;
  {$ELSE !USE_TENCODING}
  {$IFNDEF MSWINDOWS} // FPC, Kylix:
  p.size := Utf8ToUnicode(PWideChar(p.bufferW), p.size+1, PAnsiChar(p.bufferA), p.size)-1;
// TODO: ... implement read extra bytes
//    {$MESSAGE FATAL 'TODO: BufferDecoderUTF8 - not implemented read extra bytes'}
    {$MESSAGE WARN 'TODO: BufferDecoderUTF8 - not implemented read extra bytes'}
  {$ELSE MSWINDOWS}
  p.bufferA[p.size] := 0;
  iLen := MultiByteToWideChar(p.codepage, 0, PAnsiChar(p.bufferA), p.size, nil, 0);
  if iLen <= 0 then begin // RaiseLastOsError();
    p.size := 0;
    exit;
  end;
  if p.CharMaxByteCount > 1 then
    inc(iLen);
  if iLen > Length(p.bufferW) then begin
    SetLength(p.bufferW, iLen);
    p.bufferWP := PSOChar(p.bufferW);
  end;
  //--p.size := MultiByteToWideChar(p.codepage, 0, PAnsiChar(p.bufferA), p.size, PWideChar(p.bufferW), len);
  //iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
  iLen := MultiByteToWideChar(p.codepage, 0, PAnsiChar(p.bufferA), p.size, PWideChar(p.bufferW), iLen);
  //if iLen <= 0 then // RaiseLastOsError();
  //  exit;
  //
  // Extra bytes: check and read:
  //
  //if p.CharMaxByteCount > 1 then
  begin
    {$IFDEF DEBUG}
    p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
    {$ENDIF}
    //iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
    iBufWBytes := WideCharToMultiByte(p.codepage, {WCharToMBFlags}0, PWideChar(p.bufferW), iLen, nil, 0, nil, nil);
    if iBufWBytes <> p.size then
    begin
      iExtraBytes := 0;
      while (iBufWBytes <> p.size) and (iExtraBytes < p.CharMaxByteCount) do // CharMaxByteCount == 3 == p.enc.GetMaxByteCount(0)
      begin
        iReadBytes := p.stream.Read(p.bufferA[p.size], 1);
        if iReadBytes = 0 then
          break;
        inc(p.size);
        Inc(iExtraBytes);
        //iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
        iLen := MultiByteToWideChar(p.codepage, {MBToWCharFlags}0, PAnsiChar(PByte(p.bufferA)), {bytes:}p.size,
          PWideChar(p.bufferW), {chars:}p.size*2);
        {$IFDEF DEBUG}
        p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
        {$ENDIF}
        //iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
        iBufWBytes := WideCharToMultiByte(p.codepage, {WCharToMBFlags}0, PWideChar(p.bufferW), iLen, nil, 0, nil, nil);
      end;
    end;
  end;
  p.size := iLen;
  {$ENDIF MSWINDOWS}
  {$ENDIF !USE_TENCODING}
end; // procedure BufferDecoderUTF8
//
procedure BufferDecoderUTF16BE(var p: TEncoderData);
// Convertation from UTF16BE to unicode(UTF16LE):
{$IFNDEF USE_TENCODING}
var len: Integer; ps, pd: pwidechar;
{$ENDIF}
begin
  {$IFDEF USE_TENCODING}
  //dbg:  TEncoding.BigEndianUnicode.GetString(TBytes(p.bufferA), 0, p.size);
  //p.size := TEncodingAccess(TEncoding.BigEndianUnicode).GetCharsEx(PByte(p.bufferA), p.size, PChar(p.bufferW), p.size div 2);
  p.size := TEncoding.BigEndianUnicode.GetChars(PByte(p.bufferA), {bytes}p.size, PUnicodeChar(p.bufferW), {chars}p.size div 2);
  {$ELSE}
  p.size := p.size div 2;
  len := p.size;  ps := pwidechar(p.bufferA);  pd := pwidechar(p.bufferW);
  while len > 0 do begin
    pd^ := widechar( ((LongWord(ps^) shl 8) and $FF00) or ((LongWord(ps^) shr 8) and $00FF) );
    dec(len);  inc(ps);  inc(pd);
  end;
  {$ENDIF}
end; // procedure BufferDecoderUTF16BE
//
procedure BufferDecoderByCP(var p: TEncoderData);
// Convertation from ansi to unicode(UTF16LE):
{$IFDEF USE_TENCODING}
var iLen, iBufWBytes, iExtraBytes, iReadBytes: Integer;
{$ELSE !USE_TENCODING}
{$IFNDEF MSWINDOWS}
{$ELSE MSWINDOWS}
var iLen, iBufWBytes, iExtraBytes, iReadBytes: Integer;
{$ENDIF MSWINDOWS}
{$ENDIF !USE_TENCODING}
begin // dbg: pansichar(p.bufferA)
  {$IFDEF USE_TENCODING} // == BufferDecoderUTF8
  //--p.size := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PChar(p.bufferW), {chars:}p.size*2);
  iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
  //
  // Extra bytes: check and read:
  //
  if p.CharMaxByteCount > 1 then
  begin
    {$IFDEF DEBUG}
    p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
    {$ENDIF}
    iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
    if iBufWBytes <> p.size then
    begin
      iExtraBytes := 0;
      while (iBufWBytes <> p.size) and (iExtraBytes < p.CharMaxByteCount) do
      begin
        iReadBytes := p.stream.Read(p.bufferA[p.size], 1);
        if iReadBytes = 0 then
          break;
        inc(p.size);
        Inc(iExtraBytes);
        iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
        {$IFDEF DEBUG}
        p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
        {$ENDIF}
        iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
      end;
    end;
  end;
  p.size := iLen;
  {$ELSE !UNICODE}
  {$IFNDEF MSWINDOWS}// FPC, Kylix:
    //TODO: POSIX, UNIX

    //ERROR: 'platform not supported'

    //{.$MESSAGE FATAL 'PLATFORM NOT SUPPORTED'}
    //{$MESSAGE WARN 'TODO: Not supported charset convertion by codepage'}

// TODO: ... implement read extra bytes
//    {$MESSAGE FATAL 'TODO: BufferDecoderByCP - not implemented read extra bytes'}
    {$MESSAGE WARN 'TODO: BufferDecoderByCP - not implemented read extra bytes'}

// temporary:
BufferDecoderAnsi(p); // !!! it not correctly !!!
(*
SetMultiByteConversionCodePage(p.codepage); // windows only :(

  p.bufferA[p.size] := 0;
  p.bufferS := SOString(AnsiString(PAnsiChar(@p.bufferA[0]))); // excessive allocation of intermediate buffers
  p.size := length(p.bufferS);
  //move(p.bufferS[1], p.bufferw[0], p.size*SizeOf(SOChar));
  p.bufferWP := PSOChar(Pointer(p.bufferS)); // minimize memory copy/move

SetMultiByteConversionCodePage(SYS_ACP);         // windows only :(
//*)
  {$ELSE MSWINDOWS}
  p.bufferA[p.size] := 0;
  iLen := MultiByteToWideChar(p.codepage, 0, PAnsiChar(p.bufferA), p.size, nil, 0);
  if iLen = 0 then begin // RaiseLastOsError();
    p.size := 0;
    exit;
  end;
  if p.CharMaxByteCount > 1 then
    inc(iLen);
  if iLen > length(p.bufferW) then begin
    SetLength(p.bufferW, iLen);
    p.bufferWP := PSOChar(p.bufferW);
  end;
  //-p.size := MultiByteToWideChar(p.codepage, 0, PAnsiChar(p.bufferA), p.size, PWideChar(p.bufferW), iLen);
  //if p.size <= 0 then // RaiseLastOsError();
  //  exit;
  //iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
  iLen := MultiByteToWideChar(p.codepage, 0, PAnsiChar(p.bufferA), p.size, PWideChar(p.bufferW), iLen);
  //if iLen <= 0 then // RaiseLastOsError();
  //  exit;
  //
  // Extra bytes: check and read:
  //
  if p.CharMaxByteCount > 1 then
  begin
    {$IFDEF DEBUG}
    p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
    {$ENDIF}
    //iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
    iBufWBytes := WideCharToMultiByte(p.codepage, {WCharToMBFlags}0, PWideChar(p.bufferW), iLen, nil, 0, nil, nil);
    if iBufWBytes <> p.size then
    begin
      iExtraBytes := 0;
      while (iBufWBytes <> p.size) and (iExtraBytes < p.CharMaxByteCount) do
      begin
        iReadBytes := p.stream.Read(p.bufferA[p.size], 1);
        if iReadBytes = 0 then
          break;
        inc(p.size);
        Inc(iExtraBytes);
        //iLen := p.enc.GetChars(PByte(p.bufferA), {bytes:}p.size, PWideChar(p.bufferW), {chars:}p.size*2);
        iLen := MultiByteToWideChar(p.codepage, {MBToWCharFlags}0, PAnsiChar(PByte(p.bufferA)), {bytes:}p.size,
          PWideChar(p.bufferW), {chars:}p.size*2);
        {$IFDEF DEBUG}
        p.bufferW[iLen] := #0; // @dbg: for perfect debugging "PWideChar(p.bufferW)"
        {$ENDIF}
        //iBufWBytes := p.enc.GetByteCount(PWideChar(p.bufferW), iLen);
        iBufWBytes := WideCharToMultiByte(p.codepage, {WCharToMBFlags}0, PWideChar(p.bufferW), iLen, nil, 0, nil, nil);
      end;
    end;
  end;
  p.size := iLen;
  {$ENDIF MSWINDOWS}
  {$ENDIF !USE_TENCODING}
end; // procedure BufferDecoderByCP
//

function CalculateMaxCharSize(enc: TEncoding): Integer;
{$IFNDEF USE_TENCODING}{$IFDEF MSWINDOWS}
var
  ACPInfo: TCPInfo;
{$ENDIF}{$ENDIF}
begin
  case enc.CodePage of
    1200, 1201: Result := 2;                        // UTF-16LE, UTF-16BE
    12000, 12001: Result := 4;                      // UTF-32LE, UTF-32BE
    65000: Result := 6;                             // UTF-7
    65001: Result := 4;                             // UTF-8
    else begin
      {$IFDEF USE_TENCODING}
      //Result := enc.GetMaxByteCount(2)-enc.GetMaxByteCount(1);
      Result := enc.GetMaxByteCount(1);
      {$ELSE !USE_TENCODING}
      {$IFDEF MSWINDOWS}
      {$hints off} // FPC: Hint: Local variable "ACPInfo" does not seem to be initialized
      GetCPInfo(enc.CodePage, ACPInfo);
      {$hints off}
      Result := ACPInfo.MaxCharSize;
      {$ELSE !MSWINDOWS}
      case enc.CodePage of
        // Code page identifiers understood directly by iconv_open()
        154, 367, 437, 737, 775, 819, 850, 852,
        853, 855..858, 860..866, 869, 874, 922: Result := 1;
        932, 936, 943, 949, 950: Result := 2;
        1046, 1124, 1125, 1129, 1133, 1161, 1162, 1163, 1250..1258: Result := 1;
        1361: Result := 2;
        // Code page indentifiers translated to iconv_open() encoding names (by LocaleNameFromCodePage)
        10000, 10004..10007, 10010, 10017, 10021,
        10029, 10079, 10081, 10082: Result := 1;        // MacRoman .. MacCroatian
        //12000, 12001: Result := 4;                    // UTF-32LE, UTF-32BE
        20127, 20866: Result := 1;                      // ASCII, KOI8-R
        20932: Result := 3;                             // EUC-JP
        20936: Result := 2;                             // GB2312, EUC-KR
        21866, 28591..28601, 28603..28606: Result := 1; // KOI8-U, ISO-8859-1..ISO-8859-16
        50221: Result := 9;                             // ISO-2022-JP
        50225: Result := 7;                             // ISO-2022-KR
        50227: Result := 8;                             // ISO-2022-CN
        51932: Result := 3;                             // EUC-JP
        51936, 51949: Result := 2;                      // GB2312, EUC-KR
        51950, 52936, 54936: Result := 4;               // EUC-TW, HZ-GB-2312, GB18030
        //65000: Result := 6;                           // UTF-7
        //65001: Result := 4;                           // UTF-8
        else
          Result := 9;
      end; // case
      {$ENDIF !MSWINDOWS}
      {$ENDIF !USE_TENCODING}
    end; // else
  end; // case
end;

class function TSuperObject.ParseStream(stream: TStream; strict: Boolean;
  partial: boolean; const athis: ISuperObject; options: TSuperFindOptions;
  const put: ISuperObject; dt: TSuperType): ISuperObject;
begin
  Result := TSuperObject.ParseStream(stream, CP_UNKNOWN, strict, partial, athis, options, put, dt);
end;

class function TSuperObject.ParseStream(stream: TStream; ACodePage: Integer; strict: Boolean;
  partial: boolean; const athis: ISuperObject; options: TSuperFindOptions;
  const put: ISuperObject; dt: TSuperType): ISuperObject;
const
  BUFFER_SIZE = 4096;
var
  tok: TSuperTokenizer;
  p: TEncoderData;
  bom: TBom;
  j: Integer;
  {$IFDEF EXTEND_FORIN}
  o: TSuperObject;
  {$ENDIF}
  pBufferDecoder: TBufferDecoderProc;
  i, len, bomLen: integer;
  ok: boolean;
begin
//dbg('.ParseStream: 0');
  Result := nil;
  {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
  FillChar(p, SizeOf(p), 0); {$hints on}
  p.stream := stream;
  ok := true; // syntax status
  tok := TSuperTokenizer.Create;
  try
    SetLength(p.bufferA, BUFFER_SIZE+1+{MaxExtraBytes:}8); // + 1 for last char #0
    SetLength(p.bufferW, Length(p.bufferA)*({!}2{!}*SizeOf(WideChar))); // reserved for convertation from others charsets "buffreA"
    Pointer(p.bufferAP) := Pointer(p.bufferA); // Reference to raw buffer strean data
    p.bufferWP := PSOChar(p.bufferW);          // Reference to convertaion buffer

//dbg('.ParseStream: 1');
    pBufferDecoder := nil; // == cheUTF16BE
    SetLength({%H-}bom, 4+1);   // + for debug: pwidechar(bom)
    p.enc := DetectStreamEncoding(stream, bom, p.size, bomLen, p.codepage{$IFDEF USE_TENCODING}, p.encnew{$ENDIF}, ACodePage);
    if p.size = 0 then // Stream is empty
      Exit;
//dbg('.ParseStream: 2');

  (*{$IFDEF DEBUG}
  {$ifdef unicode}dbg('#,enc.class='+p.enc.classname);{$endif}
  dbg('#,enc.codepage='+inttostr(p.enc.codepage));
  dbg('#,codepa2ge='+inttostr(p.codepage));
  {$ENDIF}//*)

//TODO: UTF32
    if (bom[0] = 0) and (bom[1] = 0)  // like "UTF-32 ..."
      or ( (bomLen=4) and (bom[2] = 0) and (bom[3] = 0) ) then begin // dbg: pwidechar(bom)
      // ? when: ( (not p.enc.IsSingleByte) and (p.enc.GetMaxByteCount(0) > 2) )
      //if strict then
      raise ESuperObject.Create('JSON: do not support this stream codepage');
      Exit;
    end;
//dbg('.ParseStream: 3');

    len := (p.size-bomLen); // == Length of unread bom bytes

    if len > 0 then begin // Push unread bom bytes into "buffera" ( https://code.google.com/p/superobject/issues/detail?id=42 )
      j := 0;
      for i := bomLen to p.size-1 do begin
        p.bufferA[j] := bom[i];
        inc(j);
      end;
      p.buffera[j] := 0;
    end; // dbg: pwidechar(p.buffera); pansichar(p.buffera)

//dbg('.ParseStream: 4; p.codepage='+inttostr(p.codepage));
    case p.codepage of
      CP_UTF7, CP_UTF8: begin
          // UTF-7, UTF-8
          //p.CharMaxByteCount := 3; // p.enc.GetMaxByteCount(2)-p.enc.GetMaxByteCount(1);
          if p.codepage = CP_UTF7 then
            p.CharMaxByteCount := 6
          else
            p.CharMaxByteCount := 4;
          pBufferDecoder := TBufferDecoderProc(@BufferDecoderUTF8);
//TODO: switch to "BufferDecoderByCP":
          //pBufferDecoder := TBufferDecoderProc(@BufferDecoderByCP);
          //
          if (len > 0) and (len < p.CharMaxByteCount) then begin
            p.size := (p.CharMaxByteCount - len);
            p.size := stream.Read(p.bufferA[len], p.size);
            inc(len, p.size);
          end;
          //
          p.size := len;
          if p.size = 0 then
            p.size := stream.Read(p.bufferA[0], BUFFER_SIZE);
        end;
      CP_UTF16LE, CP_UTF16BE: begin
          // Unicode
          p.CharMaxByteCount := SizeOf(WideChar);
          if p.codepage = CP_UTF16BE then
            pBufferDecoder := TBufferDecoderProc(@BufferDecoderUTF16BE);
          //
          if (len > 0) and ( (len < p.CharMaxByteCount*2) or ((len mod p.CharMaxByteCount) <> 0) ) then begin
            p.size := (p.CharMaxByteCount*2 - len);
            if p.size < 0 then
              p.size := -p.size;
            p.size := stream.Read(p.bufferA[len], p.size);
            inc(len, p.size);
            //if (len mod SizeOf(WideChar)) > 0 then ERROR !!!
            p.size := (len div SizeOf(WideChar)) * SizeOf(WideChar); // For uncorrect stream (when las symbol is truncated)
          end;
          //
          if (p.size > 0) and (not Assigned(pBufferDecoder)) then begin
            move(p.bufferA[0], p.bufferW[0], p.size);
            len := p.size div SizeOf(WideChar);
          end;
          //
          p.size := len;
          if p.size = 0 then begin
            if Assigned(pBufferDecoder) then begin
              p.size := stream.Read(p.bufferA[0], BUFFER_SIZE);
            end else
              p.size := stream.Read(p.bufferW[0], BUFFER_SIZE * SizeOf(WideChar)) div SizeOf(WideChar);
          end;
        end;
      else begin
          if (p.codepage = CP_ANSI){$IFDEF MSWINDOWS}or (Longword(p.codepage) = SYS_ACP){$ENDIF} then // SYS_ACP == GetACP()
          begin
            p.CharMaxByteCount := 1;
            pBufferDecoder := TBufferDecoderProc(@BufferDecoderAnsi); // Ansi : p.enc.ANSI == TEncoding.ANSI
          end
          else begin
            p.CharMaxByteCount := CalculateMaxCharSize(p.enc);
            pBufferDecoder := TBufferDecoderProc(@BufferDecoderByCP);
            if (p.CharMaxByteCount > 1) and (len > 0) and (len < p.CharMaxByteCount) then begin
              p.size := (p.CharMaxByteCount - len);
              p.size := stream.Read(p.bufferA[len], p.size);
              inc(len, p.size);
            end;
          end;
          p.size := len;
          if p.size = 0 then
            p.size := stream.Read(p.bufferA[0], BUFFER_SIZE);
        end;
    end;
    {.$ENDIF !UNICODE}

//dbg('.ParseStream: 5; p.size='+inttostr(p.size));
//dbg('.ParseStream: loop: ----------');

    ok := false;
    while p.size > 0 do begin
//dbg('.ParseStream: 6; p.size='+inttostr(p.size));
      {+}
      if Assigned(pBufferDecoder) then begin
        pBufferDecoder(p{, @p});
        if p.size <= 0 then
          break; // ? ERROR  p.bufferWP[p.size] := #0;
      end;
      {+.}
//dbg('.ParseStream: 7; p.size='+inttostr(p.size));

      ParseEx(tok, p.bufferWP, p.size, strict, athis, options, put, dt);
{dbg('.ParseStream: 8; tok.err==continue='+inttostr(byte(tok.err = teContinue))
      +'; tok.err=teSuccess='+inttostr(byte(tok.err = teSuccess))
      +'; tok.char_offset='+inttostr(tok.char_offset)
      );{}

      if tok.err = teContinue then begin
        if Assigned(pBufferDecoder)
        then begin       // dbg: pwidechar(p.bufferA)
          p.size := stream.Read(p.bufferA[0], BUFFER_SIZE);
          p.bufferA[p.size] := 0;
//dbg('.ParseStream: 10; p.size='+inttostr(p.size));
        end else begin   // dbg: pwidechar(p.bufferW)
          p.size := stream.Read(p.bufferW[0], BUFFER_SIZE * SizeOf(WideChar)) div SizeOf(WideChar);
          p.bufferW[p.size] := #0;
//dbg('.ParseStream: 11; p.size='+inttostr(p.size));
        end;
      end
      else
        Break;
    end; // while
//dbg('.ParseStream: loop. ----------');

    {+} // https://code.google.com/p/superobject/issues/detail?id=33
    ok := not ( (tok.err <> teSuccess) or (not partial and (p.size <> tok.char_offset)) );
    {+.}
    if ok then
      Result := tok.stack[tok.depth].current;
  finally
    tok.Free;
    {$IFDEF USE_TENCODING}
    if p.encnew then
      p.enc.Free;
    {$ENDIF}
    if (not ok) {and strict} then
      {$warnings off}
      raise ESuperObject.Create('JSON Syntax error at offset: '+inttostr(tok.char_offset));
      {$warnings on}
    {$IFDEF EXTEND_FORIN} // TODO: "pult": need check any combination
    // Always return value !
    // Allow next code (without nil checking):
    // ----- ----- ----- sample : ----- ----- -----
    //   for item in (TSuperObject.ParseFile('empty-file.json', true, true) as ISuperObject)['stroka'] do ...
    // ----- ----- ----- sample : ----- ----- -----
    if (Result = nil) and SafeForInDefault then begin
      //Result := SO('{}');
      o := TSuperObject.Create(stObject);
      o.FJsonIsEmpty := True;
      Result := o;
    end;
    {$ENDIF}
  end;
{+.}
end;

class function TSuperObject.ParseFile(const FileName: string; strict: Boolean;
  partial: boolean; const athis: ISuperObject; options: TSuperFindOptions;
  const put: ISuperObject; dt: TSuperType): ISuperObject;
begin
  Result := TSuperObject.ParseFile(FileName, CP_UNKNOWN, strict, partial, athis, options, put, dt);
end;

class function TSuperObject.ParseFile(const FileName: string; ACodePage: Integer; strict: Boolean;
  partial: boolean; const athis: ISuperObject; options: TSuperFindOptions;
  const put: ISuperObject; dt: TSuperType): ISuperObject;
var
  stream: TFileStream;
begin
  {$warnings off} // FPC: Warning: Implicit string type conversion with potential data loss from "UnicodeString" to "AnsiString"
  stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  {$warnings on}
  try
    Result := ParseStream(stream, ACodePage, strict, partial, athis, options, put, dt);
  finally
    stream.Free;
  end;
end;

class function TSuperObject.ParseEx(tok: TSuperTokenizer; str: PSOChar; len: integer;
  strict: Boolean; const athis: ISuperObject; options: TSuperFindOptions; const put: ISuperObject; dt: TSuperType): ISuperObject;
{+}
{$IFNDEF NEXTGEN}
const
  spaces = [#32,#8,#9,#10,#12,#13];
  {%H-}delimiters = ['"', '.', '[', ']', '{', '}', '(', ')', ',', ':', #0];
  {$IFDEF FPC}
  //reserved = delimiters + spaces; // FPC: Error: Illegal expression
  reserved = [
    // delimiters:
    '"', '.', '[', ']', '{', '}', '(', ')', ',', ':', #0,
    // spaces:
    #32,#8,#9,#10,#12,#13
  ];
  {$ELSE !FPC}
  reserved = delimiters + spaces;
  {$ENDIF !FPC}
  path = ['a'..'z', 'A'..'Z', '.', '_'];
  //
  super_number_chars_set = ['0'..'9','.','+','-','e','E'];
  super_hex_chars_set = ['0'..'9','a'..'f','A'..'F'];

(*const
  {+}
  {$IFNDEF NEXTGEN}
  super_number_chars_set = ['0'..'9','.','+','-','e','E'];
  {$ELSE}
  //super_number_chars_set: array[0..14] of Char = ('0','1','2','3','4','5','6','7','8','9','.','+','-','e','E');
  super_number_chars_set = '0123456789.+-eE';
  {$ENDIF}
  {+.}
  super_hex_chars: PSOChar = '0123456789abcdef';
  {+}
  {$IFNDEF NEXTGEN}
  super_hex_chars_set = ['0'..'9','a'..'f','A'..'F'];
  {$ENDIF}
  {+.}//*)

{$ELSE NEXTGEN}
//const
//  spaces = #32#8#9#10#12#13;
//  delimiters = '".[]{}(),:'#0;
//  super_number_chars_set = '0123456789.+-eE';
  //
  function IsCharInSpaces(x: Char): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin
    //if Ord(x) < 256 then
    case x of
      #32,#8,#9,#10,#12,#13:
        Exit(True);
    end;
    Result := False;
  end;
  function IsCharInDelimiters(x: Char): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin
    //if Ord(x) < 256 then
    case x of
      '"', '.', '[', ']', '{', '}', '(', ')', ',', ':', #0:
        Exit(True);
    end;
    Result := False;
  end;
  function IsCharInSuperNumber(x: Char): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin
    //if Ord(x) < 256 then
    case x of
      '0','1','2','3','4','5','6','7','8','9','.','+','-','e','E':
        Exit(True);
    end;
    Result := False;
  end;
{$ENDIF NEXTGEN}
{+.}

  function hexdigit(x: SOChar): byte; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin
    if x <= '9' then
      Result := byte(x) - byte('0') else
      Result := (byte(x) and 7) + 9;
  end;

  function min(v1, v2: integer): integer;{$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin if v1 < v2 then result := v1 else result := v2 end;

var
  obj: ISuperObject;
  v: SOChar;
{$IFDEF SUPER_METHOD}
  sm: TSuperMethod;
{$ENDIF}
  numi: SuperInt;
  numd: Double;
  code: integer;
  TokRec: PSuperTokenerSrec;
  evalstack: integer;
  p: PSOChar;

  function IsEndDelimiter(v: {+}SOChar{+}): Boolean;
  begin
    if tok.depth > 0 then
      case tok.stack[tok.depth - 1].state of
        tsArrayAdd:
          {+}
          {$IFDEF NEXTGEN}
          Result := (v=',') or (v=']') or (v=#0);
          {$ELSE}
          Result := CharInSet(v, [',', ']', #0]);
          {$ENDIF}
        tsObjectValueAdd:
          {$IFDEF NEXTGEN}
          Result := (v=',') or (v='}') or (v=#0);
          {$ELSE}
          Result := CharInSet(v, [',', '}', #0]);
          {$ENDIF}
          {+.}
      else
        Result := v = #0;
      end else
        Result := v = #0;
  end;

label
  out, redo_char;

begin
  Result := nil;
  {+}  // D7..2006..2007
  {$IFNDEF FPC}{$IFNDEF UNICODE}{$IF (CompilerVersion > 15.00) and (CompilerVersion <= 18.50)}
  if Assigned(Result) then
  asm
    mov Result, 0 // remove compiler warning (old dcc32 ansi version)
  end;
  {$IFEND}{$ENDIF}{$ENDIF}
  {+.}//*)

  evalstack := 0;
  obj := nil;
  TokRec := @tok.stack[tok.depth];

  tok.char_offset := 0;
  tok.err := teSuccess;

  repeat
    if (tok.char_offset = len) then
    begin
      if (tok.depth = 0) and (TokRec^.state = tsEatws) and
         (TokRec^.saved_state = tsFinish)
      then tok.err := teSuccess
      else tok.err := teContinue;
      goto out;
    end;

    v := str^;

    case v of
    #10:
      begin
        inc(tok.line);
        tok.col := 0;
      end;
    #9: inc(tok.col, 4);
    else
      begin
        inc(tok.col);
      end;
    end; // case

redo_char:
    case TokRec^.state of
    tsEatws:
      begin
        if (SOIChar(v) < 256) and {+}
          {$IFDEF NEXTGEN}
          //IsCharInStr(v, spaces)
          IsCharInSpaces(v)
          {$ELSE}
          (AnsiChar(v) in spaces)
          {$ENDIF !NEXTGEN}
          {+.}
        then
          {nop}
        else if (v = '/') then
        begin
          tok.pb.Reset;
          tok.pb.Append(@v, 1);
          TokRec^.state := tsCommentStart;
        end else begin
          TokRec^.state := TokRec^.saved_state;
          goto redo_char;
        end
      end; // tsEatws

    tsStart:
      begin
        case v of
        '"',
        '''':
          begin
            TokRec^.state := tsString;
            tok.pb.Reset;
            tok.quote_char := v;
          end;
        '-':
          begin
            TokRec^.state := tsNumber;
            tok.pb.Reset;
            tok.is_double := 0;
            tok.floatcount := -1;
            goto redo_char;
          end;

        '0'..'9':
          begin
            if (tok.depth = 0) then begin
              {%H-}case ObjectGetType(athis) of
              stObject:
                begin
                  TokRec^.state := tsIdentifier;
                  TokRec^.current := athis;
                  goto redo_char;
                end;
              end;
            end;
            TokRec^.state := tsNumber;
            tok.pb.Reset;
            tok.is_double := 0;
            tok.floatcount := -1;
            goto redo_char;
          end;
        '{':
          begin
            TokRec^.state := tsEatws;
            TokRec^.saved_state := tsObjectFieldStart;
            TokRec^.current := TSuperObject.Create(stObject);
          end;
        '[':
          begin
            TokRec^.state := tsEatws;
            TokRec^.saved_state := tsArray;
            TokRec^.current := TSuperObject.Create(stArray);
          end;
        {$IFDEF SUPER_METHOD}
        '(':
          begin
            if (tok.depth = 0) and ObjectIsType(athis, stMethod) then
            begin
              TokRec^.current := athis;
              TokRec^.state := tsParamValue;
            end;
          end;
        {$ENDIF SUPER_METHOD}
        'N',
        'n':
          begin
            TokRec^.state := tsNull;
            tok.pb.Reset;
            tok.st_pos := 0;
            goto redo_char;
          end;
        'T',
        't',
        'F',
        'f':
          begin
            TokRec^.state := tsBoolean;
            tok.pb.Reset;
            tok.st_pos := 0;
            goto redo_char;
          end;
        else
          begin
            TokRec^.state := tsIdentifier;
            tok.pb.Reset;
            goto redo_char;
          end;
        end; // case
      end; // tsStart

    tsFinish:
      begin
        if(tok.depth = 0) then goto out;
        obj := TokRec^.current;
        tok.ResetLevel(tok.depth);
        dec(tok.depth);
        TokRec := @tok.stack[tok.depth];
        goto redo_char;
      end;

    tsNull:
      begin
        tok.pb.Append(@v, 1);
        if (StrLComp(TOK_NULL, PSOChar(tok.pb.FBuf), min(tok.st_pos + 1, 4)) = 0) then
        begin
          if (tok.st_pos = 4) then
          if (((SOIChar(v) < 256) and {+} // path = ['a'..'z', 'A'..'Z', '.', '_']
            {$IFDEF NEXTGEN}
            (IsCharInDiapasone(v, 'a','z') or IsCharInDiapasone(v, 'A','Z') or (v='.') or (v='_'))
            {$ELSE}
            (AnsiChar(v) in path)
            {$ENDIF !NEXTGEN}
            ){+.} or (SOIChar(v) >= 256)) then
            TokRec^.state := tsIdentifier else
          begin
            TokRec^.current := TSuperObject.Create(stNull);
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
            goto redo_char;
          end;
        end else
        begin
          TokRec^.state := tsIdentifier;
          tok.pb.FBuf[tok.st_pos] := #0;
          dec(tok.pb.FBPos);
          goto redo_char;
        end;
        inc(tok.st_pos);
      end; // tsNull

    tsCommentStart:
      begin
        if(v = '*') then
        begin
          TokRec^.state := tsComment;
        end else
        if (v = '/') then
        begin
          TokRec^.state := tsCommentEol;
        end else
        begin
          tok.err := teParseComment;
          goto out;
        end;
        tok.pb.Append(@v, 1);
      end;

    tsComment:
      begin
        if(v = '*') then
          TokRec^.state := tsCommentEnd;
        tok.pb.Append(@v, 1);
      end;

    tsCommentEol:
      begin
        if (v = #10) then
          TokRec^.state := tsEatws else
          tok.pb.Append(@v, 1);
      end;

    tsCommentEnd:
      begin
        tok.pb.Append(@v, 1);
        if (v = '/') then
          TokRec^.state := tsEatws else
          TokRec^.state := tsComment;
      end;

    tsString:
      begin
        if (v = tok.quote_char) then
        begin
          TokRec^.current := TSuperObject.Create(SOString(tok.pb.GetString));
          TokRec^.saved_state := tsFinish;
          TokRec^.state := tsEatws;
        end else
        if (v = '\') then
        begin
          TokRec^.saved_state := tsString;
          TokRec^.state := tsStringEscape;
        end else
        begin
          tok.pb.Append(@v, 1);
        end
      end;

    tsEvalProperty:
      begin
        if (TokRec^.current = nil) and (foCreatePath in options) then
        begin
          TokRec^.current := TSuperObject.Create(stObject);
          TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, TokRec^.current)
        end else
        if not ObjectIsType(TokRec^.current, stObject) then
        begin
          tok.err := teEvalObject;
          goto out;
        end;
        tok.pb.Reset;
        TokRec^.state := tsIdentifier;
        goto redo_char;
      end;

    tsEvalArray:
      begin
        if (TokRec^.current = nil) and (foCreatePath in options) then
        begin
          TokRec^.current := TSuperObject.Create(stArray);
          TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, TokRec^.current)
        end else
        if not ObjectIsType(TokRec^.current, stArray) then
        begin
          tok.err := teEvalArray;
          goto out;
        end;
        tok.pb.Reset;
        TokRec^.state := tsParamValue;
        goto redo_char;
      end;

    {$IFDEF SUPER_METHOD}
    tsEvalMethod:
      begin
        if ObjectIsType(TokRec^.current, stMethod) and assigned(TokRec^.current.AsMethod) then
        begin
          tok.pb.Reset;
          TokRec^.obj := TSuperObject.Create(stArray);
          TokRec^.state := tsMethodValue;
          goto redo_char;
        end else
        begin
          tok.err := teEvalMethod;
          goto out;
        end;
      end;

    tsMethodValue:
      begin
        case v of
        ')':
            TokRec^.state := tsIdentifier;
        else
          begin
            if (tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) then
            begin
              tok.err := teDepth;
              goto out;
            end;
            inc(evalstack);
            TokRec^.state := tsMethodPut;
            inc(tok.depth);
            tok.ResetLevel(tok.depth);
            TokRec := @tok.stack[tok.depth];
            goto redo_char;
          end;
        end; // case
      end; // tsMethodValue

    tsMethodPut:
      begin
        TokRec^.obj.AsArray.Add(obj);
        case v of
          ',':
            begin
              tok.pb.Reset;
              TokRec^.saved_state := tsMethodValue;
              TokRec^.state := tsEatws;
            end;
          ')':
            begin
              if TokRec^.obj.AsArray.Length = 1 then
                TokRec^.obj := TokRec^.obj.AsArray.GetO(0);
              dec(evalstack);
              tok.pb.Reset;
              TokRec^.saved_state := tsIdentifier;
              TokRec^.state := tsEatws;
            end;
          else
            begin
              tok.err := teEvalMethod;
              goto out;
            end;
        end;
      end; // tsMethodPut
    {$ENDIF SUPER_METHOD}

    tsParamValue:
      begin
        case v of
        ']':
            TokRec^.state := tsIdentifier;
        else
          begin
            if (tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) then
            begin
              tok.err := teDepth;
              goto out;
            end;
            inc(evalstack);
            TokRec^.state := tsParamPut;
            inc(tok.depth);
            tok.ResetLevel(tok.depth);
            TokRec := @tok.stack[tok.depth];
            goto redo_char;
          end;
        end; // case
      end; // tsParamValue

    tsParamPut:
      begin
        dec(evalstack);
        TokRec^.obj := obj;
        tok.pb.Reset;
        TokRec^.saved_state := tsIdentifier;
        TokRec^.state := tsEatws;
        if v <> ']' then
        begin
          tok.err := teEvalArray;
          goto out;
        end;
      end;

    tsIdentifier:
      begin
        if (athis = nil) then
        begin
          if (SOIChar(v) < 256) and IsEndDelimiter({+}v{+.}) then
          begin
            if not strict then
            begin
              tok.pb.TrimRight;
              TokRec^.current := TSuperObject.Create(tok.pb.Fbuf);
              TokRec^.saved_state := tsFinish;
              TokRec^.state := tsEatws;
              goto redo_char;
            end else
            begin
              tok.err := teParseString;
              goto out;
            end;
          end else
          if (v = '\') then
          begin
            TokRec^.saved_state := tsIdentifier;
            TokRec^.state := tsStringEscape;
          end else begin
            tok.pb.Append(@v, 1);
          end;
        end else { "when "athis<>nil" }
        begin
         if (SOIChar(v) < 256) and
           {+}
           {$IFDEF NEXTGEN} // reserved = delimiters + spaces
           //(IsCharInStr(v, delimiters) or IsCharInStr(v, spaces))
           (IsCharInDelimiters(v) or IsCharInSpaces(v))
           {$ELSE}
           (AnsiChar(v) in reserved)
           {$ENDIF !NEXTGEN}
           {+.} then
         begin
           TokRec^.gparent := TokRec^.parent;
           if TokRec^.current = nil then
             TokRec^.parent := athis else
             TokRec^.parent := TokRec^.current;

             {%H-}case ObjectGetType(TokRec^.parent) of
               stObject:
                 begin
                   case v of
                     '.':
                       begin
                         TokRec^.state := tsEvalProperty;
                         if tok.pb.FBPos > 0 then
                           TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                       end;
                     '[':
                       begin
                         TokRec^.state := tsEvalArray;
                         if tok.pb.FBPos > 0 then
                           TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                       end;
                     '(':
                       begin
                         TokRec^.state := tsEvalMethod;
                         if tok.pb.FBPos > 0 then
                           TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                       end;
                     else
                       begin
                         if tok.pb.FBPos > 0 then
                           TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                         if (foPutValue in options) and (evalstack = 0) then
                         begin
                           TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, put);
                           TokRec^.current := put;
                         end else
                         if (foDelete in options) and (evalstack = 0) then
                         begin
                           TokRec^.current := TokRec^.parent.AsObject.Delete(tok.pb.Fbuf);
                         end else
                         if (TokRec^.current = nil) and (foCreatePath in options) then
                         begin
                           TokRec^.current := TSuperObject.Create(dt);
                           TokRec^.parent.AsObject.PutO(tok.pb.Fbuf, TokRec^.current);
                         end;
                         if not (foDelete in options) then
                           TokRec^.current := TokRec^.parent.AsObject.GetO(tok.pb.Fbuf);
                         TokRec^.state := tsFinish;
                         goto redo_char;
                       end;
                   end; // case
                 end; // stObject
               stArray:
                 begin
                   if TokRec^.obj <> nil then
                   begin
                     if not ObjectIsType(TokRec^.obj, stInt) or (TokRec^.obj.AsInteger < 0) then
                     begin
                       tok.err := teEvalInt;
                       TokRec^.obj := nil;
                       goto out;
                     end;
                     numi := TokRec^.obj.AsInteger;
                     TokRec^.obj := nil;

                     TokRec^.current := TokRec^.parent.AsArray.GetO(numi);
                     case v of
                       '.':
                         if (TokRec^.current = nil) and (foCreatePath in options) then
                         begin
                           TokRec^.current := TSuperObject.Create(stObject);
                           TokRec^.parent.AsArray.PutO(numi, TokRec^.current);
                         end else
                         if (TokRec^.current = nil) then
                         begin
                           tok.err := teEvalObject;
                           goto out;
                         end;
                       '[':
                         begin
                           if (TokRec^.current = nil) and (foCreatePath in options) then
                           begin
                             TokRec^.current := TSuperObject.Create(stArray);
                             TokRec^.parent.AsArray.Add(TokRec^.current);
                           end else
                           if (TokRec^.current = nil) then
                           begin
                             tok.err := teEvalArray;
                             goto out;
                           end;
                           TokRec^.state := tsEvalArray;
                         end;
                       '(': TokRec^.state := tsEvalMethod;
                       else
                         begin
                           if (foPutValue in options) and (evalstack = 0) then
                           begin
                             TokRec^.parent.AsArray.PutO(numi, put);
                             TokRec^.current := put;
                           end else
                           if (foDelete in options) and (evalstack = 0) then
                           begin
                             TokRec^.current := TokRec^.parent.AsArray.Delete(numi);
                           end else
                             TokRec^.current := TokRec^.parent.AsArray.GetO(numi);
                           TokRec^.state := tsFinish;
                           goto redo_char
                         end;
                     end; // case
                   end else
                   begin
                     case v of
                       '.':
                         begin
                           if (foPutValue in options) then
                           begin
                             TokRec^.current := TSuperObject.Create(stObject);
                             TokRec^.parent.AsArray.Add(TokRec^.current);
                           end else
                             TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.Length - 1);
                         end;
                       '[':
                         begin
                           if (foPutValue in options) then
                           begin
                             TokRec^.current := TSuperObject.Create(stArray);
                             TokRec^.parent.AsArray.Add(TokRec^.current);
                           end else
                             TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.Length - 1);
                           TokRec^.state := tsEvalArray;
                         end;
                       '(':
                         begin
                           if not (foPutValue in options) then
                             TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.Length - 1) else
                             TokRec^.current := nil;

                           TokRec^.state := tsEvalMethod;
                         end;
                       else
                         begin
                           if (foPutValue in options) and (evalstack = 0) then
                           begin
                             TokRec^.parent.AsArray.Add(put);
                             TokRec^.current := put;
                           end else
                             if tok.pb.FBPos = 0 then
                               TokRec^.current := TokRec^.parent.AsArray.GetO(TokRec^.parent.AsArray.Length - 1);
                           TokRec^.state := tsFinish;
                           goto redo_char
                         end;
                     end; // case
                   end; // if
                 end; // stArray
               {$IFDEF SUPER_METHOD}
               stMethod:
                 case v of
                   '.':
                     begin
                       TokRec^.current := nil;
                       sm := TokRec^.parent.AsMethod;
                       sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                       TokRec^.obj := nil;
                     end;
                   '[':
                     begin
                       TokRec^.current := nil;
                       sm := TokRec^.parent.AsMethod;
                       sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                       TokRec^.state := tsEvalArray;
                       TokRec^.obj := nil;
                     end;
                   '(':
                     begin
                       TokRec^.current := nil;
                       sm := TokRec^.parent.AsMethod;
                       sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                       TokRec^.state := tsEvalMethod;
                       TokRec^.obj := nil;
                     end;
                   else
                   begin
                     if not (foPutValue in options) or (evalstack > 0) then
                     begin
                       TokRec^.current := nil;
                       sm := TokRec^.parent.AsMethod;
                       sm(TokRec^.gparent, TokRec^.obj, TokRec^.current);
                       TokRec^.obj := nil;
                       TokRec^.state := tsFinish;
                       goto redo_char
                     end else
                     begin
                       tok.err := teEvalMethod;
                       TokRec^.obj := nil;
                       goto out;
                     end;
                   end;
                 end; // stMethod
               {$ENDIF SUPER_METHOD}
             end; // case
          end else begin
            tok.pb.Append(@v, 1);
          end;
        end; //  if .. "when "athis<>nil"
      end; // tsIdentifier

    tsStringEscape:
      case v of
      'b',
      'n',
      'r',
      't',
      'f':
        begin
          if(v = 'b') then tok.pb.Append(TOK_BS, 1)
          else if(v = 'n') then tok.pb.Append(TOK_LF, 1)
          else if(v = 'r') then tok.pb.Append(TOK_CR, 1)
          else if(v = 't') then tok.pb.Append(TOK_TAB, 1)
          else if(v = 'f') then tok.pb.Append(TOK_FF, 1);
          TokRec^.state := TokRec^.saved_state;
        end;
      'u':
        begin
          tok.ucs_char := 0;
          tok.st_pos := 0;
          TokRec^.state := tsEscapeUnicode;
        end;
      'x':
        begin
          tok.ucs_char := 0;
          tok.st_pos := 0;
          TokRec^.state := tsEscapeHexadecimal;
        end
      else
        tok.pb.Append(@v, 1);
        TokRec^.state := TokRec^.saved_state;
      end; // tsStringEscape

    tsEscapeUnicode:
      begin
        if ((SOIChar(v) < 256) and {+}
           {$IFDEF NEXTGEN} // super_hex_chars_set = ['0'..'9','a'..'f','A'..'F']
           (IsCharInDiapasone(v,'0','9') or IsCharInDiapasone(v,'a','f') or IsCharInDiapasone(v,'A','F'))
           {$ELSE}
           (AnsiChar(v) in super_hex_chars_set)
           {$ENDIF !NEXTGEN}) {+.} then
        begin
          inc(tok.ucs_char, (Word(hexdigit(v)) shl ((3-tok.st_pos)*4)));
          inc(tok.st_pos);
          if (tok.st_pos = 4) then
          begin
            tok.pb.Append(PSOChar(@tok.ucs_char), 1); // {+} compatible with $T+ {+.}
            TokRec^.state := TokRec^.saved_state;
          end
        end else
        begin
          tok.err := teParseString;
          goto out;
        end
      end; // tsEscapeUnicode

    tsEscapeHexadecimal:
      begin
        if ((SOIChar(v) < 256) and {+}
           {$IFDEF NEXTGEN} // super_hex_chars_set = ['0'..'9','a'..'f','A'..'F']
           (IsCharInDiapasone(v,'0','9') or IsCharInDiapasone(v,'a','f') or IsCharInDiapasone(v,'A','F'))
           {$ELSE}
           (AnsiChar(v) in super_hex_chars_set)
           {$ENDIF !NEXTGEN}) {+.} then
        begin
          inc(tok.ucs_char, (Word(hexdigit(v)) shl ((1-tok.st_pos)*4)));
          inc(tok.st_pos);
          if (tok.st_pos = 2) then
          begin
            tok.pb.Append(PSOChar(@tok.ucs_char), 1); // {+} compatible with $T+ {+.}
            TokRec^.state := TokRec^.saved_state;
          end
        end else
        begin
          tok.err := teParseString;
          goto out;
        end
      end; // tsEscapeHexadecimal

    tsBoolean:
      begin
        tok.pb.Append(@v, 1);
        if (StrLComp('true', PSOChar(tok.pb.FBuf), min(tok.st_pos + 1, 4)) = 0) then
        begin
          if (tok.st_pos = 4) then
          if (((SOIChar(v) < 256) and {+} // path = ['a'..'z', 'A'..'Z', '.', '_']
            {$IFDEF NEXTGEN}
            (IsCharInDiapasone(v, 'a','z') or IsCharInDiapasone(v, 'A','Z') or (v='.') or (v='_'))
            {$ELSE}
            (AnsiChar(v) in path)
            {$ENDIF !NEXTGEN}
            ){+.} or (SOIChar(v) >= 256)) then
            TokRec^.state := tsIdentifier else
          begin
            TokRec^.current := TSuperObject.Create(true);
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
            goto redo_char;
          end
        end else
        if (StrLComp('false', PSOChar(tok.pb.FBuf), min(tok.st_pos + 1, 5)) = 0) then
        begin
          if (tok.st_pos = 5) then
          if (((SOIChar(v) < 256) and {+} // path = ['a'..'z', 'A'..'Z', '.', '_']
            {$IFDEF NEXTGEN}
            (IsCharInDiapasone(v, 'a','z') or IsCharInDiapasone(v, 'A','Z') or (v='.') or (v='_'))
            {$ELSE}
            (AnsiChar(v) in path)
            {$ENDIF !NEXTGEN}
            ){+.} or (SOIChar(v) >= 256)) then
            TokRec^.state := tsIdentifier else
          begin
            TokRec^.current := TSuperObject.Create(false);
            TokRec^.saved_state := tsFinish;
            TokRec^.state := tsEatws;
            goto redo_char;
          end
        end else
        begin
          TokRec^.state := tsIdentifier;
          tok.pb.FBuf[tok.st_pos] := #0;
          dec(tok.pb.FBPos);
          goto redo_char;
        end;
        inc(tok.st_pos);
      end; // tsBoolean

    tsNumber:
      begin
        if (SOIChar(v) < 256) and {+}
           {$IFDEF NEXTGEN}
           //IsCharInStr(v, super_number_chars_set)
           IsCharInSuperNumber(v)
           {$ELSE}
           (AnsiChar(v) in super_number_chars_set)
           {$ENDIF !NEXTGEN}
           {+.} then
        begin
          tok.pb.Append(@v, 1);
          if (SOIChar(v) < 256) then
          case v of
          '.': begin
                 tok.is_double := 1;
                 tok.floatcount := 0;
               end;
          'e','E':
            begin
              tok.is_double := 1;
              tok.floatcount := -1;
            end;
          '0'..'9':
            begin

              if (tok.is_double = 1) and (tok.floatcount >= 0) then
              begin
                inc(tok.floatcount);
                if tok.floatcount > 4 then
                  tok.floatcount := -1;
              end;
            end;
          end;
        end else
        begin
          if (tok.is_double = 0) then
          begin
            val(tok.pb.FBuf, numi, code);
            if ObjectIsType(athis, stArray) then
            begin
              if (foPutValue in options) and (evalstack = 0) then
              begin
                athis.AsArray.PutO(numi, put);
                TokRec^.current := put;
              end else
              if (foDelete in options) and (evalstack = 0) then
                TokRec^.current := athis.AsArray.Delete(numi) else
                TokRec^.current := athis.AsArray.GetO(numi);
            end else begin
              {+} // pult: 2020.1217.0757
              if (code > 0) then begin
                TokRec^.state := tsString;
                goto redo_char;
              end else
              {+.}
              TokRec^.current := TSuperObject.Create(numi);
            end;

          end else
          if (tok.is_double <> 0) then
          begin
            if tok.floatcount >= 0 then
            begin
              p := tok.pb.FBuf;
              while p^ <> '.' do inc(p);
              for code := 0 to tok.floatcount - 1 do
              begin
                p^ := p[1];
                inc(p);
              end;
              p^ := #0;
              val(tok.pb.FBuf, numi, code);
              {+} // pult: 2020.1217.0757
              if (code > 0) then begin
                TokRec^.state := tsString;
                goto redo_char;
              end;
              {+.}
              case tok.floatcount of
                0: numi := numi * 10000;
                1: numi := numi * 1000;
                2: numi := numi * 100;
                3: numi := numi * 10;
              end;
              TokRec^.current := TSuperObject.CreateCurrency(PCurrency(@numi)^);
            end else
            begin
              val(tok.pb.FBuf, numd, code);
              {+} // pult: 2020.1217.0757
              if (code > 0) then begin
                TokRec^.state := tsString;
                goto redo_char;
              end else
              {+.}
              TokRec^.current := TSuperObject.Create(numd);
            end;
          end else
          begin
            tok.err := teParseNumber;
            goto out;
          end;
          TokRec^.saved_state := tsFinish;
          TokRec^.state := tsEatws;
          goto redo_char;
        end
      end; // tsNumber

    tsArray:
      begin
        if (v = ']') then
        begin
          TokRec^.saved_state := tsFinish;
          TokRec^.state := tsEatws;
        end else
        begin
          if(tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) then
          begin
            tok.err := teDepth;
            goto out;
          end;
          TokRec^.state := tsArrayAdd;
          inc(tok.depth);
          tok.ResetLevel(tok.depth);
          TokRec := @tok.stack[tok.depth];
          goto redo_char;
        end
      end;

    tsArrayAdd:
      begin
        TokRec^.current.AsArray.Add(obj);
        TokRec^.saved_state := tsArraySep;
        TokRec^.state := tsEatws;
        goto redo_char;
      end;

    tsArraySep:
      begin
        if (v = ']') then
        begin
          TokRec^.saved_state := tsFinish;
          TokRec^.state := tsEatws;
        end else
        if (v = ',') then
        begin
          TokRec^.saved_state := tsArray;
          TokRec^.state := tsEatws;
        end else
        begin
          tok.err := teParseArray;
          goto out;
        end
      end;

    tsObjectFieldStart:
      begin
        if (v = '}') then
        begin
          TokRec^.saved_state := tsFinish;
          TokRec^.state := tsEatws;
        end else
        if (SOIChar(v) < 256) and {+} {$IFDEF NEXTGEN}
          ((v = '"') or (v = ''''))
          {$ELSE}
          CharInSet(v, ['"', ''''])
          {$ENDIF !NEXTGEN}{+.} then
        begin
          tok.quote_char := v;
          tok.pb.Reset;
          TokRec^.state := tsObjectField;
        end else
        if not((SOIChar(v) < 256) and (strict or {+}
          {$IFDEF NEXTGEN} // reserved = delimiters + spaces
          //(IsCharInStr(v, delimiters) or IsCharInStr(v, spaces))
          (IsCharInDelimiters(v) or IsCharInSpaces(v))
          {$ELSE}
          (AnsiChar(v) in reserved)
          {$ENDIF !NEXTGEN}{+.} ) ) then
        begin
          TokRec^.state := tsObjectUnquotedField;
          tok.pb.Reset;
          goto redo_char;
        end else
        begin
          tok.err := teParseObjectKeyName;
          goto out;
        end
      end; // tsObjectFieldStart

    tsObjectField:
      begin
        if (v = tok.quote_char) then
        begin
          TokRec^.field_name := tok.pb.FBuf;
          TokRec^.saved_state := tsObjectFieldEnd;
          TokRec^.state := tsEatws;
        end else
        if (v = '\') then
        begin
          TokRec^.saved_state := tsObjectField;
          TokRec^.state := tsStringEscape;
        end else
        begin
          tok.pb.Append(@v, 1);
        end
      end;

    tsObjectUnquotedField:
      begin
        if (SOIChar(v) < 256) and {+} {$IFDEF NEXTGEN}
          ((v = ':') or (v = #0))
          {$ELSE}
          CharInSet(v, [':', #0])
          {$ENDIF !NEXTGEN}{+.} then
        begin
          TokRec^.field_name := tok.pb.FBuf;
          TokRec^.saved_state := tsObjectFieldEnd;
          TokRec^.state := tsEatws;
          goto redo_char;
        end else
        if (v = '\') then
        begin
          TokRec^.saved_state := tsObjectUnquotedField;
          TokRec^.state := tsStringEscape;
        end else
          tok.pb.Append(@v, 1);
      end;

    tsObjectFieldEnd:
      begin
        if (v = ':') then
        begin
          TokRec^.saved_state := tsObjectValue;
          TokRec^.state := tsEatws;
        end else
        begin
          tok.err := teParseObjectKeySep;
          goto out;
        end
      end;

    tsObjectValue:
      begin
        if (tok.depth >= SUPER_TOKENER_MAX_DEPTH-1) then
        begin
          tok.err := teDepth;
          goto out;
        end;
        TokRec^.state := tsObjectValueAdd;
        inc(tok.depth);
        tok.ResetLevel(tok.depth);
        TokRec := @tok.stack[tok.depth];
        goto redo_char;
      end;

    tsObjectValueAdd:
      begin
        TokRec^.current.AsObject.PutO(TokRec^.field_name, obj);
        TokRec^.field_name := '';
        TokRec^.saved_state := tsObjectSep;
        TokRec^.state := tsEatws;
        goto redo_char;
      end;

    tsObjectSep:
      begin
        if (v = '}') then
        begin
          TokRec^.saved_state := tsFinish;
          TokRec^.state := tsEatws;
        end else
        if (v = ',') then
        begin
          TokRec^.saved_state := tsObjectFieldStart;
          TokRec^.state := tsEatws;
        end else
        begin
          tok.err := teParseObjectValueSep;
          goto out;
        end
      end; // tsObjectSep
    end; // case TokRec^.state

    inc(str);
    inc(tok.char_offset);
  until v = #0;

  if(TokRec^.state <> tsFinish) and
     (TokRec^.saved_state <> tsFinish) then
   begin
    tok.err := teParseEof;
   end;

out:
  if(tok.err in [teSuccess]) then
  begin
    {$IFDEF SUPER_METHOD}
    if (foCallMethod in options) and ObjectIsType(TokRec^.current, stMethod)
      and Assigned(TokRec^.current.AsMethod) then
    begin
      sm := TokRec^.current.AsMethod;
      sm(TokRec^.parent, put, Result);
    end else
    {$ENDIF SUPER_METHOD}
    begin
      Result := TokRec^.current;
    end;
  end else begin
    Result := nil;
  end;
end; // class function TSuperObject.ParseEx

procedure TSuperObject.PutO(const path: SOString; const Value: ISuperObject);
begin
  ParseString(PSOChar(path), true, False, self, [foCreatePath, foPutValue], Value);
end;

procedure TSuperObject.PutB(const path: SOString; Value: Boolean);
begin
  ParseString(PSOChar(path), true, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
end;

procedure TSuperObject.PutD(const path: SOString; Value: Double);
begin
  ParseString(PSOChar(path), true, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
end;

procedure TSuperObject.PutC(const path: SOString; Value: Currency);
begin
  ParseString(PSOChar(path), true, False, self, [foCreatePath, foPutValue], TSuperObject.CreateCurrency(Value));
end;

procedure TSuperObject.PutI(const path: SOString; Value: SuperInt);
begin
  ParseString(PSOChar(path), true, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
end;

procedure TSuperObject.PutS(const path: SOString; const Value: SOString);
begin
  ParseString(PSOChar(path), true, False, self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
end;

function TSuperObject.SaveTo(stream: TStream; indent, escape: boolean; codepage: integer; writebom: boolean): integer;
var
  pb: TSuperWriterStream;
  w: LongWord; // == DWORD
  ok: boolean;
begin
  Result := 0;
  {$IFDEF EXTEND_FORIN}
  if FJsonIsEmpty then
    Exit;
  {$ENDIF}
  pb := nil;
  try
    if escape then
      pb := {+}TSuperEscapedWriterStream{+}.Create(stream) else begin
      case codepage of
        CP_UTF8, (-CP_UTF8):
          begin
            pb := TSuperUTF8WriterStream.Create(stream);
            if writebom and (codepage > 0) then begin
              w := $00BFBBEF;
              stream.WriteBuffer(w, 3);
            end;
          end;
        CP_ANSI:
          pb := TSuperAnsiWriterStream.Create(stream);
        else
        begin
          //case codepage of 0, CP_UNICODE, CP_DEFAULT:; else if (codepage <> SYS_ACP) and (codepage <> -SYS_ACP) then
          //  raise ESuperObject.Create('Unsupported codepage'); end;
          // TODO: use WideCharToMultiByte for others charsets. TSuperMBCSEncodingiWriterStream
          pb := TSuperUnicodeWriterStream.Create(stream);
            if writebom and (codepage > 0) then begin
            w := $0000FEFF;
            stream.WriteBuffer(w, 2);
          end;
        end;
      end;

    end;
    //{$IFDEF EXTEND_FORIN}
    //ok := not FJsonIsEmpty;
    //if ok then
    //{$ENDIF}
    ok := Write(pb, indent, escape, 0) >= 0;
    if not OK then
    begin
      pb.Reset;
      Exit;
    end;
    Result := stream.Size;
  finally
    pb.Free;
  end;
end;

function TSuperObject.CalcSize(indent, escape: boolean): integer;
var
  pb: TSuperWriterFake;
begin
  pb := TSuperWriterFake.Create;
  {+}
  try
    if(Write(pb, indent, escape, 0) < 0) then
      Result := 0
    else
      Result := pb.FSize;
  finally
    pb.Free;
  end;
  {+.}
end;

function TSuperObject.SaveTo(socket: longint; indent, escape: boolean): integer;
var
  pb: TSuperWriterSock;
begin
  pb := TSuperWriterSock.Create(socket{+}, escape{+.});
  if(Write(pb, indent, escape, 0) < 0) then
  begin
    pb.Free;
    Result := 0;
    Exit;
  end;
  Result := pb.FSize;
  pb.Free;
end;

constructor TSuperObject.Create(const s: SOString);
begin
  Create(stString);
  FOString := s;
end;

procedure TSuperObject.Clear(all: boolean);
begin
  if FProcessing then
    Exit;
  FProcessing := true;
  try
    {%H-}case FDataType of
      stBoolean: FO.c_boolean := false;
      stDouble: FO.c_double := 0.0;
      stCurrency: FO.c_currency := 0.0;
      stInt: FO.c_int := 0;
      stObject: FO.c_object.Clear(all);
      stArray: FO.c_array.Clear(all);
      stString: FOString := '';
      {$IFDEF SUPER_METHOD}
      stMethod: FO.c_method := nil;
      {$ENDIF}
    end;
  finally
    FProcessing := false;
  end;
end;

procedure TSuperObject.Pack(all: boolean = false);
begin
  if FProcessing then exit;
  FProcessing := true;
  try
    {%H-}case FDataType of
      stObject: FO.c_object.Pack(all);
      stArray: FO.c_array.Pack(all);
    end;
  finally
    FProcessing := false;
  end;
end;

function TSuperObject.GetN(const path: SOString): ISuperObject;
begin
  Result := ParseString(PSOChar(path), False, true, self);
  if Result = nil then
    Result := TSuperObject.Create(stNull);
end;

procedure TSuperObject.PutN(const path: SOString; const AValue: ISuperObject);
begin
  if AValue = nil then
    ParseString(PSOChar(path), False, True, self, [foCreatePath, foPutValue], TSuperObject.Create(stNull)) else
    ParseString(PSOChar(path), False, True, self, [foCreatePath, foPutValue], AValue);
end;

function TSuperObject.Delete(const path: SOString): ISuperObject;
begin
  Result := ParseString(PSOChar(path), False, true, self, [foDelete]);
end;

function TSuperObject.Clone: ISuperObject;
var
  ite: TSuperObjectIter;
  arr: {+}ISuperArray;{+.}
  j: integer;
begin
  Result := nil;
  case FDataType of
    stBoolean: Result := TSuperObject.Create(FO.c_boolean);
    stDouble: Result := TSuperObject.Create(FO.c_double);
    stCurrency: Result := TSuperObject.CreateCurrency(FO.c_currency);
    stInt: Result := TSuperObject.Create(FO.c_int);
    stString: Result := TSuperObject.Create(FOString);
{$IFDEF SUPER_METHOD}
    stMethod: Result := TSuperObject.Create(FO.c_method);
{$ENDIF}
    stObject:
      begin
        Result := TSuperObject.Create(stObject);
        {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
        if ObjectFindFirst(self, ite) then {$hints on}
        with Result.AsObject do
        repeat
          {+} // https://code.google.com/p/superobject/issues/detail?id=41
          if ite.val<>nil then
            PutO(ite.key, ite.val.Clone)
          else
            PutO(ite.key, nil);
          {+.}
        until not ObjectFindNext(ite);
        ObjectFindClose(ite);
      end;
    stArray:
      begin
        Result := TSuperObject.Create(stArray);
        arr := AsArray;
        with Result.AsArray do
        for j := 0 to arr.Length - 1 do
          Add(arr.GetO(j).Clone);
      end;
    stNull:
      Result := TSuperObject.Create(stNull);
  end; // case
end;

procedure TSuperObject.Merge(const obj: ISuperObject; reference: boolean);
var
  prop1, prop2: ISuperObject;
  ite: TSuperObjectIter;
  arr: {+}ISuperArray;{+.}
  j: integer;
begin
  if ObjectIsType(obj, FDataType) then
  {%H-}case FDataType of
    stBoolean: FO.c_boolean := obj.AsBoolean;
    stDouble: FO.c_double := obj.AsDouble;
    stCurrency: FO.c_currency := obj.AsCurrency;
    stInt: FO.c_int := obj.AsInteger;
    stString: FOString := obj.AsString;
{$IFDEF SUPER_METHOD}
    stMethod: FO.c_method := obj.AsMethod;
{$ENDIF}
    stObject:
      begin
        {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
        if ObjectFindFirst(obj, ite) then {$hints on}
        with FO.c_object do
        repeat
          prop1 := FO.c_object.GetO(ite.key);
          if (prop1 <> nil) and (ite.val <> nil) and (prop1.DataType = ite.val.DataType) then
            prop1.Merge(ite.val) else
            if reference then
              PutO(ite.key, ite.val) else
              if ite.val <> nil then
                PutO(ite.key, ite.val.Clone) else
                PutO(ite.key, nil)

        until not ObjectFindNext(ite);
        ObjectFindClose(ite);
      end;
    stArray:
      begin
        arr := obj.AsArray;
        with FO.c_array do
        for j := 0 to arr.Length - 1 do
        begin
          prop1 := GetO(j);
          prop2 := arr.GetO(j);
          if (prop1 <> nil) and (prop2 <> nil) and (prop1.DataType = prop2.DataType) then
            prop1.Merge(prop2) else
            if reference then
              PutO(j, prop2) else
              if prop2 <> nil then
                PutO(j, prop2.Clone) else
                PutO(j, nil);
        end;
      end;
  end;
end;

procedure TSuperObject.Merge(const str: SOString);
begin
  Merge(TSuperObject.ParseString(PSOChar(str), False), true);
end;

function TSuperObject.ForcePath(const path: SOString; dataType: TSuperType = stObject): ISuperObject;
begin
  Result := ParseString(PSOChar(path), False, True, Self, [foCreatePath], nil, dataType);
end;

function TSuperObject.Format(const str: SOString; BeginSep: SOChar; EndSep: SOChar): SOString;
var
  p1, p2: PSOChar;
begin
  Result := '';
  p2 := PSOChar(str);
  p1 := p2;
  while true do
    if p2^ = BeginSep then
      begin
        if p2 > p1 then
          Result := Result + Copy(p1, 0, p2-p1);
        inc(p2);
        p1 := p2;
        while true do
          if p2^ = EndSep then Break else
          if p2^ = #0     then Exit else
            inc(p2);
        Result := Result + GetS(copy(p1, 0, p2-p1));
        inc(p2);
        p1 := p2;
      end
    else if p2^ = #0 then
      begin
        if p2 > p1 then
          Result := Result + Copy(p1, 0, p2-p1);
        Break;
      end else
        inc(p2);
end;

{+} // https://code.google.com/p/superobject/issues/detail?id=62
function TSuperObject.AsVariant: Variant;
begin
  case FDataType of
    stNull:     Result := Null;
    stBoolean:  Result := FO.c_boolean;
    stDouble:   Result := FO.c_double;
    stCurrency: Result := FO.c_currency;
    stInt:      Result := FO.c_int;
    stString:   Result := FOString;
    //stArray,
    //{$IFDEF SUPER_METHOD}
    //stMethod,
    //{$ENDIF}
    //stObject:   Result := ISuperObject(Self) as IDispatch;
    else
      Result := Null;
  end;
end;
//
function TSuperObject.GetV(const path: SOString): Variant;
var
  obj: ISuperObject;
begin
  obj := GetO(path);
  if obj <> nil then
  begin
    case obj.DataType of
    //stNull:     Result := Null;
      stBoolean:  Result := obj.AsBoolean;
      stDouble:   Result := obj.AsDouble;
      stCurrency: Result := obj.AsCurrency;
      stInt:      Result := obj.AsInteger;
      stObject:   Result := obj;
      stArray:    Result := obj;
      stString:   Result := obj.AsString;
      {$IFDEF SUPER_METHOD}
      stMethod:   Result := obj;
      {$ENDIF}
      else
        Result := Null;
    end;
  end
  else
    Result := Null;
end;
//
procedure TSuperObject.PutV(const path: SOString; Value: Variant);
begin
  with TVarData(Value) do
  case VType of
    varEmpty,
    varNull:     PutO(path, nil);
    varSmallInt: PutI(path, VSmallInt);
    varInteger:  PutI(path, VInteger);
    varSingle:   PutD(path, VSingle);
    varDouble:   PutD(path, VDouble);
    varCurrency: PutC(path, VCurrency);
    varDate:     PutI(path, DelphiToJavaDateTime(vDate));
    varOleStr:   PutS(path, SOString(VOleStr));
    varBoolean:  PutB(path, VBoolean);
    varShortInt: PutI(path, VShortInt);
    varByte:     PutI(path, VByte);
    varWord:     PutI(path, VWord);
    varLongWord: PutI(path, VLongWord);
    varInt64:    PutI(path, VInt64);
    varString:   PutS(path, SOString({+}{$IFDEF NEXTGEN}string{$ELSE}AnsiString{$ENDIF}{+.}(VString)));
    {$IF DECLARED(varUString)}
    varUString:  PutS(path, SOString({$IFDEF FPC}UnicodeString{$ELSE}string{$ENDIF}(VString)));
    {$IFEND}
    else
      raise ESuperObject.CreateFmt('Unsuported variant data type: %d', [VType]);
  end;
end;
{+.}

function TSuperObject.GetO(const path: SOString): ISuperObject;
{+}
{$IFDEF EXTEND_FORIN}
var
  o: TSuperObject;
{$ENDIF}
{+.}
begin
  Result := ParseString(PSOChar(path), False, True, Self);
  {+}
  {$IFDEF EXTEND_FORIN} // TODO: "pult": need check any combination
  // Always return value !
  // Allow next code: for item in (TSuperObject.ParseFile('123-empty.json', true, true) as ISuperObject)['stroka'] do ...
  if (Result = nil) and FSafeForIn then
  begin
    //Result := SO('{}');
    o := TSuperObject.Create(stObject);
    o.FJsonIsEmpty := True;
    Result := o;
  end;
  {$ENDIF}
  {+.}
end;

function TSuperObject.GetA(const path: SOString): {+}ISuperArray{+.};
var
  obj: ISuperObject;
  {+}
  {$IFDEF EXTEND_FORIN}
  o: TSuperObject;
  {$ENDIF}
  {+.}
begin
  obj := ParseString(PSOChar(path), False, True, Self);
  if obj <> nil then
    Result := obj.AsArray else
    Result := nil;
  {+}
  {$IFDEF EXTEND_FORIN} // TODO: "pult": need check any combination
  // Always return value !
  if (Result = nil) and FSafeForIn then
  begin
    //Result := SA([]).AsArray; // ?
    o := TSuperObject.Create(stArray);
    o.FJsonIsEmpty := True;
    obj := o;
    Result := o.AsArray;
  end;
  {$ENDIF}
  {+.}
end;

function TSuperObject.GetB(const path: SOString): Boolean;
var
  obj: ISuperObject;
begin
  obj := GetO(path);
  if obj <> nil then
    Result := obj.AsBoolean else
    Result := false;
end;

function TSuperObject.GetD(const path: SOString): Double;
var
  obj: ISuperObject;
begin
  obj := GetO(path);
  if obj <> nil then
    Result := obj.AsDouble else
    Result := 0.0;
end;

function TSuperObject.GetC(const path: SOString): Currency;
var
  obj: ISuperObject;
begin
  obj := GetO(path);
  if obj <> nil then
    Result := obj.AsCurrency else
    Result := 0.0;
end;

function TSuperObject.GetI(const path: SOString): SuperInt;
var
  obj: ISuperObject;
begin
  obj := GetO(path);
  if obj <> nil then
    Result := obj.AsInteger else
    Result := 0;
end;

function TSuperObject.GetDataPtr: Pointer;
begin
  Result := FDataPtr;
end;

{+}
{$IFDEF EXTEND_FORIN}
function TSuperObject.GetSafeForIn: Boolean;
begin
  Result := FSafeForIn;
end;
//
procedure TSuperObject.SetSafeForIn(const AValue: Boolean);
begin
  FSafeForIn := AValue;
end;
//
function TSuperObject.GetJsonIsEmpty: Boolean;
begin
  Result := FJsonIsEmpty;
end;
{$ENDIF}
{+.}

function TSuperObject.GetDataType: TSuperType;
begin
  Result := FDataType
end;

function TSuperObject.GetS(const path: SOString): SOString;
var
  obj: ISuperObject;
begin
  obj := GetO(path);
  if obj <> nil then
    Result := obj.AsString else
    Result := '';
end;

function TSuperObject.SaveTo(const FileName: string; indent, escape: boolean; codepage: integer; writebom: boolean): integer;
var
  stream: TFileStream;
begin
  {$warnings off} // FPC: Warning: Implicit string type conversion with potential data loss from "UnicodeString" to "AnsiString"
  stream := TFileStream.Create(FileName, fmCreate);
  {$warnings on}
  try
    Result := SaveTo(stream, indent, escape, codepage, writebom);
  finally
    stream.Free;
  end;
end;

{+}
function TSuperObject.ValidateCB(const rules: SOString; const defs: SOString; callback: TSuperValidatorCB): boolean;
begin
  Result := ValidateCB(TSuperObject.ParseString(PSOChar(rules), False), TSuperObject.ParseString(PSOChar(defs), False), callback);
end;

procedure do_validate_CB(sender: Pointer; error: TSuperValidateError; const objpath: SOString);
var
  a_sender: TSuperValidatorCB absolute sender;
begin
  if Assigned(sender) and Assigned(a_sender.OnError) then
    a_sender.OnError(error, objpath);
end;

function TSuperObject.ValidateCB(const rules: ISuperObject; const defs: ISuperObject; callback: TSuperValidatorCB): boolean;
var
  a_callback: TSuperOnValidateError;
  a_sender: Pointer;
begin
  a_callback := nil;
  a_sender := nil;
  if Assigned(callback) and Assigned(callback.OnError) then
  begin
    a_sender := callback;
    a_callback := do_validate_CB;
  end;
  Result := Validate(rules, defs, a_callback, a_sender);
end;
{+.}

function TSuperObject.Validate(const rules: SOString; const defs: SOString = ''; callback: TSuperOnValidateError = nil; sender: Pointer = nil): boolean;
begin
  Result := Validate(TSuperObject.ParseString(PSOChar(rules), False), TSuperObject.ParseString(PSOChar(defs), False), callback, sender);
end;

function TSuperObject.Validate(const rules: ISuperObject; const defs: ISuperObject = nil; callback: TSuperOnValidateError = nil; sender: Pointer = nil): boolean;
type
  TDataType = (dtUnknown, dtStr, dtInt, dtFloat, dtNumber, dtText, dtBool,
               dtMap, dtSeq, dtScalar, dtAny);
var
  datatypes: ISuperObject;
  names: ISuperObject;

  function FindInheritedProperty(const prop: PSOChar; p: ISuperObject): ISuperObject;
  var
    o: ISuperObject;
    e: TSuperAvlEntry;
  begin
    o := p[prop];
    if o <> nil then
      result := o else
      begin
        o := p['inherit'];
        if (o <> nil) and ObjectIsType(o, stString) then
          begin
            e := names.AsObject.Search(o.AsString);
            if (e <> nil) then
              Result := FindInheritedProperty(prop, e.Value) else
              Result := nil;
          end else
            Result := nil;
      end;
  end;

  function FindDataType(o: ISuperObject): TDataType;
  var
    e: TSuperAvlEntry;
    obj: ISuperObject;
  begin
    obj := FindInheritedProperty('type', o);
    if obj <> nil then
    begin
      e := datatypes.AsObject.Search(obj.AsString);
      if  e <> nil then
        Result := TDataType(e.Value.AsInteger) else
        Result := dtUnknown;
    end else
      Result := dtUnknown;
  end;

  procedure GetNames(o: ISuperObject);
  var
    obj: ISuperObject;
    f: TSuperObjectIter;
  begin
    obj := o['name'];
    if ObjectIsType(obj, stString) then
      names[obj.AsString] := o;

    {%H-}case FindDataType(o) of
      dtMap:
        begin
          obj := o['mapping'];
          if ObjectIsType(obj, stObject) then
          begin
            {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
            if ObjectFindFirst(obj, f) then {$hints on}
            repeat
              if ObjectIsType(f.val, stObject) then
                GetNames(f.val);
            until not ObjectFindNext(f);
            ObjectFindClose(f);
          end;
        end;
      dtSeq:
        begin
          obj := o['sequence'];
          if ObjectIsType(obj, stObject) then
            GetNames(obj);
        end;
    end;
  end;

  function FindInheritedField(const prop: SOString; p: ISuperObject): ISuperObject;
  var
    o: ISuperObject;
    e: TSuperAvlEntry;
  begin
    o := p['mapping'];
    if ObjectIsType(o, stObject) then
    begin
      o := o.AsObject.GetO(prop);
      if o <> nil then
      begin
        Result := o;
        Exit;
      end;
    end;

    o := p['inherit'];
    if ObjectIsType(o, stString) then
    begin
      e := names.AsObject.Search(o.AsString);
      if (e <> nil) then
        Result := FindInheritedField(prop, e.Value) else
        Result := nil;
    end else
      Result := nil;
  end;

  function InheritedFieldExist(const obj: ISuperObject; p: ISuperObject; const name: SOString = ''): boolean;
  var
   o: ISuperObject;
   e: TSuperAvlEntry;
   j: TSuperAvlIterator;
  begin
    Result := true;
    o := p['mapping'];
    if ObjectIsType(o, stObject) then
    begin
      j := TSuperAvlIterator.Create(o.AsObject);
      try
        j.First;
        e := j.GetIter;
        while e <> nil do
        begin
          if obj.AsObject.Search(e.Name) = nil then
          begin
            Result := False;
            if assigned(callback) then
              callback(sender, veFieldNotFound, name + '.' + e.Name);
          end;
          j.Next;
          e := j.GetIter;
        end;

      finally
        j.Free;
      end;
    end;

    o := p['inherit'];
    if ObjectIsType(o, stString) then
    begin
      e := names.AsObject.Search(o.AsString);
      if (e <> nil) then
        Result := InheritedFieldExist(obj, e.Value, name) and Result;
    end;
  end;

  function getInheritedBool(f: PSOChar; p: ISuperObject; default: boolean = false): boolean;
  var
    o: ISuperObject;
  begin
    o := FindInheritedProperty(f, p);
    case ObjectGetType(o) of
      stBoolean: Result := o.AsBoolean;
      stNull: Result := Default;
    else
      Result := default;
      if assigned(callback) then
        callback(sender, veRuleMalformated, f);
    end;
  end;

  procedure GetInheritedFieldList(list: ISuperObject; p: ISuperObject);
  var
   o: ISuperObject;
   e: TSuperAvlEntry;
   i: TSuperAvlIterator;
  begin
    Result := true;
    o := p['mapping'];
    if ObjectIsType(o, stObject) then
    begin
      i := TSuperAvlIterator.Create(o.AsObject);
      try
        i.First;
        e := i.GetIter;
        while e <> nil do
        begin
          if list.AsObject.Search(e.Name) = nil then
            list[e.Name] := e.Value;
          i.Next;
          e := i.GetIter;
        end;

      finally
        i.Free;
      end;
    end;

    o := p['inherit'];
    if ObjectIsType(o, stString) then
    begin
      e := names.AsObject.Search(o.AsString);
      if (e <> nil) then
        GetInheritedFieldList(list, e.Value);
    end;
  end;

  function CheckEnum(o: ISuperObject; p: ISuperObject; name: SOString = ''): boolean;
  var
    enum: ISuperObject;
    i: integer;
  begin
    Result := false;
    enum := FindInheritedProperty('enum', p);
    case ObjectGetType(enum) of
      stArray:
        for i := 0 to enum.AsArray.Length - 1 do
          if (o.AsString = enum.AsArray[i].AsString) then
          begin
            Result := true;
            exit;
          end;
      stNull: Result := true;
    else
      Result := false;
      if assigned(callback) then
        callback(sender, veRuleMalformated, '');
      Exit;
    end;

    if (not Result) and assigned(callback) then
      callback(sender, veValueNotInEnum, name);
  end;

  function CheckLength(len: integer; p: ISuperObject; const objpath: SOString): boolean;
  var
    length, o: ISuperObject;
  begin
    result := true;
    length := FindInheritedProperty('length', p);
    case ObjectGetType(length) of
      stObject:
        begin
          o := length.AsObject.GetO('min');
          if (o <> nil) and (o.AsInteger > len) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidLength, objpath);
          end;
          o := length.AsObject.GetO('max');
          if (o <> nil) and (o.AsInteger < len) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidLength, objpath);
          end;
          o := length.AsObject.GetO('minex');
          if (o <> nil) and (o.AsInteger >= len) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidLength, objpath);
          end;
          o := length.AsObject.GetO('maxex');
          if (o <> nil) and (o.AsInteger <= len) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidLength, objpath);
          end;
        end;
      stNull: ;
    else
      Result := false;
      if assigned(callback) then
        callback(sender, veRuleMalformated, '');
    end;
  end;

  function CheckRange(obj: ISuperObject; p: ISuperObject; const objpath: SOString): boolean;
  var
    length, o: ISuperObject;
  begin
    result := true;
    length := FindInheritedProperty('range', p);
    case ObjectGetType(length) of
      stObject:
        begin
          o := length.AsObject.GetO('min');
          if (o <> nil) and (o.Compare(obj) = cpGreat) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidRange, objpath);
          end;
          o := length.AsObject.GetO('max');
          if (o <> nil) and (o.Compare(obj) = cpLess) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidRange, objpath);
          end;
          o := length.AsObject.GetO('minex');
          if (o <> nil) and (o.Compare(obj) in [cpGreat, cpEqu]) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidRange, objpath);
          end;
          o := length.AsObject.GetO('maxex');
          if (o <> nil) and (o.Compare(obj) in [cpLess, cpEqu]) then
          begin
            Result := false;
            if assigned(callback) then
              callback(sender, veInvalidRange, objpath);
          end;
        end;
      stNull: ;
    else
      Result := false;
      if assigned(callback) then
        callback(sender, veRuleMalformated, '');
    end;
  end;

  function process(o: ISuperObject; p: ISuperObject; objpath: SOString = ''): boolean;
  var
    ite: TSuperAvlIterator;
    ent: TSuperAvlEntry;
    p2, o2, sequence: ISuperObject;
    s: SOString;
    i: integer;
    uniquelist, fieldlist: ISuperObject;
  begin
    Result := true;
    if (o = nil) then
    begin
      if getInheritedBool('required', p) then
      begin
        if assigned(callback) then
          callback(sender, veFieldIsRequired, objpath);
        result := false;
      end;
    end else
      case FindDataType(p) of
        dtStr:
          case ObjectGetType(o) of
            stString:
              begin
                Result := Result and CheckLength(Length(o.AsString), p, objpath);
                Result := Result and CheckRange(o, p, objpath);
              end;
          else
            if assigned(callback) then
              callback(sender, veInvalidDataType, objpath);
            result := false;
          end;
        dtBool:
          case ObjectGetType(o) of
            stBoolean:
              begin
                Result := Result and CheckRange(o, p, objpath);
              end;
          else
            if assigned(callback) then
              callback(sender, veInvalidDataType, objpath);
            result := false;
          end;
        dtInt:
          case ObjectGetType(o) of
            stInt:
              begin
                Result := Result and CheckRange(o, p, objpath);
              end;
          else
            if assigned(callback) then
              callback(sender, veInvalidDataType, objpath);
            result := false;
          end;
        dtFloat:
          case ObjectGetType(o) of
            stDouble, stCurrency:
              begin
                Result := Result and CheckRange(o, p, objpath);
              end;
          else
            if assigned(callback) then
              callback(sender, veInvalidDataType, objpath);
            result := false;
          end;
        dtMap:
          case ObjectGetType(o) of
            stObject:
              begin
                // all objects have and match a rule ?
                ite := TSuperAvlIterator.Create(o.AsObject);
                try
                  ite.First;
                  ent := ite.GetIter;
                  while ent <> nil do
                  begin
                    p2 :=  FindInheritedField(ent.Name, p);
                    if ObjectIsType(p2, stObject) then
                      result := process(ent.Value, p2, objpath + '.' + ent.Name) and result else
                    begin
                      if assigned(callback) then
                        callback(sender, veUnexpectedField, objpath + '.' + ent.Name);
                      result := false; // field have no rule
                    end;
                    ite.Next;
                    ent := ite.GetIter;
                  end;
                finally
                  ite.Free;
                end;

                // all expected field exists ?
                Result :=  InheritedFieldExist(o, p, objpath) and Result;
              end;
            stNull: {nop};
          else
            result := false;
            if assigned(callback) then
              callback(sender, veRuleMalformated, objpath);
          end;
        dtSeq:
          case ObjectGetType(o) of
            stArray:
              begin
                sequence := FindInheritedProperty('sequence', p);
                if sequence <> nil then
                case ObjectGetType(sequence) of
                  stObject:
                    begin
                      for i := 0 to o.AsArray.Length - 1 do
                        result := process(o.AsArray.GetO(i), sequence, objpath + '[' + SOString(IntToStr(i)) + ']') and result;
                      if getInheritedBool('unique', sequence) then
                      begin
                        // type is unique ?
                        uniquelist := TSuperObject.Create(stObject);
                        try
                          for i := 0 to o.AsArray.Length - 1 do
                          begin
                            s := o.AsArray.GetO(i).AsString;
                            if (s <> '') then
                            begin
                              if uniquelist.AsObject.Search(s) = nil then
                                uniquelist[s] := nil else
                                begin
                                  Result := False;
                                  if Assigned(callback) then
                                    callback(sender, veDuplicateEntry, objpath + '[' + SOString(IntToStr(i)) + ']');
                                end;
                            end;
                          end;
                        finally
                          uniquelist := nil;
                        end;
                      end;

                      // field is unique ?
                      if (FindDataType(sequence) = dtMap) then
                      begin
                        fieldlist := TSuperObject.Create(stObject);
                        try
                          GetInheritedFieldList(fieldlist, sequence);
                          ite := TSuperAvlIterator.Create(fieldlist.AsObject);
                          try
                            ite.First;
                            ent := ite.GetIter;
                            while ent <> nil do
                            begin
                              if getInheritedBool('unique', ent.Value) then
                              begin
                                uniquelist := TSuperObject.Create(stObject);
                                try
                                  for i := 0 to o.AsArray.Length - 1 do
                                  begin
                                    o2 := o.AsArray.GetO(i);
                                    if o2 <> nil then
                                    begin
                                      s := o2.AsObject.GetO(ent.Name).AsString;
                                      if (s <> '') then
                                      if uniquelist.AsObject.Search(s) = nil then
                                        uniquelist[s] := nil else
                                        begin
                                          Result := False;
                                          if Assigned(callback) then
                                            callback(sender, veDuplicateEntry, objpath + '[' + SOString(IntToStr(i)) + '].' + ent.name);
                                        end;
                                    end;
                                  end;
                                finally
                                  uniquelist := nil;
                                end;
                              end;
                              ite.Next;
                              ent := ite.GetIter;
                            end;
                          finally
                            ite.Free;
                          end;
                        finally
                          fieldlist := nil;
                        end;
                      end;

                    end;
                  stNull: {nop};
                else
                  result := false;
                  if assigned(callback) then
                    callback(sender, veRuleMalformated, objpath);
                end;
                Result := Result and CheckLength(o.AsArray.Length, p, objpath);

              end;
          else
            result := false;
            if assigned(callback) then
              callback(sender, veRuleMalformated, objpath);
          end;
        dtNumber:
          case ObjectGetType(o) of
            stInt,
            stDouble, stCurrency:
              begin
                Result := Result and CheckRange(o, p, objpath);
              end;
          else
            if assigned(callback) then
              callback(sender, veInvalidDataType, objpath);
            result := false;
          end;
        dtText:
          case ObjectGetType(o) of
            stInt,
            stDouble,
            stCurrency,
            stString:
              begin
                result := result and CheckLength(Length(o.AsString), p, objpath);
                Result := Result and CheckRange(o, p, objpath);
              end;
          else
            if assigned(callback) then
              callback(sender, veInvalidDataType, objpath);
            result := false;
          end;
        dtScalar:
          case ObjectGetType(o) of
            stBoolean,
            stDouble,
            stCurrency,
            stInt,
            stString:
              begin
                result := result and CheckLength(Length(o.AsString), p, objpath);
                Result := Result and CheckRange(o, p, objpath);
              end;
          else
            if assigned(callback) then
              callback(sender, veInvalidDataType, objpath);
            result := false;
          end;
        dtAny:;
      else
        if assigned(callback) then
          callback(sender, veRuleMalformated, objpath);
        result := false;
      end;
      Result := Result and CheckEnum(o, p, objpath)

  end;
var
  j: integer;

begin
  Result := False;
  datatypes := TSuperObject.Create(stObject);
  names := TSuperObject.Create;
  try
    datatypes.I['str'] := ord(dtStr);
    datatypes.I['int'] := ord(dtInt);
    datatypes.I['float'] := ord(dtFloat);
    datatypes.I['number'] := ord(dtNumber);
    datatypes.I['text'] := ord(dtText);
    datatypes.I['bool'] := ord(dtBool);
    datatypes.I['map'] := ord(dtMap);
    datatypes.I['seq'] := ord(dtSeq);
    datatypes.I['scalar'] := ord(dtScalar);
    datatypes.I['any'] := ord(dtAny);

    if ObjectIsType(defs, stArray) then
      for j := 0 to defs.AsArray.Length - 1 do
        if ObjectIsType(defs.AsArray[j], stObject) then
          GetNames(defs.AsArray[j]) else
          begin
            if assigned(callback) then
              callback(sender, veRuleMalformated, '');
            Exit;
          end;

    if ObjectIsType(rules, stObject) then
      GetNames(rules) else
      begin
        if assigned(callback) then
          callback(sender, veRuleMalformated, '');
        Exit;
      end;

    Result := process(self, rules);

  finally
    datatypes := nil;
    names := nil;
  end;
end;

function TSuperObject.Compare(const str: SOString): TSuperCompareResult;
begin
  Result := Compare(TSuperObject.ParseString(PSOChar(str), False));
end;

function TSuperObject.Compare(const obj: ISuperObject): TSuperCompareResult;
  function GetIntCompResult(const i: int64): TSuperCompareResult;
  begin
    if i < 0 then result := cpLess else
    if i = 0 then result := cpEqu else
      Result := cpGreat;
  end;

  function GetDblCompResult(const d: double): TSuperCompareResult;
  begin
    if d < 0 then result := cpLess else
    if d = 0 then result := cpEqu else
      Result := cpGreat;
  end;

begin
  case DataType of
    stBoolean:
      case ObjectGetType(obj) of
        stBoolean: Result := GetIntCompResult(int64(ord(FO.c_boolean)) - ord(obj.AsBoolean));
        stDouble:  Result := GetDblCompResult(ord(FO.c_boolean) - obj.AsDouble);
        stCurrency:Result := GetDblCompResult(ord(FO.c_boolean) - obj.AsCurrency);
        stInt:     Result := GetIntCompResult(ord(FO.c_boolean) - obj.AsInteger);
        stString:  Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      else
        Result := cpError;
      end;
    stDouble:
      case ObjectGetType(obj) of
        stBoolean: Result := GetDblCompResult(FO.c_double - ord(obj.AsBoolean));
        stDouble:  Result := GetDblCompResult(FO.c_double - obj.AsDouble);
        stCurrency:Result := GetDblCompResult(FO.c_double - obj.AsCurrency);
        stInt:     Result := GetDblCompResult(FO.c_double - obj.AsInteger);
        stString:  Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      else
        Result := cpError;
      end;
    stCurrency:
      case ObjectGetType(obj) of
        stBoolean: Result := GetDblCompResult(FO.c_currency - ord(obj.AsBoolean));
        stDouble:  Result := GetDblCompResult(FO.c_currency - obj.AsDouble);
        stCurrency:Result := GetDblCompResult(FO.c_currency - obj.AsCurrency);
        stInt:     Result := GetDblCompResult(FO.c_currency - obj.AsInteger);
        stString:  Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      else
        Result := cpError;
      end;
    stInt:
      case ObjectGetType(obj) of
        stBoolean: Result := GetIntCompResult(FO.c_int - ord(obj.AsBoolean));
        stDouble:  Result := GetDblCompResult(FO.c_int - obj.AsDouble);
        stCurrency:Result := GetDblCompResult(FO.c_int - obj.AsCurrency);
        stInt:     Result := GetIntCompResult(FO.c_int - obj.AsInteger);
        stString:  Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      else
        Result := cpError;
      end;
    stString:
      case ObjectGetType(obj) of
        stBoolean,
        stDouble,
        stCurrency,
        stInt,
        stString:  Result := GetIntCompResult(StrComp(PSOChar(AsString), PSOChar(obj.AsString)));
      else
        Result := cpError;
      end;
  else
    Result := cpError;
  end;
end;

{$IFDEF SUPER_METHOD}
function TSuperObject.AsMethod: TSuperMethod;
begin
  if FDataType = stMethod then
    Result := FO.c_method else
    Result := nil;
end;
{$ENDIF}

{$IFDEF SUPER_METHOD}
constructor TSuperObject.Create(m: TSuperMethod);
begin
  Create(stMethod);
  FO.c_method := m;
end;
{$ENDIF}

{$IFDEF SUPER_METHOD}
function TSuperObject.GetM(const path: SOString): TSuperMethod;
var
  v: ISuperObject;
begin
  v := ParseString(PSOChar(path), False, True, Self);
  if (v <> nil) and (ObjectGetType(v) = stMethod) then
    Result := v.AsMethod else
    Result := nil;
end;
{$ENDIF}

{$IFDEF SUPER_METHOD}
procedure TSuperObject.PutM(const path: SOString; Value: TSuperMethod);
begin
  ParseString(PSOChar(path), False, True, Self, [foCreatePath, foPutValue], TSuperObject.Create(Value));
end;
{$ENDIF}

{$IFDEF SUPER_METHOD}
function TSuperObject.call(const path: SOString; const param: ISuperObject): ISuperObject;
begin
  Result := ParseString(PSOChar(path), False, True, Self, [foCallMethod], param);
end;
{$ENDIF}

{$IFDEF SUPER_METHOD}
function TSuperObject.call(const path, param: SOString): ISuperObject;
begin
  Result := ParseString(PSOChar(path), False, True, Self, [foCallMethod], TSuperObject.ParseString(PSOChar(param), False));
end;
{$ENDIF}

function TSuperObject.GetProcessing: boolean;
begin
  Result := FProcessing;
end;

procedure TSuperObject.SetDataPtr(const AValue: Pointer);
begin
  FDataPtr := AValue;
end;

procedure TSuperObject.SetProcessing(value: boolean);
begin
  FProcessing := value;
end;

{+}
//
{ TSuperArrayEnumerator }
//
constructor TSuperArrayEnumerator.Create(const obj: ISuperArray);
begin
  inherited Create;
  FObj := obj;
  FCount := -1;
end;
//
function TSuperArrayEnumerator.MoveNext: Boolean;
begin
  inc(FCount);
  Result := FCount < FObj.Length;
end;
//
function TSuperArrayEnumerator.GetCurrent: ISuperObject;
begin
  Result := FObj.GetO(FCount);
end;
{+.}

{ TSuperArray }

{+}
function TSuperArray.Length;
begin
  Result := FLength;
end;
{+.}

function TSuperArray.Add(const Data: ISuperObject): Integer;
begin
  Result := FLength;
  PutO(Result, data);
end;

function TSuperArray.Add(Data: SuperInt): Integer;
begin
  Result := Add(TSuperObject.Create(Data));
end;

function TSuperArray.Add(const Data: SOString): Integer;
begin
  Result := Add(TSuperObject.Create(Data));
end;

function TSuperArray.Add(Data: Boolean): Integer;
begin
  Result := Add(TSuperObject.Create(Data));
end;

function TSuperArray.Add(Data: Double): Integer;
begin
  Result := Add(TSuperObject.Create(Data));
end;

function TSuperArray.AddC(const Data: Currency): Integer;
begin
  Result := Add(TSuperObject.CreateCurrency(Data));
end;

function TSuperArray.Delete(index: Integer): ISuperObject;
begin
  if (Index >= 0) and (Index < FLength) then
  begin
    Result := FArray^[index];
    FArray^[index] := nil;
    Dec(FLength);
    if Index < FLength then
    begin
      Move(FArray^[index + 1], FArray^[index],
        (FLength - index) * SizeOf(Pointer));
      Pointer(FArray^[FLength]) := nil;
    end;
  end;
end;

procedure TSuperArray.Insert(index: Integer; const value: ISuperObject);
begin
  if (Index >= 0) then
  if (index < FLength) then
  begin
    if FLength = FSize then
      Expand(FLength+1); // https://github.com/hgourvest/superobject/pull/16
    if Index < FLength then
      Move(FArray^[index], FArray^[index + 1],
        (FLength - index) * SizeOf(Pointer));
    Pointer(FArray^[index]) := nil;
    FArray^[index] := value;
    Inc(FLength);
  end else
    PutO(index, value);
end;

procedure TSuperArray.Clear(all: boolean);
var
  j: Integer;
  so: ^ISuperObject;
begin
  for j := FLength - 1 downto 0 do
  begin
    so := @FArray^[j];
    if Assigned(so^) then
    begin
      if all then
        so^.Clear(all);
      so^ := nil;
    end;
  end;
  FLength := 0;
end;

procedure TSuperArray.Pack(all: boolean);
var
  PackedCount, StartIndex, EndIndex, j: Integer;
begin
  if FLength > 0 then
  begin
    PackedCount := 0;
    StartIndex := 0;
    repeat
      while (StartIndex < FLength) and (FArray^[StartIndex] = nil) do
        Inc(StartIndex);
      if StartIndex < FLength then
        begin
          EndIndex := StartIndex;
          while (EndIndex < FLength) and  (FArray^[EndIndex] <> nil) do
            Inc(EndIndex);

          Dec(EndIndex);

          if StartIndex > PackedCount then
            Move(FArray^[StartIndex], FArray^[PackedCount], (EndIndex - StartIndex + 1) * SizeOf(Pointer));

          Inc(PackedCount, EndIndex - StartIndex + 1);
          StartIndex := EndIndex + 1;
        end;
    until StartIndex >= FLength;
    FillChar(FArray^[PackedCount], (FLength - PackedCount) * sizeof(Pointer), 0);
    FLength := PackedCount;
    if all then
      for j := 0 to FLength - 1 do
        FArray^[j].Pack(all);
  end;
end;

constructor TSuperArray.Create;
begin
  inherited Create;
  FSize := SUPER_ARRAY_LIST_DEFAULT_SIZE;
  FLength := 0;
  GetMem(FArray, sizeof(Pointer) * FSize);
  FillChar(FArray^, sizeof(Pointer) * FSize, 0);
end;

destructor TSuperArray.Destroy;
begin
  Clear((*?{all:}True*)); // TODO: ?all
  if Assigned(FArray) then
  begin
    FreeMem(FArray);
    FArray := nil;
  end;
  inherited;
end;

{+}
function TSuperArray.GetEnumerator: TSuperArrayEnumerator;
begin
  Result := TSuperArrayEnumerator.Create(Self);
end;
{+.}

procedure TSuperArray.Expand(max: Integer);
var
  new_size: Integer;
begin
  if (max < FSize) then
    Exit;
  if max < (FSize shl 1) then
    new_size := (FSize shl 1) else
    new_size := max + 1;
  ReallocMem(FArray, new_size * sizeof(Pointer));
  FillChar(FArray^[FSize], (new_size - FSize) * sizeof(Pointer), 0);
  FSize := new_size;
end;

function TSuperArray.GetO(const index: Integer): ISuperObject;
begin
  if(index >= FLength) then
    Result := nil else
    Result := FArray^[index];
end;

function TSuperArray.GetB(const index: integer): Boolean;
var
  obj: ISuperObject;
begin
  obj := GetO(index);
  if obj <> nil then
    Result := obj.AsBoolean else
    Result := false;
end;

function TSuperArray.GetD(const index: integer): Double;
var
  obj: ISuperObject;
begin
  obj := GetO(index);
  if obj <> nil then
    Result := obj.AsDouble else
    Result := 0.0;
end;

function TSuperArray.GetI(const index: integer): SuperInt;
var
  obj: ISuperObject;
begin
  obj := GetO(index);
  if obj <> nil then
    Result := obj.AsInteger else
    Result := 0;
end;

function TSuperArray.GetS(const index: integer): SOString;
var
  obj: ISuperObject;
begin
  obj := GetO(index);
  if obj <> nil then
    Result := obj.AsString else
    Result := '';
end;

procedure TSuperArray.PutO(const index: Integer; const Value: ISuperObject);
begin
  Expand(index);
  FArray^[index] := value;
  if(FLength <= index) then FLength := index + 1;
end;

function TSuperArray.GetN(const index: integer): ISuperObject;
begin
  Result := GetO(index);
  if Result = nil then
    Result := TSuperObject.Create(stNull);
end;

procedure TSuperArray.PutN(const index: integer; const Value: ISuperObject);
begin
  if Value <> nil then
    PutO(index, Value) else
    PutO(index, TSuperObject.Create(stNull));
end;

procedure TSuperArray.PutB(const index: integer; Value: Boolean);
begin
  PutO(index, TSuperObject.Create(Value));
end;

procedure TSuperArray.PutD(const index: integer; Value: Double);
begin
  PutO(index, TSuperObject.Create(Value));
end;

function TSuperArray.GetC(const index: integer): Currency;
var
  obj: ISuperObject;
begin
  obj := GetO(index);
  if obj <> nil then
    Result := obj.AsCurrency else
    Result := 0.0;
end;

procedure TSuperArray.PutC(const index: integer; Value: Currency);
begin
  PutO(index, TSuperObject.CreateCurrency(Value));
end;

procedure TSuperArray.PutI(const index: integer; Value: SuperInt);
begin
  PutO(index, TSuperObject.Create(Value));
end;

procedure TSuperArray.PutS(const index: integer; const Value: SOString);
begin
  PutO(index, TSuperObject.Create(Value));
end;

{$IFDEF SUPER_METHOD}
function TSuperArray.GetM(const index: integer): TSuperMethod;
var
  v: ISuperObject;
begin
  v := GetO(index);
  if (ObjectGetType(v) = stMethod) then
    Result := v.AsMethod else
    Result := nil;
end;
{$ENDIF}

{$IFDEF SUPER_METHOD}
procedure TSuperArray.PutM(const index: integer; Value: TSuperMethod);
begin
  PutO(index, TSuperObject.Create(Value));
end;
{$ENDIF}

{ TSuperWriterString }

function TSuperWriterString.Append(buf: PSOChar; Size: Integer): Integer;
  function max(a, b: Integer): integer; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin if a > b then Result := a else Result := b end;
begin
  if Size > 0 then
  begin
    if (FSize - FBPos <= Size) then
    begin
      FSize := max(FSize * 2, FBPos + Size + 8);
      ReallocMem(FBuf, FSize * SizeOf(SOChar));
    end;
    // fast move
    case Size of
    1: FBuf[FBPos] := buf^;
    2: PInteger(@FBuf[FBPos])^ := PInteger(buf)^;
    4: PInt64(@FBuf[FBPos])^ := PInt64(buf)^;
    else
      move(buf^, FBuf[FBPos], Size * SizeOf(SOChar));
    end;
    inc(FBPos, Size);
    FBuf[FBPos] := #0;
    //
    Result := Size;
  end
  else
    Result := 0;
end;

function TSuperWriterString.Append(buf: PSOChar): Integer;
begin
  Result := Append(buf, strlen(buf));
end;

constructor TSuperWriterString.Create;
begin
  inherited;
  FSize := 32;
  FBPos := 0;
  GetMem(FBuf, FSize * SizeOf(SOChar));
end;

destructor TSuperWriterString.Destroy;
begin
  inherited;
  if Assigned(FBuf) then
  begin
    FreeMem(FBuf);
    FBuf := nil;
  end;
end;

function TSuperWriterString.GetString: SOString;
begin
  SetString(Result, FBuf, FBPos);
end;

procedure TSuperWriterString.Reset;
begin
  FBuf[0] := #0;
  FBPos := 0;
end;

procedure TSuperWriterString.TrimRight;
{+}
{$IFDEF NEXTGEN}
  function IsCharIn321310(x: Char): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin
    if Ord(x) < 256 then
    case x of
      #32,#13,#10:
        Exit(True);
    end;
    Result := False;
  end;
{$ENDIF}
{+.}
begin
  while (FBPos > 0) and (FBuf[FBPos-1] < #256) and {+} {$IFDEF NEXTGEN}
    //IsCharInStr(FBuf[FBPos-1], #32#13#10)
    IsCharIn321310(FBuf[FBPos-1])
    {$ELSE}
    CharInSet(FBuf[FBPos-1], [#32, #13, #10])
    {$ENDIF}{+.} do
  begin
    dec(FBPos);
    FBuf[FBPos] := #0;
  end;
end;

{ TSuperWriterStream }

function TSuperWriterStream.Append(buf: PSOChar): Integer;
begin
  Result := Append(buf, StrLen(buf));
end;

constructor TSuperWriterStream.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
end;

procedure TSuperWriterStream.Reset;
begin
  FStream.Size := 0;
end;

{ TSuperEscapedWriterStream }

function TSuperEscapedWriterStream.Append(buf: PSOChar; Size: Integer): Integer;
const
  BUFFER_SIZE = 1024;
var
  Buffer: array[0..BUFFER_SIZE-1] of {$IFDEF DELPHI_UNICODE}Byte{$ELSE}AnsiChar{$ENDIF};
  pBuffer: {$IFDEF NEXTGEN}PByte{$ELSE}PAnsiChar{$ENDIF};
  aBuffer: {$IFDEF DELPHI_UNICODE}TBytes{$ELSE}AnsiString{$ENDIF};
  i: Integer;
begin
  if Size = 1 then
    Result := FStream.Write(buf^, Size)         // reduced widechar
  else if Size > 0 then
  begin
    if Size <= BUFFER_SIZE then
      Pointer(pBuffer) := @Buffer
    else begin
      SetLength({%H-}aBuffer, Size);
      Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[{$IFDEF UNICODE}0{$ELSE}1{$ENDIF}]
    end;
    for i := 0 to Size - 1 do
      Byte(pBuffer[i]) := Byte(buf[i]);         // reduced widechar
    Result := FStream.Write(pBuffer^, Size);
  end
  else
    Result := 0;
end;

{ TSuperAnsiWriterStream }

function TSuperAnsiWriterStream.Append(buf: PSOChar; Size: Integer): Integer;
const
  BUFFER_SIZE = 1024;
var
  Buffer: array[0..BUFFER_SIZE] of {$IFDEF USE_TENCODING}Byte{$ELSE}AnsiChar{$ENDIF}; //+1 for TEncoding
  pBuffer: {$IFDEF USE_TENCODING}PByte{$ELSE}PAnsiChar{$ENDIF};
  aBuffer: {$IFDEF USE_TENCODING}TBytes{$ELSE}AnsiString{$ENDIF};
  {$IFDEF USE_TENCODING}i: Integer;{$ENDIF}
begin
  Result := 0;
  if Size <= 0 then
    Exit;
  {+}
  {$IFNDEF USE_TENCODING}
  {+.}
  if Size <= BUFFER_SIZE then
    Pointer(pBuffer) := @Buffer
  else begin
    SetLength(aBuffer, Size);
    Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[{$IFDEF UNICODE}0{$ELSE}1{$ENDIF}]
  end;
  {+}
  {$ENDIF !USE_TENCODING}
  {+.}
  {$IFDEF USE_TENCODING}
  i := TEncoding.ANSI.GetMaxByteCount(size);
  if i <= BUFFER_SIZE then begin
    Pointer(pBuffer) := @Buffer;
    //function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; inline;
    size := TEncoding.ANSI.GetBytes(buf, size, PByte(pBuffer), BUFFER_SIZE); // TODO: two call TEncoding.ANSI => ?with TEncoding.ANSI
  end else begin
////    aBuffer := TEncoding.ANSI.GetBytes({$ifdef FPC}MakeSOBytes{$ELSE}MakeSOString{$ENDIF}(buf, Size));      // TODO: optimize memory allocation
    aBuffer := TEncoding.ANSI.GetBytes(MakeSOString(buf, Size));      // TODO: optimize memory allocation
    size := Length(aBuffer);
    Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[0]
  end;
  {$ELSE !USE_TENCODING}
  {$IFDEF USE_TENCODING}
  aBuffer := MakeSOBytes(buf, Size);
  {$ELSE}
  //TODO: FPC widestringmanager or ansistringmanager
  aBuffer := AnsiString(MakeSOString(buf, Size));
  {$ENDIF}
  size := Length(aBuffer);
  Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[0]
  {$ENDIF !USE_TENCODING}
  //
  if size > 0 then
    Result := FStream.Write(pBuffer^, Size);
end;

{ TSuperUTF8WriterStream }

function TSuperUTF8WriterStream.Append(buf: PSOChar; Size: Integer): Integer;
const // NB: buf contained terminator #0
  BUFFER_SIZE = 1024;
var
  Buffer: array[0..BUFFER_SIZE] of {$IFDEF DELPHI_UNICODE}Byte{$ELSE}AnsiChar{$ENDIF}; // +1 for UTF8
  pBuffer: {$IFDEF DELPHI_UNICODE}PByte{$ELSE}PAnsiChar{$ENDIF};
  aBuffer: {$IFDEF DELPHI_UNICODE}TBytes{$ELSE}AnsiString{$ENDIF};
  i: Integer;
begin
  Result := 0;
  if Size <= 0 then
    Exit;
  {$IFDEF USE_TENCODING}
  i := TEncoding.UTF8.GetMaxByteCount(size);
  if i <= BUFFER_SIZE then begin
    Pointer(pBuffer) := @Buffer;
    size := TEncoding.UTF8.GetBytes(buf, size, PByte(pBuffer), BUFFER_SIZE); // TODO: two call TEncoding.UTF8 => ?with TEncoding.UTF8
  end else begin
    // slowly:
    //         ( because exiss convertation pwidechar to unicode )
    // //aBuffer := TEncoding.UTF8.GetBytes(buf);                  // slowly: NB: buf contained terminator #0. Hidden calls: _PWCharLen _UStrFromPWChar
    //aBuffer := TEncoding.UTF8.GetBytes(MakeSOString(buf, Size)); // slowly: NB: buf contained terminator #0.  Hiddeh calls: _UStrFromPWCharLen
    //size := Length(aBuffer);
    //Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[0]
    //
    // optimized:
    SetLength({%H-}aBuffer, i);
    Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[0]
    size := TEncoding.UTF8.GetBytes(buf, size, PByte(pBuffer), i);
  end;
  {$ELSE !USE_TENCODING}
  i := size*3+1;
  if i <= BUFFER_SIZE then
    Pointer(pBuffer) := @Buffer
  else begin
    SetLength(aBuffer, i-1); // SetLength includes space for null terminator for "AnsiString"
    Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[1]
  end;
  size := UnicodeToUtf8(PAnsiChar(pBuffer), i, PWideChar(buf), size)-1;
  {$ENDIF !USE_TENCODING}
  if size > 0 then
    Result := FStream.Write(pBuffer^, Size);
end;

{ TSuperUnicodeWriterStream }

function TSuperUnicodeWriterStream.Append(buf: PSOChar; Size: Integer): Integer;
begin
  Result := FStream.Write(buf^, Size * 2);
end;

{ TSuperWriterFake }

function TSuperWriterFake.Append(buf: PSOChar; Size: Integer): Integer;
begin
  inc(FSize, Size);
  Result := FSize;
end;

function TSuperWriterFake.Append(buf: PSOChar): Integer;
begin
  inc(FSize, Strlen(buf));
  Result := FSize;
end;

constructor TSuperWriterFake.Create;
begin
  inherited;
  FSize := 0;
end;

procedure TSuperWriterFake.Reset;
begin
  FSize := 0;
end;

{ TSuperWriterSock }

{+}
function TSuperWriterSock.SendBuffer;//(buf: Pointer; size: Integer): Integer;
begin
  //if Assigned(buf) and (size>0) then
  {$IFDEF FPC}
  Result := fpsend(FSocket, buf, size, 0);
  {$ELSE}
  Result := send(FSocket, buf^, size, 0);
  {$ENDIF}
end;
{+.}

function TSuperWriterSock.Append(buf: PSOChar; Size: Integer): Integer;
{+} // TODO: Q>: ? buf contained terminator #0 or not ?
const
  BUFFER_SIZE = 1024;
var
  Buffer: array[0..BUFFER_SIZE] of {$IFDEF DELPHI_UNICODE}Byte{$ELSE}AnsiChar{$ENDIF}; // +1 for UTF8
  pBuffer: {$IFDEF DELPHI_UNICODE}PByte{$ELSE}PAnsiChar{$ENDIF};
  aBuffer: {$IFDEF DELPHI_UNICODE}TBytes{$ELSE}AnsiString{$ENDIF}; // TODO: ?move to internal field
  i: Integer;
{+.}
begin // TODO: test
  Result := 0;
  if Size <= 0 then
    Exit;
  if (Size = 1) {+}and FEscaped{+.} then
    Result := SendBuffer(buf, size) // reduced widechar
  else begin
    {+}
    if not FEscaped then begin // send as UTF8
      {$IFDEF USE_TENCODING}
      i := TEncoding.UTF8.GetMaxByteCount(size);
      if i <= BUFFER_SIZE then begin
        Pointer(pBuffer) := @Buffer;
        size := TEncoding.UTF8.GetBytes(buf, size, PByte(pBuffer), BUFFER_SIZE); // TODO: two call TEncoding.UTF8 => ?with TEncoding.UTF8
      end else begin
        // slowly:
        //         ( because exiss convertation pwidechar to unicode )
        //aBuffer := TEncoding.UTF8.GetBytes(MakeSOString(buf, Size)); // slowly: NB: Hiddeh calls: _UStrFromPWCharLen
        //size := Length(aBuffer);
        //Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[0]
        //
        // optimized:
        SetLength({%H-}aBuffer, i);
        Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[0]
        size := TEncoding.UTF8.GetBytes(buf, size, PByte(pBuffer), i);
      end;
      {$ELSE !USE_TENCODING}
      i := size*3+1;
      if i <= BUFFER_SIZE then
        Pointer(pBuffer) := @Buffer
      else begin
        SetLength(aBuffer, i-1); // SetLength includes space for null terminator
        Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[1]
      end;
      size := UnicodeToUtf8(PAnsiChar(pBuffer), i, PWideChar(buf), size)-1;
      {$ENDIF !USE_TENCODING}
      if size <= 0 then
        Exit;
    end else {+.} begin // send with reduced chars
      {+}
      if Size <= BUFFER_SIZE then
        Pointer(pBuffer) := @Buffer
      else begin
        SetLength(aBuffer, Size);
        Pointer(pBuffer) := @(Pointer(aBuffer)^); // == @aBuffer[{$IFDEF UNICODE}0{$ELSE}1{$ENDIF}]
      end;
      {+.}
      for i :=  0 to Size - 1 do
        Byte(pBuffer[i]) := Byte(buf[i]); // reduced widechar
    end;
    Result := SendBuffer(pBuffer, size);
  end;
  inc(FSize, Result);
end;

function TSuperWriterSock.Append(buf: PSOChar): Integer;
begin
  Result := Append(buf, StrLen(buf));
end;

constructor TSuperWriterSock.Create(ASocket: longint{+}; escaped: boolean{+.});
begin
  inherited Create;
  FSocket := ASocket;
  FSize := 0;
  {+}FEscaped := escaped;{+.}
end;

procedure TSuperWriterSock.Reset;
begin
  FSize := 0;
end;

{ TSuperTokenizer }

constructor TSuperTokenizer.Create;
begin
  inherited;
  pb := TSuperWriterString.Create;
  line := 1;
  col := 0;
  Reset();
end;

destructor TSuperTokenizer.Destroy;
begin
  Reset();
  FreeAndNil(pb);
  inherited;
end;

procedure TSuperTokenizer.Reset;
var
  i: integer;
begin
  for i := depth downto 0 do
    ResetLevel(i);
  depth := 0;
  err := teSuccess;
end;

procedure TSuperTokenizer.ResetLevel(adepth: integer);
begin
  stack[adepth].state := tsEatws;
  stack[adepth].saved_state := tsStart;
  stack[adepth].current := nil;
  stack[adepth].field_name := '';
  stack[adepth].obj := nil;
  stack[adepth].parent := nil;
  stack[adepth].gparent := nil;
end;

{ TSuperAvlTree }

constructor TSuperAvlTree.Create;
begin
  FRoot := nil;
  FCount := 0;
  inherited;
end;

destructor TSuperAvlTree.Destroy;
begin
  Clear((*?{all:}True*)); // TODO: ?all
  inherited;
end;

function TSuperAvlTree.IsEmpty: boolean;
begin
  Result := FRoot = nil;
end;

function TSuperAvlTree.balance(bal: TSuperAvlEntry): TSuperAvlEntry;
var
  deep, old: TSuperAvlEntry;
  bf: integer;
begin
  if (bal.FBf > 0) then
  begin
    deep := bal.FGt;
    if (deep.FBf < 0) then
    begin
      old := bal;
      bal := deep.FLt;
      old.FGt := bal.FLt;
      deep.FLt := bal.FGt;
      bal.FLt := old;
      bal.FGt := deep;
      bf := bal.FBf;
      if (bf <> 0) then
      begin
        if (bf > 0) then
        begin
          old.FBf := -1;
          deep.FBf := 0;
        end else
        begin
          deep.FBf := 1;
          old.FBf := 0;
        end;
        bal.FBf := 0;
      end else
      begin
        old.FBf := 0;
        deep.FBf := 0;
      end;
    end else
    begin
      bal.FGt := deep.FLt;
      deep.FLt := bal;
      if (deep.FBf = 0) then
      begin
        deep.FBf := -1;
        bal.FBf := 1;
      end else
      begin
        deep.FBf := 0;
        bal.FBf := 0;
      end;
      bal := deep;
    end;
  end else
  begin
    (* "Less than" subtree is deeper. *)

    deep := bal.FLt;
    if (deep.FBf > 0) then
    begin
      old := bal;
      bal := deep.FGt;
      old.FLt := bal.FGt;
      deep.FGt := bal.FLt;
      bal.FGt := old;
      bal.FLt := deep;

      bf := bal.FBf;
      if (bf <> 0) then
      begin
        if (bf < 0) then
        begin
          old.FBf := 1;
          deep.FBf := 0;
        end else
        begin
          deep.FBf := -1;
          old.FBf := 0;
        end;
        bal.FBf := 0;
      end else
      begin
        old.FBf := 0;
        deep.FBf := 0;
      end;
    end else
    begin
      bal.FLt := deep.FGt;
      deep.FGt := bal;
      if (deep.FBf = 0) then
      begin
        deep.FBf := 1;
        bal.FBf := -1;
      end else
      begin
        deep.FBf := 0;
        bal.FBf := 0;
      end;
      bal := deep;
    end;
  end;
  Result := bal;
end;

function TSuperAvlTree.Insert(h: TSuperAvlEntry): TSuperAvlEntry;
var
  unbal, parentunbal, hh, parent: TSuperAvlEntry;
  depth, unbaldepth: longint;
  cmp: integer;
  unbalbf: integer;
  branch: TSuperAvlBitArray;
  p: Pointer;
begin
  inc(FCount);
  h.FLt := nil;
  h.FGt := nil;
  h.FBf := 0;
  branch := [];

  if (FRoot = nil) then
    FRoot := h
  else
  begin
    unbal := nil;
    parentunbal := nil;
    depth := 0;
    unbaldepth := 0;
    hh := FRoot;
    parent := nil;
    repeat
      if (hh.FBf <> 0) then
      begin
        unbal := hh;
        parentunbal := parent;
        unbaldepth := depth;
      end;
      if hh.FHash <> h.FHash then
      begin
        if hh.FHash < h.FHash then cmp := -1 else
        if hh.FHash > h.FHash then cmp := 1 else
          cmp := 0;
      end else
        cmp := CompareNodeNode(h, hh);
      if (cmp = 0) then
      begin
        Result := hh;
        //exchange data
        p := hh.Ptr;
        hh.FPtr := h.Ptr;
        h.FPtr := p;
        doDeleteEntry(h, false);
        dec(FCount);
        exit;
      end;
      parent := hh;
      if (cmp > 0) then
      begin
        hh := hh.FGt;
        include(branch, depth);
      end else
      begin
        hh := hh.FLt;
        exclude(branch, depth);
      end;
      inc(depth);
    until (hh = nil);

    if (cmp < 0) then
      parent.FLt := h else
      parent.FGt := h;

    depth := unbaldepth;

    if (unbal = nil) then
      hh := FRoot
    else
    begin
      if depth in branch then
        cmp := 1 else
        cmp := -1;
      inc(depth);
      unbalbf := unbal.FBf;
      if (cmp < 0) then
        dec(unbalbf) else
        inc(unbalbf);
      if cmp < 0 then
        hh := unbal.FLt else
        hh := unbal.FGt;
      if ((unbalbf <> -2) and (unbalbf <> 2)) then
      begin
        unbal.FBf := unbalbf;
        unbal := nil;
      end;
    end;

    if (hh <> nil) then
      while (h <> hh) do
      begin
        if depth in branch then
          cmp := 1 else
          cmp := -1;
        inc(depth);
        if (cmp < 0) then
        begin
          hh.FBf := -1;
          hh := hh.FLt;
        end else (* cmp > 0 *)
        begin
          hh.FBf := 1;
          hh := hh.FGt;
        end;
      end;

    if (unbal <> nil) then
    begin
      unbal := balance(unbal);
      if (parentunbal = nil) then
        FRoot := unbal
      else
      begin
        depth := unbaldepth - 1;
        if depth in branch then
          cmp := 1 else
          cmp := -1;
        if (cmp < 0) then
          parentunbal.FLt := unbal else
          parentunbal.FGt := unbal;
      end;
    end;
  end;
  result := h;
end;

function TSuperAvlTree.Search(const k: SOString; st: TSuperAvlSearchTypes): TSuperAvlEntry;
var
  cmp, target_cmp: integer;
  match_h, h: TSuperAvlEntry;
  ha: Cardinal;
begin
  ha := TSuperAvlEntry.Hash(k);

  match_h := nil;
  h := FRoot;

  if (stLess in st) then
    target_cmp := 1 else
    if (stGreater in st) then
      target_cmp := -1 else
      target_cmp := 0;

  while (h <> nil) do
  begin
    if h.FHash < ha then cmp := -1 else
    if h.FHash > ha then cmp := 1 else
      cmp := 0;

    if cmp = 0 then
      cmp := CompareKeyNode(PSOChar(k), h);
    if (cmp = 0) then
    begin
      if (stEqual in st) then
      begin
        match_h := h;
        break;
      end;
      cmp := -target_cmp;
    end
    else
    if (target_cmp <> 0) then
      if ((cmp xor target_cmp) and SUPER_AVL_MASK_HIGH_BIT) = 0 then
        match_h := h;
    if cmp < 0 then
      h := h.FLt else
      h := h.FGt;
  end;
  result := match_h;
end;

function TSuperAvlTree.Delete(const k: SOString): ISuperObject;
var
  depth, rm_depth: longint;
  branch: TSuperAvlBitArray;
  h, parent, child, path, rm, parent_rm: TSuperAvlEntry;
  cmp, cmp_shortened_sub_with_path, reduced_depth, bf: integer;
  ha: Cardinal;
begin
  ha := TSuperAvlEntry.Hash(k);
  cmp_shortened_sub_with_path := 0;
  branch := [];

  depth := 0;
  h := FRoot;
  parent := nil;
  while true do
  begin
    if (h = nil) then
      exit;
    if h.FHash < ha then cmp := -1 else
    if h.FHash > ha then cmp := 1 else
      cmp := 0;

    if cmp = 0 then
      cmp := CompareKeyNode(k, h);
    if (cmp = 0) then
      break;
    parent := h;
    if (cmp > 0) then
    begin
      h := h.FGt;
      include(branch, depth)
    end else
    begin
      h := h.FLt;
      exclude(branch, depth)
    end;
    inc(depth);
    cmp_shortened_sub_with_path := cmp;
  end;
  rm := h;
  parent_rm := parent;
  rm_depth := depth;

  if (h.FBf < 0) then
  begin
    child := h.FLt;
    exclude(branch, depth);
    cmp := -1;
  end else
  begin
    child := h.FGt;
    include(branch, depth);
    cmp := 1;
  end;
  inc(depth);

  if (child <> nil) then
  begin
    cmp := -cmp;
    repeat
      parent := h;
      h := child;
      if (cmp < 0) then
      begin
        child := h.FLt;
        exclude(branch, depth);
      end else
      begin
        child := h.FGt;
        include(branch, depth);
      end;
      inc(depth);
    until (child = nil);

    if (parent = rm) then
      cmp_shortened_sub_with_path := -cmp else
      cmp_shortened_sub_with_path := cmp;

    if cmp > 0 then
      child := h.FLt else
      child := h.FGt;
  end;

  if (parent = nil) then
    FRoot := child else
    if (cmp_shortened_sub_with_path < 0) then
      parent.FLt := child else
      parent.FGt := child;

  if parent = rm then
    path := h else
    path := parent;

  if (h <> rm) then
  begin
    h.FLt := rm.FLt;
    h.FGt := rm.FGt;
    h.FBf := rm.FBf;
    if (parent_rm = nil) then
      FRoot := h
    else
    begin
      depth := rm_depth - 1;
      if (depth in branch) then
        parent_rm.FGt := h else
        parent_rm.FLt := h;
    end;
  end;

  if (path <> nil) then
  begin
    h := FRoot;
    parent := nil;
    depth := 0;
    while (h <> path) do
    begin
      if (depth in branch) then
      begin
        child := h.FGt;
        h.FGt := parent;
      end else
      begin
        child := h.FLt;
        h.FLt := parent;
      end;
      inc(depth);
      parent := h;
      h := child;
    end;

    reduced_depth := 1;
    cmp := cmp_shortened_sub_with_path;
    while true do
    begin
      if (reduced_depth <> 0) then
      begin
        bf := h.FBf;
        if (cmp < 0) then
          inc(bf) else
          dec(bf);
        if ((bf = -2) or (bf = 2)) then
        begin
          h := balance(h);
          bf := h.FBf;
        end else
          h.FBf := bf;
        reduced_depth := integer(bf = 0);
      end;
      if (parent = nil) then
        break;
      child := h;
      h := parent;
      dec(depth);
      if depth in branch then
        cmp := 1 else
        cmp := -1;
      if (cmp < 0) then
      begin
        parent := h.FLt;
        h.FLt := child;
      end else
      begin
        parent := h.FGt;
        h.FGt := child;
      end;
    end;
    FRoot := h;
  end;
  if rm <> nil then
  begin
    Result := rm.GetValue;
    doDeleteEntry(rm, false);
    dec(FCount);
  end;
end;

procedure TSuperAvlTree.Pack(all: boolean);
var
  node1, node2: TSuperAvlEntry;
  list: TList;
  i: Integer;
begin
  node1 := FRoot;
  list := TList.Create;
  while node1 <> nil do
  begin
    if (node1.FLt = nil) then
    begin
      node2 := node1.FGt;
      if (node1.FPtr = nil) then
        list.Add(node1) else
        if all then
          node1.Value.Pack(all);
    end
    else
    begin
      node2 := node1.FLt;
      node1.FLt := node2.FGt;
      node2.FGt := node1;
    end;
    node1 := node2;
  end;
  for i := 0 to list.Count - 1 do
    Delete(TSuperAvlEntry(list[i]).FName);
  list.Free;
end;

procedure TSuperAvlTree.Clear(all: boolean);
var
  node1, node2: TSuperAvlEntry;
begin
  node1 := FRoot;
  while node1 <> nil do
  begin
    if (node1.FLt = nil) then
    begin
      node2 := node1.FGt;
      doDeleteEntry(node1, all);
    end
    else
    begin
      node2 := node1.FLt;
      node1.FLt := node2.FGt;
      node2.FGt := node1;
    end;
    node1 := node2;
  end;
  FRoot := nil;
  FCount := 0;
end;

function TSuperAvlTree.CompareKeyNode(const k: SOString; h: TSuperAvlEntry): integer;
begin
  Result := StrComp(PSOChar(k), PSOChar(h.FName));
end;

function TSuperAvlTree.CompareNodeNode(node1, node2: TSuperAvlEntry): integer;
begin
  Result := StrComp(PSOChar(node1.FName), PSOChar(node2.FName));
end;

{ TSuperAvlIterator }

(* Initialize depth to invalid value, to indicate iterator is
** invalid.   (Depth is zero-base.)  It's not necessary to initialize
** iterators prior to passing them to the "start" function.
*)

constructor TSuperAvlIterator.Create(tree: TSuperAvlTree);
begin
  inherited Create;
  FDepth := not 0;
  FTree := tree;
end;

procedure TSuperAvlIterator.Search(const k: SOString; st: TSuperAvlSearchTypes);
var
  h: TSuperAvlEntry;
  d: longint;
  cmp, target_cmp: integer;
  ha: Cardinal;
begin
  ha := TSuperAvlEntry.Hash(k);
  h := FTree.FRoot;
  d := 0;
  FDepth := not 0;
  if (h = nil) then
    exit;

  if (stLess in st) then
    target_cmp := 1 else
      if (stGreater in st) then
        target_cmp := -1 else
          target_cmp := 0;

  while true do
  begin
    if h.FHash < ha then cmp := -1 else
    if h.FHash > ha then cmp := 1 else
      cmp := 0;

    if cmp = 0 then
      cmp := FTree.CompareKeyNode(k, h);
    if (cmp = 0) then
    begin
      if (stEqual in st) then
      begin
        FDepth := d;
        break;
      end;
      cmp := -target_cmp;
    end
    else
    if (target_cmp <> 0) then
      if ((cmp xor target_cmp) and SUPER_AVL_MASK_HIGH_BIT) = 0 then
        FDepth := d;
    if cmp < 0 then
      h := h.FLt else
      h := h.FGt;
    if (h = nil) then
      break;
    if (cmp > 0) then
      include(FBranch, d) else
      exclude(FBranch, d);
    FPath[d] := h;
    inc(d);
  end;
end;

procedure TSuperAvlIterator.First;
var
  h: TSuperAvlEntry;
begin
  h := FTree.FRoot;
  FDepth := not 0;
  FBranch := [];
  while (h <> nil) do
  begin
    if (FDepth <> not 0) then
      FPath[FDepth] := h;
    inc(FDepth);
    h := h.FLt;
  end;
end;

procedure TSuperAvlIterator.Last;
var
  h: TSuperAvlEntry;
begin
  h := FTree.FRoot;
  FDepth := not 0;
  FBranch := [0..SUPER_AVL_MAX_DEPTH - 1];
  while (h <> nil) do
  begin
    if (FDepth <> not 0) then
      FPath[FDepth] := h;
    inc(FDepth);
    h := h.FGt;
  end;
end;

function TSuperAvlIterator.MoveNext: boolean;
begin
  if FDepth = not 0 then
    First else
    Next;
  Result := GetIter <> nil;
end;

function TSuperAvlIterator.GetIter: TSuperAvlEntry;
begin
  if (FDepth = not 0) then
  begin
    result := nil;
    exit;
  end;
  if FDepth = 0 then
    Result := FTree.FRoot else
    Result := FPath[FDepth - 1];
end;

procedure TSuperAvlIterator.Next;
var
  h: TSuperAvlEntry;
begin
  if (FDepth <> not 0) then
  begin
    if FDepth = 0 then
      h := FTree.FRoot.FGt else
      h := FPath[FDepth - 1].FGt;

    if (h = nil) then
      repeat
        if (FDepth = 0) then
        begin
          FDepth := not 0;
          break;
        end;
        dec(FDepth);
      until (not (FDepth in FBranch))
    else
    begin
      include(FBranch, FDepth);
      FPath[FDepth] := h;
      inc(FDepth);
      while true do
      begin
        h := h.FLt;
        if (h = nil) then
          break;
        exclude(FBranch, FDepth);
        FPath[FDepth] := h;
        inc(FDepth);
      end;
    end;
  end;
end;

procedure TSuperAvlIterator.Prior;
var
  h: TSuperAvlEntry;
begin
  if (FDepth <> not 0) then
  begin
    if FDepth = 0 then
      h := FTree.FRoot.FLt else
      h := FPath[FDepth - 1].FLt;
    if (h = nil) then
      repeat
        if (FDepth = 0) then
        begin
          FDepth := not 0;
          break;
        end;
        dec(FDepth);
      until (FDepth in FBranch)
    else
    begin
      exclude(FBranch, FDepth);
      FPath[FDepth] := h;
      inc(FDepth);
      while true do
      begin
        h := h.FGt;
        if (h = nil) then
          break;
        include(FBranch, FDepth);
        FPath[FDepth] := h;
        inc(FDepth);
      end;
    end;
  end;
end;

procedure TSuperAvlTree.doDeleteEntry(Entry: TSuperAvlEntry; all: boolean);
begin
  Entry.Free;
end;

function TSuperAvlTree.GetEnumerator: TSuperAvlIterator;
begin
  Result := TSuperAvlIterator.Create(Self);
end;

{ TSuperAvlEntry }

constructor TSuperAvlEntry.Create(const AName: SOString; Obj: Pointer);
begin
  inherited Create;
  FName := AName;
  FPtr := Obj;
  FHash := Hash(FName);
end;

function TSuperAvlEntry.GetValue: ISuperObject;
begin
  Result := ISuperObject(FPtr)
end;

{+} // https://code.google.com/p/superobject/issues/detail?id=22
    // integer overflow exception when overflow
    // https://code.google.com/p/superobject/issues/detail?id=13
{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{+.}
class function TSuperAvlEntry.Hash(const k: SOString): Cardinal;
var
  h: cardinal;
  i: Integer;
begin
  h := 0;
  for i := 1 to Length(k) do
    h := h*129 + ord(k[i]) + $9e370001;
  Result := h;
end;
{+}
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{+.}

procedure TSuperAvlEntry.SetValue(const val: ISuperObject);
begin
  ISuperObject(FPtr) := val;
end;

{ TSuperTableString }

function TSuperTableString.GetValues: ISuperObject;
var
  ite: TSuperAvlIterator;
  obj: TSuperAvlEntry;
begin
  Result := TSuperObject.Create(stArray);
  ite := TSuperAvlIterator.Create(Self);
  try
    ite.First;
    obj := ite.GetIter;
    while obj <> nil do
    begin
      Result.AsArray.Add(obj.Value);
      ite.Next;
      obj := ite.GetIter;
    end;
  finally
    ite.Free;
  end;
end;

function TSuperTableString.GetNames: ISuperObject;
var
  ite: TSuperAvlIterator;
  obj: TSuperAvlEntry;
begin
  Result := TSuperObject.Create(stArray);
  ite := TSuperAvlIterator.Create(Self);
  try
    ite.First;
    obj := ite.GetIter;
    while obj <> nil do
    begin
      Result.AsArray.Add(TSuperObject.Create(obj.FName));
      ite.Next;
      obj := ite.GetIter;
    end;
  finally
    ite.Free;
  end;
end;

procedure TSuperTableString.doDeleteEntry(Entry: TSuperAvlEntry; all: boolean);
begin
  if Entry.Ptr <> nil then
  begin
    if all then Entry.Value.Clear(true);
    Entry.Value := nil;
  end;
  inherited;
end;

function TSuperTableString.Find(const k: SOString; var value: ISuperObject): Boolean;
var
  e: TSuperAvlEntry;
begin
  e := Search(k);
  if e <> nil then
  begin
    value := e.Value;
    Result := True;
  end else
    Result := False;
end;

function TSuperTableString.Exists(const k: SOString): Boolean;
begin
  Result := Search(k) <> nil;
end;

function TSuperTableString.GetO(const k: SOString): ISuperObject;
var
  e: TSuperAvlEntry;
begin
  e := Search(k);
  if e <> nil then
    Result := e.Value else
    Result := nil
end;

procedure TSuperTableString.PutO(const k: SOString; const value: ISuperObject);
var
  entry: TSuperAvlEntry;
begin
  entry := Insert(TSuperAvlEntry.Create(k, Pointer(value)));
  if entry.FPtr <> nil then
    ISuperObject(entry.FPtr)._AddRef;
end;

procedure TSuperTableString.PutS(const k: SOString; const value: SOString);
begin
  PutO(k, TSuperObject.Create(Value));
end;

function TSuperTableString.GetS(const k: SOString): SOString;
var
  obj: ISuperObject;
begin
 obj := GetO(k);
 if obj <> nil then
   Result := obj.AsString else
   Result := '';
end;

procedure TSuperTableString.PutI(const k: SOString; value: SuperInt);
begin
  PutO(k, TSuperObject.Create(Value));
end;

function TSuperTableString.GetI(const k: SOString): SuperInt;
var
  obj: ISuperObject;
begin
 obj := GetO(k);
 if obj <> nil then
   Result := obj.AsInteger else
   Result := 0;
end;

procedure TSuperTableString.PutD(const k: SOString; value: Double);
begin
  PutO(k, TSuperObject.Create(Value));
end;

procedure TSuperTableString.PutC(const k: SOString; value: Currency);
begin
  PutO(k, TSuperObject.CreateCurrency(Value));
end;

function TSuperTableString.GetC(const k: SOString): Currency;
var
  obj: ISuperObject;
begin
 obj := GetO(k);
 if obj <> nil then
   Result := obj.AsCurrency else
   Result := 0.0;
end;

function TSuperTableString.GetD(const k: SOString): Double;
var
  obj: ISuperObject;
begin
 obj := GetO(k);
 if obj <> nil then
   Result := obj.AsDouble else
   Result := 0.0;
end;

procedure TSuperTableString.PutB(const k: SOString; value: Boolean);
begin
  PutO(k, TSuperObject.Create(Value));
end;

function TSuperTableString.GetB(const k: SOString): Boolean;
var
  obj: ISuperObject;
begin
 obj := GetO(k);
 if obj <> nil then
   Result := obj.AsBoolean else
   Result := False;
end;

{$IFDEF SUPER_METHOD}
procedure TSuperTableString.PutM(const k: SOString; value: TSuperMethod);
begin
  PutO(k, TSuperObject.Create(Value));
end;
{$ENDIF}

{$IFDEF SUPER_METHOD}
function TSuperTableString.GetM(const k: SOString): TSuperMethod;
var
  obj: ISuperObject;
begin
 obj := GetO(k);
 if obj <> nil then
   Result := obj.AsMethod else
   Result := nil;
end;
{$ENDIF}

procedure TSuperTableString.PutN(const k: SOString; const value: ISuperObject);
begin
  if value <> nil then
  {+} // https://code.google.com/p/superobject/issues/detail?id=60
    PutO(k, value)
  else
    PutO(k, TSuperObject.Create(stNull));
  {+.}
end;

function TSuperTableString.GetN(const k: SOString): ISuperObject;
var
  obj: ISuperObject;
begin
 obj := GetO(k);
 if obj <> nil then
   Result := obj else
   Result := TSuperObject.Create(stNull);
end;

{$IFDEF HAVE_RTTI}

{ TSuperAttribute }

constructor TSuperAttribute.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

{+} // https://code.google.com/p/superobject/issues/detail?id=16
{$IFDEF USE_REFLECTION}
type
  // Imported from DSharp library: DSharp.Core.Reflection.pas: class: "TRttiObjectHelper"
  TRttiObjectHelper = class helper for TRttiObject
  public
    function GetCustomAttribute<T: TCustomAttribute>: T;
    function GetCustomAttributes: TArray<TCustomAttribute>; overload;
    function GetCustomAttributes<T: TCustomAttribute>: TArray<T>; overload;
    function GetCustomAttributes(attributeType: TClass; MaxCount: Integer = 0): TArray<TCustomAttribute>; overload;
  end;
//
{ TRttiObjectHelper }
//
function TRttiObjectHelper.GetCustomAttribute<T>: T;
begin
  Result := Default(T);
  //for Result in GetCustomAttributes<T> do
  //  Break;
  for Result in TArray<T>(GetCustomAttributes(TClass(T), {MaxCount:}1)) do ;
end;
//
function TRttiObjectHelper.GetCustomAttributes: TArray<TCustomAttribute>;
begin
  {$IFDEF FPC}
  Result := TArray<TCustomAttribute>(GetCustomAttributes(TCustomAttribute));
  {$ELSE}
  Result := GetCustomAttributes<TCustomAttribute>; // FPC: Error: Illegal expression
  {$ENDIF}
end;
//
function TRttiObjectHelper.GetCustomAttributes<T>: TArray<T>;
begin
  Result := TArray<T>(GetCustomAttributes(TClass(T)));
end;
//
function TRttiObjectHelper.GetCustomAttributes(attributeType: TClass; MaxCount: Integer): TArray<TCustomAttribute>;
var
  A: TCustomAttribute;
begin
  {%H-}Result := nil;
  SetLength({%H-}Result, 0);
  for A in GetAttributes do begin
    if A.InheritsFrom(attributeType) then begin
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := A;
      if (MaxCount > 0) and (Length(Result) >= MaxCount) then
        Exit;
    end;
  end;
end;
{$ENDIF USE_REFLECTION}
{+.}

{ TClassAttribute }

constructor TClassAttribute.Create(const AElements: TClassElements; const AIgnoredName: string);
begin
  inherited Create;
  FElements := AElements;
  FIgnoredName := AIgnoredName;
end;

constructor TClassAttribute.Create(const AElements: Cardinal; const AIgnoredName: string);
begin
  if(AElements and cst_ce_property = cst_ce_property) then
    Create([ceProperty], AIgnoredName)
  else
    Create([], AIgnoredName);
end;

function TClassAttribute.IsIgnoredName(const AName: string): Boolean;
begin
  Result := SameText(FIgnoredName, AName);
end;

{ TSuperTypeMap }

constructor TSuperTypeMap.Create(ATypeInfo: PTypeInfo);
begin
  inherited Create;
  FTypeInfo := ATypeInfo;
end;

{ SOTypeMap<T> }

constructor SOTypeMap<T>.Create();
begin
  inherited Create(nil);
  FTypeInfo := TypeInfo(T);
end;

{ TSuperMREWSync }
{$if declared(TSuperMREWSync)}

constructor TSuperMREWSync.Create(AObj: Pointer);
begin
  inherited Create;
  FObj := AObj;
end;

procedure TSuperMREWSync.BeginRead;
begin
  AtomicIncrement(FLocks);
  inherited BeginRead;
end;

function TSuperMREWSync.EndRead: Integer;
begin
  if (FLocks > 0) then begin
    inherited EndRead;
    Result := AtomicDecrement(FLocks);
  end else begin
    Result := 0;
  end;
end;

function TSuperMREWSync.BeginWrite: Boolean;
begin
  AtomicIncrement(FLocks);
  Result := inherited BeginWrite;
  if not Result then
    AtomicDecrement(FLocks);
end;

function TSuperMREWSync.EndWrite: Integer;
begin
  if (FLocks > 0) then begin
    inherited EndWrite;
    Result := AtomicDecrement(FLocks);
  end else begin
    Result := 0;
  end;
end;
{$ifend} // declared(TSuperMREWSync)

{ TSuperRttiContext }

constructor TSuperRttiContext.Create;
begin
  inherited;

  FForceDefault := True;
  FForceSet := True; // OLD: False
  FForceEnumeration := True; // OLD: False
  FForceBaseType := True; // OLD: False
  FForceTypeMap := False;
  FForceSerializer := False;

  FRWSynchronize := False;
  {$if declared(TSuperMREWSync)}
  FMREWSyncLocks := TObjectDictionary<{Key: @<T>}Pointer, {Value:}TSuperMREWSync>.Create([doOwnsValues]);
  {$ifend}

  SuperDateTimeZoneHandling := sdzUTC;
  SuperDateFormatHandling := sdfISO; // OLD: sdfJava

  Context := TRttiContext.Create;
  SerialFromJson := TDictionary<PTypeInfo, TSerialFromJson>.Create;
  SerialToJson := TDictionary<PTypeInfo, TSerialToJson>.Create;

  SerialFromJson.Add(TypeInfo(Boolean), SerialFromBoolean);
  SerialToJson.Add(TypeInfo(Boolean), SerialToBoolean);

  SerialFromJson.Add(TypeInfo(TDateTime), SerialFromDateTime);
  SerialToJson.Add(TypeInfo(TDateTime), SerialToDateTime);

  SerialFromJson.Add(TypeInfo(TGUID), SerialFromGuid);
  SerialToJson.Add(TypeInfo(TGUID), SerialToGuid);

  {+} // https://code.google.com/p/superobject/issues/detail?id=16
  {$IFDEF USE_REFLECTION}
  FieldsVisibility := [mvPrivate, mvProtected, mvPublic, mvPublished];
  PropertiesVisibility := [];
  {$ENDIF}
  {+.}
end;

destructor TSuperRttiContext.Destroy;
begin
  if Self = SuperRttiContextDefault then
    SuperRttiContextDefault := nil;
  FreeAndNil(SerialFromJson);
  FreeAndNil(SerialToJson);
  Context.Free; // record
  {$if declared(TSuperMREWSync)}
  FreeAndNil(FMREWSyncLocks);
  {$ifend}
  inherited;
end;

procedure TSuperRttiContext.BeginRead(Obj: Pointer; var L: TMREWSyncHandle);
{$if declared(TSuperMREWSync)}
var
  S: TSuperMREWSync;
{$ifend}
begin
  L := nil;
  {$if declared(TSuperMREWSync)}
  if FRWSynchronize then begin
    TMonitor.Enter(Self);
    try
      if FRWSynchronize then begin
        if not FMREWSyncLocks.TryGetValue(Obj, S) then begin
          S := TSuperMREWSync.Create(Obj);
          FMREWSyncLocks.Add(Obj, S);
        end;
        L := TMREWSyncHandle(S);
        S.BeginRead;
      end;
    finally
      TMonitor.Exit(Self);
    end;
  end;
  {$ifend} // declared(TSuperMREWSync)
end;

procedure TSuperRttiContext.BeginRead<T>(const obj: T; var L: TMREWSyncHandle);
begin
  BeginRead(@Obj, L);
end;

procedure TSuperRttiContext.EndRead(var L: TMREWSyncHandle);
{$if declared(TSuperMREWSync)}
var
  S: TSuperMREWSync;
{$ifend}
begin
  {$if declared(TSuperMREWSync)}
  if Assigned(L) then begin
    S := TSuperMREWSync(L);
    if (S.EndRead = 0) then begin
      TMonitor.Enter(Self);
      try
        if (S.Locks = 0) then
          FMREWSyncLocks.Remove(S.Obj);
      finally
        TMonitor.Exit(Self);
      end;
    end;
  end;
  {$ifend} // declared(TSuperMREWSync)
  L := nil;
end;

procedure TSuperRttiContext.BeginWrite(Obj: Pointer; var L: TMREWSyncHandle);
{$if declared(TSuperMREWSync)}
var
  S: TSuperMREWSync;
{$ifend}
begin
  L := nil;
  {$if declared(TSuperMREWSync)}
  if FRWSynchronize then begin
    TMonitor.Enter(Self);
    try
      if FRWSynchronize then begin
        if not FMREWSyncLocks.TryGetValue(Obj, S) then begin
          S := TSuperMREWSync.Create(Obj);
          FMREWSyncLocks.Add(Obj, S);
        end;
        L := TMREWSyncHandle(S);
        S.BeginWrite;
      end;
    finally
      TMonitor.Exit(Self);
    end;
  end;
  {$ifend} // declared(TSuperMREWSync)
end;

procedure TSuperRttiContext.BeginWrite<T>(const obj: T; var L: TMREWSyncHandle);
begin
  BeginWrite(@Obj, L);
end;

procedure TSuperRttiContext.EndWrite(var L: TMREWSyncHandle);
{$if declared(TSuperMREWSync)}
var
  S: TSuperMREWSync;
{$ifend}
begin
  {$if declared(TSuperMREWSync)}
  if Assigned(L) then begin
    S := TSuperMREWSync(L);
    if (S.EndWrite = 0) then begin
      TMonitor.Enter(Self);
      try
        if (S.Locks = 0) then
          FMREWSyncLocks.Remove(S.Obj);
      finally
        TMonitor.Exit(Self);
      end;
    end;
  end;
  {$ifend} // declared(TSuperMREWSync)
  L := nil;
end;

class function TSuperRttiContext.IsArrayExportable(const aMember: TRttiMember): Boolean;
var
  A: TCustomAttribute;
begin
  for A in aMember.GetAttributes do begin
    if A.InheritsFrom(SOArray) then begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

class function TSuperRttiContext.IsExportable(const aType: TRttiType; const Element: TClassElement): Boolean;
var
  A: TCustomAttribute;
begin
  for A in aType.GetAttributes do begin
    if A.InheritsFrom(SOElements) then begin
      Result := Element in SOElements(A).Elements;
      Exit;
    end;
  end;
  Result := Element = ceField;
end;

class function TSuperRttiContext.IsIgnoredName(const aType: TRttiType; const aMember: TRttiMember): Boolean;
var
  A: TCustomAttribute;
begin
  for A in aType.GetAttributes do begin
    if A.InheritsFrom(SOElements) then begin
      Result := SOElements(A).IsIgnoredName(aMember.Name);
      Exit;
    end;
  end;
  Result := False;
end;

class function TSuperRttiContext.IsIgnoredObject(r: TRttiObject): Boolean;
var
  A: TCustomAttribute;
begin
  for A in r.GetAttributes do begin
    if A.InheritsFrom(SOIgnore) then begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

class function TSuperRttiContext.GetObjectTypeInfo(r: TRttiObject; aDef: PTypeInfo): PTypeInfo;
var
  A: TCustomAttribute;
begin //@dbg: r.Name
  for A in r.GetAttributes do begin
    if A.InheritsFrom(TSuperTypeMap) then begin
      Result := TSuperTypeMap(A).FTypeInfo;
      Exit;
    end;
  end;
  //if r is TRttiType then
  //  Result := r.Handle
  //else
  Result := aDef;
end;

function TSuperRttiContext.GetObjectTypeInfo(aType: PTypeInfo): PTypeInfo;
var
  r: TRttiType;
begin
  r := Context.GetType(aType);
  if Assigned(r) then
    Result := GetObjectTypeInfo(r, {Default:}aType)
  else
    Result := aType;
end;

class function TSuperRttiContext.GetObjectName(r: TRttiNamedObject): string;
var
  A: TCustomAttribute;
begin
  for A in r.GetAttributes do begin
    if A.InheritsFrom(SOName) then begin
      Result := SOName(A).Name;
      Exit;
    end;
  end;
  Result := r.Name;
end;

class function TSuperRttiContext.GetObjectDefault(r: TRttiObject; const obj: ISuperObject): ISuperObject;
var
  A: TCustomAttribute;
begin
  if not ObjectIsType(obj, stNull) then begin
    Result := obj;
    Exit;
  end;
  for A in r.GetAttributes do begin
    if A.InheritsFrom(SODefault) then begin
      Result := SO(SOString(SODefault(A).Name));
      Exit;
    end;
  end;
  Result := obj;
end;

function TSuperRttiContext.AsType<T>(const obj: ISuperObject): T;
var
  L: TMREWSyncHandle;
  ret: TValue;
begin
  BeginWrite(@obj, {%H-}L);
  try
    ret:= TValue.Empty; // https://code.google.com/p/superobject/issues/detail?id=53
    if FromJson(TypeInfo(T), obj, ret) then begin
      {$IFDEF FPC}
      ret.ExtractRawData(@Result);
      {$ELSE} //@dbg: ret.DataSize == SizeOf(Result)
      Result := ret.AsType<T>;
      {$ENDIF}
    end else
    begin // https://code.google.com/p/superobject/issues/detail?id=53
      if ret.Kind = tkClass then
      {$IFDEF AUTOREFCOUNT}
        ret := nil;
      {$ELSE}
        ret.AsObject.Free;
      {$ENDIF}
      raise ESuperObject.Create('Marshalling error');
    end;
  finally
    EndWrite(L);
  end;
end;

function TSuperRttiContext.AsJson<T>(const obj: T; const index: ISuperObject = nil): ISuperObject;
var
  L: TMREWSyncHandle;
  V: TValue;
begin
  BeginRead(@obj, {%H-}L);
  try
    TValue.Make(@obj, TypeInfo(T), V);
    if index <> nil then
      Result := ToJson(V, index) else
      Result := ToJson(V, SO());
  finally
    EndRead(L);
  end;
end;

function TSuperRttiContext.jFromChar(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
begin
  Result := ObjectIsType(obj, stString) and (Length(obj.AsString) = 1);
  if Result then
    Value := string({+}{AnsiString{+.}(obj.AsString)[1]);
end;

function TSuperRttiContext.jFromWideChar(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
begin
  Result := ObjectIsType(obj, stString) and (Length(obj.AsString) = 1);
  if Result then begin
    {$IFDEF FPC}
    Value := TValue.From<SOChar>( PSOChar(obj.AsString)^ );
    {$ELSE}
    Value := obj.AsString[1];
    {$ENDIF}
  end;
end;

function TSuperRttiContext.jFromInt64(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var
  i: Int64;
begin
  case ObjectGetType(obj) of
    stInt:
      begin
        TValue.Make(nil, ATypeInfo, Value);
        TValueData(Value).FAsSInt64 := obj.AsInteger;
        Result := True;
      end;
    stString:
      begin
        Result := TryStrToInt64(string(obj.AsString), i);
        if Result then begin
          TValue.Make(nil, ATypeInfo, Value);
          TValueData(Value).FAsSInt64 := i;
        end;
      end;
    else
      Result := False;
  end; // case
end;

function TSuperRttiContext.jFromInt(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var
  TypeData: PTypeData;
  i: Integer;
  o: ISuperObject;
begin
  case ObjectGetType(obj) of
    stInt, stBoolean:
      begin
        i := obj.AsInteger;
        TypeData := GetTypeData(ATypeInfo);
        if TypeData.MaxValue > TypeData.MinValue then
          Result := (i >= TypeData.MinValue) and (i <= TypeData.MaxValue)
        else
          Result := (i >= TypeData.MinValue) and (i <= Int64(PCardinal(@TypeData.MaxValue)^));
        if Result then
          TValue.Make(@i, ATypeInfo, Value);
      end;
    stString:
      begin
        o := SO(obj.AsString);
        Result := ObjectIsType(o, stString)
          or jFromInt(ATypeInfo, o, Value);
      end;
    else
      Result := False;
  end; // case
end;

function TSuperRttiContext.jFromEnumeration(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var
  SValue: string;
  i: Integer;
  TypeData: PTypeData;
begin
  case ObjectGetType(obj) of
    stInt:
      begin
        i := obj.AsInteger;
        if (i = -1) then begin // "-1" == True
           TValue.Make(nil, ATypeInfo, Value);
           TypeData := Value.TypeData;
           if (TypeData.MinValue = 0) and (TypeData.MaxValue = 1) then begin
             i := 1; // "-1" == True
             TValue.Make(@i, ATypeInfo, Value);
             Result := True;
             Exit;
           end;
        end;
        Result := jFromInt(ATypeInfo, obj, Value);
      end;
    stBoolean:
      Result := jFromInt(ATypeInfo, obj, Value);
    stString:
      begin
        SValue := string(obj.AsString);
        Result := TryStrToInt(SValue, i)
          and jFromInt(ATypeInfo, obj, Value);
        if (not Result) and FForceEnumeration then begin
           TValue.Make(nil, ATypeInfo, Value);
           TypeData := Value.TypeData;
            if (TypeData.MinValue = 0) and (TypeData.MaxValue = 1)
              and ( SameText(SValue, 'True') or SameText(SValue, 'False')
                or SameText(SValue, '1') or (SValue = '-1') or (SValue = '0')
              )
            then
            begin
              if SameText(SValue, 'True') or (SValue = '1') or (SValue = '-1')
              then i := 1
              else i := 0;
              TValue.Make(@i, ATypeInfo, Value);
              Result := True;
            end else begin
              i := {TypInfo.pas}GetEnumValue(ATypeInfo, SValue);
              if i >= 0 then begin
                TValue.Make(@i, ATypeInfo, Value);
                Result := True;
              end;
            end;
        end;
      end;
    else
      Result := False;
  end; // case
end;

function SuperSetToString(ATypeInfo: PTypeInfo; const ASetValue: Pointer; Brackets: Boolean): string;
begin
  if (ATypeInfo = nil) or (ATypeInfo.Kind <> tkSet) or (ASetValue = nil) then
    Exit;
  {$IF defined(FPC) or (CompilerVersion >= 30.00)} // @dbg: ATypeInfo.TypeData.SetTypeOrSize
  Result := TypInfo.SetToString(ATypeInfo, ASetValue, Brackets);
  {$ELSE}
  Result := TypInfo.SetToString(ATypeInfo, Integer(Word(ASetValue^)), Brackets);
  {$IFEND}
end;

function SuperSetToString(ATypeInfo: PTypeInfo; const ASetValue; Brackets: Boolean): string;
begin
  if (ATypeInfo = nil) or (ATypeInfo.Kind <> tkSet) or (@ASetValue = nil) then
    Exit;
  {$IF defined(FPC) or (CompilerVersion >= 30.00)} // @dbg: ATypeInfo.TypeData.SetTypeOrSize
  Result := TypInfo.SetToString(ATypeInfo, Pointer(@ASetValue), Brackets);
  {$ELSE}
  Result := TypInfo.SetToString(ATypeInfo, Integer(Word(ASetValue)), Brackets);
  {$IFEND}
end;

(*function SuperStringToSet(TypeInfo: PTypeInfo; const Value: string): Integer;
// Safe implementation of "TypInfo.pas"."StringToSet(PTypeInfo...)"
begin
  if (TypeInfo = nil) then begin
    Result := -1;
    Exit;
  end;
  try
    Result := {TypInfo.}StringToSet(TypeInfo, Value);
  except
    Result := -1;
  end;
end;//*)
function SuperStringToSet(TypeInfo: PTypeInfo; const Value: string): Integer;
// Safe implementation of "TypInfo.pas"."StringToSet(PTypeInfo...)" without Exceptions
var
  P: PChar;
  EnumName: string;
  EnumValue: NativeInt;
  PEnumInfo: {$IFDEF FPC}PTypeInfo{$ELSE}PPTypeInfo{$ENDIF};

  // grab the next enum name
  function NextWord(var P: PChar): string;
  var
    i: Integer;
  begin
    i := 0;

    // scan til whitespace
    while not (CharInSet(P[i], [',', ' ', #0,']'])) do
      Inc(i);

    SetString(Result, P, i);

    // skip whitespace
    while (CharInSet(P[i], [',', ' ',']'])) do
      Inc(i);

    Inc(P, i);
  end;

begin
  {+}
  if (TypeInfo = nil) then begin
    Result := -1;
    Exit;
  end;
  {+.}
  Result := 0;
  if Value = '' then Exit;
  P := PChar(Value);

  // skip leading bracket and whitespace
  while (CharInSet(P^, ['[',' '])) do
    Inc(P);

  PEnumInfo := GetTypeData(TypeInfo)^.CompType;
  if PEnumInfo <> nil then
  begin
    EnumName := NextWord(P);
    while EnumName <> '' do
    begin
      EnumValue := GetEnumValue(PEnumInfo{$IFNDEF FPC}^{$ENDIF}, EnumName);
      if EnumValue < 0 then
      {+}
      begin
        //raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyElement, [EnumName]);
        Result := -1;
        Exit;
      end;
      {+.}
      Include(TIntegerSet(Result), enumvalue);
      EnumName := NextWord(P);
    end;
  end
  else
  begin
    EnumName := NextWord(P);
    while EnumName <> '' do
    begin
      EnumValue := StrToIntDef(EnumName, -1);
      if EnumValue < 0 then
      {+}
      begin
        //raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyElement, [EnumName]);
        Result := -1;
        Exit;
      end;
      {+.}
      Include(TIntegerSet(Result), enumvalue);
      EnumName := NextWord(P);
    end;
  end;
end; // function SuperStringToSet
//*)

function TSuperRttiContext.jFromSet(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var
  i: Integer;
  SValue: string;
begin
  case ObjectGetType(obj) of
    stInt:
      begin
        TValue.Make(nil, ATypeInfo, Value);
        TValueData(Value).FAsSLong := obj.AsInteger;
        Result := True;
      end;
    stString:
      begin
        SValue := string(obj.AsString);
        if (SValue = '') or (FForceSet and (SValue = '[]') ) then begin
          i := 0; // [] == "0" ; empty set
          TValue.Make(@i, ATypeInfo, Value);
          Result := True;
          Exit;
        end;
        Result := TryStrToInt(SValue, i);
        if Result then begin
          TValue.Make(nil, ATypeInfo, Value);
          TValueData(Value).FAsSLong := i;
        end else if FForceSet then begin
          i := SuperStringToSet(ATypeInfo, SValue);
          if i >= 0 then begin
            TValue.Make(@i, ATypeInfo, Value);
            Result := True;
          end;
        end;
      end;
    else
      Result := False;
  end; // case
end;

function TSuperRttiContext.jFromFloat(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var
  typ: TSuperType;
  LTypeData: PTypeData;
  o: ISuperObject;
  SValue: SOString;
  dt: TDateTime;
begin
  Result := False;
  typ := ObjectGetType(obj); // @dbg: obj.DataType
  {%H-}case typ of
    stInt, stDouble, stCurrency:
      begin
        TValue.Make(nil, ATypeInfo, Value);
        LTypeData := GetTypeData(ATypeInfo);
        if Assigned(LTypeData) then begin
          case LTypeData.FloatType of
            ftSingle: begin
              TValueData(Value).FAsSingle := obj.AsDouble;
              Result := True;
            end;
            ftDouble: begin
              TValueData(Value).FAsDouble := obj.AsDouble;
              Result := True;
            end;
            ftExtended: begin
              TValueData(Value).FAsExtended := obj.AsDouble;
              Result := True;
            end;
            ftComp: begin
              TValueData(Value).FAsSInt64 := obj.AsInteger;
              Result := True;
            end;
            ftCurr: begin
              TValueData(Value).FAsCurr := obj.AsCurrency;
              Result := True;
            end;
          end; // case
        end;
      end;
    stString:
      begin
        SValue := obj.AsString;
        o := SO(SValue); // @dbg: obj.DataType
        typ := ObjectGetType(o); // @dbg: o.DataType
        Result := typ in [stInt, stDouble, stCurrency];
        if Result then begin
          Result := jFromFloat(ATypeInfo, o, Value);
        {+} // pult: 2020.1217.0757
        end else if (typ = stString) then begin
          Result := TryObjectToDate(o, dt);
          if Result then begin
            TValue.Make(@dt, TypeInfo(Double), Value);
          end;
        {+.}
        end;
      end;
  end; // case
end;

function TSuperRttiContext.jFromString(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
begin
  case ObjectGetType(obj) of
  stObject, stArray:
    Result := False;
  stnull:
    begin
      Value := '';
      Result := True;
    end;
   else begin
      {$IFDEF FPC}
      Value := TValue.From<SOString>(SOString(obj.AsString));
      {$ELSE}
      Value := obj.AsString;
      {$ENDIF}
      Result := True;
    end;
  end; // case
end;

function TSuperRttiContext.jFromClass(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var
  {$IFNDEF FPC}
  LRttiField: {$IFDEF FPC}TRttiMember{$ELSE}TRttiField{$ENDIF};
  {$ENDIF}
  LValue: TValue;
  {+} // https://code.google.com/p/superobject/issues/detail?id=39
  LArrObj: {+}ISuperArray{+.};
  i: Integer;
  AMethod: TRttiMethod;
  {+.}
  {$IFDEF USE_REFLECTION} // https://code.google.com/p/superobject/issues/detail?id=16
  LRttiProp: TRttiProperty;
  {$ENDIF}
  LTypeInfo: PTypeInfo;
  {$IFDEF USE_REFLECTION}
  LBasedType: PTypeInfo;
  {$ENDIF}
  LValObj: ISuperObject;
  LRttiType: TRttiType;
begin
  case ObjectGetType(obj) of
    stObject:
      begin
        Result := True;
        if Value.Kind <> tkClass then
          Value := GetTypeData(ATypeInfo).ClassType.Create; // @dbg: GetTypeData(ATypeInfo).ClassType.ClassName
        {$IFNDEF FPC} // FPC: Currently not supported rtti for Fields
        {+} // https://code.google.com/p/superobject/issues/detail?id=16
        //
        // FIELDS:
        //
        {$IFDEF USE_REFLECTION}
        if FieldsVisibility <> [] then
        {$ENDIF}
        {+.}
        for LRttiField in Context.GetType(Value.AsObject.ClassType).GetFields do begin
          {+} // https://code.google.com/p/superobject/issues/detail?id=16
          if (LRttiField.FieldType <> nil) {$IFDEF USE_REFLECTION} and (LRttiField.Visibility in FieldsVisibility)
            and (LRttiField.GetCustomAttribute<SOIgnore> = nil) {$ENDIF} then
          {+.}
          begin
            LValue := TValue.Empty;
            LTypeInfo := LRttiField.FieldType.Handle;
            {$IFDEF USE_REFLECTION}
            if FForceTypeMap then begin
              LBasedType := GetObjectTypeInfo(LRttiField, LTypeInfo);
              if (LTypeInfo <> LBasedType) and (LTypeInfo.Kind = LBasedType.Kind) then
                LTypeInfo := LBasedType;
            end;
            {$ENDIF USE_REFLECTION}
            LValObj := obj.AsObject[GetObjectName(LRttiField)];
            LValObj := GetObjectDefault(LRttiField, LValObj);
            Result := FromJson(LTypeInfo, LValObj, LValue);
            if Result then
            {+} // https://code.google.com/p/superobject/issues/detail?id=64
              LRttiField.SetValue(Value.AsObject, LValue)
            else if ForceSerializer then
              Result := True
            else
            {+.}
              Exit; // error
          end;
        end; // for
        {$ENDIF !FPC}
        {+} // https://code.google.com/p/superobject/issues/detail?id=16
        {$IFDEF USE_REFLECTION}
        //
        // PROPERTIES:
        //
        if PropertiesVisibility <> [] then
        for LRttiProp in Context.GetType(Value.AsObject.ClassType).GetProperties do begin
          if (LRttiProp.PropertyType <> nil) and (LRttiProp.Visibility in PropertiesVisibility)
            and (LRttiProp.IsWritable)
            and (LRttiProp.GetCustomAttribute<SOIgnore> = nil) then
          begin
            LValObj := obj.AsObject[SOString(GetPropertyName(LRttiProp))];
            LValObj := GetPropertyDefault(LRttiProp, LValObj);
            LTypeInfo := LRttiProp.PropertyType.Handle;
            if FForceTypeMap then begin
              LBasedType := GetObjectTypeInfo(LRttiProp, LTypeInfo);
              if (LTypeInfo <> LBasedType) and (LTypeInfo.Kind = LBasedType.Kind) then
                LTypeInfo := LBasedType;
            end;
            LValue := TValue.Empty;
            Result := FromJson(LTypeInfo, LValObj, LValue);
            if Result then
              LRttiProp.SetValue(Value.AsObject, LValue)
            else if ForceSerializer then
              Result := True
            else
              Exit; // error
          end;
        end; // for
        {$ENDIF USE_REFLECTION}
        {+.}
      end;
    {+} // https://code.google.com/p/superobject/issues/detail?id=39
    stArray:
      begin
        Result := False;
        if IsList(Context, ATypeInfo) and IsGenericType(ATypeInfo) then begin
          if Value.Kind <> tkClass then
            Value := GetTypeData(ATypeInfo).ClassType.Create;
          AMethod := Context.GetType(Value.AsObject.ClassType).GetMethod('Add');
          Result := Assigned(AMethod); // True;
          if Result then begin
            LArrObj := obj.AsArray;
            for i := 0 to LArrObj.Length-1 do begin
              LValue := TValue.Empty;
              LRttiType := GetDeclaredGenericType(Context, ATypeInfo);
              LTypeInfo := LRttiType.Handle;
              Result := FromJson(LTypeInfo, LArrObj[i], LValue);
              if Result then
                AMethod.Invoke(Value.AsObject, [LValue])
              else
                Exit; // error
            end; // for
          end;
        end;
      end;
    {+.}
    stNull:
      begin
        Value := nil;
        Result := True;
      end
    else begin
        // error
        Value := nil;
        Result := False;
      end;
  end; // case
end; // function TSuperRttiContext.jFromClass

function TSuperRttiContext.jFromRecord(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
{$IFNDEF FPC} // FPC: Currently not supported rtti for Fields
var
  LRttiField: {$IFDEF FPC}TRttiMember{$ELSE}TRttiField{$ENDIF};
  pValue: Pointer;
  LValue: TValue;
  fieldObj: ISuperObject;
  LFieldType: PTypeInfo;
  {$IFDEF USE_REFLECTION}
  LBasedType: PTypeInfo;
  {$ENDIF USE_REFLECTION}
  //IsManaged: Boolean;
{$ENDIF !FPC}
begin
  {$IFDEF FPC} // FPC: Currently not supported rtti for Fields
  Result := False;
  {$ELSE !FPC}
  Result := True;
  //IsManaged := {$if declared(tkMRecord)} (ATypeInfo <> nil) and (ATypeInfo^.Kind = tkMRecord) {$else} False {$ifend};
  TValue.Make(nil, ATypeInfo, Value);
  for LRttiField in Context.GetType(ATypeInfo).GetFields do
  begin
    if ObjectIsType(obj, stObject) and (LRttiField.FieldType <> nil) then
    begin // @dbg: LRttiField.FieldType.Handle^
      {+} // https://code.google.com/p/superobject/issues/detail?id=40
      fieldObj := obj.AsObject[GetObjectName(LRttiField)];
      //?if Assigned(fieldObj) then // ATRLP: 20160708: optional (no value in JSON) fields are allowed // https://github.com/hgourvest/superobject/pull/19/
      begin
        fieldObj := GetObjectDefault(LRttiField, fieldObj);
        LFieldType := LRttiField.FieldType.Handle;
        {$IFDEF USE_REFLECTION}
        if FForceTypeMap then begin
          LBasedType := GetObjectTypeInfo(LRttiField, LFieldType);
          if (LFieldType <> LBasedType) and (LFieldType.Kind = LBasedType.Kind) then
            LFieldType := LBasedType;
        end;
        {$ENDIF USE_REFLECTION}
        if FromJson(LFieldType, fieldObj, LValue) then begin
          {$IFDEF VER210}
          pValue := IValueData(TValueData(Value).FHeapData).GetReferenceToRawData;
          {$ELSE}
          pValue := TValueData(Value).FValueData.GetReferenceToRawData;
          {$ENDIF}
          LRttiField.SetValue(pValue, LValue);
        end;
      end;
      fieldObj := nil;
      {+.}
    end else
    begin
      Result := False;
      //Exit;
    end;
  end; // for
  {$ENDIF !FPC}
end; // function TSuperRttiContext.jFromRecord

function TSuperRttiContext.jFromDynArray(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var
  {+} // https://code.google.com/p/superobject/issues/detail?id=63
  i: {$IFDEF DELPHI_UNICODE}NativeInt{$ELSE}PtrInt{$ENDIF};
  {+.}
  p: Pointer;
  pb: PByte;
  val: TValue;
  typ: PTypeData;
  el: PTypeInfo;
begin
  case ObjectGetType(obj) of
  stArray:
    begin
      i := obj.AsArray.Length;
      p := nil;
      DynArraySetLength(p, ATypeInfo, 1, @i);
      pb := p;
      typ := GetTypeData(ATypeInfo);
      {$IFDEF FPC}
      if typ.elTypeRef <> nil then
        el := typ.elTypeRef^ else
        el := typ.elType2Ref^;
      {$ELSE !FPC}
      if typ.elType <> nil then
        el := typ.elType^ else
        el := typ.elType2^;
      {$ENDIF !FPC}

      Result := True;
      for i := 0 to i - 1 do
      begin
        Result := FromJson(el, obj.AsArray[i], {%H-}val);
        if not Result then
          Break;
        val.ExtractRawData(pb);
        val := TValue.Empty;
        Inc(pb, typ.elSize);
      end;
      if Result then begin
        {$IFDEF FPC}
        TValue.Make(@p, ATypeInfo, Value);
        {$ELSE}
        TValue.MakeWithoutCopy(@p, ATypeInfo, Value);
        {$ENDIF}
      end else
        DynArrayClear(p, ATypeInfo);
    end;
  stNull:
    begin
      {$IFDEF FPC}
      TValue.Make(nil, ATypeInfo, Value);
      {$ELSE}
      TValue.MakeWithoutCopy(nil, ATypeInfo, Value);
      {$ENDIF}
      Result := True;
    end;
  else
    i := 1;
    p := nil;
    DynArraySetLength(p, ATypeInfo, 1, @i);
    pb := p;
    typ := GetTypeData(ATypeInfo);
    {$IFDEF FPC}
    if typ.elTypeRef <> nil then
      el := typ.elTypeRef^ else
      el := typ.elType2Ref^;
    {$ELSE !FPC}
    if typ.elType <> nil then
      el := typ.elType^ else
      el := typ.elType2^;
    {$ENDIF !FPC}

    Result := FromJson(el, obj, val);
    val.ExtractRawData(pb);
    val := TValue.Empty;

    if Result then begin
      {$IFDEF FPC}
      TValue.Make(@p, ATypeInfo, Value);
      {$ELSE !FPC}
      TValue.MakeWithoutCopy(@p, ATypeInfo, Value);
      {$ENDIF !FPC}
    end else
      DynArrayClear(p, ATypeInfo);
  end;
end; // function TSuperRttiContext.jFromDynArray

function TSuperRttiContext.jFromArray(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
var // TODO: FPC: Check
  ArrayData: {$IFDEF FPC}^TArrayTypeData{$ELSE}PArrayTypeData{$ENDIF};
  idx: Integer;
  function ProcessDim(dim: Byte; const o: ISuperobject): Boolean;
  var
    i: Integer;
    v: TValue;
    dt: PTypeData;
    //a: {$IFDEF FPC}^TArrayTypeData{$ELSE}PTypeData{$ENDIF};
  begin
    if ObjectIsType(o, stArray) and (ArrayData.Dims[dim-1] <> nil) then
    begin
      dt := GetTypeData(ArrayData.Dims[dim-1]{$IFNDEF FPC}^{$ENDIF});
//      {$IFDEF FPC}
//      //a := @GetTypeData(ArrayData.Dims[dim-1]).ArrayData;
//      a := @dt.ArrayData;
//      {$ELSE !FPC}
//      {$IF CompilerVersion >= 34.00} // TODO: check
//      //a := PTypeData(
//      //     @GetTypeData(ArrayData.Dims[dim-1]^).ArrayData
//      //);
//      a := PTypeData(@dt.ArrayData);
//      {$ELSE}
//      //a := @GetTypeData(ArrayData.Dims[dim-1]^).ArrayData;
//      a := @dt.ArrayData;
//      {$IFEND}
//      {$ENDIF !FPC}
//      {$IFDEF FPC}
//      //-if (a.Size <> o.AsArray.Length) then
//      if (dt.MaxValue - dt.MinValue + 1) <> o.AsArray.Length then
//      {$ELSE}
//      if (a.MaxValue - a.MinValue + 1) <> o.AsArray.Length then
//      {$ENDIF}
      if (dt.MaxValue - dt.MinValue + 1) <> o.AsArray.Length then
      begin
        Result := False;
        Exit;
      end;
      Result := True;
      if (dim = ArrayData.DimCount) then begin
//        {$IFDEF FPC}
//        //-for i := 0 to a.Size-1 do
//        for i := dt.MinValue to dt.MaxValue do
//        {$ELSE !FPC}
//        for i := a.MinValue to a.MaxValue do
//        {$ENDIF !FPC}
        for i := dt.MinValue to dt.MaxValue do
        begin
          Result := FromJson(ArrayData.ElType{$IFNDEF FPC}^{$ENDIF}, o.AsArray[i], {%H-}v);
          if not Result then
            Exit;
          Value.SetArrayElement(idx, v);
          inc(idx);
        end
      end
      else begin
//        {$IFDEF FPC}
//        //-for i := 0 to a.Size-1 do
//        for i := dt.MinValue to dt.MaxValue do
//        {$ELSE !FPC}
//        for i := a.MinValue to a.MaxValue do
//        {$ENDIF !FPC}
        for i := dt.MinValue to dt.MaxValue do
        begin
          Result := ProcessDim(dim + 1, o.AsArray[i]);
          if not Result then
            Exit;
        end;
      end;
    end else
      Result := False;
  end;
var
  i: Integer;
  v: TValue;
begin
  TValue.Make(nil, ATypeInfo, Value);
  ArrayData := @GetTypeData(ATypeInfo).ArrayData;
  idx := 0;
  if ArrayData.DimCount = 1 then
  begin
    if ObjectIsType(obj, stArray) and (obj.AsArray.Length = ArrayData.ElCount) then
    begin
      Result := True;
      for i := 0 to ArrayData.ElCount - 1 do
      begin
        Result := FromJson(ArrayData.ElType{$IFNDEF FPC}^{$ENDIF}, obj.AsArray[i], {%H-}v);
        if not Result then
          Exit;
        Value.SetArrayElement(idx, v);
        v := TValue.Empty;
        inc(idx);
      end;
    end else
      Result := False;
  end else
    Result := ProcessDim(1, obj);
end; // function TSuperRttiContext.jFromArray

function TSuperRttiContext.jFromClassRef(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
{$IFNDEF FPC} // FPC rtti Currently not supported FindType
var
  r: TRttiType;
{$ENDIF !FPC}
begin
  Result := False;
  {$IFNDEF FPC} // FPC rtti Currently not supported FindType
  if ObjectIsType(obj, stString) then
  begin
    r := Context.FindType(obj.AsString);
    Result := Assigned(r);
    if Result then
      Value := TRttiInstanceType(r).MetaClassType;
  end;
  {$ENDIF !FPC}
end;

function TSuperRttiContext.jFromUnknown(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
begin
  case ObjectGetType(obj) of
    stBoolean:
      begin
        Value := obj.AsBoolean;
        Result := True;
      end;
    stDouble:
      begin
        Value := obj.AsDouble;
        Result := True;
      end;
    stCurrency:
      begin
        Value := obj.AsCurrency;
        Result := True;
      end;
    stInt:
      begin
        Value := obj.AsInteger;
        Result := True;
      end;
    stString:
      begin
        {$IFDEF FPC}
        Value := TValue.From<SOString>( obj.AsString );
        {$ELSE !FPC}
        Value := obj.AsString;
        {$ENDIF !FPC}
        Result := True;
      end
    else begin
        Value := nil;
        Result := False;
      end;
  end; // case
end;

function TSuperRttiContext.jFromInterface(ATypeInfo: PTypeInfo; const obj: ISuperObject; var Value: TValue): Boolean;
const soGUID: TGuid = '{4B86A9E3-E094-4E5A-954A-69048B7B6327}';
var
  o: ISuperObject;
  {+}
  {$IF defined(FPC) or (CompilerVersion >= 33.00)}  // DX 10.3 Rio Up
  AGuid: TGUID;
  {$IFEND}
  {+.}
begin
  {+}
  {$IF defined(FPC) or (CompilerVersion >= 33.00)}  // DX 10.3 Rio Up
  AGuid := GetTypeData(ATypeInfo).Guid;
  if CompareMem(@AGuid, @soGUID, SizeOf(TGUID)) then
  {$ELSE}
  if CompareMem(@GetTypeData(ATypeInfo).Guid, @soGUID, SizeOf(TGUID)) then
  {$IFEND}
  {+.}
  begin
    if obj <> nil then
      TValue.Make(@obj, ATypeInfo, Value) else
      begin
        o := TSuperObject.Create(stNull);
        TValue.Make(@o, ATypeInfo, Value);
      end;
    Result := True;
  end else
    Result := False;
end;

function TSuperRttiContext.FromJson(ATypeInfo: PTypeInfo; const obj: ISuperObject;
  var Value: TValue): Boolean;
var
  Serial: TSerialFromJson;
  LBaseType: PTypeInfo;
begin
  Result := False;
  if ATypeInfo = nil then
    Exit;

  LBaseType := ATypeInfo; // @dbg: ATypeInfo^
  Serial := nil;
  Result := SerialFromJson.TryGetValue(ATypeInfo, Serial) and Assigned(Serial);
  if (not Result) and FForceBaseType then begin // https://github.com/pult/SuperObject.Delphi/issues/1#issuecomment-745615978
    LBaseType := SuperBaseTypeInfo(ATypeInfo);
    if (LBaseType <> ATypeInfo) then
      Result := SerialFromJson.TryGetValue(LBaseType, Serial) and Assigned(Serial);
  end;
  if Result then begin
    TValue.Make(nil, LBaseType, Value);
    Result := Serial(Self, obj, Value);
    if Value.IsObject then
      Result := jFromClass(ATypeInfo, obj, Value);
    Exit;
  end;

  case ATypeInfo.Kind of
    tkChar:
      Result := jFromChar(ATypeInfo, obj, Value);
    tkInt64:
      Result := jFromInt64(ATypeInfo, obj, Value);
    tkEnumeration:
      Result := jFromEnumeration(ATypeInfo, obj, Value);
    tkInteger:
      Result := jFromInt(ATypeInfo, obj, Value);
    tkSet:
      Result := jFromSet(ATypeInfo, obj, Value);
    tkFloat:
      Result := jFromFloat(ATypeInfo, obj, Value);
    tkString, tkLString, tkUString, tkWString:
      Result := jFromString(ATypeInfo, obj, Value);
    tkClass:
      Result := jFromClass(ATypeInfo, obj, Value);
    tkMethod: ;
    tkWChar:
      Result := jFromWideChar(ATypeInfo, obj, Value);
    tkRecord {$if declared(tkMRecord)},tkMRecord{$ifend}:
      Result := jFromRecord(ATypeInfo, obj, Value);
    tkPointer: ;
    tkInterface:
      Result := jFromInterface(ATypeInfo, obj, Value);
    tkArray:
      Result := jFromArray(ATypeInfo, obj, Value);
    tkDynArray:
      Result := jFromDynArray(ATypeInfo, obj, Value);
    tkClassRef:
      Result := jFromClassRef(ATypeInfo, obj, Value);
    else
      Result := jFromUnknown(ATypeInfo, obj, Value);
  end; // case
end; // function TSuperRttiContext.FromJson

{+} // https://code.google.com/p/superobject/issues/detail?id=16
{$IFDEF USE_REFLECTION}
class function TSuperRttiContext.GetPropertyDefault(r: TRttiProperty; const obj: ISuperObject): ISuperObject;
var
  o: TCustomAttribute;
begin
  if not ObjectIsType(obj, stNull) then Exit(obj);
  for o in r.GetAttributes do
    if o is SODefault then
      Exit(SO(SOString(SODefault(o).Name)));
  Result := obj;
end;
//
class function TSuperRttiContext.GetPropertyName(r: TRttiProperty): string;
var
  o: TCustomAttribute;
begin
  for o in r.GetAttributes do
    if o is SOName then
      Exit(SOName(o).Name);
  Result := r.Name;
end;

function TSuperRttiContext.Array2Class(const Value: TValue; const index: ISuperObject): TSuperObject;
var
  enumObject, obj: TObject;
  t: TRttiType;
  getEnumerator, moveNext: TRttiMethod;
  current: TRttiProperty;
  currentValue, enumeratorValue: TValue;
begin
  Result := nil;
  obj := TValueData(Value).FAsObject;

  t := Context.GetType(obj.ClassType);
  getEnumerator := t.GetMethod('GetEnumerator');
  if (getEnumerator <> nil) then
  begin
    Result := TSuperObject.Create(stArray);

    enumeratorValue := getEnumerator.Invoke(obj, []);
    //if (enumeratorValue = nil) then
    //  Exit;
    enumObject := TValueData(enumeratorValue).FAsObject;
    //if (enumObject = nil) then
    //  Exit;

    t := Context.GetType(enumObject.ClassType);
    //if (t = nil) then
    //  Exit;
    moveNext := t.GetMethod('MoveNext');
    if (moveNext = nil) then
      Exit;
    current := t.GetProperty('Current');
    if (current = nil) then
      Exit;

    while moveNext.Invoke(enumObject, []).AsBoolean do
    begin
      currentValue := current.GetValue(enumObject);
      Result.AsArray.Add(toJSon(currentValue, index));
    end;
  end;
end;
{$ENDIF USE_REFLECTION}
{+.}

function TSuperRttiContext.jToInt64(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LValue: SuperInt;
begin
  LValue := SuperInt(Value.AsInt64);
  if FForceDefault or (LValue <> {Default:}0) then
    Result := TSuperObject.Create(LValue)
  else
    Result := nil;
end;

function TSuperRttiContext.jToChar(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LValue: SOString;
begin
  {$IFDEF FPC}
    {$if SizeOf(SOChar) = 1}
    LValue := SOString(AnsiString(Value.AsAnsiChar));
    {$else}
    LValue := SOString(UnicodeString(Value.AsWideChar));
    {$ifend}
  {$ELSE !FPC}
    //?Value := SOString(Value.AsType<SOChar>);
    {$IFDEF NEXTGEN}
    LValue := SOString(string(Value.AsType<Char>));
    {$ELSE}
    LValue := SOString(AnsiString(Value.AsType<AnsiChar>));
    {$ENDIF}
  {$ENDIF !FPC}
  if FForceDefault or (LValue <> SOString(#0)) then
    Result := TSuperObject.Create(LValue)
  else
    Result := nil;
end;

function TSuperRttiContext.jToInteger(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LValue: Longint;
begin
  LValue := SuperInt(TValueData(Value).FAsSLong);
  if FForceDefault or (LValue <> {Default:}0) then
    Result := TSuperObject.Create(LValue)
  else
    Result := nil;
end;

function TSuperRttiContext.jToFloat(var Value: TValue; const index: ISuperObject): ISuperObject;
begin
  Result := nil;
  {%H-}case Value.TypeData.FloatType of
    ftSingle:
      begin
        if FForceDefault or (TValueData(Value).FAsSingle <> {Default:}0) then
          Result := TSuperObject.Create(TValueData(Value).FAsSingle);
      end;
    ftDouble:
      begin
        if FForceDefault or (TValueData(Value).FAsDouble <> {Default:}0) then
          Result := TSuperObject.Create(TValueData(Value).FAsDouble);
      end;
    ftExtended:
      begin
        if FForceDefault or (TValueData(Value).FAsExtended <> {Default:}0) then
          Result := TSuperObject.Create(TValueData(Value).FAsExtended);
      end;
    ftComp:
      begin
        if FForceDefault or (TValueData(Value).FAsSInt64 <> {Default:}0) then
          Result := TSuperObject.Create(TValueData(Value).FAsSInt64);
      end;
    ftCurr:
      begin
        if FForceDefault or (TValueData(Value).FAsCurr <> {Default:}0) then
          Result := TSuperObject.CreateCurrency(TValueData(Value).FAsCurr);
      end;
  end; // case
end;

function TSuperRttiContext.jToString(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LValue: SOString;
begin
  {$IFDEF FPC}
  {$if SizeOf(SOChar) = 1}
  LValue = SOString(Value.AsAnsiString);
  {$else}
  LValue := SOString(Value.AsUnicodeString);
  {$ifend}
  {$ELSE !FPC}
  LValue := SOString(string(Value.AsType<string>));
  {$ENDIF !FPC}
  if FForceDefault or (Length(LValue) > 0) then
    Result := TSuperObject.Create(LValue)
  else
    Result := nil;
end;

function TSuperRttiContext.jToClass(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  t: TRttiType;
  {$IFNDEF FPC}
  LField: {$IFDEF FPC}TRttiMember{$ELSE}TRttiField{$ENDIF};
  {$ENDIF !FPC}
  {$IFDEF USE_REFLECTION} // https://code.google.com/p/superobject/issues/detail?id=16
  LProp: TRttiProperty;
  {$ENDIF}
  {$IFDEF USE_REFLECTION}
  LType, LTypeMap: PTypeInfo; LValueMap: TValue;
  {$ENDIF USE_REFLECTION}
  LValue: TValue;
  LObject: ISuperObject;
begin
  Result := nil;
  if TValueData(Value).FAsObject = nil then
    Exit;
  Result := index[SOString(IntToStr(NativeInt(Value.AsObject)))];
  if Assigned(Result) then
    Exit;
  Result := TSuperObject.Create(stObject);
  index[SOString(IntToStr(NativeInt(Value.AsObject)))] := Result;
  t := nil;
  //
  // FIELDS:
  //
  {+} // https://code.google.com/p/superobject/issues/detail?id=16
  {$IFNDEF FPC} // FPC rtti currently not supported TRttiType.GetFields
  {$IFDEF USE_REFLECTION}
  if (FieldsVisibility <> []) then
  {$ENDIF}
  begin
    t := Context.GetType(Value.AsObject.ClassType);
    {$IFDEF USE_REFLECTION}
    if IsExportable(t, ceField) then // https://github.com/hgourvest/superobject/pull/13
    {$ENDIF USE_REFLECTION}
    begin
      for LField in t.GetFields do begin
        {+} // https://code.google.com/p/superobject/issues/detail?id=16
        if (LField.FieldType <> nil)
          {$IFDEF USE_REFLECTION}
          and (LField.Visibility in FieldsVisibility)
          //-and (LField.GetCustomAttribute<SOIgnore> = nil)
          and (not IsIgnoredObject(LField)) // https://github.com/hgourvest/superobject/pull/13
          and (not isIgnoredName(t, LField))
          {$ENDIF USE_REFLECTION}
        {+.}
        then begin
          LObject := nil;
          LValue := LField.GetValue(Value.AsObject);
          {$IFDEF USE_REFLECTION}
          if FForceTypeMap then begin
            //
            // Check attributes: +[SOType(TypeInfo(T))] or -[SOTypeMap<T>]
            //
            LType := LValue.TypeInfo;
            LTypeMap := GetObjectTypeInfo(LField, {Default:}LType);
            if (LTypeMap <> LType) then begin
              //--if LValue.TryCast(LTypeMap, LValueMap) then begin // Failed TypeInfo after castiing
              if (LTypeMap.Kind = LType.Kind) then begin
                TValue.Make(LValue.GetReferenceToRawData(), LTypeMap, LValueMap);
                LValue := LValueMap;
              end;
            end;
          end;
          if IsArrayExportable(LField) then begin
            LObject := Array2Class(LValue, index);
          end else
          {$ENDIF USE_REFLECTION}
          begin
            LObject := ToJson(LValue, index);
          end;
          if Assigned(LObject) then
            Result.AsObject[getObjectName(LField)] := LObject;
        end;
      end; // for
    end; // if IsExportable
  end; // if FieldsVisibility
  {$ENDIF !FPC}
  {+}
  //
  // PROPERTIES:
  //
  {$IFDEF USE_REFLECTION}
  if (PropertiesVisibility <> []) then begin
    if t = nil then
      t := Context.GetType(Value.AsObject.ClassType);
    //
    if IsExportable(t, ceProperty) then // https://github.com/hgourvest/superobject/pull/13
    begin
      for LProp in t.GetProperties do begin
        if (LProp.PropertyType <> nil) and (LProp.Visibility in PropertiesVisibility)
          and (LProp.IsReadable)
          //-and (LProp.GetCustomAttribute<SOIgnore> = nil)
          and (not IsIgnoredObject(LProp)) // https://github.com/hgourvest/superobject/pull/13
          and (not isIgnoredName(t, LProp))
        then begin
          LValue := LProp.GetValue(Value.AsObject);
          if FForceTypeMap then begin
            //
            // Check attributes: +[SOType(TypeInfo(T))] or -[SOTypeMap<T>]
            //
            LType := LValue.TypeInfo;
            LTypeMap := GetObjectTypeInfo(LProp, {Default:}LType);
            if (LTypeMap <> LType) then begin
              //--if LValue.TryCast(LTypeMap, LValueMap) then begin // Failed TypeInfo after castiing
              if (LTypeMap.Kind =  LType.Kind) then begin
                TValue.Make(LValue.GetReferenceToRawData(), LTypeMap, LValueMap);
                LValue := LValueMap;
              end;
            end;
          end;
          if IsArrayExportable(LProp) then
            LObject := Array2Class(LValue, index)
          else
            LObject := ToJson(LValue, index);
          if Assigned(LObject) then
            Result.AsObject[SOString(getObjectName(LProp))] := LObject;
        end
      end; // for
    end; // if IsExportable
  end; // if PropertiesVisibility
  {$ENDIF USE_REFLECTION}
  {+.}
end; // function TSuperRttiContext.jToClass

function TSuperRttiContext.jToWChar(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LValue: SOString;
begin
  {$IFDEF FPC}
  LValue :=  SOString(UnicodeString(Value.AsWideChar));
  {$ELSE !FPC}
  LValue :=  SOString(UnicodeString(Value.AsType<WideChar>));
  {$ENDIF !FPC}
  if FForceDefault or (LValue <> SOString(#0)) then
    Result := TSuperObject.Create(LValue)
  else
    Result := nil;
end;

function TSuperRttiContext.jToSet(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LTypeInfo: PTypeInfo;
  SValue: SOString;
begin
  if not FForceSet then begin
    Result := jToInteger(Value, index);
    Exit;
  end;
  LTypeInfo := Value.TypeInfo;
  SValue := SOString(SuperSetToString(LTypeInfo, Pointer(Value.GetReferenceToRawData), {Brackets:}True));
  if FForceDefault or (SValue <> '[]') then
    Result := TSuperObject.Create(SValue)
  else
    Result := nil;
end;

function TSuperRttiContext.jToEnumeration(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LValue, LEnum: string;
  TypeData: PTypeData;
begin
  if (not FForceEnumeration) then begin
    Result := TSuperObject.Create(TValueData(Value).FAsSLong); // == jToInteger(Value, index);
    Exit;
  end;
  TypeData := Value.TypeData;
  LValue := GetEnumName(Value.TypeInfo,Value.AsOrdinal);
  if (TypeData.MinValue = 0) and (TypeData.MaxValue = 1)
    and ( SameText(LValue, 'True') or SameText(LValue, 'False') ) then
  begin
    if FForceDefault or SameText(LValue, 'True') then
      Result := TSuperObject.Create(Boolean(Value.AsBoolean));
  end else begin
    LEnum := GetEnumName(Value.TypeInfo,TypeData.MinValue);
    if FForceDefault or (LValue <> LEnum) then
      Result := TSuperObject.Create(SOString(LValue));
  end;
end;

function TSuperRttiContext.jToVariant(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  LValue: Variant;
  {$IFDEF FPC}
  vd: TVarData;
  {$ENDIF FPC}
begin
  Result := nil;
  if not Value.IsEmpty then begin
    {$IFDEF FPC} // TODO: FPC Check
    if Value.DataSize = SizeOf(TVarData) then begin
      Value.ExtractRawData(@vd);
      LValue := Variant(vd);
    end;
    {$ELSE !FPC}
    LValue := Value.AsVariant;
    {$ENDIF !FPC}
  end;
  if FForceDefault or (not ( VarIsEmpty(LValue) or VarIsNull(LValue) )) then
    Result := SO(LValue);
end;

function TSuperRttiContext.jToRecord(var Value: TValue; const index: ISuperObject): ISuperObject;
{$IFNDEF FPC} // FPC rtti currently not supported TRttiType.GetFields
var
  LField: {$IFDEF FPC}TRttiMember{$ELSE}TRttiField{$ENDIF};
  LValue: TValue;
  {$IFDEF USE_REFLECTION}
  LType, LTypeMap: PTypeInfo; LValueMap: TValue;
  {$ENDIF USE_REFLECTION}
  LObject: ISuperObject;
  //IsManaged: Boolean;
{$ENDIF !FPC}
begin
  {$IFDEF FPC} // FPC rtti currently not supported TRttiType.GetFields
  Result := nil;
  {$ELSE} //
  //IsManaged := {$if declared(tkMRecord)} (Value.TypeInfo <> nil) and (Value.TypeInfo^.Kind = tkMRecord) {$else} False {$ifend};
  Result := TSuperObject.Create(stObject);
  for LField in Context.GetType(Value.TypeInfo).GetFields do begin
    {$IFDEF USE_REFLECTION} //@dbg: TRttiType(LField).Name
    //-if (LField.GetCustomAttribute<SOIgnore> = nil) then
    if (not IsIgnoredObject(LField)) then // https://github.com/hgourvest/superobject/pull/13
    {$ENDIF USE_REFLECTION}
    begin
      {$IFDEF VER210}
      LValue := f.GetValue(IValueData(TValueData(Value).FHeapData).GetReferenceToRawData);
      {$ELSE}
      LValue := LField.GetValue(TValueData(Value).FValueData.GetReferenceToRawData);
      {$ENDIF}

      {$IFDEF USE_REFLECTION}
      if FForceTypeMap then begin
        //
        // Check attributes: +[SOType(TypeInfo(T))] or -[SOTypeMap<T>]
        //
        LType := LValue.TypeInfo;
        LTypeMap := GetObjectTypeInfo(LField, {Default:}LType);
        if (LTypeMap <> LType) then begin
          //--if LValue.TryCast(LTypeMap, LValueMap) then begin // Failed TypeInfo after castiing
          if (LTypeMap.Kind =  LType.Kind) then begin
            TValue.Make(LValue.GetReferenceToRawData(), LTypeMap, LValueMap);
            LValue := LValueMap;
          end;
        end;
      end;
      {$ENDIF USE_REFLECTION}

      LObject := ToJson(LValue, Index);
      if Assigned(LObject) then
        Result.AsObject[GetObjectName(LField)] := LObject;
    end;
  end;
  {$ENDIF !FPC}
end;

function TSuperRttiContext.jToArray(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  idx: Integer;
  ArrayData: {$IFDEF FPC}^TArrayTypeData{$ELSE}PArrayTypeData{$ENDIF !FPC};

  procedure ProcessDim(dim: Byte; const o: ISuperObject);
  var
    dt: PTypeData;
    i: Integer;
    o2: ISuperObject;
    v: TValue;
  begin
    if ArrayData.Dims[dim-1] = nil then
      Exit;
    dt := GetTypeData(ArrayData.Dims[dim-1]{$IFNDEF FPC}^{$ENDIF});
    if Dim = ArrayData.DimCount then begin
      for i := dt.MinValue to dt.MaxValue do begin
        v := Value.GetArrayElement(idx);
        o.AsArray.Add(toJSon(v, index));
        inc(idx);
      end
    end else begin
      for i := dt.MinValue to dt.MaxValue do begin
        o2 := TSuperObject.Create(stArray);
        o.AsArray.Add(o2);
        ProcessDim(dim + 1, o2);
      end;
    end;
  end;
var
  i: Integer;
  v: TValue;
begin
  Result := nil;
  ArrayData := @Value.TypeData.ArrayData;
  idx := 0;
  if ArrayData.DimCount = 1 then begin
    if FForceDefault or (ArrayData.ElCount > 0) then begin
      Result := TSuperObject.Create(stArray);
      for i := 0 to ArrayData.ElCount - 1 do
      begin
        v := Value.GetArrayElement(i);
        Result.AsArray.Add(toJSon(v, index))
      end;
    end;
  end else begin
    Result := TSuperObject.Create(stArray);
    ProcessDim(1, Result); // TODO: FForceDefault
  end;
end; // function TSuperRttiContext.jToArray

function TSuperRttiContext.jToDynArray(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  i: Integer;
  v: TValue;
begin
  Result := nil;
  i := Value.GetArrayLength;
  if FForceDefault or (i > 0) then begin
    Result := TSuperObject.Create(stArray);
    for i := 0 to i - 1 do begin
      v := Value.GetArrayElement(i);
      Result.AsArray.Add(toJSon(v, index));
    end;
  end;
end;

function TSuperRttiContext.jToClassRef(var Value: TValue; const index: ISuperObject): ISuperObject;
begin
  if TValueData(Value).FAsClass <> nil then
    Result :=  TSuperObject.Create(SOString(
      TValueData(Value).FAsClass.UnitName + '.' +
      TValueData(Value).FAsClass.ClassName)) else
    Result := nil;
end;

function TSuperRttiContext.jToInterface(var Value: TValue; const index: ISuperObject): ISuperObject;
{$IFNDEF VER210}
var
  intf: IInterface;
{$ENDIF}
begin
  Result := nil;
  {$IFDEF VER210}
  if TValueData(Value).FHeapData <> nil then
    TValueData(Value).FHeapData.QueryInterface(ISuperObject, Result);
  {$ELSE}
  if TValueData(Value).FValueData <> nil then begin
    intf := IInterface(PPointer(TValueData(Value).FValueData.GetReferenceToRawData)^);
    if Assigned(intf) then
      intf.QueryInterface(ISuperObject, Result);
  end;
  {$ENDIF}
end;

function TSuperRttiContext.ToJson(var Value: TValue; const index: ISuperObject): ISuperObject;
var
  Serial: TSerialToJson;
  LType, LBaseType: PTypeInfo;
begin
  Result := nil;
  if Value.IsEmpty and (not FForceDefault) then
    Exit;
  LType := Value.TypeInfo; //@dbg: Value.FTypeInfo^
  Serial := nil;
  if SerialToJson.TryGetValue(LType, Serial) and Assigned(Serial) then begin
    Result := Serial(Self, Value, index);
    Exit;
  end;
  if FForceBaseType then begin // https://github.com/pult/SuperObject.Delphi/issues/1#issuecomment-745615978
    LBaseType := SuperBaseTypeInfo(LType);
    if (LBaseType <> LType) then begin
      if SerialToJson.TryGetValue(LBaseType, Serial) and Assigned(Serial) then begin
        Result := Serial(Self, Value, index);
        Exit;
      end;
    end;
  end;
  {%H-}case Value.Kind of
    tkInt64:
      Result := jToInt64(Value, index);
    tkChar:
      Result := jToChar(Value, index);
    tkSet:
      Result := jToSet(Value, index);
    tkInteger:
      Result := jToInteger(Value, index);
    tkFloat:
      Result := jToFloat(Value, index);
    tkString, tkLString, tkUString, tkWString:
      Result := jToString(Value, index);
    tkClass:
      Result := jToClass(Value, index);
    tkWChar:
      Result := jToWChar(Value, index);
    tkEnumeration:
      Result := jToEnumeration(Value, index);
    tkVariant:
      Result := jToVariant(Value, index);
    tkRecord {$if declared(tkMRecord)},tkMRecord{$ifend} :
      Result := jToRecord(Value, index);
    tkArray:
      Result := jToArray(Value, index);
    tkDynArray:
      Result := jToDynArray(Value, index);
    tkClassRef:
      Result := jToClassRef(Value, index);
    tkInterface:
      Result := jToInterface(Value, index);
  end; // case
end; // function TSuperRttiContext.ToJson

{ TSuperObjectHelper }

constructor TSuperObjectHelper.FromJson(const obj: ISuperObject; ctx: TSuperRttiContext = nil);
var
  ctxowned: Boolean;
  v: TValue;
begin
  inherited;
  ctxowned := False;
  if ctx = nil then begin
    ctx := SuperRttiContextDefault;
    if ctx = nil then begin
      if SuperRttiContextClassDefault = nil then
        ctx := TSuperRttiContext.Create
      else
        ctx := SuperRttiContextClassDefault.Create;
      ctxowned := True;
    end;
  end;
  try
    v := Self;
    if not ctx.FromJson(v.TypeInfo, obj, v) then
      raise ESuperObject.Create('Invalid object');
  finally
    if ctxowned then
      ctx.Free;
  end;
end;

constructor TSuperObjectHelper.FromJson(const str: string; ctx: TSuperRttiContext = nil);
begin
  FromJson(SO(SOString(str)), ctx);
end;

function TSuperObjectHelper.ToJson(ctx: TSuperRttiContext = nil): ISuperObject;
var
  ctxowned: Boolean;
  v: TValue;
begin
  ctxowned := False;
  if ctx = nil then begin
    ctx := SuperRttiContextDefault;
    if ctx = nil then begin
      if SuperRttiContextClassDefault = nil then
        ctx := TSuperRttiContext.Create
      else
        ctx := SuperRttiContextClassDefault.Create;
      ctxowned := True;
    end;
  end;
  try
    v := Self;
    Result := ctx.ToJson(v, SO);
  finally
    if ctxowned then
      ctx.Free;
  end;
end;
{$ENDIF HAVE_RTTI}

{$IFDEF HAVE_RTTI}
procedure SuperRegisterCustomTypeInfo(CustomType, BaseType: PTypeInfo);
begin
  if (CustomType = nil) then
    Exit;
  if (BaseType = nil) then begin
    // unregister
    if Assigned(SuperTypeInfoDictionary) then begin
      SuperTypeInfoDictionary.Remove(CustomType);
      //if SuperTypeInfoDictionary.Count = 0 then
      //  FreeAndNil(SuperTypeInfoDictionary);
    end;
  end;
  if (BaseType = CustomType) then
    Exit;
  if (CustomType.Kind <> BaseType.Kind) then begin
    // Error: Types is diff sizes
    Exit;
  end;
  if (SuperTypeInfoDictionary = nil) then
    SuperTypeInfoDictionary := TDictionary<Pointer, Pointer>.Create;
  SuperTypeInfoDictionary.AddOrSetValue(CustomType,BaseType);
end;

procedure SuperUnRegisterCustomTypeInfo(CustomType: PTypeInfo);
begin
  if Assigned(CustomType) and Assigned(SuperTypeInfoDictionary) then begin
    SuperTypeInfoDictionary.Remove(CustomType);
    //if SuperTypeInfoDictionary.Count = 0 then
    //  FreeAndNil(SuperTypeInfoDictionary);
  end;
end;

function SuperBaseTypeInfo(CustomType: PTypeInfo): PTypeInfo;
begin
  if (SuperTypeInfoDictionary = nil)
    or (not SuperTypeInfoDictionary.TryGetValue(CustomType, Pointer(Result))) then
    Result := CustomType;
end;
{$ENDIF HAVE_RTTI}

initialization
  {$IFDEF MSWINDOWS}
  SYS_ACP := GetACP();
  SYS_CP_OEM := GetOEMCP();
  {$ELSE}
  SYS_CP_OEM := CP_437;
  {$ENDIF}
  {$IFDEF NEED_FORMATSETTINGS}
  SOFormatSettings.DecimalSeparator := '.';
  //SOFormatSettings.ThousandSeparator := ',';
  SOFormatSettings.DateSeparator := '-';
  SOFormatSettings.TimeSeparator := ':';
  SOFormatSettings.ShortDateFormat := 'yy-mm-dd';
  SOFormatSettings.LongDateFormat := 'yyyy-mm-dd';
  SOFormatSettings.ShortTimeFormat := 'hh:mm';
  SOFormatSettings.LongTimeFormat := 'hh:mm:ss';
  {$ENDIF}
  {$IFDEF HAVE_RTTI}
  SuperRttiContextClassDefault := TSuperRttiContext;
  SuperRttiContextDefault := SuperRttiContextClassDefault.Create;
  {$ENDIF HAVE_RTTI}
finalization
  {$IFDEF HAVE_RTTI}
  SuperRttiContextDefault.Free;
  SuperTypeInfoDictionary.Free;
  {$ENDIF HAVE_RTTI}
  {$IFDEF DEBUG}
  Assert(debugcount = 0, 'Memory leak');
  {$ENDIF}
end.
