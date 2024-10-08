unit SCVBioControlID;

interface

uses
  Vcl.Forms, Winapi.Windows, ControliD, System.SysUtils, Vcl.Graphics, Vcl.Dialogs;

  //validar digital
  function ValidarDigital(cDigital1: String; cDigital2: String): Boolean;

  //retornar digital
  function RetornarDigital: String;

  //retornar o estado do leitor
  function VerificaLeitor: RetCode;

  //retora os dados do leitor
  function DadosLeitor: string;

  //retornar imagem
  function RetornarImagem(out oBytes: ByteArray; out oWidth, oHeight: Integer): Boolean;
  function ImageBufferToBitmap(const imageBuf: ByteArray; width, height: Integer): TBitmap;

implementation

function ValidarDigital(cDigital1: String; cDigital2: String): Boolean;
var
  Ret: RetCode;
  aScore: Int32;
  bio : CIDBio;
begin
  Result := False;

  Ret := CIDBIO.Init;
  try
    if Ret >= RetCode.SUCCESS then
    begin
      bio := CIDBio.Create;
      Ret := bio.MatchTemplates(cDigital1, cDigital2, aScore);
      Result := (Ret = RetCode.SUCCESS);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: '+ CIDBio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
    CIDBIO.Terminate;
  end;

end;

function RetornarDigital: String;
var
  Ret: RetCode;
  stemplate: String;
  aBytes: ByteArray;
  aWidth, aHeigt: Int32;
  aQualidade: Int32;
  bio : CIDBio;
begin
  Result := '';

  Ret := CIDBIO.Init;
  try
    if Ret >= RetCode.SUCCESS then
    begin
      bio := CIDBio.Create;
      Ret := bio.CaptureImageAndTemplate(stemplate, aBytes, aWidth, aHeigt, aQualidade);
      if Ret = RetCode.SUCCESS then
      begin
        Result := stemplate;
      end
      else
        Application.MessageBox(pchar('Erro no leitor: '+ CIDBio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: '+ CIDBio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
    CIDBIO.Terminate;
  end;

end;

function VerificaLeitor : RetCode;
begin
  try
    Result := CIDBIO.Init;
  finally
    CIDBIO.Terminate;
  end;

end;

function DadosLeitor: string;
var
  version: String;
  serialNumber: String;
  model: String;
  Ret: RetCode;
  bio : CIDBIO;
begin
  Result := '';

  Ret := CIDBIO.Init;
  try
    if Ret >= RetCode.SUCCESS then
    begin
      bio := CIDBio.Create;
      Ret := bio.GetDeviceInfo(version, serialNumber, model);
      if Ret = RetCode.SUCCESS then
      begin
        Result := 'Versão Frimware: '+ version +sLineBreak+
                  'Nº série: '+ serialNumber +sLineBreak+
                  'Modelo: '+ model;
      end
      else
        Application.MessageBox(pchar('Erro no leitor: ' + CIDBIO.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: ' + CIDBIO.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
    CIDBIO.Terminate;
  end;

end;

function ImageBufferToBitmap(const imageBuf: ByteArray; width, height: Integer): TBitmap;
var
  x, y: Integer;
  color: Byte;
begin
  if Length(imageBuf) <> width * height then
    raise Exception.Create('O tamanho do buffer de imagem não corresponde às dimensões fornecidas.');

  Result := TBitmap.Create;
  try
    Result.PixelFormat := pf24bit;
    Result.Width := width;
    Result.Height := height;
    for y := 0 to height - 1 do
    begin
      for x := 0 to width - 1 do
      begin
        color := imageBuf[x + width * y];
        Result.Canvas.Pixels[x, y] := RGB(color, color, color);
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function RetornarImagem(out oBytes: ByteArray; out oWidth, oHeight: Integer): Boolean;
var
  Ret: RetCode;
  stemplate: String;
  aQualidade: Integer;
  aBytes: ByteArray;
  aWidth, aHeight: Integer;
  bio: CIDBio;
begin
  Result := False;

  Ret := CIDBIO.Init;
  try
    if Ret >= RetCode.SUCCESS then
    begin
      bio := CIDBio.Create;
      try
        Ret := bio.CaptureImageAndTemplate(stemplate, aBytes, aWidth, aHeight, aQualidade);
        if Ret = RetCode.SUCCESS then
        begin
          oBytes := aBytes;
          oWidth := aWidth;
          oHeight := aHeight;
          Result := True;
        end
        else
          Application.MessageBox(PChar('Erro no leitor: ' + CIDBio.GetErrorMessage(Ret)), 'Atenção', MB_ICONWARNING);
      finally
        bio.Free;
      end;
    end
    else
      Application.MessageBox(PChar('Erro no leitor: ' + CIDBio.GetErrorMessage(Ret)), 'Atenção', MB_ICONWARNING);
  finally
    CIDBIO.Terminate;
  end;
end;

end.
