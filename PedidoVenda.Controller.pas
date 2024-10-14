unit PedidoVenda.Controller;

interface

uses
  PedidoVenda.Model; //, Produto, Cliente, Database;

type
  TPedidoController = class
  private
    FPedidoModel: TPedidoModel;
  public
    constructor Create;
    procedure AdicionarProduto(CodigoProduto, Quantidade: Integer; ValorUnitario: Currency);
    procedure RemoverProduto(Index: Integer);
    procedure GravarPedido;
    function CarregarPedido(NumeroPedido: Integer): TPedidoModel;
  end;

implementation

constructor TPedidoController.Create;
begin
  FPedidoModel := TPedidoModel.Create;
end;

procedure TPedidoController.AdicionarProduto(CodigoProduto, Quantidade: Integer; ValorUnitario: Currency);
begin
  FPedidoModel.AdicionarProduto(CodigoProduto, Quantidade, ValorUnitario);
end;

procedure TPedidoController.RemoverProduto(Index: Integer);
begin
  FPedidoModel.RemoverProduto(Index);
end;

procedure TPedidoController.GravarPedido;
begin
  FPedidoModel.GravarPedido;
end;

function TPedidoController.CarregarPedido(NumeroPedido: Integer): TPedidoModel;
begin
  Result := FPedidoModel.CarregarPedido(NumeroPedido);
end;

end.

