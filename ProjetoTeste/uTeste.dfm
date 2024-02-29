object frmProjetoTeste: TfrmProjetoTeste
  Left = 0
  Top = 0
  Caption = 'Teste'
  ClientHeight = 617
  ClientWidth = 960
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 392
    Top = 160
    object Arquivo1: TMenuItem
      Caption = 'Arquivo'
      object mnuClientes: TMenuItem
        Caption = 'Clientes'
        OnClick = mnuClientesClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuSair: TMenuItem
        Caption = 'Sair'
        OnClick = mnuSairClick
      end
    end
  end
end
