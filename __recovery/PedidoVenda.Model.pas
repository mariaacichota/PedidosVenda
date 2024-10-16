unit PedidoVenda.Model;

interface

uses
  SysUtils, Classes, Produto.Model, Cliente.Model, Generics.Collections, Database.Model;

type
  TPedidoProduto = class
  private
    FCodigoProduto: Integer;
    FDescricao: String;
    FQuantidade: Integer;
    FValorUnitario: Currency;
    FValorTotal: Currency;
  public
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Descricao: String read FDescricao write FDescricao;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    property ValorTotal: Currency read FValorTotal write FValorTotal;

    constructor Create(ACodigoProduto: Integer; ADescricao: String; AQuantidade: Integer; AValorUnitario: Currency);
  end;

  TPedido = class
  private
    FNumeroPedido: Integer;
    FDataEmissao: TDateTime;
    FCliente: TCliente;
    FProdutos: TObjectList<TPedidoProduto>;
    FValorTotal: Currency;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarProduto(CodigoProduto, Quantidade: Integer; Descricao: String; ValorUnitario: Currency);
    procedure RemoverProduto(Index: Integer);
    procedure ExcluirPedido(Index: Integer);
    procedure AtualizarProduto(Index: Integer; Quantidade: Integer; ValorUnitario: Currency);
    procedure CalcularTotal;
    procedure GravarPedido;
    function CarregarPedido(Index: Integer): TPedido;
    procedure SetCliente(CodigoCliente: Integer);

    property NumeroPedido: Integer read FNumeroPedido;
    property DataEmissao: TDateTime read FDataEmissao;
    property Cliente: TCliente read FCliente;
    property Produtos: TObjectList<TPedidoProduto> read FProdutos;
    property ValorTotal: Currency read FValorTotal;
  end;

implementation

uses
  FireDAC.Comp.Client;

{ TPedidoProduto }

constructor TPedidoProduto.Create(ACodigoProduto: Integer; ADescricao: String; AQuantidade: Integer; AValorUnitario: Currency);
begin
  FCodigoProduto := ACodigoProduto;
  FDescricao := ADescricao;
  FQuantidade := AQuantidade;
  FValorTotal := AQuantidade * AValorUnitario;
  FValorUnitario := AValorUnitario;
end;

{ TPedido }

constructor TPedido.Create;
begin
//  FCliente := nil;
  FDataEmissao := Now;
  FProdutos := TObjectList<TPedidoProduto>.Create;
  FValorTotal := 0.00;
end;

destructor TPedido.Destroy;
begin
  FProdutos.Free;
  inherited;
end;

procedure TPedido.ExcluirPedido(Index: Integer);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := TDatabase.GetConnection;
    Query.Connection.StartTransaction;
    try
      Query.Connection := TDatabase.GetConnection;
      Query.SQL.Text := 'DELETE FROM pedidos WHERE numero_pedido = :pedido)';
      Query.ParamByName('pedido').AsInteger := Index;
      Query.ExecSQL;


      Query.SQL.Text := 'DELETE FROM pedido_produtos WHERE numero_pedido = :pedido';
      Query.ParamByName('pedido').AsInteger := Index;
      Query.ExecSQL;

      Query.Connection.Commit;
    except
      Query.Connection.Rollback;
      raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure TPedido.AdicionarProduto(CodigoProduto, Quantidade: Integer; Descricao: String; ValorUnitario: Currency);
var
  Produto: TPedidoProduto;
begin
  Produto := TPedidoProduto.Create(CodigoProduto, Descricao, Quantidade, ValorUnitario);
  FProdutos.Add(Produto);
  CalcularTotal;
end;

procedure TPedido.RemoverProduto(Index: Integer);
begin
  FProdutos.Delete(Index);
  CalcularTotal;
end;

procedure TPedido.SetCliente(CodigoCliente: Integer);
var
  ClienteModel: TCliente;
