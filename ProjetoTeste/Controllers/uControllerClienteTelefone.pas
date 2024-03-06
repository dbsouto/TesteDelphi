unit uControllerClienteTelefone;

interface

uses SysUtils, System.Generics.Collections, uController,
  uClienteTelefone, udmMSSQLServer, Data.Win.ADODB, Data.DB;

type
  TControllerClienteTelefone = class(TInterfacedObject, IController<TClienteTelefone>)
  public
    function Select(Objeto: TClienteTelefone): TEnumerable<TClienteTelefone>;
    procedure Insert(Objeto: TEnumerable<TClienteTelefone>);
    procedure Update(Objeto: TEnumerable<TClienteTelefone>);
    procedure Delete(Objeto: TEnumerable<TClienteTelefone>);
  end;

implementation

{ TControllerClienteTelefone }

function TControllerClienteTelefone.Select(Objeto: TClienteTelefone): TEnumerable<TClienteTelefone>;
var
  outTel : TClienteTelefone;
  outList: TObjectList<TClienteTelefone>;
begin
  with dmSQLServer.sp_clientetelefone_select do
  begin
    try
      Parameters.ParamByName('@IdCliente').Value := Objeto.IdCliente;
      Open;

      if not IsEmpty then
        outList := TObjectList<TClienteTelefone>.Create
      else
        outList := nil;

      while not Eof do
      begin
        outTel := TClienteTelefone.Create;
        outTel.IdClienteTelefone := FieldByName('IdClienteTelefone').Value;
        outTel.IdCliente:= FieldByName('IdCliente').Value;
        outTel.DDD := FieldByName('DDD').Value;
        outTel.Numero := FieldByName('Numero').Value;

        outList.Add(outTel);
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

procedure TControllerClienteTelefone.Insert(Objeto: TEnumerable<TClienteTelefone>);
var
  Telefone: TClienteTelefone;
  qr: TADOQuery;
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;

      for telefone in Objeto do
      begin
        sp_clientetelefone_insert.Parameters.ParamByName('@IdCliente').Value := Telefone.IdCliente;
        sp_clientetelefone_insert.Parameters.ParamByName('@DDD').Value := Telefone.DDD;
        sp_clientetelefone_insert.Parameters.ParamByName('@Numero').Value := Telefone.Numero;
        sp_clientetelefone_insert.ExecProc;

        telefone.IdClienteTelefone := sp_clientetelefone_insert.Parameters.ParamByName('@IdClienteTelefone').Value;
      end;

      AdoConnection.CommitTrans;
    except
      On E: Exception do
      begin
        for telefone in Objeto do
          telefone.IdClienteTelefone := 0;

        ADOConnection.RollbackTrans;
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

procedure TControllerClienteTelefone.Update(Objeto: TEnumerable<TClienteTelefone>);
var
  Telefone: TClienteTelefone;
  qr      : TADOQuery;
  Param   : TParameter;
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;

      qr := TADOQuery.Create(nil);
      qr.Connection := ADOConnection;
      qr.SQL.Add('IF OBJECT_ID(''tempdb..#temp'') is not null');
      qr.SQL.Add('DROP TABLE #temp;');
      qr.SQL.Add('CREATE TABLE #temp (');
      qr.SQL.Add('IdClienteTelefone INT,');
      qr.SQL.Add('IdCliente INT,');
      qr.SQL.Add('DDD CHAR(3),');
      qr.SQL.Add('Numero VARCHAR(10))');
      qr.ExecSQL;

      qr.SQL.Clear;
      for telefone in Objeto do
      begin
        if telefone.Numero.Length > 0 then
          qr.SQL.Add(
          Format('INSERT INTO #temp (IdClienteTelefone, IdCliente, DDD, Numero) values (%d, %d,'
            + QuotedStr(telefone.DDD) + ', ' + QuotedStr(telefone.Numero) + ')',
            [telefone.IdClienteTelefone, telefone.IdCliente]));
      end;
      if qr.SQL.Count > 0 then
        qr.ExecSQL;

      sp_clientetelefone_update.Parameters.ParamByName('@IdCliente').Value := Telefone.IdCliente;
      sp_clientetelefone_update.ExecProc;

      AdoConnection.CommitTrans;
    except
      On E: Exception do
      begin
        ADOConnection.RollbackTrans;
        Raise Exception.Create(E.Message);
      end;
    end;
  end;

  FreeAndNil(qr);
end;

procedure TControllerClienteTelefone.Delete(Objeto: TEnumerable<TClienteTelefone>);
begin

end;

end.
