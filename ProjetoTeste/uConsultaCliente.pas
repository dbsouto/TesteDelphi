unit uConsultaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, uController, uCliente, System.Generics.Collections;

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
    _controllerCliente: IController<TCliente>;
    _list: TObjectList<TCliente>;
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

procedure TfrmConsultaCliente.FormShow(Sender: TObject);
begin
  FCliente := TCliente.Create;
  _list := TObjectList<TCliente>.Create;

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

procedure TfrmConsultaCliente.ConsultaCliente;
var
  I: Integer;
begin
  FCliente.Nome := edtNome.Text;
  _list := TObjectList<TCliente>(_controllerCliente.Select(FCliente));

  gridClientes.RowCount   := 2;
  gridClientes.Rows[1][0] := '';
  gridClientes.Rows[1][1] := '';
  btnConfirmar.Enabled    := false;

  if Assigned(_list) then
  begin
    gridClientes.RowCount := gridClientes.RowCount + _list.Count;

    for I := 0 to _list.Count - 1 do
    begin
      gridClientes.Rows[i + 1][0] := TCliente(_list.Items[i]).Nome;
      gridClientes.Rows[i + 1][1] := TCliente(_list.Items[i]).Cidade;
      gridClientes.Rows[i + 1][2] := TCliente(_list.Items[i]).Uf;
    end;

    btnConfirmar.Enabled := true;
    gridClientes.RowCount := gridClientes.RowCount - 1;
  end
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
  FCliente := TCliente(_list.Items[gridClientes.Row - 1]);
end;

end.