begin
  ClienteModel := TCliente.Create;
  try
    FCliente := ClienteModel.ObterCliente(CodigoCliente);
  finally
    ClienteModel.Free;
  end;
end;

procedure TPedido.AtualizarProduto(Index: Integer; Quantidade: Integer; ValorUnitario: Currency);
begin
  FProdutos[Index].Quantidade := Quantidade;
  FProdutos[Index].ValorUnitario := ValorUnitario;
  FProdutos[Index].ValorTotal := Quantidade * ValorUnitario;
  CalcularTotal;
end;

procedure TPedido.CalcularTotal;
var
  I: Integer;
  Total: Currency;
begin
  Total := 0;
  for I := 0 to FProdutos.Count - 1 do
  begin
    Total := Total + FProdutos[I].ValorTotal;
  end;
  FValorTotal := Total;
end;

function TPedido.CarregarPedido(Index: Integer): TPedido;
var
  Query: TFDQuery;
  Produto: TPedidoProduto;
begin
  Result := Self;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := TDatabase.GetConnection;

    Query.SQL.Text := 'SELECT * FROM pedidos WHERE numero_pedido = :pedido';
    Query.ParamByName('pedido').AsInteger := Index;
    Query.Open;

    if not Query.IsEmpty then
    begin
      FNumeroPedido := Query.FieldByName('numero_pedido').AsInteger;
      FDataEmissao := Query.FieldByName('data_emissao').AsDateTime;
      FValorTotal := Query.FieldByName('valor_total').AsCurrency;

      FCliente := TCliente.Create;
      FCliente.Codigo := Query.FieldByName('codigo_cliente').AsInteger;
    end;

    Query.SQL.Text := 'SELECT * FROM pedido_produtos WHERE numero_pedido = :pedido';
    Query.ParamByName('pedido').AsInteger := FNumeroPedido;
    Query.Open;

    FProdutos.Clear;

    while not Query.Eof do
    begin
      Produto := TPedidoProduto.Create(
        Query.FieldByName('codigo_produto').AsInteger,
        '',
        Query.FieldByName('quantidade').AsInteger,
        Query.FieldByName('valor_unitario').AsCurrency
      );
      FProdutos.Add(Produto);
      Query.Next;
    end;

  finally
    Query.Free;
  end;
end;

procedure TPedido.GravarPedido;
var
  I: Integer;
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := TDatabase.GetConnection;
    Query.Connection.StartTransaction;
    try
      Query.Connection := TDatabase.GetConnection;
      Query.SQL.Text := 'INSERT INTO pedidos (data_emissao, codigo_cliente, valor_total) VALUES (:data, :cliente, :valor)';
      Query.ParamByName('data').AsDateTime := FDataEmissao;
      Query.ParamByName('cliente').AsInteger := FCliente.Codigo;
      Query.ParamByName('valor').AsCurrency := FValorTotal;
      Query.ExecSQL;

      FNumeroPedido := Query.Connection.ExecSQLScalar('SELECT MAX(numero_pedido) from pedidos');

      for I := 0 to FProdutos.Count - 1 do
      begin
        Query.SQL.Text := 'INSERT INTO pedido_produtos (numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) VALUES (:pedido, :produto, :quantidade, :unitario, :total)';
        Query.ParamByName('pedido').AsInteger := FNumeroPedido;
        Query.ParamByName('produto').AsInteger := FProdutos[I].CodigoProduto;
        Query.ParamByName('quantidade').AsInteger := FProdutos[I].Quantidade;
        Query.ParamByName('unitario').AsCurrency := FProdutos[I].ValorUnitario;
        Query.ParamByName('total').AsCurrency := FProdutos[I].ValorTotal;
        Query.ExecSQL;
      end;
      Query.Connection.Commit;
    except
      Query.Connection.Rollback;
      raise;
    end;
  finally
    Query.Free;
  end;
end;

end.

