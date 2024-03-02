unit uClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uConsultaCliente, uControllerCliente,
  Vcl.ExtCtrls, Vcl.Mask, System.StrUtils, Vcl.Grids, uControllerPais, Contnrs, uPais, uTelefone,
  uCliente, uControllerTelefone, System.Math, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc, Data.DB, Vcl.DBGrids, udmMSSQLServer, Data.Win.ADODB,
  uController, uValidation, uType;

type
  TfrmClientes = class(TForm)
    Label1: TLabel;
    edtNomeCliente: TEdit;
    btnConsultar: TButton;
    btnNovo: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    btnSalvar: TButton;
    Panel2: TPanel;
    cmbTipoPessoa: TComboBox;
    Label2: TLabel;
    mskCpfCnpj: TMaskEdit;
    lbCpfCnpj: TLabel;
    mskRGIE: TMaskEdit;
    lbRGIE: TLabel;
    edtLogradouro: TEdit;
    Label3: TLabel;
    edtLogradouroNumero: TEdit;
    Label4: TLabel;
    edtBairro: TEdit;
    edtCidade: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    mskCEP: TMaskEdit;
    Label7: TLabel;
    Label8: TLabel;
    mskDataCadastro: TMaskEdit;
    Label9: TLabel;
    chkAtivo: TCheckBox;
    edtTelefoneDDD: TEdit;
    Label10: TLabel;
    edtTelefoneNumero: TEdit;
    Label11: TLabel;
    Panel3: TPanel;
    Label12: TLabel;
    btnTelefoneAdiciona: TButton;
    btnTelefoneRemove: TButton;
    Panel4: TPanel;
    Label13: TLabel;
    cmbPais: TComboBox;
    Label14: TLabel;
    btnBuscaCEP: TButton;
    XMLDoc: TXMLDocument;
    edtUF: TEdit;
    DBGridTelefone: TDBGrid;
    qr_telefone: TADOQuery;
    ds_telefone: TDataSource;
    qr_telefoneIdTelefone: TAutoIncField;
    qr_telefoneIdCliente: TIntegerField;
    qr_telefoneDDD: TStringField;
    qr_telefoneNumero: TStringField;
    btnAlterar: TButton;
    procedure btnConsultarClick(Sender: TObject);
    procedure cmbTipoPessoaChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTelefoneAdicionaClick(Sender: TObject);
    procedure btnTelefoneRemoveClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnBuscaCEPClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure mskCEPExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    _novoCliente: Boolean;
    _controllerPais: IController<TPais>;
    _controllerTelefone: IController<TTelefone>;
    _controllerCliente: IController<TCliente>;
    _cliente: TCliente;
    _telefoneList: TObjectList;
    procedure HabilitaObjetos(valor: Boolean);
    procedure LimpaCampos;
    procedure ConsultaTelefones;
    procedure MudaTipoPessoa;
  public
    constructor Create(AOwner: TComponent;
     AControllerCliente: IController<TCliente>;
     AControllerTelefone: IController<TTelefone>;
     AControllerPais: IController<TPais>); overload;
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

constructor TfrmClientes.Create(AOwner: TComponent;
  AControllerCliente: IController<TCliente>;
  AControllerTelefone: IController<TTelefone>;
  AControllerPais: IController<TPais>);
begin
  inherited Create(AOwner);
  _controllerCliente := AControllerCliente;
  _controllerTelefone := AControllerTelefone;
  _controllerPais := AControllerPais;
end;

procedure TfrmClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if btnCancelar.Enabled then
    btnCancelarClick(Sender);
end;

procedure TfrmClientes.FormShow(Sender: TObject);
var
  i: Integer;
  PaisList: TObjectList;
begin
  _novoCliente := false;
  _controllerPais := TControllerPais.Create;
  _controllerTelefone := TControllerTelefone.Create;
  _telefoneList := TObjectList.Create;
  PaisList := TObjectList.Create;

  lbCpfCnpj.Caption := 'CPF';
  lbRGIE.Caption := 'RG';
  mskCpfCnpj.EditMask := CPFMask;

  PaisList := _controllerPais.Select(nil);

  for i := 0 to PaisList.Count - 1 do
  begin
    cmbPais.AddItem(
      TPais(PaisList.Items[i]).Nome,
      TPais(PaisList.Items[i]));
  end;

  cmbPais.ItemIndex := -1;

  HabilitaObjetos(false);
