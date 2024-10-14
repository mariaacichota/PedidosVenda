unit PedidoVenda.Model;

interface

uses
  SysUtils, Classes;//, Produto, Cliente, Database;

type
  TPedidoModel = class
  private
    FNumero: Integer;
    FDataEmissao: TDateTime;
//    FCliente: TCliente;
    FProdutos: TList;
    FValorTotal: Currency;
  public
    constructor Create;
    procedure AdicionarProduto(CodigoProduto, Quantidade: Integer; ValorUnitario: Currency);
    procedure RemoverProduto(Index: Integer);
    procedure GravarPedido;
    function CalcularTotal: Currency;
    function CarregarPedido(NumeroPedido: Integer): TPedidoModel;
  end;

implementation

constructor TPedidoModel.Create;
begin
  FProdutos := TList.Create;
end;

procedure TPedidoModel.AdicionarProduto(CodigoProduto, Quantidade: Integer; ValorUnitario: Currency);
begin
  // Implementar a l�gica para adicionar produto
end;

procedure TPedidoModel.RemoverProduto(Index: Integer);
begin
  // Implementar a l�gica para remover produto
end;

procedure TPedidoModel.GravarPedido;
begin
  // Implementar l�gica para gravar o pedido no banco
end;

function TPedidoModel.CalcularTotal: Currency;
begin
  // Implementar c�lculo do valor total do pedido
end;

function TPedidoModel.CarregarPedido(NumeroPedido: Integer): TPedidoModel;
begin
  // Implementar l�gica para carregar pedido do banco
end;

end.

