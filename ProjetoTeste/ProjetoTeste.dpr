program ProjetoTeste;

uses
  Vcl.Forms,
  uTeste in 'uTeste.pas' {frmProjetoTeste},
  udmMSSQLServer in 'Conexao\udmMSSQLServer.pas' {dmSQLServer: TDataModule},
  uClientes in 'uClientes.pas' {frmClientes},
  uController in 'Controllers\uController.pas',
  uCliente in 'Model\uCliente.pas',
  uPais in 'Model\uPais.pas',
  uControllerCliente in 'Controllers\uControllerCliente.pas',
  uControllerPais in 'Controllers\uControllerPais.pas',
  uConsultaCliente in 'uConsultaCliente.pas' {frmConsultaCliente},
  uValidation in 'Helper\uValidation.pas',
  uControllerClienteTelefone in 'Controllers\uControllerClienteTelefone.pas',
  uClienteTelefone in 'Model\uClienteTelefone.pas',
  uGlobal in 'Helper\uGlobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProjetoTeste, frmProjetoTeste);
  Application.CreateForm(TdmSQLServer, dmSQLServer);
  Application.CreateForm(TfrmClientes, frmClientes);
  Application.CreateForm(TfrmConsultaCliente, frmConsultaCliente);
  Application.Run;
end.
