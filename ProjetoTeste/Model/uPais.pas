unit uPais;

interface

type
  TPais = class
    private
      FIdPais: Integer;
      FNome: String;

    public
      property IdPais: Integer read FIdPais write FIdPais;
      property Nome: String read FNome write FNome;
  end;

implementation

end.