end;

procedure TfrmClientes.HabilitaObjetos(valor: Boolean);
begin
  btnTelefoneAdiciona.Enabled := valor;
  btnTelefoneRemove.Enabled := valor;
  btnBuscaCEP.Enabled := valor;
  cmbPais.Enabled := valor;
  cmbTipoPessoa.Enabled := valor;
  mskCpfCnpj.Enabled := valor;
  mskRGIE.Enabled := valor;
  mskCEP.Enabled := valor;
  chkAtivo.Enabled := valor;
  chkAtivo.Checked := valor;
  edtNomeCliente.Enabled := valor;
  edtBairro.Enabled := valor;
  edtCidade.Enabled := valor;
  edtUF.Enabled := valor;
  edtLogradouro.Enabled := valor;
  edtLogradouroNumero.Enabled := valor;
  edtNomeCliente.Enabled := valor;
  edtTelefoneDDD.Enabled := valor;
  edtTelefoneNumero.Enabled := valor;
  DBGridTelefone.Enabled := valor;
end;

procedure TfrmClientes.LimpaCampos;
begin
  cmbPais.ItemIndex := -1;
  cmbTipoPessoa.ItemIndex := -1;
  mskCpfCnpj.Text := '';
  mskRGIE.Text := '';
  mskCEP.Text := '';
  mskDataCadastro.Text := '';
  edtNomeCliente.Text := '';
  edtBairro.Text := '';
  edtCidade.Text := '';
  edtUF.Text := '';
  edtLogradouro.Text := '';
  edtLogradouroNumero.Text := '';
  edtNomeCliente.Text := '';
  edtTelefoneDDD.Text := '';
  edtTelefoneNumero.Text := '';
end;

procedure TfrmClientes.mskCEPExit(Sender: TObject);
begin
  btnBuscaCEPClick(Sender);
end;

procedure TfrmClientes.MudaTipoPessoa;
begin
  if cmbTipoPessoa.ItemIndex = 0 then
  begin
    lbCpfCnpj.Caption := 'CPF';
    lbRGIE.Caption := 'RG';
    mskCpfCnpj.EditMask := CPFMask;
    mskRGIE.EditMask := '';
  end
  else
  begin
    lbCpfCnpj.Caption := 'CNPJ';
    lbRGIE.Caption := 'IE';
    mskCpfCnpj.EditMask := CNPJMask;
    mskRGIE.EditMask := IEMask;
  end;
end;

procedure TfrmClientes.btnAlterarClick(Sender: TObject);
begin
  btnAlterar.Enabled := false;
  _novoCliente := false;
  btnNovo.Enabled := false;
  btnExcluir.Enabled := false;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;

  HabilitaObjetos(true);
  ConsultaTelefones;
end;

procedure TfrmClientes.btnBuscaCEPClick(Sender: TObject);

begin
    if mskCEP.Text = '' then
    begin
      Application.MessageBox(PChar('Informe um CEP'), 'Aviso', MB_ICONEXCLAMATION or MB_OK);
      mskCEP.SetFocus;
      Exit;
    end;

  try
    XMLDoc.FileName := 'https://viacep.com.br/ws/'+ mskCEP.Text + '/xml/';
    XMLDoc.Active := true;
  finally
    if XMLDOC.DocumentElement.ChildNodes.Count = 1 then
    begin
      Application.MessageBox(PChar('CEP inválido'), 'Aviso', MB_ICONEXCLAMATION or MB_OK);
      mskCEP.Text := '';
      mskCEP.SetFocus;
    end
    else
    begin
      EdtLogradouro.Text := XMLDoc.DocumentElement.ChildNodes['logradouro'].Text;
      EdtBairro.Text := XMLDoc.DocumentElement.ChildNodes['bairro'].Text;
      edtCidade.Text := XMLDoc.DocumentElement.ChildNodes['localidade'].Text;
      edtUF.Text := XMLDoc.DocumentElement.ChildNodes['uf'].Text;
    end;

    XMLDoc.Active := false;
  end;
