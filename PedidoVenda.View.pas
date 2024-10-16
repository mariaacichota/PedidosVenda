unit PedidoVenda.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, PedidoVenda.Controller, Datasnap.DBClient;

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
    btnSalvarPedido: TButton;
    btnBuscarPedido: TButton;
    btnCancelarPedido: TButton;
    cdsProdutosPedido: TClientDataSet;
    dsProdutosPedido: TDataSource;
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure btnSalvarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure LimparFormulario;
    procedure edtCodigoPedidoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoProdutoChange(Sender: TObject);
    procedure btnNovoPedidoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LayoutDSGridProdutos;
    procedure ExcluirProduto;
    procedure AlterarProduto;
    procedure gridPedidosVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FController: TPedidoController;
  public

  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

uses
  PedidoVenda.Model;

{$R *.dfm}

{ TfrmPedidoVenda }

procedure TfrmPedidoVenda.AlterarProduto;
var
  Produto: TPedidoProduto;
  Index: Integer;
begin
  Index := gridPedidosVenda.DataSource.DataSet.RecNo - 1;

  if (Index < 0) or (Index >= FController.PedidoModel.Produtos.Count) then
    Exit;

  Produto := FController.PedidoModel.Produtos[Index];

  edtCodigoProduto.Text := IntToStr(Produto.CodigoProduto);
  edtQuantidade.Text := IntToStr(Produto.Quantidade);
  edtValorUnitario.Text := FloatToStr(Produto.ValorUnitario);

  btnAdicionarProduto.Caption := 'Atualizar Produto';
end;

procedure TfrmPedidoVenda.btnAdicionarProdutoClick(Sender: TObject);
var
  CodigoProduto, Quantidade: Integer;
  ValorUnitario: Currency;
begin
  CodigoProduto := StrToInt(edtCodigoProduto.Text);
  Quantidade := StrToInt(edtQuantidade.Text);
  ValorUnitario := StrToFloat(edtValorUnitario.Text);

  if btnAdicionarProduto.Caption = 'Atualizar Produto' then
  begin
    FController.AtualizarProduto(gridPedidosVenda.DataSource.DataSet.RecNo - 1, Quantidade, ValorUnitario);
    btnAdicionarProduto.Caption := 'Adicionar Produto';
  end
  else
  begin
    FController.AdicionarProduto(CodigoProduto, Quantidade, lblDescricaoProduto.Caption, ValorUnitario);
  end;

  lblValorTotal.Caption := Format('R$ %.2f', [FController.GetValorTotal]);
  FController.PreencherProdutosDataSet(cdsProdutosPedido);
end;

procedure TfrmPedidoVenda.btnBuscarPedidoClick(Sender: TObject);
var
  Pedido: TPedido;
begin
  Pedido := FController.CarregarPedido(StrToInt(edtCodigoPedido.Text));

  if Pedido <> nil then
  begin
    edtCodigoCliente.Text := Pedido.Cliente.Codigo.ToString;
    lblDescricaoCliente.Caption := Pedido.Cliente.Nome;

    cdsProdutosPedido.EmptyDataSet;

    for var Produto in Pedido.Produtos do
    begin
      cdsProdutosPedido.Append;
      cdsProdutosPedido.FieldByName('CodigoProduto').AsInteger := Produto.CodigoProduto;
      cdsProdutosPedido.FieldByName('Descricao').AsString := Produto.Descricao;
      cdsProdutosPedido.FieldByName('Quantidade').AsInteger := Produto.Quantidade;
      cdsProdutosPedido.FieldByName('ValorUnitario').AsCurrency := Produto.ValorUnitario;
      cdsProdutosPedido.FieldByName('ValorTotal').AsCurrency := Produto.ValorTotal;
      cdsProdutosPedido.Post;
    end;

    lblValorTotal.Caption := Format('R$ %.2f', [Pedido.ValorTotal]);

  end
  else
  begin
    ShowMessage('Pedido n�o encontrado');
  end;

  FController.BuscarPedido(StrToInt(edtCodigoPedido.Text));
  lblValorTotal.Caption := Format('R$ %.2f', [FController.GetValorTotal]);
end;

procedure TfrmPedidoVenda.btnCancelarPedidoClick(Sender: TObject);
var
  Confirm: Integer;
begin
  Confirm := MessageDlg('Deseja realmente cancelar este pedido?', mtConfirmation, [mbYes, mbNo], 0);
  if Confirm = mrYes then
  begin
    FController.ExcluirPedido(StrToInt(edtCodigoPedido.Text));
  end;
end;

