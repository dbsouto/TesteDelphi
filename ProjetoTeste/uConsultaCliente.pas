unit uConsultaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, uController, uCliente, Contnrs;

type
  TfrmConsultaCliente = class(TForm)
    gridClientes: TStringGrid;
    edtNome: TEdit;
    Label1: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    btnProcurar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
  private
    FCliente: TCliente;
    ClienteList: TObjectList;
    _controllerCliente: IController<TCliente>;
    procedure ConsultaCliente;
  public
    constructor Create(AOwner: TComponent; AController: IController<TCliente>); overload;
    property Cliente: TCliente read FCliente write FCliente;
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

{$R *.dfm}

constructor TfrmConsultaCliente.Create(AOwner: TComponent;
  AController: IController<TCliente>);
begin
  inherited Create(AOwner);
  _controllerCliente := AController;
end;

procedure TfrmConsultaCliente.ConsultaCliente;
var
  I: Integer;
begin
  Cliente.Nome := edtNome.Text;
  ClienteList := _controllerCliente.Select(Cliente);

  gridClientes.RowCount := 2;
  gridClientes.Rows[1][0] := '';
  gridClientes.Rows[1][1] := '';

  if Assigned(ClienteList) then
  begin
    gridClientes.RowCount := gridClientes.RowCount + ClienteList.Count;

    for I := 0 to ClienteList.Count - 1 do
    begin
      gridClientes.Rows[i + 1][0] := TCliente(ClienteList.Items[i]).Nome;
      gridClientes.Rows[i + 1][1] := TCliente(ClienteList.Items[i]).Cidade;
      gridClientes.Rows[i + 1][2] := TCliente(ClienteList.Items[i]).Uf;
    end;

      gridClientes.RowCount := gridClientes.RowCount - 1;
  end;
end;

procedure TfrmConsultaCliente.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmConsultaCliente.btnProcurarClick(Sender: TObject);
begin
  ConsultaCliente;
end;

procedure TfrmConsultaCliente.btnConfirmarClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Cliente := TCliente(ClienteList.Items[gridClientes.Row - 1]);
end;

procedure TfrmConsultaCliente.FormShow(Sender: TObject);
begin
  Cliente := TCliente.Create;
  ClienteList := TObjectList.Create;

  with gridClientes do
  begin
    Rows[0][0] := 'Nome';
    Rows[0][1] := 'Cidade';
    Rows[0][2] := 'UF';
    ColWidths[0] := 300;
    ColWidths[1] := 125;
    ColWidths[2] := 50;
  end;

  ConsultaCliente;
end;

end.
