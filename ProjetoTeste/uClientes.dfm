object frmClientes: TfrmClientes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Clientes'
  ClientHeight = 573
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 34
    Height = 15
    Caption = 'Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 91
    Width = 64
    Height = 15
    Caption = 'Tipo Pessoa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbCpfCnpj: TLabel
    Left = 135
    Top = 91
    Width = 20
    Height = 15
    Caption = 'CPF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbRGIE: TLabel
    Left = 299
    Top = 91
    Width = 17
    Height = 15
    Caption = 'RG'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 235
    Top = 193
    Width = 64
    Height = 15
    Caption = 'Logradouro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 633
    Top = 193
    Width = 46
    Height = 15
    Caption = 'N'#250'mero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 17
    Top = 257
    Width = 34
    Height = 15
    Caption = 'Bairro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 18
    Top = 193
    Width = 20
    Height = 15
    Caption = 'CEP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 234
    Top = 257
    Width = 37
    Height = 15
    Caption = 'Cidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 490
    Top = 257
    Width = 15
    Height = 15
    Caption = 'UF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 637
    Top = 91
    Width = 93
    Height = 15
    Caption = 'Data do cadastro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 18
    Top = 354
    Width = 27
    Height = 15
    Caption = 'DDD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 66
    Top = 354
    Width = 46
    Height = 15
    Caption = 'N'#250'mero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 18
    Top = 322
    Width = 44
    Height = 15
    Caption = 'Telefone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 18
    Top = 155
    Width = 49
    Height = 15
    Caption = 'Endere'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel
    Left = 560
    Top = 257
    Width = 21
    Height = 15
    Caption = 'Pa'#237's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtNomeCliente: TEdit
    Left = 16
    Top = 45
    Width = 457
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnConsultar: TButton
    Left = 490
    Top = 45
    Width = 97
    Height = 28
    Caption = 'Consultar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnConsultarClick
  end
  object btnNovo: TButton
    Left = 18
    Top = 528
    Width = 97
    Height = 28
    Caption = 'Novo'
    TabOrder = 20
    OnClick = btnNovoClick
  end
  object btnExcluir: TButton
    Left = 255
    Top = 529
    Width = 97
    Height = 28
    Caption = 'Excluir'
    Enabled = False
    TabOrder = 22
    OnClick = btnExcluirClick
  end
  object btnCancelar: TButton
    Left = 637
    Top = 528
    Width = 97
    Height = 28
    Caption = 'Cancelar'
    Enabled = False
    TabOrder = 24
    OnClick = btnCancelarClick
  end
  object btnSalvar: TButton
    Left = 517
    Top = 528
    Width = 97
    Height = 28
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 23
    OnClick = btnSalvarClick
  end
  object Panel2: TPanel
    Left = 16
    Top = 511
    Width = 718
    Height = 2
    TabOrder = 25
  end
  object cmbTipoPessoa: TComboBox
    Left = 18
    Top = 112
    Width = 97
    Height = 28
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = cmbTipoPessoaChange
    Items.Strings = (
      'F'#237'sica'
      'Jur'#237'dica')
  end
  object mskCpfCnpj: TMaskEdit
    Left = 135
    Top = 112
    Width = 143
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = ''
  end
  object mskRGIE: TMaskEdit
    Left = 299
    Top = 112
    Width = 143
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = ''
  end
  object edtLogradouro: TEdit
    Left = 235
    Top = 214
    Width = 379
    Height = 28
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
  object edtLogradouroNumero: TEdit
    Left = 633
    Top = 214
    Width = 97
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 10
  end
  object edtBairro: TEdit
    Left = 17
    Top = 278
    Width = 200
    Height = 28
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
  end
  object edtCidade: TEdit
    Left = 234
    Top = 278
    Width = 239
    Height = 28
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
  end
  object mskCEP: TMaskEdit
    Left = 18
    Top = 214
    Width = 96
    Height = 28
    EditMask = '00000-000;0;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 9
    ParentFont = False
    TabOrder = 7
    Text = ''
    OnExit = mskCEPExit
  end
  object mskDataCadastro: TMaskEdit
    Left = 637
    Top = 112
    Width = 97
    Height = 28
    Color = clBtnFace
    EditMask = '!99/99/0000;1; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Text = '  /  /    '
  end
  object chkAtivo: TCheckBox
    Left = 466
    Top = 119
    Width = 63
    Height = 17
    Caption = 'Ativo'
    TabOrder = 5
  end
  object edtTelefoneDDD: TEdit
    Left = 18
    Top = 375
    Width = 32
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 2
    ParentFont = False
    TabOrder = 15
  end
  object edtTelefoneNumero: TEdit
    Left = 66
    Top = 375
    Width = 111
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 16
  end
  object Panel3: TPanel
    Left = 18
    Top = 343
    Width = 391
    Height = 1
    TabOrder = 26
  end
  object btnTelefoneAdiciona: TButton
    Left = 197
    Top = 375
    Width = 97
    Height = 28
    Caption = 'Adicionar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    OnClick = btnTelefoneAdicionaClick
  end
  object btnTelefoneRemove: TButton
    Left = 309
    Top = 375
    Width = 97
    Height = 28
    Caption = 'Remover'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 18
    OnClick = btnTelefoneRemoveClick
  end
  object Panel4: TPanel
    Left = 18
    Top = 176
    Width = 716
    Height = 1
    TabOrder = 27
  end
  object cmbPais: TComboBox
    Left = 560
    Top = 278
    Width = 174
    Height = 28
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object btnBuscaCEP: TButton
    Left = 126
    Top = 214
    Width = 91
    Height = 28
    Caption = 'Busca CEP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnBuscaCEPClick
  end
  object edtUF: TEdit
    Left = 490
    Top = 278
    Width = 53
    Height = 28
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
  end
  object DBGridTelefone: TDBGrid
    Left = 18
    Top = 409
    Width = 388
    Height = 88
    DataSource = ds_telefone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 19
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DDD'
        ReadOnly = True
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Numero'
        ReadOnly = True
        Title.Caption = 'N'#250'mero'
        Width = 120
        Visible = True
      end>
  end
  object btnAlterar: TButton
    Left = 135
    Top = 529
    Width = 97
    Height = 28
    Caption = 'Alterar'
    Enabled = False
    TabOrder = 21
    OnClick = btnAlterarClick
  end
  object XMLDoc: TXMLDocument
    Left = 680
    Top = 328
  end
  object qr_telefone: TADOQuery
    Connection = dmSQLServer.ADOConnection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IdCliente'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      
        'SELECT IdTelefone, IdCliente, DDD, Numero FROM Telefone WHERE Id' +
        'Cliente = :IdCliente')
    Left = 680
    Top = 440
    object qr_telefoneIdTelefone: TAutoIncField
      FieldName = 'IdTelefone'
      ReadOnly = True
    end
    object qr_telefoneIdCliente: TIntegerField
      FieldName = 'IdCliente'
    end
    object qr_telefoneDDD: TStringField
      FieldName = 'DDD'
      FixedChar = True
      Size = 3
    end
    object qr_telefoneNumero: TStringField
      FieldName = 'Numero'
      Size = 10
    end
  end
  object ds_telefone: TDataSource
    AutoEdit = False
    DataSet = qr_telefone
    Left = 680
    Top = 384
  end
end
