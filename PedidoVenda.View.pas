unit PedidoVenda.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, PedidoVenda.Controller;

type
  TfrmPedidoVenda = class(TForm)
    pnlInfoPedido: TPanel;
    pnlGrid: TPanel;
    gridPedidosVenda: TDBGrid;
    pnlFooter: TPanel;
    edtCodigoProduto: TEdit;
    lblCodigoProduto: TLabel;
    lblDescricaoProduto: TLabel;
    lblQuantidade: TLabel;
    edtQuantidade: TEdit;
    edtValorUnitario: TEdit;
    lblValorUnitario: TLabel;
    btnAdicionarProduto: TButton;
    lblValorTotal: TLabel;
    lblTotal: TLabel;
    lblCodigoCliente: TLabel;
    edtCodigoCliente: TEdit;
    lblDescricaoCliente: TLabel;
    lblCodigoPedido: TLabel;
    edtCodigoPedido: TEdit;
    pnlTop: TPanel;
    btnNovoPedido: TButton;
    btnExcluirPedido: TButton;
    btnBuscarPedido: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

{$R *.dfm}

end.
