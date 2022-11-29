{ supertypes.pas } // version: 2015.0727.0725
unit supertypes;

{$IFDEF FPC}
  //-- {$mode objfpc}
  {$mode delphi}
  //{$mode delphiunicode} { optional }
  {$h+} // long AnsiString (not ShortString)
{$ENDIF}

{$IFNDEF FPC}{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 24}
    {$LEGACYIFEND ON} // Allow old style mixed $endif $ifend
  {$IFEND}
{$ENDIF}{$ENDIF}

interface

type
{$IFDEF FPC}
  NativeInt = PtrInt;
  NativeUInt = PtrUInt;
  IntPtr  = PtrInt;
  UIntPtr = PtrUInt;
{$ELSE}

  {$IFDEF CPUX64}
  PtrInt = Int64;
  PtrUInt = UInt64;
  {$ELSE}
  PtrInt = longint;
  PtrUInt = Longword;
  {$ENDIF}

  {$IF CompilerVersion < 20.00} // Less then Delphi 2009
  NativeInt = PtrInt;
  NativeUInt = PtrUInt;
  {$IFEND}

  {$IF CompilerVersion < 23.00} // Lest then XE2
  IntPtr  = NativeInt;
  UIntPtr = NativeUInt;
  {$IFEND}

  {$IFNDEF UNICODE}{$IFDEF LINUX} // Kylix
  DWORD = LongWord;
  {$ENDIF}{$ENDIF}

{$ENDIF !FPC}
  SuperInt = Int64;

{$if (sizeof(Char) = 1)}
  SOChar = WideChar;
  SOIChar = Word;
  PSOChar = PWideChar;
{$IFDEF FPC}
  SOString = UnicodeString;
{$ELSE}
  SOString = WideString;
{$ENDIF}
{$else}
  SOChar = Char;
  SOIChar = Word;
  PSOChar = PChar;
  SOString = string;
{$ifend}

{$IFNDEF FPC}
  {$IFDEF CONDITIONALEXPRESSIONS}
    {$IF CompilerVersion <= 18.00}
   TBytes = array of Byte;
    {$IFEND}
  {$ELSE}
   TBytes = array of Byte;
  {$ENDIF}
{$ENDIF !FPC}

implementation

end.
