object dmSQLServer: TdmSQLServer
  Height = 417
  Width = 401
  object ADOConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123;Persist Security Info=True;User' +
      ' ID=sa;Initial Catalog=Teste;Data Source=DESKTOP-1AUOI6F\SQLEXPR' +
      'ESS;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=' +
      '4096;Workstation ID=DESKTOP-1AUOI6F;Use Encryption for Data=Fals' +
      'e;Tag with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 56
    Top = 32
  end
  object sp_cliente_delete: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_cliente_delete'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IdCliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 56
    Top = 104
  end
  object sp_pais_select: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_pais_select'
    Parameters = <>
    Left = 200
    Top = 104
  end
  object sp_clientetelefone_update: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_clientetelefone_update'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IdCliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 200
    Top = 248
  end
  object sp_clientetelefone_select: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_clientetelefone_select'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IdCliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 200
    Top = 176
  end
  object sp_cliente_select: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_cliente_select'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Nome'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end>
    Left = 56
    Top = 176
  end
  object sp_cliente_update: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_cliente_update'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IdCliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Nome'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@TipoPessoa'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = '@CPFCNPJ'
        Attributes = [paNullable]
        DataType = ftString
        Size = 14
        Value = Null
      end
      item
        Name = '@RG'
        Attributes = [paNullable]
        DataType = ftString
        Size = 12
        Value = Null
      end
      item
        Name = '@IE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 18
        Value = Null
      end
      item
        Name = '@CEP'
        Attributes = [paNullable]
        DataType = ftString
        Size = 8
        Value = Null
      end
      item
        Name = '@Logradouro'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@LogradouroNumero'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = '@Bairro'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@Cidade'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@UF'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2
        Value = Null
      end
      item
        Name = '@IdPais'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Ativo'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end>
    Left = 56
    Top = 248
  end
  object sp_cliente_insert: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_cliente_insert'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
      end
      item
        Name = '@Nome'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
      end
      item
        Name = '@TipoPessoa'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
      end
      item
        Name = '@CPFCNPJ'
        Attributes = [paNullable]
        DataType = ftString
        Size = 14
      end
      item
        Name = '@RG'
        Attributes = [paNullable]
        DataType = ftString
        Size = 12
      end
      item
        Name = '@IE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 18
      end
      item
        Name = '@CEP'
        Attributes = [paNullable]
        DataType = ftString
        Size = 8
      end
      item
        Name = '@Logradouro'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
      end
      item
        Name = '@LogradouroNumero'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
      end
      item
        Name = '@Bairro'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
      end
      item
        Name = '@Cidade'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
      end
      item
        Name = '@UF'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2
      end
      item
        Name = '@IdPais'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
      end
      item
        Name = '@Ativo'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
      end
      item
        Name = '@IdCliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
      end
      item
        Name = '@Data'
        Attributes = [paNullable]
        DataType = ftDateTime
        Direction = pdInputOutput
      end>
    Left = 56
    Top = 320
  end
  object sp_clientetelefone_insert: TADOStoredProc
    Connection = ADOConnection
    ProcedureName = 'sp_clientetelefone_insert;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
      end
      item
        Name = '@IdCliente'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
      end
      item
        Name = '@DDD'
        Attributes = [paNullable]
        DataType = ftString
        Size = 3
      end
      item
        Name = '@Numero'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
      end
      item
        Name = '@IdClienteTelefone'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
      end>
    Left = 200
    Top = 320
  end
end
