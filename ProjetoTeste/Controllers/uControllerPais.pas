unit uControllerPais;

interface

uses SysUtils, System.Generics.Collections, uController, uPais, udmMSSQLServer;

type
  TControllerPais = class(TInterfacedObject, IController<TPais>)
  public
    function Select(Objeto: TPais): TEnumerable<TPais>;
    procedure Insert(Objeto: TEnumerable<TPais>);
    procedure Update(Objeto: TEnumerable<TPais>);
    procedure Delete(Objeto: TEnumerable<TPais>);
  end;

implementation

{ TControllerPais }

function TControllerPais.Select(Objeto: TPais): TEnumerable<TPais>;
var
  Pais   : TPais;
  outList: TObjectList<TPais>;
begin
  with dmSQLServer.sp_pais_select do
  begin
    try
      Open;

      if not IsEmpty then
        outList := TObjectList<TPais>.Create
      else
        outList := nil;

      while not Eof do
      begin
        Pais := TPais.Create;
        Pais.IdPais := FieldByName('IdPais').Value;
        Pais.Nome := FieldByName('Nome').Value;

        outList.Add(Pais);
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

procedure TControllerPais.Insert(Objeto: TEnumerable<TPais>);
begin

end;

procedure TControllerPais.Update(Objeto: TEnumerable<TPais>);
begin

end;

procedure TControllerPais.Delete(Objeto: TEnumerable<TPais>);
begin

end;

end.
