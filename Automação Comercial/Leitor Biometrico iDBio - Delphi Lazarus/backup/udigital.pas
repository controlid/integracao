unit uDigital;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, CapDigitais;

type

  { TCaptura }

  TCaptura = class(TForm)
    btn3: TButton;
    btn6: TButton;
    btn1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbl1: TLabel;
    Memo1: TMemo;
    mmoDedo: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    sDedo: String;
  public
     biometria : TDigital;
  end;

var
  Captura: TCaptura;

implementation

{$R *.lfm}

{ TCaptura }

procedure TCaptura.btn3Click(Sender: TObject);
begin
  // Button "Capturar digital"
  mmoDedo.Lines.Clear;
  btn3.Enabled := False;
  btn1.Enabled := False;

  lbl1.Caption := 'Coloque o dedo no leitor';
  lbl1.Refresh;

  try
    sDedo := biometria.RetornarDigital();
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

procedure TCaptura.btn6Click(Sender: TObject);
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
    stemplate := biometria.RetornarDigital();
    if (stemplate <> '') then
    begin
      if (biometria.ValidarDigital(stemplate, sDedo) = True) then
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

procedure TCaptura.btn1Click(Sender: TObject);
begin
  // Button "Informações do leitor"
  memo1.lines.clear;
  memo1.lines.add(biometria.DadosLeitor());
end;

procedure TCaptura.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   biometria.free;
end;

procedure TCaptura.FormShow(Sender: TObject);
begin
   biometria := TDigital.create();
end;

end.

