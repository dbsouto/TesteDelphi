unit uControllerCliente;

interface

uses SysUtils, System.Generics.Collections, uController, uCliente, udmMSSQLServer;

type
  TControllerCliente = class(TInterfacedObject, IController<TCliente>)
  public
    function Select(Objeto: TCliente): TEnumerable<TCliente>;
    procedure Insert(Objeto: TEnumerable<TCliente>);
    procedure Update(Objeto: TEnumerable<TCliente>);
    procedure Delete(Objeto: TEnumerable<TCliente>);
  end;

implementation

{ TControllerCliente }

function TControllerCliente.Select(Objeto: TCliente): TEnumerable<TCliente>;
var
  Cliente : TCliente;
  outList : TObjectList<TCliente>;
begin
  with dmSQLServer.sp_cliente_select do
  begin
    try
      Parameters.ParamByName('@Nome').Value := Objeto.Nome;
      Open;

      if not IsEmpty then
        outList := TObjectList<TCliente>.Create
      else
        outList := nil;

      while not Eof do
      begin
        Cliente := TCliente.Create;
        Cliente.IdCliente := FieldByName('IdCliente').Value;
        Cliente.Nome := FieldByName('Nome').Value;
        Cliente.TipoPessoa := FieldByName('TipoPessoa').Value;
        Cliente.CPFCNPJ := FieldByName('CPFCNPJ').Value;
        Cliente.RG := FieldByName('RG').Value;
        Cliente.IE := FieldByName('IE').Value;
        Cliente.CEP := FieldByName('CEP').Value;
        Cliente.Logradouro := FieldByName('Logradouro').Value;
        Cliente.LogradouroNumero := FieldByName('LogradouroNumero').Value;
        Cliente.Bairro := FieldByName('Bairro').Value;
        Cliente.Cidade := FieldByName('Cidade').Value;
        Cliente.UF := FieldByName('UF').Value;
        Cliente.IdPais := FieldByName('IdPais').Value;
        Cliente.Data := FieldByName('Data').Value;
        Cliente.Ativo := FieldByName('Ativo').Value;

        outList.Add(Cliente);
        Next;
      end;
    except
      On E: Exception do
      begin
        outList.Clear;
        FreeAndNil(outList);

        Raise Exception.Create(E.Message);
      end;
    end;

    Close;
  end;

  Result := outList;
end;

procedure TControllerCliente.Insert(Objeto: TEnumerable<TCliente>);
var
  cliente : TCliente;
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;

      for cliente in Objeto do
      begin
        sp_cliente_insert.Parameters.ParamByName('@Nome').Value := cliente.Nome;
        sp_cliente_insert.Parameters.ParamByName('@TipoPessoa').Value := cliente.TipoPessoa;
        sp_cliente_insert.Parameters.ParamByName('@CPFCNPJ').Value := cliente.CPFCNPJ;
        sp_cliente_insert.Parameters.ParamByName('@RG').Value := cliente.RG;
        sp_cliente_insert.Parameters.ParamByName('@IE').Value := cliente.IE;
        sp_cliente_insert.Parameters.ParamByName('@CEP').Value := cliente.CEP;
        sp_cliente_insert.Parameters.ParamByName('@Logradouro').Value := cliente.Logradouro;
        sp_cliente_insert.Parameters.ParamByName('@LogradouroNumero').Value := cliente.LogradouroNumero;
        sp_cliente_insert.Parameters.ParamByName('@Bairro').Value := cliente.Bairro;
        sp_cliente_insert.Parameters.ParamByName('@Cidade').Value := cliente.Cidade;
        sp_cliente_insert.Parameters.ParamByName('@UF').Value := cliente.UF;
        sp_cliente_insert.Parameters.ParamByName('@IdPais').Value := cliente.IdPais;
        sp_cliente_insert.Parameters.ParamByName('@Ativo').Value := cliente.Ativo;
        sp_cliente_insert.ExecProc;

        cliente.IdCliente := sp_cliente_insert.Parameters.ParamByName('@IdCliente').Value;
        cliente.Data := sp_cliente_insert.Parameters.ParamByName('@Data').Value;
      end;

      ADOConnection.CommitTrans;
    except
      On E: Exception do
      begin
        for cliente in Objeto do
          cliente.IdCliente := 0;

        ADOConnection.RollbackTrans;
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

procedure TControllerCliente.Update(Objeto: TEnumerable<TCliente>);
var
  cliente: TCliente;
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;

      for cliente in Objeto do
      begin
        sp_cliente_update.Parameters.ParamByName('@IdCliente').Value := cliente.IdCliente;
        sp_cliente_update.Parameters.ParamByName('@Nome').Value := cliente.Nome;
        sp_cliente_update.Parameters.ParamByName('@TipoPessoa').Value := cliente.TipoPessoa;
        sp_cliente_update.Parameters.ParamByName('@CPFCNPJ').Value := cliente.CPFCNPJ;
        sp_cliente_update.Parameters.ParamByName('@RG').Value := cliente.RG;
        sp_cliente_update.Parameters.ParamByName('@IE').Value := cliente.IE;
        sp_cliente_update.Parameters.ParamByName('@CEP').Value := cliente.CEP;
        sp_cliente_update.Parameters.ParamByName('@Logradouro').Value := cliente.Logradouro;
        sp_cliente_update.Parameters.ParamByName('@LogradouroNumero').Value := cliente.LogradouroNumero;
        sp_cliente_update.Parameters.ParamByName('@Cidade').Value := cliente.Cidade;
        sp_cliente_update.Parameters.ParamByName('@Bairro').Value := cliente.Bairro;
        sp_cliente_update.Parameters.ParamByName('@UF').Value := cliente.UF;
        sp_cliente_update.Parameters.ParamByName('@IdPais').Value := cliente.IdPais;
        sp_cliente_update.Parameters.ParamByName('@Ativo').Value := cliente.Ativo;
        sp_cliente_update.ExecProc;
      end;

      AdoConnection.CommitTrans;
    except
      On E: Exception do
      begin
        ADOConnection.RollbackTrans;
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

procedure TControllerCliente.Delete(Objeto: TEnumerable<TCliente>);
var
  cliente: TCliente;
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;

      for cliente in Objeto do
      begin
        sp_cliente_delete.Parameters.ParamByName('@IdCliente').Value := cliente.IdCliente;
        sp_cliente_delete.ExecProc;
      end;

      AdoConnection.CommitTrans;
    except
      On E: Exception do
      begin
        ADOConnection.RollbackTrans;
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

end.
