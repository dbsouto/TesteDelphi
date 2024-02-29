object frmConsultaCliente: TfrmConsultaCliente
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta Cliente'
  ClientHeight = 352
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 27
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object gridClientes: TStringGrid
    Left = 16
    Top = 84
    Width = 558
    Height = 205
    ColCount = 3
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object edtNome: TEdit
    Left = 16
    Top = 48
    Width = 433
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnConfirmar: TButton
    Left = 185
    Top = 307
    Width = 105
    Height = 28
    Caption = 'Confirmar'
    TabOrder = 2
    OnClick = btnConfirmarClick
  end
  object btnCancelar: TButton
    Left = 320
    Top = 307
    Width = 105
    Height = 28
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object btnProcurar: TButton
    Left = 469
    Top = 48
    Width = 105
    Height = 28
    Caption = 'Procurar'
    TabOrder = 4
    OnClick = btnProcurarClick
  end
end