end;

procedure TfrmClientes.btnCancelarClick(Sender: TObject);
begin
  if _novoCliente then
    _controllerCliente.Delete(_cliente);

  _novoCliente := false;
  HabilitaObjetos(false);

  btnNovo.Enabled := true;
  btnAlterar.Enabled := false;
  btnCancelar.Enabled := false;
  btnSalvar.Enabled := false;
  btnExcluir.Enabled := false;
end;

procedure TfrmClientes.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Confirma a exclusão do cliente?'), 'Aviso', MB_ICONQUESTION or MB_YESNO) = IDYES then
  begin
     _controllerCliente := TControllerCliente.Create;

    try
      _controllerCliente.Delete(_cliente);
    except
        On E: Exception do
        begin
           Application.MessageBox(PChar(E.Message), 'Erro', MB_ICONERROR or MB_OK);
           Exit;
        end;
    end;

    HabilitaObjetos(false);

    btnNovo.Enabled := true;
    btnSalvar.Enabled := false;
    btnCancelar.Enabled := false;
    btnExcluir.Enabled := false;
  end;
end;

procedure TfrmClientes.btnNovoClick(Sender: TObject);
begin
  _novoCliente := true;

  LimpaCampos;
  HabilitaObjetos(true);

  qr_telefone.Close;

  FreeAndNil(_cliente);
  _cliente := TCliente.Create;
  _cliente.IdPais := 0;
  _controllerCliente.Insert(_cliente);
  with dmSQLServer do
  begin
    qrAux.SQL.Text := 'SELECT TOP 1 IdCliente FROM cliente ORDER BY IdCliente DESC';
    qrAux.Open;
    _cliente.IdCliente := dmSQLServer.qrAux.FieldByName('IdCliente').AsInteger;
    qrAux.Close;
  end;

  btnExcluir.Enabled := false;
  btnSalvar.Enabled := true;
  btnCancelar.Enabled := true;
end;

procedure TfrmClientes.btnConsultarClick(Sender: TObject);
begin
  frmConsultaCliente := TfrmConsultaCliente.Create(Self, _controllerCliente);
  if frmConsultaCliente.ShowModal = mrOk then
  begin
    _novoCliente := false;

    btnNovo.Enabled := false;
    btnAlterar.Enabled := true;
    btnExcluir.Enabled := true;

    FreeAndNil(_cliente);
    _cliente := frmConsultaCliente.Cliente;

    LimpaCampos;
    edtNomeCliente.Text := _cliente.Nome;
    cmbTipoPessoa.ItemIndex := IfThen(_cliente.TipoPessoa = 'F', 0, 1);
    MudaTipoPessoa;
    mskCpfCnpj.Text := _cliente.CPFCNPJ;
    mskRGIE.Text := IfThen(_cliente.TipoPessoa = 'F', _cliente.RG, _cliente.IE);
    chkAtivo.Checked := _cliente.Ativo = '1';
    mskDataCadastro.Text := FormatDateTime('dd/mm/yyyy',_cliente.Data);
    mskCEP.Text := _cliente.CEP;
    edtLogradouro.Text := _cliente.Logradouro;
    edtLogradouroNumero.Text := _cliente.LogradouroNumero;
    edtBairro.Text := _cliente.Bairro;
    edtCidade.Text := _cliente.Cidade;
    edtUF.Text := _cliente.UF;
    cmbPais.ItemIndex := _cliente.IdPais - 1;

    ConsultaTelefones;
  end;

  frmConsultaCliente.Free;
end;

