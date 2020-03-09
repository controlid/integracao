unit CapDigitais;

{$mode objfpc}{$H+}

interface

uses
  Forms, Classes, SysUtils,  Dialogs, LCLType, ControliD;


Type

TDigital = class(TComponent)
  private


  protected


  public

  Ret: Integer;
  aScore: Integer;
  bio : CIDBio;

  //validar digital
  function ValidarDigital(cDigital1: String; cDigital2: String): Boolean;

  //retornar digital
  function RetornarDigital: String;

  //retornar o estado do leitor
  function VerificaLeitor: Integer;

  //retora os dados do leitor
  function DadosLeitor: string;

  function MensagemErro(value : Integer) : String;

     Constructor Create();
     Destructor Destroy;

  published


  end;

implementation

constructor TDigital.Create();
begin
   bio := CIDBio.Create;
end;

destructor TDigital.Destroy;
begin
   bio.Free;
   inherited Destroy;
end;

function TDigital.MensagemErro(value : integer): String;
begin
  Result := '';
  try
    Ret := bio.Init;
    if Ret >= SUCCESS then
    begin
      Result := bio.GetErrorMessage(value)
    end else
      Application.MessageBox(pchar('Erro no leitor: '+ Bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
    bio.Terminate;
  end;
end;

function TDigital.ValidarDigital(cDigital1: String; cDigital2: String): Boolean;

begin
  Result := False;
  try
    Ret := bio.Init;
    if Ret >= SUCCESS then
    begin
      Ret := bio.MatchTemplates(cDigital1, cDigital2, aScore);
      Result := (Ret = SUCCESS);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: '+ Bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
    bio.Terminate;
  end;
end;

function TDigital.RetornarDigital: String;
var
  stemplate: String;
  aBytes: ByteArray;
  aWidth, aHeigt: Integer;
  aQualidade: Integer;
begin
  Result := '';
  try
    Ret := bio.Init;
    if Ret >= SUCCESS then
    begin
      Ret := bio.CaptureImageAndTemplate(stemplate, aBytes, aWidth, aHeigt, aQualidade);
      if Ret = SUCCESS then
      begin
        Result := stemplate;
      end
      else
        Application.MessageBox(pchar('Erro no leitor: '+ bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: '+ bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
     bio.Terminate;
  end;
end;

function TDigital.VerificaLeitor : Integer;
begin
  try
    Result := bio.Init;
  finally
    bio.Terminate;
  end;

end;

function TDigital.DadosLeitor: string;
var
  version: String;
  serialNumber: String;
  model: String;
begin
  Result := '';
  try
    Ret := bio.Init;
    if Ret >= SUCCESS then
    begin

      Ret := bio.GetDeviceInfo(version, serialNumber, model);
      if Ret = SUCCESS then
      begin
        Result := 'Versão Frimware: '+ version +sLineBreak+
                  'Nº série: '+ serialNumber +sLineBreak+
                  'Modelo: '+ model;
      end
      else
        Application.MessageBox(pchar('Erro no leitor: ' + bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: ' + bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
      bio.Terminate;
  end;
end;


end.





