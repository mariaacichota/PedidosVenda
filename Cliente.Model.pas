unit Cliente.Model;

interface

uses
  SysUtils, Classes, Database.Model, FireDAC.Comp.Client;

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    FUF: String;
  public
    function ObterCliente(CodigoCliente: Integer): TCliente;

    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
  end;

implementation

function TCliente.ObterCliente(CodigoCliente: Integer): TCliente;
var
  Query: TFDQuery;
begin
  Result := nil;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := TDatabase.GetConnection;
    Query.SQL.Text := 'SELECT Codigo, Nome, Cidade, UF FROM clientes WHERE Codigo = :Codigo';
    Query.ParamByName('Codigo').AsInteger := CodigoCliente;
    Query.Open;

    if not Query.IsEmpty then
    begin
      Result := TCliente.Create;
      Result.Codigo := Query.FieldByName('Codigo').AsInteger;
      Result.Nome := Query.FieldByName('Nome').AsString;
      Result.Cidade := Query.FieldByName('Cidade').AsString;
      Result.UF := Query.FieldByName('UF').AsString;
    end;
  finally
    Query.Free;
  end;
end;

end.

