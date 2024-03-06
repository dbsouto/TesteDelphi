unit udmMSSQLServer;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Data.DB, Data.Win.ADODB, Datasnap.DBClient, Data.FMTBcd,
  Data.SqlExpr, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet;

type
  TdmSQLServer = class(TDataModule)
    ADOConnection: TADOConnection;
    sp_cliente_delete: TADOStoredProc;
    sp_pais_select: TADOStoredProc;
    sp_clientetelefone_update: TADOStoredProc;
    sp_clientetelefone_select: TADOStoredProc;
    sp_cliente_select: TADOStoredProc;
    sp_cliente_update: TADOStoredProc;
    sp_cliente_insert: TADOStoredProc;
    sp_clientetelefone_insert: TADOStoredProc;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmSQLServer: TdmSQLServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
