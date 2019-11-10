unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  CIDPrinter_TLB;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
  public
    Print: CIDPrintiD;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  //Inicialmente, abre a DLL e instancia o objeto COM. Nunca esquecer desta parte
  if Print = nil then
  begin
    Print := CoCIDPrintiD.Create;
  end;

  Print.Iniciar(); //Também é possível iniciar como rede:  Print.IniciarRede();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Print.Imprimir('Teste de Delphi\n');
  Print.ImprimirFormatado('String formatada\n', True, True, False, True, False);
  Print.ImprimirTeste();
  Print.ConfigurarCodigoDeBarras(100,100,PosicaoCaracteresBarras_CARACTERES_ABAIXO);
  Print.ImprimirCodigoQR('TESTE',4,QRCorrecaoErro_ALTO,QRModelo_MODELO_1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Print.AbrirGaveta(PinoGaveta_PINO2_RJ12,200,200);
  Print.AbrirGaveta(PinoGaveta_PINO5_RJ12,200,200);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Print.Finalizar();
end;

end.
