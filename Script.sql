USE [master]
GO

CREATE DATABASE [Teste]
GO

USE [Teste]
GO

CREATE TABLE [dbo].[Pais](
	[IdPais] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL primary key,
	[Nome] [varchar](50) NOT NULL,
	[TipoPessoa] [char](1) NOT NULL,
	[CPFCNPJ] [varchar](14) NOT NULL,
	[RG] [varchar](12) NULL,
	[IE] [varchar](18) NULL,
	[CEP] [varchar](8) NULL,
	[Logradouro] [varchar](50) NULL,
	[LogradouroNumero] [varchar](10) NULL,
	[Bairro] [varchar](30) NULL,
	[Cidade] [varchar](30) NULL,
	[UF] [char](2) NULL,
	[IdPais] [int] NULL,
	[Data] [datetime] NOT NULL,
	[Ativo] [char](1) NOT NULL)
GO

ALTER TABLE Cliente
ADD CONSTRAINT FK_Pais_Cliente
FOREIGN KEY (IdPais) REFERENCES Pais(IdPais)
GO

CREATE TABLE [dbo].[ClienteTelefone](
	[IdClienteTelefone] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IdCliente] [int] NOT NULL,
	[DDD] [char](3) NOT NULL,
	[Numero] [varchar](10) NOT NULL)
GO

ALTER TABLE ClienteTelefone
ADD CONSTRAINT FK_Cliente_Telefone
FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
GO

CREATE PROCEDURE [dbo].[sp_cliente_delete]
	@IdCliente int
AS
BEGIN
	DELETE FROM ClienteTelefone WHERE IdCliente = @IdCliente
	DELETE FROM Cliente WHERE IdCliente = @IdCliente
END
GO

CREATE PROCEDURE [dbo].[sp_cliente_insert]
	@Nome varchar(50),
	@TipoPessoa char(10),
	@CPFCNPJ varchar(14),
	@RG varchar(12) NUll,
	@IE varchar(18) NULL,
	@CEP varchar(8) NULL,
	@Logradouro varchar(50) NULL,
	@LogradouroNumero varchar(10) NULL,
	@Bairro varchar(30) NULL,
	@Cidade varchar(30) NULL,
	@UF char(2) NULL,
	@IdPais int NULL,
	@Ativo char(1),
	@IdCliente int OUTPUT,
	@Data datetime OUTPUT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM Cliente WHERE NULLIF(CPFCNPJ,'') = @CPFCNPJ)
	BEGIN
	  DECLARE @Mensagem varchar(20)
      SET @Mensagem = IIF(@TipoPessoa = 'F', 'CPF', 'CNPJ') + ' já cadastrado!'

	  RAISERROR(@Mensagem, 16,1)
	  RETURN 1
	END

	DECLARE @IdTable TABLE (Id INT, data DATETIME);

	INSERT Cliente
	OUTPUT INSERTED.IdCliente, INSERTED.Data INTO @IdTable
	VALUES
		(@Nome,
		@TipoPessoa, 
		@CPFCNPJ, 
		NULLIF(@RG,''), 
		NULLIF(@IE,''), 
		NULLIF(@CEP,''), 
		NULLIF(@Logradouro,''), 
		NULLIF(@LogradouroNumero,''), 
		NULLIF(@Bairro,''), 
		NULLIF(@Cidade,''), 
		NULLIF(@UF,''), 
		NULLIF(@IdPais,0), 
		CONVERT(VARCHAR(10), GETDATE(), 103), 
		@Ativo);

	SELECT @IdCliente =  Id, @Data = data FROM @IdTable
END
GO

CREATE PROCEDURE [dbo].[sp_cliente_select]
	@Nome varchar(50) NULL
AS
BEGIN
	SELECT
		IdCliente,
		Nome,
		TipoPessoa,
		CPFCNPJ,
		RG = ISNULL(RG,''),
		IE = ISNULL(IE,''),
		CEP = ISNULL(CEP,''),
		Logradouro = ISNULL(Logradouro,''),
		LogradouroNumero = ISNULL(LogradouroNumero,''),
		Bairro = ISNULL(bairro,''),
		Cidade = ISNULL(Cidade,''),
		UF = ISNULL(UF,''),
		IdPais = ISNULL(IdPais,0),
		Data,
		Ativo
	FROM Cliente
	WHERE (Nome like '%' + ISNULL(@Nome, '') + '%' AND Ativo = '1')
	OR   (NULLIF(@Nome, '') IS NULL AND Ativo = '1')
	ORDER BY NOME	
