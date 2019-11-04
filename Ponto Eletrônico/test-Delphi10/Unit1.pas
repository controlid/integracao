unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, vcl.Graphics,
  vcl.Forms, vcl.Dialogs, RepCid_TLB, Vcl.Controls, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
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
implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);

begin
  try
    if rep = nil then
    begin

      rep := CoRepCid_.Create;
      st := rep.Conectar(WideString('192.168.2.184'),Integer(443), Cardinal(0));
      Label1.Caption :='Conectado: '+IntToStr(st);//Integer.ToString(st); //

    end;

  except on E: Exception DO
    ShowMessage('Erro: '+E.Message);
  end;
end;



end.
