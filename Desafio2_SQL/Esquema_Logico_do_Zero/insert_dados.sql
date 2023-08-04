-- Inserção de Dados na Tabela Clientes_PF
INSERT INTO `E-commerce`.`Clientes_PF` (`Primeiro_Nome`, `Ultimo_Nome`, `Data_Nascimento`, `CPF`, `Endereco`)
VALUES
  ('João', 'Silva', '1990-01-15', '12345678900', 'Rua A, 25'),
  ('Maria', 'Santos', '1985-05-20', '98765432100', 'Rua B, 46'),
  ('Pedro', 'Ferreira', '1995-09-10', '11122233300', 'Rua C, 18');

-- Inserção de Dados na Tabela Clientes_PJ
INSERT INTO `E-commerce`.`Clientes_PJ` (`Razao_Social`, `CNPJ`, `Endereco`)
VALUES
  ('Empresa A', '12345678901234', 'Rua Comercial, 123'),
  ('Empresa B', '98765432109876', 'Rua Comercial, 456'),
  ('Empresa C', '45678901234567', 'Rua Comercial, 789');

-- Inserção de Dados na Tabela Pagamento
INSERT INTO `E-commerce`.`Pagamento` (`Forma`)
VALUES
  ('PIX'),
  ('Boleto'),
  ('Cartão'),
  ('Dois Cartões');

-- Inserção de Dados na Tabela Entrega
INSERT INTO `E-commerce`.`Entrega` (`Status_Entrega`)
VALUES
  ('Em andamento'),
  ('Enviado'),
  ('Entregue');
  
-- Inserção de Dados na Tabela Pedidos
desc Pedidos;
INSERT INTO `E-commerce`.`Pedidos` (`Descricao`, `Cliente_idCliente`, `Frete`, `Pagamento_idPagamento`, `Entrega_idEntrega`, `Clientes PJ_idClientesPJ`)
VALUES
  ('Pedido 1', 1, 10.0, 3, 1, 1),
  ('Pedido 2', 2, 20.0, 2, 2, 1),
  ('Pedido 3', 3, 15.0, 1, 3, 1);

-- Inserção de Dados na Tabela Categorias
INSERT INTO `E-commerce`.`Categorias` (`Categorias`)
VALUES
	('Alimentos e Bebidas'),
    ('Brinquedos e Jogos'),
    ('Eletrônicos, TV e Áudio'),
    ('Roupas, Calçados e Acessódios');
    
-- Inserção de Dados na Tabela Produtos
INSERT INTO `E-commerce`.`Produtos` (`Nome`, `Valor`, `Avaliacao`, `Categorias_idCategorias`)
VALUES
  ('Arroz', 10.99, 4.5, '1'),
  ('Boneca', 25.50, 6.8, '2'),
  ('Smartphone', 1200.00, 3.9, '3');

-- Inserção de Dados na Tabela Fornecedor
INSERT INTO `E-commerce`.`Fornecedor` (`Razao_Social`, `CNPJ`)
VALUES
  ('Fornecedor A', '12345678000101'),
  ('Fornecedor B', '98765432000102');
  
-- Inserção de Dados na Tabela Disponibilizando um Produto
INSERT INTO `E-commerce`.`Disponibilizando um Produto` (`Fornecedor_idFornecedor`, `Produto_idproduto`)
VALUES
  (1, 1),
  (1, 2),
  (2, 3);

-- Inserção de Dados na Tabela Estoque
INSERT INTO `E-commerce`.`Estoque` (`Local`)
VALUES
  ('Depósito A'),
  ('Depósito B');

-- Inserção de Dados na Tabela Produto / Estoque
INSERT INTO `E-commerce`.`Produto / Estoque` (`Produto_idproduto`, `Estoque_idEstoque`, `Quantidade`)
VALUES
  (1, 1, '100 unidades'),
  (2, 1, '50 unidades'),
  (3, 2, '200 unidades');

-- Inserção de Dados na Tabela Terceiro - Vendedor
INSERT INTO `E-commerce`.`Terceiro - Vendedor` (`Razao_Social`, `Local`)
VALUES
  ('Vendedor A', 'Rua Comercial, 789'),
  ('Vendedor B', 'Avenida das Vendas, 456');

-- Inserção de Dados na Tabela Produtos por Vendedor (terceiro)
INSERT INTO `E-commerce`.`Produtos por Vendedor (terceiro)` (`Terceiro - Vendedor_idTerceiro - Vendedor`, `Produto_idproduto`, `Quantidade`)
VALUES
  (1, 1, 20),
  (1, 2, 15),
  (2, 3, 30);