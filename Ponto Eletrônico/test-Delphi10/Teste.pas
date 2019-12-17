unit Teste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, RepCid_TLB;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rep: RepCid_;
  st: Integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    if rep = nil then
    begin

      rep := CoRepCid_.Create;
      st := rep.Conectar(WideString('192.168.111.49'),Integer(443), Cardinal(0));
      Label1.Caption :='Conectado: '+IntToStr(st);//Integer.ToString(st); //

    end;

  except on E: Exception DO
    ShowMessage('Erro: '+E.Message);
  end;
end;

end.