procedure TfrmClientes.btnSalvarClick(Sender: TObject);
begin
  if edtNomeCliente.Text = '' then
  begin
    Application.MessageBox(PChar('Informe o nome do cliente'), 'Aviso', MB_ICONEXCLAMATION or MB_OK);
    edtNomeCliente.SetFocus;
    Exit;
  end;

  if cmbTipoPessoa.ItemIndex = -1 then
  begin
    Application.MessageBox(PChar('Informe o Tipo de Pessoa'), 'Aviso', MB_ICONEXCLAMATION or MB_OK);
    cmbTipoPessoa.SetFocus;
    Exit;
  end;

  if mskCpfCnpj.Text = '' then
  begin
    Application.MessageBox(PChar('Informe o ' + lbCpfCnpj.Caption), 'Aviso', MB_ICONEXCLAMATION or MB_OK);
    mskCpfCnpj.SetFocus;
    Exit;
  end;

  if (cmbTipoPessoa.ItemIndex = 1) and not TValidation.IsValidCNPJ(mskCpfCnpj.Text) then
  begin
    Application.MessageBox(PChar('CNPJ inválido!'), 'Aviso', MB_ICONERROR or MB_OK);
    mskCpfCnpj.SetFocus;
    Exit;
  end;

  _controllerCliente := TControllerCliente.Create;

  _cliente.IdPais := cmbPais.ItemIndex + 1;
  _cliente.TipoPessoa := IfThen(cmbTipoPessoa.ItemIndex = 0, 'F', 'J');
  _cliente.UF := edtUF.Text;
  _cliente.CPFCNPJ := mskCpfCnpj.Text;
  if _cliente.TipoPessoa = 'F' then
  begin
    _cliente.RG := mskRGIE.Text;
    _cliente.IE := '';
  end
  else
  begin
    _cliente.IE := mskRGIE.Text;
    _cliente.Rg := '';
  end;
  _cliente.CEP := mskCEP.Text;
  _cliente.Ativo := IfThen(chkAtivo.Enabled, '1', '0');
  _cliente.Bairro := edtBairro.Text;
  _cliente.Cidade := edtCidade.Text;
  _cliente.Logradouro := edtLogradouro.Text;
  _cliente.LogradouroNumero := edtLogradouroNumero.Text;
  _cliente.Nome := edtNomeCliente.Text;

  try
    _controllerCliente.Update(_cliente);
  except
      On E: Exception do
      begin
         Application.MessageBox(PChar(E.Message), 'Erro', MB_ICONERROR or MB_OK);
         Exit;
      end;
  end;

  btnNovo.Enabled := true;
  btnAlterar.Enabled := true;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
  btnExcluir.Enabled := false;
end;

procedure TfrmClientes.btnTelefoneAdicionaClick(Sender: TObject);
var
  i: Integer;
  Telefone: TTelefone;
begin
  if edtTelefoneDDD.Text = '' then
  begin
    Application.MessageBox(PChar('Informe o DDD'), 'Aviso', MB_ICONEXCLAMATION or MB_OK);
    edtTelefoneDDD.SetFocus;
    Exit;
  end
  else if edtTelefoneNumero.Text = '' then
  begin
    Application.MessageBox(PChar('Informe o número do telefone'), 'Aviso', MB_ICONEXCLAMATION or MB_OK);
    edtTelefoneNumero.SetFocus;
    Exit;
  end;

  qr_telefone.Close;

  Telefone := TTelefone.Create;
  Telefone.IdCliente := _cliente.IdCliente;
  Telefone.DDD := edtTelefoneDDD.Text;
  Telefone.Numero := edtTelefoneNumero.Text;

  _controllerTelefone.Insert(Telefone);

  edtTelefoneDDD.Text := '';
  edtTelefoneNumero.Text := '';

  ConsultaTelefones;
end;

procedure TfrmClientes.btnTelefoneRemoveClick(Sender: TObject);
begin
  qr_telefone.delete;
  btnTelefoneRemove.Enabled := qr_telefone.RecordCount > 0;
end;

procedure TfrmClientes.cmbTipoPessoaChange(Sender: TObject);
begin
  MudaTipoPessoa;
end;

procedure TfrmClientes.ConsultaTelefones;
var
  i: Integer;
  Telefone: TTelefone;
begin
  qr_telefone.Close;
  qr_telefone.Parameters.ParamByName('IdCliente').Value := _cliente.IdCliente;
  qr_telefone.Open;

  if btnSalvar.Enabled then
    btnTelefoneRemove.Enabled := qr_telefone.RecordCount > 0;
end;

end.
