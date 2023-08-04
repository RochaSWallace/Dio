-- -----------------------------------------------------
-- Schema E-commerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `E-commerce` ;
USE `E-commerce` ;

-- -----------------------------------------------------
-- Criando Tabela Clientes_PF
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Clientes_PF` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Primeiro_Nome` VARCHAR(45) NOT NULL,
  `Ultimo_Nome` VARCHAR(45) NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Pagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `Forma` ENUM('PIX', 'Boleto', 'Cartão', 'Dois Cartões') NOT NULL DEFAULT 'Boleto',
  PRIMARY KEY (`idPagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Entrega
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `Status_Entrega` ENUM('Em andamento', 'Enviado', 'Entregue') NULL,
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Clientes_PJ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Clientes_PJ` (
  `idClientesPJ` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(100) NOT NULL,
  `CNPJ` CHAR(14) NOT NULL,
  `Endereco` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idClientesPJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Pedidos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Pedidos` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(255) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Frete` FLOAT NULL DEFAULT 30,
  `Pagamento_idPagamento` INT NOT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  `Clientes PJ_idClientesPJ` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `Pagamento_idPagamento`, `Entrega_idEntrega`, `Clientes PJ_idClientesPJ`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedidos_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  INDEX `fk_Pedidos_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  INDEX `fk_Pedidos_Clientes PJ1_idx` (`Clientes PJ_idClientesPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `E-commerce`.`Clientes_PF` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `E-commerce`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `E-commerce`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Clientes PJ1`
    FOREIGN KEY (`Clientes PJ_idClientesPJ`)
    REFERENCES `E-commerce`.`Clientes_PJ` (`idClientesPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Categorias
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Categorias` (
  `idCategorias` INT NOT NULL AUTO_INCREMENT,
  `Categorias` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idCategorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Produtos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Produtos` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `Valor` FLOAT NOT NULL,
  `Avaliacao` FLOAT NOT NULL DEFAULT 0,
  `Categorias_idCategorias` INT NOT NULL,
  PRIMARY KEY (`idProduto`, `Categorias_idCategorias`),
  INDEX `fk_Produtos_Categorias1_idx` (`Categorias_idCategorias` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_Categorias1`
    FOREIGN KEY (`Categorias_idCategorias`)
    REFERENCES `E-commerce`.`Categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(45) NULL,
  `CNPJ` CHAR(14) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Disponibilizando um Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Disponibilizando um Produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idproduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idproduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idproduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `E-commerce`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idproduto`)
    REFERENCES `E-commerce`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Relação Produto/Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Relação Produto/Pedido` (
  `Produto_idproduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idproduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idproduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idproduto`)
    REFERENCES `E-commerce`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `E-commerce`.`Pedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Produto / Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Produto / Estoque` (
  `Produto_idproduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produto_idproduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idproduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idproduto`)
    REFERENCES `E-commerce`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `E-commerce`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Terceiro - Vendedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Terceiro - Vendedor` (
  `idTerceiro - Vendedor` INT NOT NULL AUTO_INCREMENT,
  `Razao_Social` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro - Vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Criando Tabela Produtos por Vendedor (terceiro)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commerce`.`Produtos por Vendedor (terceiro)` (
  `Terceiro - Vendedor_idTerceiro - Vendedor` INT NOT NULL,
  `Produto_idproduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`, `Produto_idproduto`),
  INDEX `fk_Terceiro - Vendedor_has_Produto_Produto1_idx` (`Produto_idproduto` ASC) VISIBLE,
  INDEX `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1_idx` (`Terceiro - Vendedor_idTerceiro - Vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1`
    FOREIGN KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`)
    REFERENCES `E-commerce`.`Terceiro - Vendedor` (`idTerceiro - Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idproduto`)
    REFERENCES `E-commerce`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;