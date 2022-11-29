{ superdate.pas } // version: 2020.1216.2117
unit superdate;

interface

{+}
{$IFDEF FPC}
  //-- {$mode objfpc}
  {$mode delphi}
  //{$mode delphiunicode} { optional }
  {$h+} // long AnsiString (not ShortString)
  //--{$Q-} // overflow error - off
{$ENDIF}

{$B-}
{$warnings on}
{$hints on}
//
{$IFDEF FPC}
  {$notes on}
  {$DEFINE HAVE_INLINE}
{$ELSE}{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 24}
    {$LEGACYIFEND ON} // Allow old style mixed $endif $ifend
  {$IFEND}
  {$IF CompilerVersion >= 17}
    {$DEFINE HAVE_INLINE}
  {$IFEND}
  {$IF CompilerVersion >= 23.00}  // XE2 Up; XE(22.00) partial implement "Unit Scope"
    {$define HAVE_UNITSCOPE}
  {$IFEND}
{$ENDIF}{$ENDIF}
//
{$UNDEF SUPERTIMEZONE}
{$IFNDEF FPC}{$IFDEF UNICODE}{$IFDEF MSWINDOWS}{$IF CompilerVersion > 23} // XE2 Up
  {$DEFINE SUPERTIMEZONE}
{$IFEND}{$ENDIF}{$ENDIF}{$ENDIF}
{$IFNDEF SUPERTIMEZONE}{$IFDEF MSWINDOWS}
  {$DEFINE WINDOWSNT_COMPATIBILITY}
{$ENDIF}{$ENDIF}
//
{$UNDEF USE_POSIX}
{$IFNDEF WINDOWSNT_COMPATIBILITY}
  {$IFDEF UNIX}
    {$DEFINE USE_POSIX} // FPC
  {$ENDIF}
  {$IFDEF POSIX}
    {$DEFINE USE_POSIX}

    {$IFNDEF FPC}{$IFNDEF UNICODE}{$IFDEF LINUX} // Kylix
      {$DEFINE KYLIX}
      {$DEFINE UNIX}
    {$ENDIF}{$ENDIF}{$ENDIF}

    //{$IFDEF ANDROID}
    //{$ENDIF}
    //{$IFDEF IOS}
    //{$ENDIF}
    //{$IFDEF MACOS}
    //{$ENDIF}

  {$ENDIF}
{$ENDIF}
//
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
{$IFNDEF FPC}{$IFDEF UNICODE}
  {$HIGHCHARUNICODE ON}  {make all #nn char constants Wide for better portability}
{$ENDIF}{$ENDIF}

{$UNDEF SQLTIMESTAMP}
{+.}

uses
  supertypes
{+}
  ,SysUtils
  ,DateUtils
  {$IFDEF SUPERTIMEZONE}
  ,supertimezone
  {$ELSE !SUPERTIMEZONE}
    {$IFDEF MSWINDOWS}
  ,Windows
    {$ELSE !MSWINDOWS}
      {$IFDEF UNIX} // FPC, Kylix
        {$IFDEF KYLIX}
  ,Libc//, ckLibc // ckLibc - from CrossKylix
        {$ELSE}
  ,baseunix, unix // FPC
        {$ENDIF}
      {$ENDIF}
      {$IFDEF HAVE_UNITSCOPE}
        {$IFDEF USE_POSIX}
  ,Posix.Dlfcn, Posix.Fcntl, Posix.SysStat, Posix.SysTime, Posix.SysTypes, Posix.Time
        {$ENDIF}
  ,System.TimeSpan
      {$ENDIF}
    {$ENDIF !MSWINDOWS}

    {$IFNDEF FPC}
    {$if not declared(TTimeZone)}
  ,SqlTimSt {$DEFINE SQLTIMESTAMP}
    {$ifend}
    {$ENDIF !FPC}

  {$ENDIF !SUPERTIMEZONE}
  ;

{$IFDEF SUPERTIMEZONE}
{+.}
function JavaToDelphiDateTime(const dt: Int64; const TimeZone: SOString = ''): TDateTime;
function DelphiToJavaDateTime(const dt: TDateTime; const TimeZone: SOString = ''): Int64;
//function JavaDateTimeToISO8601Date(const dt: Int64; const TimeZone: SOString = ''): SOString;
//function DelphiDateTimeToISO8601Date(const dt: TDateTime; const TimeZone: SOString = ''): SOString;
function ISO8601DateToJavaDateTime(const str: SOString; var ms: Int64; const TimeZone: SOString = ''): Boolean;
//function ISO8601DateToDelphiDateTime(const str: SOString; var dt: TDateTime; const TimeZone: SOString = ''): Boolean;
{+}
{$ELSE !SUPERTIMEZONE}

function JavaToDelphiDateTime(const dt: int64): TDateTime;
function DelphiToJavaDateTime(const dt: TDateTime): int64;
//--function JavaDateTimeToISO8601Date(const dt: Int64; const TimeZone: SOString = ''): SOString;
//function DelphiDateTimeToISO8601Date(dt: TDateTime): String;
function ISO8601DateToJavaDateTime(const str: SOString; var ms: Int64): Boolean;
//function ISO8601DateToDelphiDateTime(const str: String; var dt: TDateTime): Boolean;

{$ENDIF !SUPERTIMEZONE}
{+.}

function DelphiDateToISO8601(const ADate: TDateTime; AInputIsUTC: Boolean = true): SOString;
function TryISO8601ToDelphiDate(const AISODate: SOString; out Value: TDateTime; AReturnUTC: Boolean = True): Boolean;

function DelphiDateTimeToUnix(const AValue: TDateTime; AInputIsUTC: Boolean = True): Int64;
function UnixToDelphiDateTime(const AValue: Int64; AReturnUTC: Boolean): TDateTime;

implementation

{$IFDEF SQLTIMESTAMP}
var
  FTZInfo: TTimeZone;
  FTZInfoInitialized: Boolean;

procedure InitTZInfo;
begin
  if not FTZInfoInitialized then begin
    FTZInfo := TTimeZone.GetTimeZone;
    FTZInfoInitialized := True;
  end;
end;
{$ENDIF SQLTIMESTAMP}

{$IFDEF SUPERTIMEZONE}
{+.}
function JavaToDelphiDateTime(const dt: Int64; const TimeZone: SOString = ''): TDateTime;
begin
  Result := TSuperTimeZone.Zone[TimeZone].JavaToDelphi(dt);
end;

function DelphiToJavaDateTime(const dt: TDateTime; const TimeZone: SOString = ''): Int64;
begin
  Result := TSuperTimeZone.Zone[TimeZone].DelphiToJava(dt);
end;

//function JavaDateTimeToISO8601Date(const dt: Int64; const TimeZone: SOString = ''): SOString;
//begin
//  Result := TSuperTimeZone.Zone[TimeZone].JavaToISO8601(dt);
//end;

//function DelphiDateTimeToISO8601Date(const dt: TDateTime; const TimeZone: SOString = ''): SOString;
//begin
//  Result := TSuperTimeZone.Zone[TimeZone].DelphiToISO8601(dt);
//end;

function ISO8601DateToJavaDateTime(const str: SOString; var ms: Int64; const TimeZone: SOString = ''): Boolean;
begin
  Result := TSuperTimeZone.Zone[TimeZone].ISO8601ToJava(str, ms);
end;

//function ISO8601DateToDelphiDateTime(const str: SOString; var dt: TDateTime; const TimeZone: SOString = ''): Boolean;
//begin
//  Result := TSuperTimeZone.Zone[TimeZone].ISO8601ToDelphi(str, dt);
//end;

{+}
{$ELSE !SUPERTIMEZONE}

{$IFNDEF UNICODE}
function CharInSet(AC: AnsiChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin
  Result := AC in CharSet;
end;

function CharInSet(WC: WideChar; const CharSet: TSysCharSet): Boolean; overload; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
begin
  Result := (Ord(WC) <= $FF) and (AnsiChar(WC) in CharSet);
end;
{$ENDIF}

{$IFDEF USE_POSIX}
function GetTimeBias: integer;
{$IFDEF UNIX} // FPC, Kylix
var
  TimeVal: TTimeVal;
  TimeZone: TTimeZone;
begin
  {$IFDEF KYLIX}
//    {$MESSAGE FATAL 'TODO: Kylix not implemented function GetTimeBias'}
    {$MESSAGE WARN 'TODO: Fatal: Kylix not implemented function GetTimeBias'}
  {$ELSE}
  fpGetTimeOfDay(@TimeVal, @TimeZone);
  {$ENDIF}
  Result := TimeZone.tz_minuteswest;
end;
{$ELSE !UNIX}
//var
//  tv: timeval;
//  tz: tm;
var
  TimeZone: TTimeZone;
begin
  // TODO: Android, ...
  //Result := 0;
  //{$WARNING 'Not implemented GetTimeBias'}

  //GetTimeOfDay(tv, @tz);
  //Result := tz.tm_gmtoff div 60;

  TimeZone := TTimeZone.Local;
  Result := Trunc(TimeZone.UtcOffset.Negate.TotalMinutes);
end;
{$ENDIF !UNIX}
{$ELSE !USE_POSIX}
function GetTimeBias: integer;
var
  tzi : TTimeZoneInformation;
begin
  {$hints off} // FPC: Hint: Local variable "tzi" does not seem to be initialized
  case GetTimeZoneInformation(tzi) of
  {$hints on}
    TIME_ZONE_ID_UNKNOWN : Result := tzi.Bias;
    TIME_ZONE_ID_STANDARD: Result := tzi.Bias + tzi.StandardBias;
    TIME_ZONE_ID_DAYLIGHT: Result := tzi.Bias + tzi.DaylightBias;
  else
    Result := 0;
  end;
end;
{$ENDIF !USE_POSIX}

{$IFDEF USE_POSIX}
{+} // https://code.google.com/p/superobject/issues/detail?id=18
    // existed in "Libc"
{type
  ptm = ^tm;
  tm = record
    tm_sec: Integer;    (* Seconds: 0-59 (K&R says 0-61?) *)
    tm_min: Integer;    (* Minutes: 0-59 *)
    tm_hour: Integer; (* Hours since midnight: 0-23 *)
    tm_mday: Integer; (* Day of the month: 1-31 *)
    tm_mon: Integer;    (* Months *since* january: 0-11 *)
    tm_year: Integer; (* Years since 1900 *)
    tm_wday: Integer; (* Days since Sunday (0-6) *)
    tm_yday: Integer; (* Days since Jan. 1: 0-365 *)
    tm_isdst: Integer;  (* +1 Daylight Savings Time, 0 No DST, -1 don't know *)
    //+
    //tm_gmtoff: LongInt;         // Seconds east of UTC
    //tm_zone: MarshaledAString;  // Timezone abbreviation
    //+.
  end;

function mktime(p: ptm): LongInt; cdecl; external;
function gmtime(const t: PLongint): ptm; cdecl; external;
function localtime(const t: PLongint): ptm; cdecl; external;
{+.}

function DelphiToJavaDateTime(const dt: TDateTime): Int64;
{$if defined(UNIX) and (not defined(KYLIX)) and (not defined(FPC))} // FPC and not Kylix
var
  p: ptm;
  l, ms: Integer;
  v: Int64;
begin
  v := Round((dt - 25569) * 86400000);
  ms := v mod 1000;
  l := v div 1000;
  p := localtime(@l);
  Result := Int64(mktime(p)) * 1000 + ms;
end;
{$ELSE !UNIX}
//const
//  UnixStartDate = 25569.0;
begin
  //Result := 0;
  // TODO: Android, ...
  //{$WARNING 'Not implemented DelphiToJavaDateTime'}
  //
  //Result := Round(dt-UnixStartDate)*86400;
  //
  // OR:
  //
  Result := DateTimeToUnix(dt)*1000;
  //
  // OR:
  //
  //Result := MilliSecondsBetween(UnixDateDelta, dt);
  //if dt < UnixDateDelta then
  //  Result := -Result;
end;
{$ifend !UNIX}

function JavaToDelphiDateTime(const dt: int64): TDateTime;
{$if defined(UNIX) and (not defined(KYLIX)) and (not defined(FPC))} // FPC and not Kylix
var
  p: ptm;
  l, ms: Integer;
begin
  l := dt div 1000;
  ms := dt mod 1000;
  p := gmtime(@l);
  Result := EncodeDateTime(p^.tm_year+1900, p^.tm_mon+1, p^.tm_mday, p^.tm_hour, p^.tm_min, p^.tm_sec, ms);
end;
{$ELSE !UNIX}
//const
//  UnixStartDate = 25569.0;
begin
  //Result := 0;
  // TODO: Android, ...
  //{$WARNING 'Not implemented JavaToDelphiDateTime'}
  //
  //Result := dt/86400 + UnixStartDate;
  //
  // OR:
  //
  Result := UnixToDateTime(dt div 1000);
  //
  // OR:
  //
  //Result := IncMilliSecond(UnixDateDelta, dt);
end;
{$ifend !UNIX}
{$ELSE !USE_POSIX}

{$IFDEF WINDOWSNT_COMPATIBILITY}
function DayLightCompareDate(const date: PSystemTime;
  const compareDate: PSystemTime): Integer;
var
  limit_day, dayinsecs, weekofmonth: Integer;
  First: Word;
begin
  if (date^.wMonth < compareDate^.wMonth) then
  begin
    Result := -1; (* We are in a month before the date limit. *)
    Exit;
  end;

  if (date^.wMonth > compareDate^.wMonth) then
  begin
    Result := 1; (* We are in a month after the date limit. *)
    Exit;
  end;

  (* if year is 0 then date is in day-of-week format, otherwise
   * it's absolute date.
   *)
  if (compareDate^.wYear = 0) then
  begin
    (* compareDate.wDay is interpreted as number of the week in the month
     * 5 means: the last week in the month *)
    weekofmonth := compareDate^.wDay;
    (* calculate the day of the first DayOfWeek in the month *)
    First := (6 + compareDate^.wDayOfWeek - date^.wDayOfWeek + date^.wDay) mod 7 + 1;
    limit_day := First + 7 * (weekofmonth - 1);
    (* check needed for the 5th weekday of the month *)
    if (limit_day > MonthDays[(date^.wMonth=2) and IsLeapYear(date^.wYear)][date^.wMonth]) then
      dec(limit_day, 7);
  end
  else
    limit_day := compareDate^.wDay;

  (* convert to seconds *)
  limit_day := ((limit_day * 24  + compareDate^.wHour) * 60 + compareDate^.wMinute ) * 60;
  dayinsecs := ((date^.wDay * 24  + date^.wHour) * 60 + date^.wMinute ) * 60 + date^.wSecond;
  (* and compare *)

  if dayinsecs < limit_day then
    Result :=  -1 else
    if dayinsecs > limit_day then
      Result :=  1 else
      Result :=  0; (* date is equal to the date limit. *)
end;

{$ifdef fpc}{$hints off}{$endif}
{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
function CompTimeZoneID(const pTZinfo: PTimeZoneInformation;
  lpFileTime: PFileTime; islocal: Boolean): LongWord;
var
  ret: Integer;
  beforeStandardDate, afterDaylightDate: Boolean;
  llTime: Int64;
  SysTime: TSystemTime;
  ftTemp: TFileTime;
begin
  llTime := 0;

  if (pTZinfo^.DaylightDate.wMonth <> 0) then
  begin
    (* if year is 0 then date is in day-of-week format, otherwise
     * it's absolute date.
     *)
    if ((pTZinfo^.StandardDate.wMonth = 0) or
        ((pTZinfo^.StandardDate.wYear = 0) and
        ((pTZinfo^.StandardDate.wDay < 1) or
        (pTZinfo^.StandardDate.wDay > 5) or
        (pTZinfo^.DaylightDate.wDay < 1) or
        (pTZinfo^.DaylightDate.wDay > 5)))) then
    begin
      SetLastError(ERROR_INVALID_PARAMETER);
      Result := TIME_ZONE_ID_INVALID;
      Exit;
    end;

    if (not islocal) then
    begin
      llTime := PInt64(lpFileTime)^;
      dec(llTime, Int64(pTZinfo^.Bias + pTZinfo^.DaylightBias) * 600000000);
      PInt64(@ftTemp)^ := llTime;
      lpFileTime := @ftTemp;
    end;

    FileTimeToSystemTime(lpFileTime^, SysTime);

    (* check for daylight savings *)
    ret := DayLightCompareDate(@SysTime, @pTZinfo^.StandardDate);
    if (ret = -2) then
    begin
      Result := TIME_ZONE_ID_INVALID;
      Exit;
    end;

    beforeStandardDate := ret < 0;

    if (not islocal) then
    begin
      dec(llTime, Int64(pTZinfo^.StandardBias - pTZinfo^.DaylightBias) * 600000000);
      PInt64(@ftTemp)^ := llTime;
      FileTimeToSystemTime(lpFileTime^, SysTime);
    end;

    ret := DayLightCompareDate(@SysTime, @pTZinfo^.DaylightDate);
    if (ret = -2) then
    begin
      Result := TIME_ZONE_ID_INVALID;
      Exit;
    end;

    afterDaylightDate := ret >= 0;

    Result := TIME_ZONE_ID_STANDARD;
    if( pTZinfo^.DaylightDate.wMonth < pTZinfo^.StandardDate.wMonth ) then
    begin
      (* Northern hemisphere *)
      if( beforeStandardDate and afterDaylightDate) then
        Result := TIME_ZONE_ID_DAYLIGHT;
    end else    (* Down south *)
      if( beforeStandardDate or afterDaylightDate) then
        Result := TIME_ZONE_ID_DAYLIGHT;
  end else
    (* No transition date *)
    Result := TIME_ZONE_ID_UNKNOWN;
end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$ifdef fpc}{$hints on}{$endif}

function GetTimezoneBias(const pTZinfo: PTimeZoneInformation;
  lpFileTime: PFileTime; islocal: Boolean; pBias: PLongint): Boolean;
var
  bias: LongInt;
  tzid: LongWord;
begin
  bias := pTZinfo^.Bias;
  tzid := CompTimeZoneID(pTZinfo, lpFileTime, islocal);

  if( tzid = TIME_ZONE_ID_INVALID) then
  begin
    Result := False;
    Exit;
  end;
  if (tzid = TIME_ZONE_ID_DAYLIGHT) then
    inc(bias, pTZinfo^.DaylightBias)
  else if (tzid = TIME_ZONE_ID_STANDARD) then
    inc(bias, pTZinfo^.StandardBias);
  pBias^ := bias;
  Result := True;
end;

function SystemTimeToTzSpecificLocalTime(
  lpTimeZoneInformation: PTimeZoneInformation;
  lpUniversalTime, lpLocalTime: PSystemTime): BOOL;
var
  ft: TFileTime;
  lBias: LongInt;
  llTime: Int64;
  tzinfo: TTimeZoneInformation;
begin
  if (lpTimeZoneInformation <> nil) then
    tzinfo := lpTimeZoneInformation^ else
    if (GetTimeZoneInformation(tzinfo) = TIME_ZONE_ID_INVALID) then
    begin
      Result := False;
      Exit;
    end;
  {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
  if (not SystemTimeToFileTime(lpUniversalTime^, ft)) then
  {$hints on}
  begin
    Result := False;
    Exit;
  end;
  llTime := PInt64(@ft)^;
  if (not GetTimezoneBias(@tzinfo, @ft, False, @lBias)) then
  begin
    Result := False;
    Exit;
  end;
  (* convert minutes to 100-nanoseconds-ticks *)
  dec(llTime, Int64(lBias) * 600000000);
  PInt64(@ft)^ := llTime;
  Result := FileTimeToSystemTime(ft, lpLocalTime^);
end;

function TzSpecificLocalTimeToSystemTime(
    const lpTimeZoneInformation: PTimeZoneInformation;
    const lpLocalTime: PSystemTime; lpUniversalTime: PSystemTime): BOOL;
var
  ft: TFileTime;
  lBias: LongInt;
  t: Int64;
  tzinfo: TTimeZoneInformation;
begin
  if (lpTimeZoneInformation <> nil) then
    tzinfo := lpTimeZoneInformation^
  else
    if (GetTimeZoneInformation(tzinfo) = TIME_ZONE_ID_INVALID) then
    begin
      Result := False;
      Exit;
    end;

  {$hints off}//FPC: Hint: Local variable "*" does not seem to be initialized
  if (not SystemTimeToFileTime(lpLocalTime^, ft)) then
  {$hints on}
  begin
    Result := False;
    Exit;
  end;
  t := PInt64(@ft)^;
  if (not GetTimezoneBias(@tzinfo, @ft, True, @lBias)) then
  begin
    Result := False;
    Exit;
  end;
  (* convert minutes to 100-nanoseconds-ticks *)
  inc(t, Int64(lBias) * 600000000);
  PInt64(@ft)^ := t;
  Result := FileTimeToSystemTime(ft, lpUniversalTime^);
end;
{$ELSE !WINDOWSNT_COMPATIBILITY}
function TzSpecificLocalTimeToSystemTime(
  lpTimeZoneInformation: PTimeZoneInformation;
  lpLocalTime, lpUniversalTime: PSystemTime): BOOL; stdcall; external 'kernel32.dll';

function SystemTimeToTzSpecificLocalTime(
  lpTimeZoneInformation: PTimeZoneInformation;
  lpUniversalTime, lpLocalTime: PSystemTime): BOOL; stdcall; external 'kernel32.dll';
{$ENDIF !WINDOWSNT_COMPATIBILITY}

function JavaToDelphiDateTime(const dt: int64): TDateTime;
var
  t: TSystemTime;
begin
  DateTimeToSystemTime(25569 + (dt / 86400000), t);
  SystemTimeToTzSpecificLocalTime(nil, @t, @t);
  Result := SystemTimeToDateTime(t);
end;

function DelphiToJavaDateTime(const dt: TDateTime): int64;
var
  t: TSystemTime;
begin
  DateTimeToSystemTime(dt, t);
  TzSpecificLocalTimeToSystemTime(nil, @t, @t);
  Result := Round((SystemTimeToDateTime(t) - 25569) * 86400000)
end;
{$ENDIF !USE_POSIX}

{$ifdef fpc}{$hints off}{$endif}
function ISO8601DateToJavaDateTime(const str: SOString; var ms: Int64): Boolean;
type
  TState = (
    stStart, stYear, stMonth, stWeek, stWeekDay, stDay, stDayOfYear,
    stHour, stMin, stSec, stMs, stUTC, stGMTH, stGMTM,
    stGMTend, stEnd);

  TPerhaps = (yes, no, perhaps);
  TDateTimeInfo = record
    year: Word;
    month: Word;
    week: Word;
    weekday: Word;
    day: Word;
    dayofyear: Integer;
    hour: Word;
    minute: Word;
    second: Word;
    ms: Word;
    bias: Integer;
  end;

var
  p: PSOChar;
  state: TState;
  pos, v: Word;
  sep: TPerhaps;
  inctz, havetz, havedate: Boolean;
  st: TDateTimeInfo;
  DayTable: PDayTable;

  function get(var v: Word; c: SOChar): Boolean; {$IFDEF HAVE_INLINE}inline;{$ENDIF}
  begin
    if (SOIChar(c) < 256) and {+}
      {$IFDEF NEXTGEN}
      ( (Ord(c) >= Ord('0')) and (Ord(c) <= Ord('9')) )
      {$ELSE}
      CharInSet(c, ['0'..'9'])
      {$ENDIF}
      {+.} then
    begin
      Result := True;
      v := v * 10 + Ord(c) - Ord('0');
    end else
      Result := False;
  end;

label
  error;
begin
  p := PSOChar(str);
  sep := perhaps;
  state := stStart;
  pos := 0;
  FillChar(st, SizeOf(st), 0);
  havedate := True;
  inctz := False;
  havetz := False;

  while true do
  case state of
    stStart:
      case p^ of
        '0'..'9': state := stYear;
        'T', 't':
          begin
            state := stHour;
            pos := 0;
            inc(p);
            havedate := False;
          end;
      else
        goto error;
      end;
    stYear:
      case pos of
        0..1,3:
              if get(st.year, p^) then
              begin
                Inc(pos);
                Inc(p);
              end else
                goto error;
        2:    case p^ of
                '0'..'9':
                  begin
                    st.year := st.year * 10 + ord(p^) - ord('0');
                    Inc(pos);
                    Inc(p);
                  end;
                ':':
                  begin
                    havedate := false;
                    st.hour := st.year;
                    st.year := 0;
                    inc(p);
                    pos := 0;
                    state := stMin;
                    sep := yes;
                  end;
              else
                goto error;
              end;
        4: case p^ of
             '-': begin
                    pos := 0;
                    Inc(p);
                    sep := yes;
                    state := stMonth;
                  end;
             '0'..'9':
                  begin
                    sep := no;
                    pos := 0;
                    state := stMonth;
                  end;
             'W', 'w' :
                  begin
                    pos := 0;
                    Inc(p);
                    state := stWeek;
                  end;
             'T', 't', ' ':
                  begin
                    state := stHour;
                    pos := 0;
                    inc(p);
                    st.month := 1;
                    st.day := 1;
                  end;
             #0:
                  begin
                    st.month := 1;
                    st.day := 1;
                    state := stEnd;
                  end;
           else
             goto error;
           end;
      end;
    stMonth:
      case pos of
        0:  case p^ of
              '0'..'9':
                begin
                  st.month := ord(p^) - ord('0');
                  Inc(pos);
                  Inc(p);
                end;
              'W', 'w':
                begin
                  pos := 0;
                  Inc(p);
                  state := stWeek;
                end;
            else
              goto error;
            end;
        1:  if get(st.month, p^) then
            begin
              Inc(pos);
              Inc(p);
            end else
              goto error;
        2: case p^ of
             '-':
                  if (sep in [yes, perhaps])  then
                  begin
                    pos := 0;
                    Inc(p);
                    state := stDay;
                    sep := yes;
                  end else
                    goto error;
             '0'..'9':
                  if sep in [no, perhaps] then
                  begin
                    pos := 0;
                    state := stDay;
                    sep := no;
                  end else
                  begin
                    st.dayofyear := st.month * 10 + Ord(p^) - Ord('0');
                    st.month := 0;
                    inc(p);
                    pos := 3;
                    state := stDayOfYear;
                  end;
             'T', 't', ' ':
                  begin
                    state := stHour;
                    pos := 0;
                    inc(p);
                    st.day := 1;
                 end;
             #0:
               begin
                 st.day := 1;
                 state := stEnd;
               end;
           else
             goto error;
           end;
      end;
    stDay:
      case pos of
        0:  if get(st.day, p^) then
            begin
              Inc(pos);
              Inc(p);
            end else
              goto error;
        1:  if get(st.day, p^) then
            begin
              Inc(pos);
              Inc(p);
            end else
            if sep in [no, perhaps] then
            begin
              st.dayofyear := st.month * 10 + st.day;
              st.day := 0;
              st.month := 0;
              state := stDayOfYear;
            end else
              goto error;

        2: case p^ of
             'T', 't', ' ':
                  begin
                    pos := 0;
                    Inc(p);
                    state := stHour;
                  end;
             #0:  state := stEnd;
           else
             goto error;
           end;
      end;
    stDayOfYear:
      begin
        if (st.dayofyear <= 0) then goto error;
        case p^ of
          'T', 't', ' ':
               begin
                 pos := 0;
                 Inc(p);
                 state := stHour;
               end;
          #0:  state := stEnd;
        else
          goto error;
        end;
      end;
    stWeek:
      begin
        case pos of
          0..1: if get(st.week, p^) then
                begin
                  inc(pos);
                  inc(p);
                end else
                  goto error;
          2: case p^ of
               '-': if (sep in [yes, perhaps]) then
                    begin
                      Inc(p);
                      state := stWeekDay;
                      sep := yes;
                    end else
                      goto error;
               '1'..'7':
                    if sep in [no, perhaps] then
                    begin
                      state := stWeekDay;
                      sep := no;
                    end else
                      goto error;
             else
               goto error;
             end;
        end;
      end;
    stWeekDay:
      begin
        if (st.week > 0) and get(st.weekday, p^) then
        begin
          inc(p);
          v := st.year - 1;
          v := ((v * 365) + (v div 4) - (v div 100) + (v div 400)) mod 7 + 1;
          st.dayofyear := (st.weekday - v) + ((st.week) * 7) + 1;
          if v <= 4 then dec(st.dayofyear, 7);
          case p^ of
            'T', 't', ' ':
                 begin
                   pos := 0;
                   Inc(p);
                   state := stHour;
                 end;
            #0:  state := stEnd;
          else
            goto error;
          end;
        end else
          goto error;
      end;
    stHour:
      case pos of
        0:    case p^ of
                '0'..'9':
                    if get(st.hour, p^) then
                    begin
                      inc(pos);
                      inc(p);
                      end else
                        goto error;
                '-':
                  begin
                    inc(p);
                    state := stMin;
                  end;
              else
                goto error;
              end;
        1:    if get(st.hour, p^) then
              begin
                inc(pos);
                inc(p);
              end else
                goto error;
        2: case p^ of
             ':': if sep in [yes, perhaps] then
                  begin
                    sep := yes;
                    pos := 0;
                    Inc(p);
                    state := stMin;
                  end else
                    goto error;
             ',', '.':
                begin
                  Inc(p);
                  state := stMs;
                end;
             '+':
               if havedate then
               begin
                 state := stGMTH;
                 pos := 0;
                 v := 0;
                 inc(p);
               end else
                 goto error;
             '-':
               if havedate then
               begin
                 state := stGMTH;
                 pos := 0;
                 v := 0;
                 inc(p);
                 inctz := True;
               end else
                 goto error;
             'Z', 'z':
                  if havedate then
                    state := stUTC else
                    goto error;
             '0'..'9':
                  if sep in [no, perhaps] then
                  begin
                    pos := 0;
                    state := stMin;
                    sep := no;
                  end else
                    goto error;
             #0:  state := stEnd;
           else
             goto error;
           end;
      end;
    stMin:
      case pos of
        0: case p^ of
             '0'..'9':
                if get(st.minute, p^) then
                begin
                  inc(pos);
                  inc(p);
                end else
                  goto error;
             '-':
                begin
                  inc(p);
                  state := stSec;
                end;
           else
             goto error;
           end;
        1: if get(st.minute, p^) then
           begin
             inc(pos);
             inc(p);
           end else
             goto error;
        2: case p^ of
             ':': if sep in [yes, perhaps] then
                  begin
                    pos := 0;
                    Inc(p);
                    state := stSec;
                    sep := yes;
                  end else
                    goto error;
             ',', '.':
                begin
                  Inc(p);
                  state := stMs;
                end;
             '+':
               if havedate then
               begin
                 state := stGMTH;
                 pos := 0;
                 v := 0;
                 inc(p);
               end else
                 goto error;
             '-':
               if havedate then
               begin
                 state := stGMTH;
                 pos := 0;
                 v := 0;
                 inc(p);
                 inctz := True;
               end else
                 goto error;
             'Z', 'z':
                  if havedate then
                    state := stUTC else
                    goto error;
             '0'..'9':
                  if sep in [no, perhaps] then
                  begin
                    pos := 0;
                    state := stSec;
                  end else
                    goto error;
             #0:  state := stEnd;
           else
             goto error;
           end;
      end;
    stSec:
      case pos of
        0..1: if get(st.second, p^) then
              begin
                inc(pos);
                inc(p);
              end else
                goto error;
        2:    case p^ of
               ',', '.':
                  begin
                    Inc(p);
                    state := stMs;
                  end;
               '+':
                 if havedate then
                 begin
                   state := stGMTH;
                   pos := 0;
                   v := 0;
                   inc(p);
                 end else
                   goto error;
               '-':
                 if havedate then
                 begin
                   state := stGMTH;
                   pos := 0;
                   v := 0;
                   inc(p);
                   inctz := True;
                 end else
                   goto error;
               'Z', 'z':
                    if havedate then
                      state := stUTC else
                      goto error;
               #0: state := stEnd;
              else
               goto error;
              end;
      end;
    stMs:
      case p^ of
        '0'..'9':
        begin
          st.ms := st.ms * 10 + ord(p^) - ord('0');
          inc(p);
        end;
        '+':
          if havedate then
          begin
            state := stGMTH;
            pos := 0;
            v := 0;
            inc(p);
          end else
            goto error;
        '-':
          if havedate then
          begin
            state := stGMTH;
            pos := 0;
            v := 0;
            inc(p);
            inctz := True;
          end else
            goto error;
        'Z', 'z':
             if havedate then
               state := stUTC else
               goto error;
        #0: state := stEnd;
      else
        goto error;
      end;
    stUTC: // = GMT 0
      begin
        havetz := True;
        inc(p);
        if p^ = #0 then
          Break else
          goto error;
      end;
    stGMTH:
      begin
        havetz := True;
        case pos of
          0..1: if get(v, p^) then
                begin
                  inc(p);
                  inc(pos);
                end else
                  goto error;
          2:
            begin
              st.bias := v * 60;
              case p^ of
                ':': //if sep in [yes, perhaps] then
                     begin
                       state := stGMTM;
                       inc(p);
                       pos := 0;
                       v := 0;
                       sep := yes;
                     end{
                     else
                       goto error};
                '0'..'9':
                     //if sep in [no, perhaps] then
                     begin
                       state := stGMTM;
                       pos := 1;
                       sep := no;
                       inc(p);
                       v := ord(p^) - ord('0');
                     end{ else
                       goto error};
                #0: state := stGMTend;
              else
                goto error;
              end;

            end;
        end;
      end;
    stGMTM:
      case pos of
        0..1:  if get(v, p^) then
               begin
                 inc(p);
                 inc(pos);
               end else
                 goto error;
        2:  case p^ of
              #0:
                begin
                  state := stGMTend;
                  inc(st.Bias, v);
                end;
            else
              goto error;
            end;
      end;
    stGMTend:
      begin
        if not inctz then
          st.Bias := -st.bias;
        Break;
      end;
    stEnd:
    begin

      Break;
    end;
  end;

  if (st.hour >= 24) or (st.minute >= 60) or (st.second >= 60) or (st.ms >= 1000) or (st.week > 53)
    then goto error;

  if not havetz then
    st.bias := GetTimeBias;

  ms := st.ms + st.second * 1000 + (st.minute + st.bias) * 60000 + st.hour * 3600000;
  if havedate then
  begin
    DayTable := @MonthDays[IsLeapYear(st.year)];
    if st.month <> 0 then
    begin
      if not (st.month in [1..12]) or (DayTable^[st.month] < st.day) then
        goto error;

      for v := 1 to st.month - 1 do
        Inc(ms, Int64(DayTable^[v]) * Int64(86400000)); // FPC: Fix Overflow Error (EIntOverflowError: Arithmertic overflow)
    end;
    dec(st.year);
    ms := ms + (int64((st.year * 365) + (st.year div 4) - (st.year div 100) +
      (st.year div 400) + st.day + st.dayofyear - 719163) * 86400000);
  end;

 Result := True;
 Exit;
error:
  Result := False;
end;
{$ifdef fpc}{$hints on}{$endif}

//function ISO8601DateToDelphiDateTime(const str: String; var dt: TDateTime): Boolean;
//var
//  ms: Int64;
//begin
//  Result := ISO8601DateToJavaDateTime(str, ms);
//  if Result then
//    dt := JavaToDelphiDateTime(ms)
//end;

//function DelphiDateTimeToISO8601Date(dt: TDateTime): String;
//var
//  year, month, day, hour, min, sec, msec: Word;
//  tzh: SmallInt;
//  tzm: Word;
//  sign: Char;
//  bias: Integer;
//begin
//  DecodeDate(dt, year, month, day);
//  DecodeTime(dt, hour, min, sec, msec);
//  bias := GetTimeBias;
//  tzh := Abs(bias) div 60;
//  tzm := Abs(bias) - tzh * 60;
//  if Bias > 0 then
//    sign := '-' else
//    sign := '+';
//  Result := Format('%.4d-%.2d-%.2dT%.2d:%.2d:%.2d,%d%s%.2d:%.2d',
//    [year, month, day, hour, min, sec, msec, sign, tzh, tzm]);
//end;

{$ENDIF !SUPERTIMEZONE}
{+.}

{$if not declared(DateToISO8601)}
function DateToISO8601(const ADate: TDateTime; AInputIsUTC: Boolean = true): string;
const
  SDateFormat: string = '%.4d-%.2d-%.2dT%.2d:%.2d:%.2d.%.3dZ'; { Do not localize }
  SOffsetFormat: string = '%s%s%.02d:%.02d'; { Do not localize }
  Neg: array[Boolean] of string = ('+', '-'); { Do not localize }
var
  y, mo, d, h, mi, se, ms: Word;
  Bias: Integer;
  {$IFNDEF SQLTIMESTAMP}
  {$if declared(TTimeZone)}
  TimeZone: TTimeZone;
  {$ifend}
  {$ENDIF !SQLTIMESTAMP}
begin
  DecodeDate(ADate, y, mo, d);
  DecodeTime(ADate, h, mi, se, ms);
  Result := Format(SDateFormat, [y, mo, d, h, mi, se, ms]);
  if not AInputIsUTC then
  begin
    {$if declared(TTimeZone)}
    {$IFDEF SQLTIMESTAMP}
    InitTZInfo;
    Bias := FTzInfo.FInfo.Bias;
    {$ELSE !SQLTIMESTAMP}
    TimeZone := TTimeZone.Local;
    {$hints off} // Hint: H2443 Inline function 'TTimeZone.GetUtcOffset' has not been expanded because unit 'System.TimeSpan' is not specified in USES list
    Bias := Trunc(TimeZone.GetUTCOffset(ADate).Negate.TotalMinutes);
    {$ENDIF !SQLTIMESTAMP}
    {$else}
?   Bias := 0;
    {$ifend}
    if Bias <> 0 then
    begin
      // Remove the Z, in order to add the UTC_Offset to the string.
      SetLength(Result, Length(Result) - 1);
      Result := Format(SOffsetFormat, [Result, Neg[Bias > 0], Abs(Bias) div MinsPerHour,
        Abs(Bias) mod MinsPerHour]);
    end
  end;
end;
{$hints on}
{$ifend}

function DelphiDateToISO8601(const ADate: TDateTime; AInputIsUTC: Boolean = true): SOString;
begin
  Result := SOString(DateToISO8601(ADate, AInputIsUTC));
end;

{$UNDEF USE_ISO8601ToDate} { not change }
{$if declared(TryISO8601ToDate)}
  {-$DEFINE USE_ISO8601ToDate} // optional: DateItils.pas: TryISO8601ToDate. !! Slowly through the use of try-except !!
{$ifend}

function TryISO8601ToDelphiDate(const AISODate: SOString; out Value: TDateTime; AReturnUTC: Boolean = True): Boolean;
{$IFNDEF USE_ISO8601ToDate}
var
  jdt: Int64;
  {$IFDEF SUPERTIMEZONE}
  LTimeZone: TSuperTimeZone;
  {$ENDIF}
  {$IFDEF SQLTIMESTAMP}
  LValue: TSQLTimeStamp;
  {$ENDIF SQLTIMESTAMP}
{$ENDIF USE_ISO8601ToDate}
begin
  {$IFDEF USE_ISO8601ToDate}
  Result := TryISO8601ToDate(AISODate, Value, AReturnUTC);
  {$ELSE !USE_ISO8601ToDate}
    {$IFDEF SUPERTIMEZONE}
    LTimeZone := TSuperTimeZone.Zone[ TSuperTimeZone.GetCurrentTimeZone ];
    Result := LTimeZone.ISO8601ToJava(AISODate, jdt);
    if Result then begin
      Value := LTimeZone.JavaToDelphi(jdt);
      if AReturnUTC then
        Value := LTimeZone.LocalToUTC(Value);
    end;
    {$ELSE}
    Result := ISO8601DateToJavaDateTime(AISODate, {%H-}jdt);
    if Result then begin
      Value := JavaToDelphiDateTime(jdt);
      if AReturnUTC then begin
        {$if declared(TTimeZone)}
        {$IFDEF SQLTIMESTAMP}
        InitTZInfo;
        LValue := DateTimeToSQLTimeStamp(Value);
        Value := SQLTimeStampToDateTime(LocalToUTC(FTzInfo, LValue));
        {$ELSE !SQLTIMESTAMP}
        Value := TTimeZone.Local.ToUniversalTime(Value);
        {$ENDIF !SQLTIMESTAMP}
        {$else}
        Value := LocalTimeToUniversal(Value);
        {$ifend}
      end;
    end;
    {$ENDIF}
  {$ENDIF !USE_ISO8601ToDate}
end;

function DelphiDateTimeToUnix(const AValue: TDateTime; AInputIsUTC: Boolean = True): Int64;
{$if defined(FPC) or (CompilerVersion >= 30.00)}{$else}
var LDate : TDateTime;
{$ifend}
{$IFDEF SQLTIMESTAMP}
var LValue: TSQLTimeStamp;
{$ENDIF SQLTIMESTAMP}
begin
  {$if defined(FPC) or (CompilerVersion >= 30.00)}
  Result := DateTimeToUnix(AValue, AInputIsUTC);
  {$else}
  if AInputIsUTC then
    LDate := AValue
  else begin
    {$if declared(TTimeZone)}
    {$IFDEF SQLTIMESTAMP}
    InitTZInfo;
    LValue := DateTimeToSQLTimeStamp(AValue);
    LDate := SQLTimeStampToDateTime(UTCToLocal(FTzInfo, LValue));
    {$ELSE !SQLTIMESTAMP}
    LDate := TTimeZone.Local.ToUniversalTime(AValue);
    {$ENDIF !SQLTIMESTAMP}
    {$else}
    LDate := LocalTimeToUniversal(AValue);
    {$ifend}
  end;
  Result := SecondsBetween(UnixDateDelta, LDate);
  if LDate < UnixDateDelta then
     Result := -Result;
  {$ifend}
end;

function UnixToDelphiDateTime(const AValue: Int64; AReturnUTC: Boolean): TDateTime;
{$IFDEF SQLTIMESTAMP}
var LValue: TSQLTimeStamp;
{$ENDIF SQLTIMESTAMP}
begin
  {$if defined(FPC) or (CompilerVersion >= 30.00)}
  Result := UnixToDateTime(AValue, AReturnUTC);
  {$else}
  if AReturnUTC then
    Result := IncSecond(UnixDateDelta, AValue)
  else begin
    {$if declared(TTimeZone)}
    {$IFDEF SQLTIMESTAMP}
    InitTZInfo;
    LValue := DateTimeToSQLTimeStamp(IncSecond(UnixDateDelta, AValue));
    Result := SQLTimeStampToDateTime(UTCToLocal(FTzInfo, LValue));
    {$ELSE !SQLTIMESTAMP}
    Result := TTimeZone.Local.ToLocalTime(IncSecond(UnixDateDelta, AValue));
    {$ENDIF !SQLTIMESTAMP}
    {$else}
    Result := UniversalTimeToLocal(AValue);
    {$ifend}
  end;
  {$ifend}
end;

end.
