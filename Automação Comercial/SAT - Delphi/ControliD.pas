unit ControliD;

interface

  {libsatid.dll functions}
  Function EnviarDadosVenda(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar; dadosVenda : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';
  Function ConsultarSAT(numeroSessao : Int32):  PAnsiChar; cdecl; External 'libsatid.dll';
  Function TesteFimAFim(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar; dadosVenda : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';
  Function ConsultarStatusOperacional(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';
  Function ExtrairLogs(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';
  Procedure DesalocarString(str : PAnsiChar); cdecl; External 'libsatid.dll';

  type
  SatId = Class(TObject)
    Public
    Class Function UtilEnviarDadosVenda(numeroSessao : Int32; codigoDeAtivacao : UTF8String; dadosVenda : UTF8String): UTF8String; Static;
    Class Function UtilConsultarSat(numeroSessao : Int32): UTF8String; Static;
    Class Function UtilTesteFimAFim(numeroSessao : Int32; codigoDeAtivacao : UTF8String; dadosVenda : UTF8String): UTF8String; Static;
    Class Function UtilConsultarStatusOperacional(numeroSessao : Int32; codigoDeAtivacao : UTF8String): UTF8String; Static;
    Class Function UtilExtrairLogs(numeroSessao : Int32; codigoDeAtivacao : UTF8String): UTF8String; Static;
  End;

implementation
  Class Function SatId.UtilEnviarDadosVenda(numeroSessao : Int32; codigoDeAtivacao : UTF8String; dadosVenda : UTF8String): UTF8String;
  Begin
    Result := EnviarDadosVenda(numeroSessao,PAnsiChar(AnsiString(codigoDeAtivacao)), PAnsiChar(AnsiString(dadosVenda)));
  End;

  Class Function SatId.UtilConsultarSat(numeroSessao : Int32): UTF8String;
  var
    p: PAnsiChar;
    s: UTF8String;
  Begin
    p := ConsultarSat(numeroSessao);
    s := p;
    DesalocarString(p);
    Result := s;
  End;

  Class Function SatId.UtilTesteFimAFim(numeroSessao : Int32; codigoDeAtivacao : UTF8String; dadosVenda : UTF8String): UTF8String;
  var
    p: PAnsiChar;
    s: UTF8String;
  Begin
    p := TesteFimAFim(numeroSessao, PAnsiChar(AnsiString(codigoDeAtivacao)), PAnsiChar(AnsiString(dadosVenda)));
    s := p;
    DesalocarString(p);
    Result := s;
  End;

  Class Function SatId.UtilConsultarStatusOperacional(numeroSessao : Int32; codigoDeAtivacao : UTF8String): UTF8String;
  var
    p: PAnsiChar;
    s: UTF8String;
  Begin
    p :=  ConsultarStatusOperacional(numeroSessao, PAnsiChar(AnsiString(codigoDeAtivacao)));
    s := p;
    DesalocarString(p);
    Result := s;
  End;

   Class Function SatId.UtilExtrairLogs(numeroSessao : Int32; codigoDeAtivacao : UTF8String): UTF8String;
   var
    p: PAnsiChar;
    s: UTF8String;
   Begin
    p :=  ExtrairLogs(numeroSessao, PAnsiChar(AnsiString(codigoDeAtivacao)));
    s := p;
    DesalocarString(p);
    Result := s;
   End;

end.
