program PedidoVendaProject;

uses
  Vcl.Forms,
  PedidoVenda.View in 'PedidoVenda.View.pas' {frmPedidoVenda},
  PedidoVenda.Controller in 'PedidoVenda.Controller.pas',
  PedidoVenda.Model in 'PedidoVenda.Model.pas',
  Produto.Model in 'Produto.Model.pas',
  Cliente.Model in 'Cliente.Model.pas',
  Database.Model in 'Database.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.Run;
end.
