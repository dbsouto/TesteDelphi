unit uTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uClientes, uControllerPais,
  uControllerClienteTelefone, uControllerCliente, Vcl.ComCtrls, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList;

type
  TfrmProjetoTeste = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    mnuClientes: TMenuItem;
    N1: TMenuItem;
    mnuSair: TMenuItem;
    procedure mnuSairClick(Sender: TObject);
    procedure mnuClientesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _controllerCliente: TControllerCliente;
    _controllerClienteTelefone: TControllerClienteTelefone;
    _controllerPais: TControllerPais;
  public
    { Public declarations }
  end;

var
  frmProjetoTeste: TfrmProjetoTeste;

implementation

{$R *.dfm}

procedure TfrmProjetoTeste.FormShow(Sender: TObject);
begin
  _controllerCliente := TControllerCliente.Create;
  _controllerClienteTelefone := TControllerClienteTelefone.Create;
  _controllerPais := TControllerPais.Create;
end;

procedure TfrmProjetoTeste.mnuClientesClick(Sender: TObject);
begin
  frmClientes := TfrmClientes.Create(Self, _controllerCliente,
  _controllerClienteTelefone, _controllerPais);
  frmClientes.ShowModal;
end;

procedure TfrmProjetoTeste.mnuSairClick(Sender: TObject);
begin
  Close;
end;

end.
