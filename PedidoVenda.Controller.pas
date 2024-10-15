unit PedidoVenda.Controller;

interface

uses
  PedidoVenda.Model, Produto.Model, Cliente.Model, Database.Model,
  Datasnap.DBClient;

type
  TPedidoController = class
  private
    FPedidoModel: TPedido;
    FProdutoAtual: TProduto;
  public
    constructor Create;
    procedure AdicionarProduto(CodigoProduto, Quantidade: Integer; Descricao: String; ValorUnitario: Currency);
    procedure RemoverProduto(Index: Integer);
    procedure GravarPedido;
    procedure BuscarPedido(Index: Integer);
    procedure ExcluirPedido(Index: Integer);
    function GetValorTotal: Double;
    function CarregarPedido(NumeroPedido: Integer): TPedido;
    procedure SetCliente(CodigoCliente: Integer);
    function GetClienteNome: String;
    procedure SetProduto(CodigoProduto: Integer);
    function GetProdutoDescricao: String;
    function GetProdutoValorUnitario: Currency;
    procedure PreencherProdutosDataSet(DataSet: TClientDataSet);
    procedure AtualizarProduto(Index: Integer; Quantidade: Integer; ValorUnitario: Currency);

    property PedidoModel: TPedido read FPedidoModel write FPedidoModel;
  end;

implementation

constructor TPedidoController.Create;
begin
  FPedidoModel := TPedido.Create;
end;

procedure TPedidoController.ExcluirPedido(Index: Integer);
begin
  FPedidoModel.ExcluirPedido(Index);
end;

procedure TPedidoController.AdicionarProduto(CodigoProduto, Quantidade: Integer; Descricao: String; ValorUnitario: Currency);
begin
  FPedidoModel.AdicionarProduto(CodigoProduto, Quantidade, Descricao, ValorUnitario);
end;

procedure TPedidoController.RemoverProduto(Index: Integer);
begin
  FPedidoModel.RemoverProduto(Index);
end;

procedure TPedidoController.SetCliente(CodigoCliente: Integer);
begin
  FPedidoModel.SetCliente(CodigoCliente);
end;

procedure TPedidoController.SetProduto(CodigoProduto: Integer);
var
  ProdutoModel: TProduto;
begin
  ProdutoModel := TProduto.Create;
  try
    FProdutoAtual := ProdutoModel.ObterProduto(CodigoProduto);
  finally
    ProdutoModel.Free;
  end;
end;

function TPedidoController.GetProdutoDescricao: String;
begin
  if Assigned(FProdutoAtual) then
    Result := FProdutoAtual.Descricao
  else
    Result := '';
end;

function TPedidoController.GetProdutoValorUnitario: Currency;
begin
  if Assigned(FProdutoAtual) then
    Result := FProdutoAtual.PrecoVenda
  else
    Result := 0.00;
end;

function TPedidoController.GetClienteNome: String;
begin
  if Assigned(FPedidoModel.Cliente) then
    Result := FPedidoModel.Cliente.Nome
  else
    Result := '';
end;

function TPedidoController.GetValorTotal: Double;
begin
  Result := FPedidoModel.ValorTotal;
end;

procedure TPedidoController.GravarPedido;
begin
  FPedidoModel.GravarPedido;
end;

procedure TPedidoController.PreencherProdutosDataSet(DataSet: TClientDataSet);
var
  I: Integer;
begin
  DataSet.EmptyDataSet;
  for I := 0 to FPedidoModel.Produtos.Count - 1 do
  begin
    DataSet.Append;
    DataSet.FieldByName('CodigoProduto').AsInteger := FPedidoModel.Produtos[I].CodigoProduto;
    DataSet.FieldByName('Descricao').AsString := FPedidoModel.Produtos[I].Descricao;
    DataSet.FieldByName('Quantidade').AsInteger := FPedidoModel.Produtos[I].Quantidade;
    DataSet.FieldByName('ValorUnitario').AsCurrency := FPedidoModel.Produtos[I].ValorUnitario;
    DataSet.FieldByName('ValorTotal').AsCurrency := FPedidoModel.Produtos[I].ValorTotal;
    DataSet.Post;
  end;
end;

procedure TPedidoController.AtualizarProduto(Index, Quantidade: Integer;
  ValorUnitario: Currency);
begin
  FPedidoModel.AtualizarProduto(Index, Quantidade, ValorUnitario);
end;

procedure TPedidoController.BuscarPedido(Index: integer);
begin
  FPedidoModel.CarregarPedido(Index);
end;

function TPedidoController.CarregarPedido(NumeroPedido: Integer): TPedido;
begin
  Result := FPedidoModel.CarregarPedido(NumeroPedido);
end;

end.