END
GO

CREATE PROCEDURE [dbo].[sp_cliente_update]
	@IdCliente int,
	@Nome varchar(50),
	@TipoPessoa char(10),
	@CPFCNPJ varchar(14),
	@RG varchar(12) NUll,
	@IE varchar(18) NULL,
	@CEP varchar(8) NUll,
	@Logradouro varchar(50) NUll,
	@LogradouroNumero varchar(10) NUll,
	@Bairro varchar(30) NUll,
	@Cidade varchar(30) NUll,
	@UF char(2) NUll,
	@IdPais int NUll,
	@Ativo char(1)
AS
BEGIN
	UPDATE cliente SET
	Nome = @Nome,
	TipoPessoa = @TipoPessoa,
	CPFCNPJ = @CPFCNPJ,
	RG = NULLIF(@RG,''),
	IE = NULLIF(@IE,''),
	CEP = NULLIF(@CEP,''),
	Logradouro = NULLIF(@Logradouro,''),
	LogradouroNumero = NULLIF(@LogradouroNumero,''),
	Bairro = NULLIF(@Bairro,''),
	Cidade = NULLIF(@Cidade,''),
	UF = NULLIF(@UF,''),
	IdPais = NULLIF(@IdPais,0),
	Ativo = @Ativo
	WHERE IdCliente = @IdCliente

	IF @@ROWCOUNT = 0
	BEGIN
		RAISERROR('Nenhuma linha foi atualizada!',16,1)
		RETURN 1
	END
END
GO

CREATE PROCEDURE [dbo].[sp_pais_select]
AS
BEGIN
	SELECT IdPais, Nome FROM Pais
END
GO

CREATE PROCEDURE [dbo].[sp_clientetelefone_delete]
	@IdClienteTelefone int
AS
BEGIN
	DELETE FROM ClienteTelefone WHERE IdClienteTelefone = @IdClienteTelefone
END
GO

CREATE PROCEDURE [dbo].[sp_clientetelefone_insert]
	@IdCliente int,
	@DDD char(3),
	@Numero varchar(10),
	@IdClienteTelefone int OUTPUT
AS
BEGIN
	DECLARE @IdTable TABLE (Id INT);

	INSERT INTO ClienteTelefone
	OUTPUT inserted.IdClienteTelefone INTO @IdTable
	VALUES (@IdCliente, @DDD, @Numero)

	SELECT @IdClienteTelefone = Id FROM @IdTable
END
GO

CREATE PROCEDURE [dbo].[sp_clientetelefone_select]
	@IdCliente int
AS
BEGIN
	SELECT IdClienteTelefone, DDD, Numero FROM ClienteTelefone
	WHERE IdCliente = @IdCliente
END
GO

CREATE PROCEDURE [dbo].[sp_clientetelefone_update]
	@IdCliente int
AS
BEGIN
	DECLARE @IdClienteTelefone INT, @DDD CHAR(3), @Numero VARCHAR(10)

	DECLARE cr_telefone CURSOR FOR
	SELECT IdClienteTelefone, DDD, Numero FROM ClienteTelefone WHERE IdCliente = @IdCliente

	OPEN cr_telefone
	FETCH NEXT FROM cr_telefone
	INTO @IdClienteTelefone, @DDD, @Numero

	IF OBJECT_ID('tempdb..#temp') IS NULL
	BEGIN
		RAISERROR('Tabela para cliente não encontrada!',16,1)
		RETURN 1
	END

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM #temp WHERE IdClienteTelefone = @IdClienteTelefone)
			UPDATE ClienteTelefone SET Numero = 'delete' WHERE IdClienteTelefone = @IdClienteTelefone

		FETCH NEXT FROM cr_telefone
		INTO @IdClienteTelefone, @DDD, @Numero	
	END

	CLOSE cr_telefone
	DEALLOCATE cr_telefone

	DELETE FROM ClienteTelefone
	WHERE IdCliente = @IdCliente
	AND Numero = 'delete'

	INSERT INTO ClienteTelefone
	SELECT IdCliente, DDD, Numero FROM #temp
	WHERE IdClienteTelefone = 0

	IF OBJECT_ID('tempdb..#temp') IS NOT NULL
		DROP TABLE #temp
END
GO

