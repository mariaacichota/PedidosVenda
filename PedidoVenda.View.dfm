object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 623
  ClientWidth = 1048
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnlInfoPedido: TPanel
    Left = 0
    Top = 59
    Width = 1048
    Height = 113
    Align = alTop
    TabOrder = 0
    ExplicitTop = 0
    ExplicitWidth = 996
    object lblCodigoProduto: TLabel
      Left = 16
      Top = 67
      Width = 75
      Height = 15
      Caption = 'C'#243'd. Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDescricaoProduto: TLabel
      Left = 226
      Top = 67
      Width = 202
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 449
      Top = 67
      Width = 67
      Height = 15
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorUnitario: TLabel
      Left = 666
      Top = 67
      Width = 69
      Height = 15
      Caption = 'Vlr. Unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCodigoCliente: TLabel
      Left = 359
      Top = 27
      Width = 69
      Height = 15
      Caption = 'C'#243'd. Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDescricaoCliente: TLabel
      Left = 560
      Top = 27
      Width = 298
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCodigoPedido: TLabel
      Left = 22
      Top = 27
      Width = 68
      Height = 15
      Caption = 'C'#243'd. Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigoProduto: TEdit
      Left = 96
      Top = 64
      Width = 121
      Height = 23
      TabOrder = 0
    end
    object edtQuantidade: TEdit
      Left = 520
      Top = 64
      Width = 121
      Height = 23
      TabOrder = 1
    end
    object edtValorUnitario: TEdit
      Left = 737
      Top = 64
      Width = 121
      Height = 23
      TabOrder = 2
    end
    object btnAdicionarProduto: TButton
      Left = 872
      Top = 63
      Width = 115
      Height = 25
      Caption = 'Adicionar Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object edtCodigoCliente: TEdit
      Left = 433
      Top = 24
      Width = 121
      Height = 23
      TabOrder = 4
    end
    object edtCodigoPedido: TEdit
      Left = 96
      Top = 24
      Width = 121
      Height = 23
      TabOrder = 5
    end
    object btnBuscarPedido: TButton
      Left = 223
      Top = 23
      Width = 115
      Height = 25
      Caption = 'Buscar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 172
    Width = 1048
    Height = 410
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 824
    ExplicitTop = 552
    ExplicitWidth = 185
    ExplicitHeight = 41
    object gridPedidosVenda: TDBGrid
      Left = 1
      Top = 1
      Width = 1046
      Height = 408
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 582
    Width = 1048
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 776
    ExplicitTop = 352
    ExplicitWidth = 185
    object lblValorTotal: TLabel
      Left = 1005
      Top = 1
      Width = 42
      Height = 39
      Align = alRight
      Alignment = taCenter
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 1010
      ExplicitHeight = 15
    end
    object lblTotal: TLabel
      Left = 975
      Top = 1
      Width = 30
      Height = 39
      Align = alRight
      Caption = 'Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 965
      ExplicitHeight = 15
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1048
    Height = 59
    Align = alTop
    TabOrder = 3
    object btnNovoPedido: TButton
      Left = 16
      Top = 18
      Width = 115
      Height = 25
      Caption = 'Novo Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object btnExcluirPedido: TButton
      Left = 144
      Top = 18
      Width = 115
      Height = 25
      Caption = 'Excluir Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
end
