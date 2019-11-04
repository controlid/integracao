unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, RepCid_TLB;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  rep: RepCid_;
  st: Integer;

  sn: WideString;
  tam_bobina: LongWord;
  restante_bobina: LongWord;
  uptime: LongWord;
  cortes: LongWord;
  papel_acumulado: LongWord;
  nsr_atual: LongWord;

  documento: WideString;
  tipoDocumento: Integer;
  cei: WideString;
  razaoSocial: WideString;
  endereco: WideString;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  try
    if rep = nil then
      rep := CoRepCid_.Create;

    st := rep.Conectar(WideString('192.168.0.99'),Integer(1818),Cardinal(0));
    Label1.Caption := Integer.ToString(st);

    if st = 1 then
    begin

      rep.LerInfo( sn, tam_bobina, restante_bobina, uptime, cortes, papel_acumulado, nsr_atual);
      Label1.Caption := sn;

      rep.LerEmpregador( documento, tipoDocumento, cei, razaoSocial, endereco);
      Label2.Caption := razaoSocial;

    end;

  except on E: Exception DO
    ShowMessage('Erro: '+E.Message);
  end;
end;

end.
