unit Teste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, superobject, Vcl.StdCtrls,IdBaseComponent, IdComponent, IdTCPServer, Vcl.Dialogs, IdHTTP, RepCid_TLB;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rep: RepCid_;
  st: Integer;
  session: String;
  nsr: Integer;

  documento: WideString;
  tipoDocumento: Integer;
  cei: WideString;
  razaoSocial: WideString;
  endereco: WideString;

implementation

{$R *.dfm}

//
// INICIAR A COMUNICACAO COM O REP:
//


// Por DLL:
// Botao 1: conecta com o REP atraves da DLL
procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    if rep = nil then
    begin

      rep := CoRepCid_.Create;
      st := rep.Conectar(WideString('192.168.0.129'),Integer(443), Cardinal(0));
      Label1.Caption :='Conectado: '+IntToStr(st);

    end;

  except on E: Exception DO
    ShowMessage('Erro: '+E.Message);
  end;
end;


// Por API:
// Botao 2: abre sessao com o REP pela API através de requisicao HTTPS
// https://www.controlid.com.br/suporte/api_idclass_latest.html#50_introduction
procedure TForm1.Button2Click(Sender: TObject);
var
  lJSO : ISuperObject;
  lRequest: TStringStream;
  lResponse: String;
  IdHTTP1: TIdHTTP;
  lJSOR : ISuperObject;
begin
  IdHTTP1 := TidHTTP.Create;
  lJSO := SO('{"login": "admin", "password": "admin"}');
  lRequest := TStringStream.Create(lJSO.AsString, TEncoding.UTF8);
  try
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.Charset := 'utf-8';
    try
      lResponse := IdHTTP1.Post('https://192.168.0.129/login.fcgi', lRequest);
      ShowMessage(lResponse);
      lJSOR := SO(lResponse);
      session := lJSOR.AsObject.S['session'];
    except
      on E: Exception do
        ShowMessage('Error on request:'#13#10 + E.Message);
    end;
  finally
    lRequest.Free;
    IdHTTP1.Free;
  end;
  lJSO := nil;
end;


////////////////////////////////////////////////////////////////////////////////

//
// EXTRAIR AFD FILTRADO:
//


// Por API:
// Botao 3: chama getAFD para extrair AFD filtrado por data inicial
// https://www.controlid.com.br/suporte/api_idclass_latest.html#58_get_afd
procedure TForm1.Button3Click(Sender: TObject);
  var
    lJSO : ISuperObject;
    lRequest: TStringStream;
    lResponse: String;
    IdHTTP1: TIdHTTP;
  begin
    IdHTTP1 := TidHTTP.Create;
    lJSO := SO('{initial_date:{day: 1,month: 1,year: 2015}}');
    lRequest := TStringStream.Create(lJSO.AsString, TEncoding.UTF8);
    try
      IdHTTP1.Request.ContentType := 'application/json';
      IdHTTP1.Request.Charset := 'utf-8';
      try
        lResponse := IdHTTP1.Post('https://192.168.0.129/get_afd.fcgi?session=' + session, lRequest);
        ShowMessage(lResponse);
      except
        on E: Exception do
          ShowMessage('Error on request:'#13#10 + E.Message);
      end;
    finally
      lRequest.Free;
      IdHTTP1.Free;
    end;
    lJSO := nil;
end;

// Por DLL:
// Botao 4: chama buscarAFD e lerAFD pela DLL para extrair AFD filtrado por NSR inicial
procedure TForm1.Button4Click(Sender: TObject);
var
  linha: WideString;
begin
  try
    if rep = nil then
    begin
    rep := CoRepCid_.Create;
    st := rep.Conectar(WideString('192.168.0.129'),Integer(443), Cardinal(0));
    Label1.Caption :='Conectado: '+IntToStr(st);
    rep.BuscarAFD(1);
    end;

    if st = 1 then
    begin
      rep.LerEmpregador( documento, tipoDocumento, cei, razaoSocial, endereco);
      Label4.Caption := razaoSocial;
      While rep.LerAFD(linha) do
      begin
        Memo1.Lines.Add(linha);
      end;
    end;
  except on E: Exception DO
  ShowMessage('Erro: '+E.Message);
  end;
end;

end.
