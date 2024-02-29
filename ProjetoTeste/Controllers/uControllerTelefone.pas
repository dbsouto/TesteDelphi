unit uControllerTelefone;

interface

uses SysUtils, Contnrs, uController, uTelefone, udmMSSQLServer,
Data.DB, System.Classes;

type
  TControllerTelefone = class(TInterfacedObject, IController<TTelefone>)
  public
    procedure Delete(Objeto: TTelefone);
    procedure Insert(Objeto: TTelefone);
    function Select(Objeto: TTelefone): TObjectList;
    function Update(Objeto: TTelefone): TTelefone;
  end;

implementation

{ TControllerPais }

procedure TControllerTelefone.Delete(Objeto: TTelefone);
begin

end;

procedure TControllerTelefone.Insert(Objeto: TTelefone);
begin
  with dmSQLServer do
  begin
    try
      ADOConnection.BeginTrans;
      sp_telefone_insert.Parameters.ParamByName('@IdCliente').Value := Objeto.IdCliente;
      sp_telefone_insert.Parameters.ParamByName('@DDD').Value := Objeto.DDD;
      sp_telefone_insert.Parameters.ParamByName('@Numero').Value := Objeto.Numero;
      sp_telefone_insert.ExecProc;
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

function TControllerTelefone.Select(Objeto: TTelefone): TObjectList;
begin
  Result := nil;
end;

function TControllerTelefone.Update(Objeto: TTelefone): TTelefone;
begin
  Result := nil;
end;

end.
