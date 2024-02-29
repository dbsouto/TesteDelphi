unit udmMSSQLServer;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Data.DB, Data.Win.ADODB, Datasnap.DBClient, Data.FMTBcd,
  Data.SqlExpr;

type
  TdmSQLServer = class(TDataModule)
    ADOConnection: TADOConnection;
    sp_cliente_delete: TADOStoredProc;
    sp_pais_select: TADOStoredProc;
    sp_telefone_delete: TADOStoredProc;
    sp_telefone_select: TADOStoredProc;
    sp_telefone_insert: TADOStoredProc;
    sp_cliente_insert: TADOStoredProc;
    sp_cliente_update: TADOStoredProc;
    sp_cliente_select: TADOStoredProc;
    qrAux: TADOQuery;
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
