unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls, ControliD;
type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Panel1: TPanel;
    Button4: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  arquivoVenda : UTF8String;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   returnMsg: UTF8String;
   numeroSessao: Int32;
begin
   randomize();
   numeroSessao := random(1000);
   returnMsg := SatId.UtilConsultarSat(numeroSessao);
   ShowMessage(returnMsg);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   returnMsg: UTF8String;
   numeroSessao: Int32;
begin
   randomize();
   numeroSessao := random(1000);
   returnMsg :=  SatId.UtilConsultarStatusOperacional(numeroSessao, Edit1.Text);
   ShowMessage(returnMsg);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
   returnMsg: UTF8String;
   numeroSessao: Int32;
begin
   randomize();
   numeroSessao := random(1000);
   returnMsg :=  SatId.UtilEnviarDadosVenda(numeroSessao, Edit1.Text, arquivoVenda);
   ShowMessage(returnMsg);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  myFile : TextFile;
begin
   AssignFile(myFile, Edit2.Text);
  Reset(myFile);
  while not Eof(myFile) do
  begin
    ReadLn(myFile, arquivoVenda);
  end;
  CloseFile(myFile);
  ShowMessage('Arquivo lido');
end;

procedure TForm1.Button5Click(Sender: TObject);
var
   returnMsg: UTF8String;
   numeroSessao: Int32;
   cnpjSoftwareHouse : UTF8String;
   assinaturaAC : UTF8String;
   cnpjContribuinte : UTF8String;
   dadosVenda : UTF8String;
begin
  cnpjSoftwareHouse := '16716114000172';
  assinaturaAC := 'SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT';
  cnpjContribuinte := '08238299000129';

  randomize();
  numeroSessao := random(1000);
  dadosVenda :=
                '<CFe><infCFe versaoDadosEnt = "0.07"><ide><CNPJ>'
                        + cnpjSoftwareHouse
                        + '</CNPJ><signAC>' + assinaturaAC
                        + '</signAC><numeroCaixa>001</numeroCaixa></ide><emit><CNPJ>'
                        + cnpjContribuinte
                        + '</CNPJ><IE>149392863111</IE><indRatISSQN>N</indRatISSQN></emit><dest></dest>'
                         + '<det nItem = "1"><prod><cProd>0001</cProd><xProd>Produto teste 1</xProd><CFOP>5001</CFOP><uCom>kg</uCom><qCom>1.0000</qCom><vUnCom>10.00</vUnCom><indRegra>A</indRegra></prod><imposto><ICMS>' +
                        '<ICMS00><Orig>0</Orig><CST>00</CST><pICMS>10.00</pICMS></ICMS00></ICMS><PIS><PISNT><CST>08</CST></PISNT>' +
                        '</PIS><COFINS><COFINSNT><CST>08</CST></COFINSNT></COFINS></imposto></det><total></total><pgto><MP><cMP>01</cMP><vMP>10.00</vMP></MP></pgto></infCFe></CFe>';

  returnMsg := SatId.UtilTesteFimAFim(numeroSessao,Edit1.Text, dadosVenda);
  ShowMessage(returnMsg);
end;

procedure TForm1.Button6Click(Sender: TObject);
var
   numeroSessao: Int32;
   myFile : TextFile;
   text   : string;
begin
   randomize();
   numeroSessao := random(1000);
    text := SatId.UtilExtrairLogs(numeroSessao, Edit1.Text);
    AssignFile(myFile, 'Logs.txt');
    ReWrite(myFile);
    WriteLn(myFile, text);
    CloseFile(myFile);
    ShowMessage('Logs Disponíveis em Logs.txt');
end;

end.
