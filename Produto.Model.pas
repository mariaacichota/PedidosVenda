unit Produto.Model;

interface

uses
  SysUtils, Classes, Database.Model, FireDAC.Comp.Client;

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: String;
    FPrecoVenda: Currency;
  public
    function ObterProduto(CodigoProduto: Integer): TProduto;

    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property PrecoVenda: Currency read FPrecoVenda write FPrecoVenda;
  end;

implementation

function TProduto.ObterProduto(CodigoProduto: Integer): TProduto;
var
  Query: TFDQuery;
begin
  Result := nil;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := TDatabase.GetConnection;
    Query.SQL.Text := 'SELECT Codigo, Descricao, Preco_venda FROM produtos WHERE Codigo = :Codigo';
    Query.ParamByName('Codigo').AsInteger := CodigoProduto;
    Query.Open;

    if not Query.IsEmpty then
    begin
      Result := TProduto.Create;
      Result.Codigo := Query.FieldByName('Codigo').AsInteger;
      Result.Descricao := Query.FieldByName('Descricao').AsString;
      Result.PrecoVenda := Query.FieldByName('Preco_venda').AsCurrency;
    end;
  finally
    Query.Free;
  end;
end;

end.

