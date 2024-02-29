unit uControllerCliente;

interface

uses SysUtils, Contnrs, uController, uCliente, udmMSSQLServer;

type
  TControllerCliente = class(TInterfacedObject, IController<TCliente>)
  public
    procedure Delete(Objeto: TCliente);
    procedure Insert(Objeto: TCliente);
    function Select(Objeto: TCliente): TObjectList;
    function Update(Objeto: TCliente): TCliente;
  end;

implementation

{ TControllerCliente }

procedure TControllerCliente.Delete(Objeto: TCliente);
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;
      sp_cliente_delete.Parameters.ParamByName('@IdCliente').Value := Objeto.IdCliente;
      sp_cliente_delete.ExecProc;
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

procedure TControllerCliente.Insert(Objeto: TCliente);
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;
      sp_cliente_insert.Parameters.ParamByName('@Nome').Value := Objeto.Nome;
      sp_cliente_insert.Parameters.ParamByName('@TipoPessoa').Value := Objeto.TipoPessoa;
      sp_cliente_insert.Parameters.ParamByName('@CPFCNPJ').Value := Objeto.CPFCNPJ;
      sp_cliente_insert.Parameters.ParamByName('@RG').Value := Objeto.RG;
      sp_cliente_insert.Parameters.ParamByName('@IE').Value := Objeto.IE;
      sp_cliente_insert.Parameters.ParamByName('@CEP').Value := Objeto.CEP;
      sp_cliente_insert.Parameters.ParamByName('@Logradouro').Value := Objeto.Logradouro;
      sp_cliente_insert.Parameters.ParamByName('@LogradouroNumero').Value := Objeto.LogradouroNumero;
      sp_cliente_insert.Parameters.ParamByName('@Bairro').Value := Objeto.Bairro;
      sp_cliente_insert.Parameters.ParamByName('@Cidade').Value := Objeto.Cidade;
      sp_cliente_insert.Parameters.ParamByName('@UF').Value := Objeto.UF;
      sp_cliente_insert.Parameters.ParamByName('@IdPais').Value := Objeto.IdPais;
      sp_cliente_insert.Parameters.ParamByName('@Ativo').Value := Objeto.Ativo;
      sp_cliente_insert.ExecProc;
      ADOConnection.CommitTrans;
    except
      On E: Exception do
      begin
        ADOConnection.RollbackTrans;
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

function TControllerCliente.Select(Objeto: TCliente): TObjectList;
var
  Cliente: TCliente;
  ObjectList: TObjectList;
begin
  with dmSQLServer.sp_cliente_select do
  begin
    try
      Parameters.ParamByName('@Nome').Value := Objeto.Nome;

      Open;

      if not IsEmpty then
        ObjectList := TObjectList.Create
      else
        ObjectList := nil;

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

        ObjectList.Add(Cliente);
        Next;
      end;

      Close;
    except
      On E: Exception do
      begin
        Raise Exception.Create(E.Message);
      end;
    end;
  end;

  Result := ObjectList;
end;

function TControllerCliente.Update(Objeto: TCliente): TCliente;
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;
      sp_cliente_update.Parameters.ParamByName('@IdCliente').Value := Objeto.IdCliente;
      sp_cliente_update.Parameters.ParamByName('@Nome').Value := Objeto.Nome;
      sp_cliente_update.Parameters.ParamByName('@TipoPessoa').Value := Objeto.TipoPessoa;
      sp_cliente_update.Parameters.ParamByName('@CPFCNPJ').Value := Objeto.CPFCNPJ;
      sp_cliente_update.Parameters.ParamByName('@RG').Value := Objeto.RG;
      sp_cliente_update.Parameters.ParamByName('@IE').Value := Objeto.IE;
      sp_cliente_update.Parameters.ParamByName('@CEP').Value := Objeto.CEP;
      sp_cliente_update.Parameters.ParamByName('@Logradouro').Value := Objeto.Logradouro;
      sp_cliente_update.Parameters.ParamByName('@LogradouroNumero').Value := Objeto.LogradouroNumero;
      sp_cliente_update.Parameters.ParamByName('@Cidade').Value := Objeto.Cidade;
      sp_cliente_update.Parameters.ParamByName('@Bairro').Value := Objeto.Bairro;
      sp_cliente_update.Parameters.ParamByName('@UF').Value := Objeto.UF;
      sp_cliente_update.Parameters.ParamByName('@IdPais').Value := Objeto.IdPais;
      sp_cliente_update.Parameters.ParamByName('@Ativo').Value := Objeto.Ativo;
      sp_cliente_update.ExecProc;
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
