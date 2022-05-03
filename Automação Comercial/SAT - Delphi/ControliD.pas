unit ControliD;

interface

  {libsatid.dll functions}
  Function EnviarDadosVenda(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar; dadosVenda : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';
  Function ConsultarSAT(numeroSessao : Int32):  PAnsiChar; cdecl; External 'libsatid.dll';
  Function TesteFimAFim(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar; dadosVenda : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';
  Function ConsultarStatusOperacional(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';
  Function ExtrairLogs(numeroSessao : Int32; codigoDeAtivacao : PAnsiChar): PAnsiChar ; cdecl; External 'libsatid.dll';

  type
  SatId = Class(TObject)
    Public
    Class Function UtilEnviarDadosVenda(numeroSessao : Int32; codigoDeAtivacao : String; dadosVenda : String): String; Static;
    Class Function UtilConsultarSat(numeroSessao : Int32): String; Static;
    Class Function UtilTesteFimAFim(numeroSessao : Int32; codigoDeAtivacao : String; dadosVenda : String): String; Static;
    Class Function UtilConsultarStatusOperacional(numeroSessao : Int32; codigoDeAtivacao : String): String; Static;
    Class Function UtilExtrairLogs(numeroSessao : Int32; codigoDeAtivacao : String): String; Static;
  End;

implementation
  Class Function SatId.UtilEnviarDadosVenda(numeroSessao : Int32; codigoDeAtivacao : String; dadosVenda : String): String;
  Begin
    Result := EnviarDadosVenda(numeroSessao,PAnsiChar(AnsiString(codigoDeAtivacao)), PAnsiChar(AnsiString(dadosVenda)));
  End;

  Class Function SatId.UtilConsultarSat(numeroSessao : Int32): String;
  Begin
    Result :=  ConsultarSat(numeroSessao);
  End;

  Class Function SatId.UtilTesteFimAFim(numeroSessao : Int32; codigoDeAtivacao : String; dadosVenda : String): String;
  Begin
    Result := TesteFimAFim(numeroSessao, PAnsiChar(AnsiString(codigoDeAtivacao)), PAnsiChar(AnsiString(dadosVenda)));
  End;

  Class Function SatId.UtilConsultarStatusOperacional(numeroSessao : Int32; codigoDeAtivacao : String): String;
  Begin
    Result :=  ConsultarStatusOperacional(numeroSessao, PAnsiChar(AnsiString(codigoDeAtivacao)));
  End;

   Class Function SatId.UtilExtrairLogs(numeroSessao : Int32; codigoDeAtivacao : String): String;
   Begin
    Result :=  ExtrairLogs(numeroSessao, PAnsiChar(AnsiString(codigoDeAtivacao)));
   End;

end.
