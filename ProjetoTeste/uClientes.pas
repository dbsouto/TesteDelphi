unit uClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uConsultaCliente, uControllerCliente,
  Vcl.ExtCtrls, Vcl.Mask, System.StrUtils, Vcl.Grids, uControllerPais, uPais, uClienteTelefone,
  uCliente, uControllerClienteTelefone, System.Math, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc, Data.DB, Vcl.DBGrids, udmMSSQLServer, Data.Win.ADODB, System.Generics.Collections,
  uController, uValidation, uGlobal, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    dsMemTable: TDataSource;
    btnAlterar: TButton;
    memTable: TFDMemTable;
    memTableIdClienteTelefone: TIntegerField;
    memTableIdCliente: TIntegerField;
    memTableDDD: TStringField;
    memTableNumero: TStringField;
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
    _controllerClienteTelefone: IController<TClienteTelefone>;
    _controllerCliente: IController<TCliente>;
    _cliente: TCliente;
    procedure HabilitaObjetos(valor: Boolean);
    procedure LimpaCampos;
    procedure ConsultaTelefones;
    procedure MudaTipoPessoa;
    procedure ExibirInfoCliente;
  public
    constructor Create(AOwner: TComponent;
     AControllerCliente: IController<TCliente>;
     AControllerClienteTelefone: IController<TClienteTelefone>;
     AControllerPais: IController<TPais>); overload;
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

constructor TfrmClientes.Create(AOwner: TComponent;
  AControllerCliente: IController<TCliente>;
  AControllerClienteTelefone: IController<TClienteTelefone>;
  AControllerPais: IController<TPais>);
begin
  inherited Create(AOwner);
  _controllerCliente := AControllerCliente;
  _controllerClienteTelefone := AControllerClienteTelefone;
  _controllerPais := AControllerPais;
end;

procedure TfrmClientes.ExibirInfoCliente;
begin
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
end;

procedure TfrmClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if btnCancelar.Enabled then
    btnCancelarClick(Sender);
end;

procedure TfrmClientes.FormShow(Sender: TObject);
var
  i: Integer;
  PaisList: TObjectList<TPais>;
begin
  _novoCliente := false;
  PaisList := TObjectList<TPais>.Create;

  lbCpfCnpj.Caption := 'CPF';
  lbRGIE.Caption := 'RG';
  mskCpfCnpj.EditMask := CPFMask;

  PaisList := TObjectList<TPais>(_controllerPais.Select(nil));

  for i := 0 to PaisList.Count - 1 do
  begin
    cmbPais.AddItem(
      TPais(PaisList.Items[i]).Nome,
      TPais(PaisList.Items[i]));
  end;

  PaisList.Clear;
  FreeAndNil(PaisList);

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
    Exit;

  try
    Cursor := crHourGlass;
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

    Cursor := crDefault;
    XMLDoc.Active := false;
  end;
end;

procedure TfrmClientes.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
  memTable.Close;

  _novoCliente := false;
  HabilitaObjetos(false);

  btnNovo.Enabled := true;
  btnAlterar.Enabled := false;
  btnCancelar.Enabled := false;
  btnSalvar.Enabled := false;
  btnExcluir.Enabled := false;
end;

procedure TfrmClientes.btnExcluirClick(Sender: TObject);
var
  list: TList<TCliente>;
begin
  if Application.MessageBox(PChar('Confirma a exclusão do cliente?'), 'Aviso', MB_ICONQUESTION or MB_YESNO) = IDYES then
  begin
    try
      list := TList<TCliente>.create;
      list.Add(_cliente);

      _controllerCliente.Delete(list);

      FreeAndNil(list);
    except
        On E: Exception do
        begin
           Application.MessageBox(PChar(E.Message), 'Erro', MB_ICONERROR or MB_OK);
           Exit;
        end;
    end;

    LimpaCampos;
    HabilitaObjetos(false);
    memTable.Close;

    btnNovo.Enabled := true;
    btnSalvar.Enabled := false;
    btnCancelar.Enabled := false;
    btnExcluir.Enabled := false;
  end;
end;

procedure TfrmClientes.btnNovoClick(Sender: TObject);
begin
  _novoCliente := true;

  FreeAndNil(_cliente);
  _cliente := TCliente.Create;

  LimpaCampos;
  HabilitaObjetos(true);

  memTable.Open;
  memTable.Edit;

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

    btnNovo.Enabled := true;
    btnAlterar.Enabled := true;
    btnExcluir.Enabled := true;

    FreeAndNil(_cliente);
    _cliente := frmConsultaCliente.Cliente;

    ExibirInfoCliente;
    ConsultaTelefones;
  end;

  frmConsultaCliente.Free;
