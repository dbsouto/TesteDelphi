unit uControllerPais;

interface

uses SysUtils, Contnrs, uController, uPais, udmMSSQLServer,
Data.DB, System.Classes;

type
  TControllerPais = class(TInterfacedObject, IController<TPais>)
  public
    procedure Delete(Objeto: TPais);
    procedure Insert(Objeto: TPais);
    function Select(Objeto: TPais): TObjectList;
    function Update(Objeto: TPais): TPais;
  end;

implementation

{ TControllerPais }

procedure TControllerPais.Delete(Objeto: TPais);
begin

end;

procedure TControllerPais.Insert(Objeto: TPais);
begin

end;

function TControllerPais.Select(Objeto: TPais): TObjectList;
var
  Pais: TPais;
  ObjectList: TObjectList;
begin
  with dmSQLServer.sp_pais_select do
  begin
    try
      Open;

      if not IsEmpty then
        ObjectList := TObjectList.Create
      else
        ObjectList := nil;

      while not Eof do
      begin
        Pais := TPais.Create;
        Pais.IdPais := FieldByName('IdPais').Value;
        Pais.Nome := FieldByName('Nome').Value;

        ObjectList.Add(Pais);
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

function TControllerPais.Update(Objeto: TPais): TPais;
begin
  result := nil;
end;

end.
