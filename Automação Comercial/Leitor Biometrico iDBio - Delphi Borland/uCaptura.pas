unit uCaptura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.DApt, Vcl.ExtCtrls, ControliD;

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
    btn_CaptureImage: TButton;
    Image1: TImage;
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn_CaptureImageClick(Sender: TObject);
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

uses SCVBioControlID;

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

procedure TForm1.btn_CaptureImageClick(Sender: TObject);
var
  Bitmap: TBitmap;
  imageBytes: ByteArray;
  width, height: Integer;
  success: Boolean;
begin
// Button "Capturar Imagem"
  mmoDedo.Lines.Clear;

  lbl1.Caption := 'Coloque o dedo no leitor';
  lbl1.Refresh;

  success := RetornarImagem(imageBytes, width, height);
  //ShowMessage(Format('Width: %d, Height: %d', [width, height]));

  if success then
    Bitmap := ImageBufferToBitmap(imageBytes, width, height);
    Image1.Picture.Bitmap.Assign(Bitmap);
    mmoDedo.Lines.Add('');

end;

procedure TForm1.btn4Click(Sender: TObject);
var
  error: String;
begin
// Button "Get Erro"
  error := CIDBIO.GetErrorMessage(RetCode(se1.Value));
  mmoDedo.Lines.Add(error);

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
