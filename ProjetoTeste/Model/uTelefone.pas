unit uTelefone;

interface

type
  TTelefone = class
    private
      FIdTelefone: Integer;
      FIdCliente: Integer;
      FDDD: String;
      FNumero: String;

    public
      property IdTelefone: Integer read FIdTelefone write FIdTelefone;
      property IdCliente: Integer read FIdCliente write FIdCliente;
      property DDD: String read FDDD write FDDD;
      property Numero: String read FNumero write FNumero;
  end;

implementation

end.