end;

procedure TfrmClientes.btnSalvarClick(Sender: TObject);
var
  telefone: TClienteTelefone;
  listCli : TList<TCliente>;
  listTel : TObjectList<TClienteTelefone>;
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

  listCli := TList<TCliente>.Create;
  listTel := TObjectList<TClienteTelefone>.create;

  _cliente.Nome := edtNomeCliente.Text;
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
  _cliente.IdPais := cmbPais.ItemIndex + 1;

  listCli.Add(_cliente);

  try
    if memTable.RecordCount > 0 then
    begin
      memTable.First;

      while not memTable.Eof do
      begin
        telefone := TClienteTelefone.Create;
        telefone.IdClienteTelefone := memTableIdClienteTelefone.AsInteger;
        telefone.IdCliente := memTableIdCliente.AsInteger;
        telefone.DDD := memTableDDD.AsString;
        telefone.Numero := memTableNumero.AsString;

        listTel.Add(telefone);
        memTable.Next;
      end;
    end;

    if _novoCliente then
    begin
       _controllerCliente.Insert(listCli);

       if memTable.RecordCount > 0 then
         for telefone in listTel do
           telefone.IdCliente := _cliente.IdCliente;

       mskDataCadastro.Text := FormatDateTime('dd/mm/yyyy',_cliente.Data);

      _controllerClienteTelefone.Insert(listTel);
    end
    else
    begin
      if memTable.RecordCount = 0 then
      begin
        telefone := TClienteTelefone.Create;
        telefone.IdCliente := _cliente.IdCliente;
        listTel.Add(telefone);
      end;

      _controllerCliente.Update(listCli);
      _controllerClienteTelefone.Update(listTel);
    end;
  except
      On E: Exception do
      begin
         Application.MessageBox(PChar(E.Message), 'Erro', MB_ICONERROR or MB_OK);
         Exit;
      end;
  end;

  listTel.Clear;
  FreeAndNil(listCli);
  FreeAndNil(listTel);

  _novoCliente := false;

  //LimpaCampos;
  HabilitaObjetos(false);

  btnNovo.Enabled := true;
  btnAlterar.Enabled := true;
  btnExcluir.Enabled := true;
  btnSalvar.Enabled := false;
  btnCancelar.Enabled := false;
end;

procedure TfrmClientes.btnTelefoneAdicionaClick(Sender: TObject);
var
  i: Integer;
  ClienteTelefone: TClienteTelefone;
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

  memTable.Append;
  memTable.FieldByName('IdCliente').Value := _cliente.IdCliente;
  memTable.FieldByName('DDD').Value := edtTelefoneDDD.Text;
  memTable.FieldByName('Numero').Value := edtTelefoneNumero.Text;
  memTable.Post;

  btnTelefoneRemove.Enabled := memTable.RecordCount > 0;

  edtTelefoneDDD.Text := '';
  edtTelefoneNumero.Text := '';
end;

procedure TfrmClientes.btnTelefoneRemoveClick(Sender: TObject);
begin
  memTable.Delete;
  btnTelefoneRemove.Enabled := memTable.RecordCount > 0;
end;

procedure TfrmClientes.cmbTipoPessoaChange(Sender: TObject);
begin
  MudaTipoPessoa;
end;

procedure TfrmClientes.ConsultaTelefones;
var
  Telefone: TClienteTelefone;
  t: TClienteTelefone;
  listTelefone: TobjectList<TClienteTelefone>;
begin
  Telefone := TClienteTelefone.Create;
  Telefone.IdCliente := _cliente.IdCliente;

  listTelefone := TobjectList<TClienteTelefone>(_controllerClienteTelefone.Select(Telefone));

  memTable.Close;
  memTable.Open;
  memTable.Edit;

  if Assigned(listTelefone) then
  begin
    for t in listTelefone do
    begin
      memTable.Append;
      memTableIdClienteTelefone.AsInteger := t.IdClienteTelefone;
      memTableIdCliente.AsInteger := t.IdCliente;
      memTableDDD.AsString := t.DDD;
      memTableNumero.AsString := t.Numero;
      memTable.Post;
    end;

    listTelefone.Clear;
    FreeAndNil(listTelefone);
  end;

  if btnSalvar.Enabled then
    btnTelefoneRemove.Enabled := memTable.RecordCount > 0;
end;

end.