BEGIN TRAN;
INSERT INTO Pais (Nome) VALUES ('Afeganistão');
INSERT INTO Pais (Nome) VALUES ('África do Sul');
INSERT INTO Pais (Nome) VALUES ('Albânia');
INSERT INTO Pais (Nome) VALUES ('Alemanha');
INSERT INTO Pais (Nome) VALUES ('Andorra');
INSERT INTO Pais (Nome) VALUES ('Angola');
INSERT INTO Pais (Nome) VALUES ('Anguilla');
INSERT INTO Pais (Nome) VALUES ('Antártida');
INSERT INTO Pais (Nome) VALUES ('Antígua e Barbuda');
INSERT INTO Pais (Nome) VALUES ('Antilhas Holandesas');
INSERT INTO Pais (Nome) VALUES ('Arábia Saudita');
INSERT INTO Pais (Nome) VALUES ('Argélia');
INSERT INTO Pais (Nome) VALUES ('Argentina');
INSERT INTO Pais (Nome) VALUES ('Armênia');
INSERT INTO Pais (Nome) VALUES ('Aruba');
INSERT INTO Pais (Nome) VALUES ('Austrália');
INSERT INTO Pais (Nome) VALUES ('Áustria');
INSERT INTO Pais (Nome) VALUES ('Azerbaijão');
INSERT INTO Pais (Nome) VALUES ('Bahamas');
INSERT INTO Pais (Nome) VALUES ('Bahrein');
INSERT INTO Pais (Nome) VALUES ('Bangladesh');
INSERT INTO Pais (Nome) VALUES ('Barbados');
INSERT INTO Pais (Nome) VALUES ('Belarus');
INSERT INTO Pais (Nome) VALUES ('Bélgica');
INSERT INTO Pais (Nome) VALUES ('Belize');
INSERT INTO Pais (Nome) VALUES ('Benin');
INSERT INTO Pais (Nome) VALUES ('Bermudas');
INSERT INTO Pais (Nome) VALUES ('Bolívia');
INSERT INTO Pais (Nome) VALUES ('Bósnia-Herzegóvina');
INSERT INTO Pais (Nome) VALUES ('Botsuana');
INSERT INTO Pais (Nome) VALUES ('Brasil');
INSERT INTO Pais (Nome) VALUES ('Brunei');
INSERT INTO Pais (Nome) VALUES ('Bulgária');
INSERT INTO Pais (Nome) VALUES ('Burkina Fasso');
INSERT INTO Pais (Nome) VALUES ('Burundi');
INSERT INTO Pais (Nome) VALUES ('Butão');
INSERT INTO Pais (Nome) VALUES ('Cabo Verde');
INSERT INTO Pais (Nome) VALUES ('Camarões');
INSERT INTO Pais (Nome) VALUES ('Camboja');
INSERT INTO Pais (Nome) VALUES ('Canadá');
INSERT INTO Pais (Nome) VALUES ('Cazaquistão');
INSERT INTO Pais (Nome) VALUES ('Chade');
INSERT INTO Pais (Nome) VALUES ('Chile');
INSERT INTO Pais (Nome) VALUES ('China');
INSERT INTO Pais (Nome) VALUES ('Chipre');
INSERT INTO Pais (Nome) VALUES ('Cingapura');
INSERT INTO Pais (Nome) VALUES ('Colômbia');
INSERT INTO Pais (Nome) VALUES ('Congo');
INSERT INTO Pais (Nome) VALUES ('Coréia do Norte');
INSERT INTO Pais (Nome) VALUES ('Coréia do Sul');
INSERT INTO Pais (Nome) VALUES ('Costa do Marfim');
INSERT INTO Pais (Nome) VALUES ('Costa Rica');
INSERT INTO Pais (Nome) VALUES ('Croácia (Hrvatska)');
INSERT INTO Pais (Nome) VALUES ('Cuba');
INSERT INTO Pais (Nome) VALUES ('Dinamarca');
INSERT INTO Pais (Nome) VALUES ('Djibuti');
INSERT INTO Pais (Nome) VALUES ('Dominica');
INSERT INTO Pais (Nome) VALUES ('Egito');
INSERT INTO Pais (Nome) VALUES ('El Salvador');
INSERT INTO Pais (Nome) VALUES ('Emirados Árabes Unidos');
INSERT INTO Pais (Nome) VALUES ('Equador');
INSERT INTO Pais (Nome) VALUES ('Eritréia');
INSERT INTO Pais (Nome) VALUES ('Eslováquia');
INSERT INTO Pais (Nome) VALUES ('Eslovênia');
INSERT INTO Pais (Nome) VALUES ('Espanha');
INSERT INTO Pais (Nome) VALUES ('Estados Unidos');
INSERT INTO Pais (Nome) VALUES ('Estônia');
INSERT INTO Pais (Nome) VALUES ('Etiópia');
INSERT INTO Pais (Nome) VALUES ('Fiji');
INSERT INTO Pais (Nome) VALUES ('Filipinas');
INSERT INTO Pais (Nome) VALUES ('Finlândia');
INSERT INTO Pais (Nome) VALUES ('França');
INSERT INTO Pais (Nome) VALUES ('Gabão');
INSERT INTO Pais (Nome) VALUES ('Gâmbia');
INSERT INTO Pais (Nome) VALUES ('Gana');
INSERT INTO Pais (Nome) VALUES ('Geórgia');
INSERT INTO Pais (Nome) VALUES ('Gibraltar');
INSERT INTO Pais (Nome) VALUES ('Grã-Bretanha (Reino Unido, UK)');
INSERT INTO Pais (Nome) VALUES ('Granada');
INSERT INTO Pais (Nome) VALUES ('Grécia');
INSERT INTO Pais (Nome) VALUES ('Groelândia');
INSERT INTO Pais (Nome) VALUES ('Guadalupe');
INSERT INTO Pais (Nome) VALUES ('Guam (Território dos Estados Unidos)');
INSERT INTO Pais (Nome) VALUES ('Guatemala');
INSERT INTO Pais (Nome) VALUES ('Guernsey');
INSERT INTO Pais (Nome) VALUES ('Guiana');
INSERT INTO Pais (Nome) VALUES ('Guiana Francesa');
INSERT INTO Pais (Nome) VALUES ('Guiné');
INSERT INTO Pais (Nome) VALUES ('Guiné Equatorial');
INSERT INTO Pais (Nome) VALUES ('Guiné-Bissau');
INSERT INTO Pais (Nome) VALUES ('Haiti');
INSERT INTO Pais (Nome) VALUES ('Holanda');
INSERT INTO Pais (Nome) VALUES ('Honduras');
INSERT INTO Pais (Nome) VALUES ('Hong Kong');
INSERT INTO Pais (Nome) VALUES ('Hungria');
INSERT INTO Pais (Nome) VALUES ('Iêmen');
INSERT INTO Pais (Nome) VALUES ('Ilha Bouvet (Território da Noruega)');
INSERT INTO Pais (Nome) VALUES ('Ilha do Homem');
INSERT INTO Pais (Nome) VALUES ('Ilha Natal');
INSERT INTO Pais (Nome) VALUES ('Ilha Pitcairn');
INSERT INTO Pais (Nome) VALUES ('Ilha Reunião');
INSERT INTO Pais (Nome) VALUES ('Ilhas Aland');
INSERT INTO Pais (Nome) VALUES ('Ilhas Cayman');
INSERT INTO Pais (Nome) VALUES ('Ilhas Cocos');
INSERT INTO Pais (Nome) VALUES ('Ilhas Comores');
INSERT INTO Pais (Nome) VALUES ('Ilhas Cook');
INSERT INTO Pais (Nome) VALUES ('Ilhas Faroes');
INSERT INTO Pais (Nome) VALUES ('Ilhas Falkland (Malvinas)');
INSERT INTO Pais (Nome) VALUES ('Ilhas Geórgia do Sul e Sandwich do Sul');
INSERT INTO Pais (Nome) VALUES ('Ilhas Heard e McDonald (Território da Austrália)');
INSERT INTO Pais (Nome) VALUES ('Ilhas Marianas do Norte');
INSERT INTO Pais (Nome) VALUES ('Ilhas Marshall');
INSERT INTO Pais (Nome) VALUES ('Ilhas Menores dos Estados Unidos');
INSERT INTO Pais (Nome) VALUES ('Ilhas Norfolk');
INSERT INTO Pais (Nome) VALUES ('Ilhas Seychelles');
INSERT INTO Pais (Nome) VALUES ('Ilhas Solomão');
INSERT INTO Pais (Nome) VALUES ('Ilhas Svalbard e Jan Mayen');
INSERT INTO Pais (Nome) VALUES ('Ilhas Tokelau');
INSERT INTO Pais (Nome) VALUES ('Ilhas Turks e Caicos');
INSERT INTO Pais (Nome) VALUES ('Ilhas Virgens (Estados Unidos)');
INSERT INTO Pais (Nome) VALUES ('Ilhas Virgens (Inglaterra)');
INSERT INTO Pais (Nome) VALUES ('Ilhas Wallis e Futuna');
INSERT INTO Pais (Nome) VALUES ('índia');
INSERT INTO Pais (Nome) VALUES ('Indonésia');
INSERT INTO Pais (Nome) VALUES ('Irã');
INSERT INTO Pais (Nome) VALUES ('Iraque');
INSERT INTO Pais (Nome) VALUES ('Irlanda');
INSERT INTO Pais (Nome) VALUES ('Islândia');
INSERT INTO Pais (Nome) VALUES ('Israel');
INSERT INTO Pais (Nome) VALUES ('Itália');
INSERT INTO Pais (Nome) VALUES ('Jamaica');
INSERT INTO Pais (Nome) VALUES ('Japão');
INSERT INTO Pais (Nome) VALUES ('Jersey');
INSERT INTO Pais (Nome) VALUES ('Jordânia');
INSERT INTO Pais (Nome) VALUES ('Kênia');
INSERT INTO Pais (Nome) VALUES ('Kiribati');
INSERT INTO Pais (Nome) VALUES ('Kuait');
INSERT INTO Pais (Nome) VALUES ('Laos');
INSERT INTO Pais (Nome) VALUES ('Látvia');
INSERT INTO Pais (Nome) VALUES ('Lesoto');
INSERT INTO Pais (Nome) VALUES ('Líbano');
INSERT INTO Pais (Nome) VALUES ('Libéria');
INSERT INTO Pais (Nome) VALUES ('Líbia');
INSERT INTO Pais (Nome) VALUES ('Liechtenstein');
INSERT INTO Pais (Nome) VALUES ('Lituânia');
INSERT INTO Pais (Nome) VALUES ('Luxemburgo');
INSERT INTO Pais (Nome) VALUES ('Macau');
INSERT INTO Pais (Nome) VALUES ('Macedônia (República Yugoslava)');
INSERT INTO Pais (Nome) VALUES ('Madagascar');
INSERT INTO Pais (Nome) VALUES ('Malásia');
INSERT INTO Pais (Nome) VALUES ('Malaui');
INSERT INTO Pais (Nome) VALUES ('Maldivas');
INSERT INTO Pais (Nome) VALUES ('Mali');
INSERT INTO Pais (Nome) VALUES ('Malta');
INSERT INTO Pais (Nome) VALUES ('Marrocos');
INSERT INTO Pais (Nome) VALUES ('Martinica');
INSERT INTO Pais (Nome) VALUES ('Maurício');
INSERT INTO Pais (Nome) VALUES ('Mauritânia');
INSERT INTO Pais (Nome) VALUES ('Mayotte');
INSERT INTO Pais (Nome) VALUES ('México');
INSERT INTO Pais (Nome) VALUES ('Micronésia');
INSERT INTO Pais (Nome) VALUES ('Moçambique');
INSERT INTO Pais (Nome) VALUES ('Moldova');
INSERT INTO Pais (Nome) VALUES ('Mônaco');
INSERT INTO Pais (Nome) VALUES ('Mongólia');
INSERT INTO Pais (Nome) VALUES ('Montenegro');
INSERT INTO Pais (Nome) VALUES ('Montserrat');
INSERT INTO Pais (Nome) VALUES ('Myanma');
INSERT INTO Pais (Nome) VALUES ('Namíbia');
INSERT INTO Pais (Nome) VALUES ('Nauru');
INSERT INTO Pais (Nome) VALUES ('Nepal');
INSERT INTO Pais (Nome) VALUES ('Nicarágua');
INSERT INTO Pais (Nome) VALUES ('Níger');
INSERT INTO Pais (Nome) VALUES ('Nigéria');
INSERT INTO Pais (Nome) VALUES ('Niue');
INSERT INTO Pais (Nome) VALUES ('Noruega');
INSERT INTO Pais (Nome) VALUES ('Nova Caledônia');
INSERT INTO Pais (Nome) VALUES ('Nova Zelândia');
INSERT INTO Pais (Nome) VALUES ('Omã');
INSERT INTO Pais (Nome) VALUES ('Palau');
INSERT INTO Pais (Nome) VALUES ('Panamá');
INSERT INTO Pais (Nome) VALUES ('Papua-Nova Guiné');
INSERT INTO Pais (Nome) VALUES ('Paquistão');
INSERT INTO Pais (Nome) VALUES ('Paraguai');
INSERT INTO Pais (Nome) VALUES ('Peru');
INSERT INTO Pais (Nome) VALUES ('Polinésia Francesa');
INSERT INTO Pais (Nome) VALUES ('Polônia');
INSERT INTO Pais (Nome) VALUES ('Porto Rico');
INSERT INTO Pais (Nome) VALUES ('Portugal');
INSERT INTO Pais (Nome) VALUES ('Qatar');
INSERT INTO Pais (Nome) VALUES ('Quirguistão');
INSERT INTO Pais (Nome) VALUES ('República Centro-Africana');
INSERT INTO Pais (Nome) VALUES ('República Democrática do Congo');
INSERT INTO Pais (Nome) VALUES ('República Dominicana');
INSERT INTO Pais (Nome) VALUES ('República Tcheca');
INSERT INTO Pais (Nome) VALUES ('Romênia');
INSERT INTO Pais (Nome) VALUES ('Ruanda');
INSERT INTO Pais (Nome) VALUES ('Rússia');
INSERT INTO Pais (Nome) VALUES ('Saara Ocidental');
INSERT INTO Pais (Nome) VALUES ('Saint Vincente e Granadinas');
INSERT INTO Pais (Nome) VALUES ('Samoa Americana');
INSERT INTO Pais (Nome) VALUES ('Samoa Ocidental');
INSERT INTO Pais (Nome) VALUES ('San Marino');
INSERT INTO Pais (Nome) VALUES ('Santa Helena');
INSERT INTO Pais (Nome) VALUES ('Santa Lúcia');
INSERT INTO Pais (Nome) VALUES ('São Bartolomeu');
INSERT INTO Pais (Nome) VALUES ('São Cristóvão e Névis');
INSERT INTO Pais (Nome) VALUES ('São Martim');
INSERT INTO Pais (Nome) VALUES ('São Tomé e Príncipe');
INSERT INTO Pais (Nome) VALUES ('Senegal');
INSERT INTO Pais (Nome) VALUES ('Serra Leoa');
INSERT INTO Pais (Nome) VALUES ('Sérvia');
INSERT INTO Pais (Nome) VALUES ('Síria');
INSERT INTO Pais (Nome) VALUES ('Somália');
INSERT INTO Pais (Nome) VALUES ('Sri Lanka');
INSERT INTO Pais (Nome) VALUES ('St. Pierre and Miquelon');
INSERT INTO Pais (Nome) VALUES ('Suazilândia');
INSERT INTO Pais (Nome) VALUES ('Sudão');
INSERT INTO Pais (Nome) VALUES ('Suécia');
INSERT INTO Pais (Nome) VALUES ('Suíça');
INSERT INTO Pais (Nome) VALUES ('Suriname');
INSERT INTO Pais (Nome) VALUES ('Tadjiquistão');
INSERT INTO Pais (Nome) VALUES ('Tailândia');
INSERT INTO Pais (Nome) VALUES ('Taiwan');
INSERT INTO Pais (Nome) VALUES ('Tanzânia');
INSERT INTO Pais (Nome) VALUES ('Território Britânico do Oceano índico');
INSERT INTO Pais (Nome) VALUES ('Territórios do Sul da França');
INSERT INTO Pais (Nome) VALUES ('Territórios Palestinos Ocupados');
INSERT INTO Pais (Nome) VALUES ('Timor Leste');
INSERT INTO Pais (Nome) VALUES ('Togo');
INSERT INTO Pais (Nome) VALUES ('Tonga');
INSERT INTO Pais (Nome) VALUES ('Trinidad and Tobago');
INSERT INTO Pais (Nome) VALUES ('Tunísia');
INSERT INTO Pais (Nome) VALUES ('Turcomenistão');
INSERT INTO Pais (Nome) VALUES ('Turquia');
INSERT INTO Pais (Nome) VALUES ('Tuvalu');
INSERT INTO Pais (Nome) VALUES ('Ucrânia');
INSERT INTO Pais (Nome) VALUES ('Uganda');
INSERT INTO Pais (Nome) VALUES ('Uruguai');
INSERT INTO Pais (Nome) VALUES ('Uzbequistão');
INSERT INTO Pais (Nome) VALUES ('Vanuatu');
INSERT INTO Pais (Nome) VALUES ('Vaticano');
INSERT INTO Pais (Nome) VALUES ('Venezuela');
INSERT INTO Pais (Nome) VALUES ('Vietnã');
INSERT INTO Pais (Nome) VALUES ('Zâmbia');
INSERT INTO Pais (Nome) VALUES ('Zimbábue');
COMMIT TRAN;