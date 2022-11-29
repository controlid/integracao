{ superdbg.pas } // version: 2021.0116.1637
unit superdbg;

interface

{$IFDEF FPC}
  //{$mode objfpc}
  {$mode delphi}
  {$h+} // long AnsiString (not ShortString)
{$ENDIF}

{$IFNDEF FPC}{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 24}
    {$LEGACYIFEND ON} // Allow old style mixed $endif $ifend
  {$IFEND}
{$ENDIF}{$ENDIF}
{$IFDEF NEXTGEN}
  {$ZEROBASEDSTRINGS OFF}
{$ENDIF}
{$IFNDEF FPC}{$IFDEF UNICODE}
  {$HIGHCHARUNICODE ON}  {make all #nn char constants Wide for better portability}
{$ENDIF}{$ENDIF}

{$IFDEF MSWINDOWS}
  {.$define _JCL_}  { optional }
{$ELSE}
  {$undef _JCL_}
{$ENDIF}

uses
  {$IFDEF _JCL_}
  JclSysUtils, JclDebug,
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  SysUtils, Classes, supertypes;

const
  jcl_present: boolean = {$IFDEF _JCL_}true{$ELSE}false{$ENDIF};
var
  dbg_prefix: string = 'dbg:> ';

function GetExceptionStackList(AExceptionAddr: Pointer = nil): TStrings;
function GetExceptionStack(AExceptionAddr: Pointer = nil): string;

function GetCallStackList(): TStrings;
function GetCallStack(): string;

//procedure dbg(const S: string); overload;
procedure dbgTraceError(E: Exception = nil);

implementation

uses
  superobject;

(*{$IFDEF MSWINDOWS}{$IF (not defined(FPC)) and (CompilerVersion < 23)} // Less then Delphi XE2. TODO: check console output for XE2 (CompilerVersion==23)
function AnsiToOEM(const S: AnsiString): AnsiString; overload; begin
  SetLength(Result, Length(S));
  if Length(S) > 0 then
    Windows.CharToOemA(PAnsiChar(S), PAnsiChar(Result));
end;{$IFDEF UNICODE}
function AnsiToOEM(const S: string): string; overload; inline; begin
  Result := string(AnsiToOem(AnsiString(S)));
end;
{$ENDIF}{$IFEND}{$ENDIF}

procedure dbgraw(const s: string);
begin
  {$IFDEF MSWINDOWS}
  OutputDebugString(PChar(
    // for OutputDebugString(...) and "Event Viewer"(or dbgview.exe)
    StringReplace(s, #9, #32#32#32#32, [rfReplaceAll])
  ));
  {$ENDIF}
  if IsConsole then // TODO: write to stderror
    writeln({$IFDEF MSWINDOWS}{$IF (not defined(FPC)) and (CompilerVersion < 23)}AnsiToOEM{$IFEND}{$ENDIF}(s));
end;

procedure dbg(L: TStrings); overload;
var
  i: Integer;
  S: string;
begin
  try
    for i := 0 to L.Count - 1 do
    begin
      S := L[i];
      if Length(S) > 0 then
      begin
        S := dbg_prefix + S;
        dbgraw(S)
      end
      else
        dbgraw(dbg_prefix);
    end;
  except
  end;
end;

procedure dbg(const S: string); overload;
var L: TStrings; i: Integer;
begin
  //OLD: dbgraw(dbg_prefix+S);
  try
    if Length(s) > 0 then
    begin
      L := TStringList.Create;
      try
        L.Text := S;
        for i := 0 to L.Count - 1 do
          dbgraw(dbg_prefix + L[i]);
      finally
        L.Free;
      end;
    end
    else
      dbgraw(dbg_prefix);
  except
  end;
end;//*)

function GetExceptionStackList(AExceptionAddr: Pointer): TStrings;
{$IFNDEF _JCL_}
begin
  Result := nil;
end;
{$ELSE IFDEF _JCL_}
var
  StackList: TJclStackInfoList;
  L: TStringList;
begin
  Result := nil;
  if not jcl_present then
    Exit;
  L := nil;
  StackList := nil;
  try
    try
      if AExceptionAddr = nil then
        AExceptionAddr := ExceptAddr;
      if AExceptionAddr = nil then
        Exit;
      StackList := JclCreateStackList({Raw=}True, {IgnoreLevels=}7, AExceptionAddr{nil});
      if Assigned(StackList) and (StackList.Count > 0) then
      begin
        CorrectExceptStackListTop(StackList, {SkipFirstItem:}True);
        if StackList.Count > 0 then
        begin
          L := TStringList.Create;
          StackList.AddToStrings(L, {Module}True, {AOffs}True, {POffs}True, {VAddr}True);
          Result := L;
          L := nil;
        end;
      end;
    finally
      StackList.Free;
      L.Free;
    end;
  except
  end;
end;
{$ENDIF _JCL}

function GetExceptionStack(AExceptionAddr: Pointer): string;
var
  L: TStrings;
begin
  if not jcl_present then
  begin
    Result := '';
    Exit;
  end;
  L := GetExceptionStackList(AExceptionAddr);
  if Assigned(L) then
  begin
    Result := L.Text;
    L.Free;
  end
  else
    Result := '';
end;

procedure _GetCallStackFinit; forward;

function GetCallStackListEx(ACaller: Pointer): TStrings;
{$IFNDEF _JCL_}
begin
  Result := nil;
end;
{$ELSE IFDEF _JCL_}
var
  StackList: TJclStackInfoList;
  L: TStringList;
  //
  procedure remove_stack_items_created_by_it_call();
  var
    i, j: Integer;
    ptrAppHandleExBegin: PtrUInt;
    ptrAppHandleExEnd: PtrUInt;
    ptrStackAddr: PtrUInt;
  begin
    if ACaller = nil then
      ACaller := @GetCallStackListEx;
    ptrAppHandleExBegin := PtrUInt(ACaller);
    ptrAppHandleExEnd := PtrUInt(@_GetCallStackFinit); // GetCallStack _GetCallStackFinit
    for i := StackList.Count - 1 downto 1 do
    begin
      ptrStackAddr := PtrUInt(StackList.Items[i].CallerAddr);
      if (ptrStackAddr >=  ptrAppHandleExBegin) and (ptrStackAddr < ptrAppHandleExEnd) then
      begin
        for j := i downto 0 do
          StackList.Delete(0);
      end;
    end;
  end;{}
  //
begin
  Result := nil;
  if not jcl_present then
    Exit;
  L := nil;
  StackList := nil;
  try
    try
      StackList := JclCreateThreadStackTraceFromID(True, GetCurrentThreadID());
      if Assigned(StackList) and (StackList.Count > 0) then
      begin
        if StackList.Count > 0 then
        begin
          //CorrectExceptStackListTop(StackList, {SkipFirstItem:}True);
          remove_stack_items_created_by_it_call();
        end;
        if StackList.Count > 0 then
        begin
          L := TStringList.Create;
          StackList.AddToStrings(L, {Module}True, {AOffs}True, {POffs}True, {VAddr}True);
          Result := L;
          L := nil;
        end;
      end;
    finally
      StackList.Free;
      L.Free;
    end;
  except
  end;
end;
{$ENDIF _JCL}

function GetCallStackList(): TStrings;
begin
  Result := GetCallStackListEx({caller:}@GetCallStackList);
end;
//
function GetCallStack(): string;
var
  L: TStrings;
begin
  if not jcl_present then
  begin
    Result := '';
    Exit;
  end;
  L := GetCallStackList();
  if Assigned(L) then
  begin
    Result := L.Text;
    L.Free;
  end
  else
    Result := '';
end;

procedure dbgTraceError(E: Exception);
{$IFDEF _JCL_}
var
  L: TStrings;
  i: integer;
{$ENDIF}
begin
  if (e = nil) then
    dbgraw(dbg_prefix+'ERROR: (unknown)')
  else if (e.ClassType = nil) then
    dbgraw(dbg_prefix+'ERROR: (internal)')
  else if (e.ClassType <> EAbort) then
  try
    //if (e is EAbort) then
    //  Exit;
    try
      dbg(Format('EXCEPTION(%s): %s', [e.ClassName, E.Message]));
    except
      dbgraw(dbg_prefix+'EXCEPTION: (internal)')
    end;
    //
    {$IFDEF _JCL_}
    if not jcl_present then
      exit;
    L := GetCallStackListEx({caller:}@dbgTraceError);
    if L.Count = 0 then
      Exit;
    dbgraw(dbg_prefix);
    dbgraw(dbg_prefix + '<TRACE_CALLS>');
    for i := 0 to L.Count - 1 do
      dbgraw(dbg_prefix + #32#32#32#32 + L[i]);
    dbgraw(dbg_prefix + '<\TRACE_CALLS>');
    {$ENDIF}
  except
  end;
end;

procedure _GetCallStackFinit(); begin {empty} end;
{$IFDEF _JCL_}
procedure DoInit();
var
  s: string;
begin
  s := ChangeFileExt(paramstr(0), '.jdbg');
  jcl_present := FileExists(s);
  if not jcl_present then
  begin
    s := ChangeFileExt(s, '.map');
    jcl_present := FileExists(s);
  end;
  //if not jcl_present then dbg('#  not exist "$(appname)[.map|.jdbg]" file');
  if not jcl_present then
    exit;
  //
  //<JCL>
  //
  //dbg('#  hook: exception by "JCL"');
  //
  //ExcDialogSystemInfos := [siStackList, siModule{, siModuleList}];
  //ExcDialogSystemInfos := ExcDialogSystemInfos + [siOsInfo];
  JclStackTrackingOptions := JclStackTrackingOptions + [stRawMode];
  JclStackTrackingOptions := JclStackTrackingOptions + [stStaticModuleList];
  JclStackTrackingOptions := JclStackTrackingOptions + [stDelayedTrace, stAllModules];{}

  //JclDebugThreadList.OnSyncException := TExceptionDialog.ExceptionThreadHandler;
  JclHookThreads;
  JclStartExceptionTracking;
  JclTrackExceptionsFromLibraries;
  //Application.OnException := TExceptionDialog.ExceptionHandler;
  //
  //<\JCL>
  //
//-  //dbg('#  hook: "superobject.dbg"');
//-  superobject.dbg := @superdbg.dbg;
  //dbg('#  hook: "superobject.dbgTraceError"');
  superobject.dbgTraceError := @superdbg.dbgTraceError;
end;
initialization
  DoInit();
{$ENDIF _JCL_}
end.
