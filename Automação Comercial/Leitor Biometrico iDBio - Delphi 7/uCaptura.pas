unit uCaptura;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ControlId,
  Dialogs, StdCtrls, ExtCtrls, Spin;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    mmoDedo: TMemo;
    btn3: TButton;
    btn4: TButton;
    se1: TSpinEdit;
    btn6: TButton;
    pnl1: TPanel;
    lblLeitor: TLabel;
    btn1: TButton;
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);   

    //retora os dados do leitor
    function DadosLeitor: string;

    //retornar digital
    function RetornarDigital: String;

    //validar digital
    function ValidarDigital(cDigital1: String; cDigital2: String): Boolean;

  private
    { Private declarations }
    sDedo: String;



  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.DadosLeitor: string;
var
  version: String;
  serialNumber: String;
  model: String;
  Ret: Integer;
  bio : CIDBio;
begin
   Result := '';
   bio := CIDBio.Create;
   try
        Ret := bio.Init;
        if Ret >= SUCCESS then
        begin
             Result := bio.GetErrorMessage(ret)
        end
        else Application.MessageBox(pchar('Erro no leitor: '+ Bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
   finally
        bio.GetDeviceInfo(version, serialNumber, model);
        Result := 'Versão Firmware: '+ version +sLineBreak+
                  'Nº série: '+ serialNumber +sLineBreak+
                  'Modelo: '+ model;
        bio.Terminate;
   end;
        bio.Free;
end;

function TForm1.RetornarDigital: String;
var
  Ret: Integer;
  stemplate: String;
  aBytes: ByteArray;
  aWidth, aHeigt: Integer;
  aQualidade: Integer;
  bio : CIDBio;
begin
  Result := '';
  bio := CIDBio.Create;
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
  bio.Free;

end;

function TForm1.ValidarDigital(cDigital1: String; cDigital2: String): Boolean;
var
  Ret: Integer;
  aScore: Integer;
  bio : CIDBio;
begin
  Result := False;
  bio := CIDBio.Create;

  try
    Ret := bio.Init;
    if Ret >= SUCCESS then
    begin
      Ret := bio.MatchTemplates(cDigital1, cDigital2, aScore);
      Result := (Ret = SUCCESS);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: '+ bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
    bio.Terminate;
  end;
  bio.Free;

end;


procedure TForm1.btn1Click(Sender: TObject);
begin
// Button "Dados do Leitor"
  lblLeitor.Caption := DadosLeitor();

end;

procedure TForm1.btn3Click(Sender: TObject);
begin
// Button "Capturar digital"
  mmoDedo.Lines.Clear;
  btn3.Enabled := False;
  btn1.Enabled := False;

  lbl1.Caption := 'Coloque o dedo no leitor';
  lbl1.Refresh;

  try
    sDedo := RetornarDigital();
    if (sDedo <> '') then
    begin
      mmoDedo.Lines.Add( sDedo );
      lbl1.Caption := 'Template gerado';
    end
    else
      lbl1.Caption := 'Captura';

    lbl1.Refresh;
  except
    on E: Exception do
      ShowMessage('Erro: '+E.Message);
  end;

  btn3.Enabled := True;
  btn1.Enabled := True;

end;

procedure TForm1.btn4Click(Sender: TObject);
var
  error: String;
  bio : CIDBio;
  ret : integer;
begin

  bio := CIDBio.Create;
  try
    Ret := bio.Init;
    if Ret >= SUCCESS then
    begin
         error := bio.GetErrorMessage(se1.Value);
         mmoDedo.Lines.Add(error);
    end
    else
      Application.MessageBox(pchar('Erro no leitor: '+ bio.GetErrorMessage(Ret)),'Atenção', MB_ICONWARNING);
  finally
    bio.Terminate;
  end;
  bio.Free;



end;

procedure TForm1.btn5Click(Sender: TObject);
var
  stemplate: String;
begin
// Button "Validar Digital"
  lbl1.Caption := 'Coloque o dedo no leitor';
  lbl1.Refresh;

  btn6.Enabled := False;
  btn1.Enabled := False;
  btn3.Enabled := False;

  try
    stemplate := RetornarDigital();
    if (stemplate <> '') then
    begin
      if (ValidarDigital(stemplate, sDedo) = True) then
        lbl1.Caption := 'Digital válida'
      else
        lbl1.Caption := 'Digital inválida';
    end
    else
      lbl1.Caption := 'Captura';

    lbl1.Refresh;
  except
    on E: Exception do
      ShowMessage('Erro: '+E.Message);
  end;

  btn6.Enabled := True;
  btn1.Enabled := True;
  btn3.Enabled := True;

end;

end.