procedure TfrmPedidoVenda.btnNovoPedidoClick(Sender: TObject);
begin
  LimparFormulario;
end;

procedure TfrmPedidoVenda.btnSalvarPedidoClick(Sender: TObject);
begin
  FController.GravarPedido;
  lblValorTotal.Caption := Format('R$ %.2f', [FController.GetValorTotal]);
end;

procedure TfrmPedidoVenda.edtCodigoClienteChange(Sender: TObject);
var
  CodigoCliente: Integer;
  ClienteNome: String;
begin
  if edtCodigoCliente.Text <> '' then
  begin
    CodigoCliente := StrToIntDef(edtCodigoCliente.Text, 0);
    if CodigoCliente > 0 then
    begin
      FController.SetCliente(CodigoCliente);
      ClienteNome := FController.GetClienteNome;
      lblDescricaoCliente.Caption := ClienteNome;
    end;
  end;

  btnBuscarPedido.Enabled := (edtCodigoCliente.Text = EmptyStr);
  btnCancelarPedido.Enabled := (edtCodigoCliente.Text = EmptyStr);
end;

procedure TfrmPedidoVenda.edtCodigoPedidoChange(Sender: TObject);
begin
  btnBuscarPedido.Enabled := (edtCodigoPedido.Text <> EmptyStr);
  btnSalvarPedido.Enabled := (edtCodigoPedido.Text <> EmptyStr);
  btnCancelarPedido.Enabled := (edtCodigoPedido.Text <> EmptyStr);
end;

procedure TfrmPedidoVenda.edtCodigoProdutoChange(Sender: TObject);
var
  CodigoProduto: Integer;
  ProdutoDescricao: String;
  ValorUnitario: Currency;
begin
  if edtCodigoProduto.Text <> '' then
  begin
    CodigoProduto := StrToIntDef(edtCodigoProduto.Text, 0);
    if CodigoProduto > 0 then
    begin
      FController.SetProduto(CodigoProduto);
      ProdutoDescricao := FController.GetProdutoDescricao;
      ValorUnitario := FController.GetProdutoValorUnitario;
      lblDescricaoProduto.Caption := ProdutoDescricao;
      edtValorUnitario.Text := CurrToStr(ValorUnitario);
    end;
  end;

  btnAdicionarProduto.Enabled := (edtCodigoProduto.Text <> EmptyStr);
end;

procedure TfrmPedidoVenda.ExcluirProduto;
var
  Index: Integer;
  Confirm: Integer;
begin
  Index := gridPedidosVenda.DataSource.DataSet.RecNo - 1;

  if (Index < 0) or (Index >= FController.PedidoModel.Produtos.Count) then
    Exit;

  Confirm := MessageDlg('Deseja realmente excluir este produto?', mtConfirmation, [mbYes, mbNo], 0);
  if Confirm = mrYes then
  begin
    FController.RemoverProduto(Index);
    lblValorTotal.Caption := Format('R$ %.2f', [FController.GetValorTotal]);
  end;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
  FController := TPedidoController.Create;
  btnSalvarPedido.Enabled := False;
  btnCancelarPedido.Enabled := False;
  btnAdicionarProduto.Enabled := False;
  btnBuscarPedido.Enabled := False;
  lblValorTotal.Caption := Format('R$ %.2f', [FController.GetValorTotal]);
end;

procedure TfrmPedidoVenda.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TfrmPedidoVenda.gridPedidosVendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    AlterarProduto;
    Key := 0;
  end
  else if Key = VK_DELETE then
  begin
    ExcluirProduto;
    Key := 0;
  end;
end;

procedure TfrmPedidoVenda.LayoutDSGridProdutos;
begin
  with cdsProdutosPedido.FieldDefs do
  begin
    Add('CodigoProduto', ftInteger);
    Add('Descricao', ftString, 100);
    Add('Quantidade', ftInteger);
    Add('ValorUnitario', ftCurrency);
    Add('ValorTotal', ftCurrency);
  end;
  cdsProdutosPedido.CreateDataSet;

  dsProdutosPedido.DataSet := cdsProdutosPedido;
  gridPedidosVenda.DataSource := dsProdutosPedido;
end;

procedure TfrmPedidoVenda.LimparFormulario;
begin
  edtCodigoProduto.Text := EmptyStr;
  edtQuantidade.Text := EmptyStr;
  edtValorUnitario.Text := EmptyStr;
  edtCodigoPedido.Text := EmptyStr;
  lblDescricaoProduto.Caption := EmptyStr;
  lblDescricaoCliente.Caption := EmptyStr;
end;

end.
