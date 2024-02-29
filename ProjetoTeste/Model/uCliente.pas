unit uCliente;

interface

type
  TCliente = class
    private
      FIdCliente: Integer;
      FNome: string;
      FTipoPessoa: string;
      FCPFCNPJ: string;
      FRG: string;
      FIE: string;
      FCEP: string;
      FLogradouro: string;
      FLogradouroNumero: string;
      FBairro: string;
      FCidade: string;
      FUF: string;
      FIdPais: Integer;
      FData: TDateTime;
      FAtivo: string;

    public
      property IdCliente: Integer read FIdCliente write FIdCliente;
      property Nome: String read FNome write FNome;
      property TipoPessoa: String read FTipoPessoa write FTipoPessoa;
      property CPFCNPJ: String read FCPFCNPJ write FCPFCNPJ;
      property RG: String read FRG write FRG;
      property IE: String read FIE write FIE;
      property CEP: String read FCEP write FCEP;
      property Logradouro: String read FLogradouro write FLogradouro;
      property LogradouroNumero: String read FLogradouroNumero write FLogradouroNumero;
      property Bairro: String read FBairro write FBairro;
      property Cidade: String read FCidade write FCidade;
      property UF: String read FUF write FUF;
      property IdPais: Integer read FIdPais write FIdPais;
      property Data: TDateTime read FData write FData;
      property Ativo: String read FAtivo write FAtivo;
  end;

implementation

end.
