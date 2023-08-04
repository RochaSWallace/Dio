USE `E-commerce`;

SHOW TABLES;

-- Quais são os produtos disponíveis na tabela Produtos e suas respectivas categorias?
select * from Produtos;
SELECT p.Nome, p.Valor, c.Categoria
FROM Produtos p
JOIN Categorias c ON p.Categorias_idCategorias = c.idCategorias;


-- Quais são os clientes pessoas físicas que fizeram pedidos (estão na tabela Pedidos) e ainda não
-- receberam a entrega (status de entrega 'Em andamento' ou 'Enviado') na tabela Entrega?
SELECT c.Primeiro_Nome, p.Descricao, e.Status_Entrega
FROM Pedidos p
JOIN Clientes_PF c ON p.Cliente_idCliente = c.idCliente
JOIN Entrega e ON p.Entrega_idEntrega = e.idEntrega
WHERE Status_Entrega IN ('Em andamento', 'Enviado');


-- Qual é o produto mais bem avaliado na tabela Produtos?
SELECT *
FROM Produtos
WHERE Avaliacao = (SELECT MAX(Avaliacao) FROM Produtos);


-- Qual a quantidade de cada Produto no Estoque e o seu Local?
SELECT p.Nome, pe.Quantidade, e.`Local`
FROM `Produto / Estoque` pe
JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque
JOIN Produtos p ON pe.Produto_idproduto = p.idproduto;
