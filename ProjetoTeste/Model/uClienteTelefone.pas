unit uClienteTelefone;

interface

type
  TClienteTelefone = class
    private
      FIdClienteTelefone: Integer;
      FIdCliente: Integer;
      FDDD: String;
      FNumero: String;

    public
      property IdClienteTelefone: Integer read FIdClienteTelefone write FIdClienteTelefone;
      property IdCliente: Integer read FIdCliente write FIdCliente;
      property DDD: String read FDDD write FDDD;
      property Numero: String read FNumero write FNumero;
  end;

implementation

end.
