create table Reveste;
-- -----------------------------------------------------
-- Table Usuario
-- -----------------------------------------------------
create table Usuario (
  idUsuario INT PRIMARY KEY auto_increment,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) NOT NULL,
  telefone CHAR(11) NOT NULL,
  email VARCHAR(45) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  tipoUsuario VARCHAR(45) NOT NULL,
  ativo TINYINT,
  imagem_url VARCHAR(200) NOT NULL);

-- -----------------------------------------------------
-- Table Endereco
-- -----------------------------------------------------
CREATE TABLE Endereco (
  idEndereco INT primary key auto_increment,
  apelido VARCHAR(100) NOT NULL,
  cep CHAR(8) NOT NULL,
  rua VARCHAR(100) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  complemento VARCHAR(100),
  bairro VARCHAR(100) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  uf CHAR(2) NOT NULL,
  fkUsuario INT NOT NULL,
    FOREIGN KEY (fkUsuario) REFERENCES Usuario (idUsuario));

-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE Produto (
  idProduto INT primary key auto_increment,
  nome VARCHAR(100) not NULL,
  tamanho VARCHAR(4) not NULL,
  categoria VARCHAR(45) not NULL,
  marca VARCHAR(45) not NULL,
  preco DOUBLE not NULL,
  descricao VARCHAR(255) not NULL,
  qtdEstoque INT not NULL,
  status_produto VARCHAR(10) not NULL);


-- -----------------------------------------------------
-- Table Entrega
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Entrega (
  idEntrega int primary key auto_increment,
  previstoPara DATE NOT NULL,
  status_entrega VARCHAR(45) NOT NULL,
  codigoRastreio VARCHAR(45) NOT NULL,
  dataHoraEnvio DATETIME NOT NULL,
  fkEndereco INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES Endereco (idEndereco));

-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE Pedido (
  idPedido INT NOT NULL,
  dataHora DATETIME NOT NULL,
  tipoFrete VARCHAR(45) NOT NULL,
  valorFrete DOUBLE NOT NULL,
  valorTotal DOUBLE NOT NULL,
  status_pedido VARCHAR(45) NOT NULL,
  fkUsuario INT NOT NULL,
  fkEntrega VARCHAR(45) NOT NULL,
  PRIMARY KEY (idPedido, fkUsuario),
    FOREIGN KEY (fkEntrega) REFERENCES Entrega (idEntrega),
    FOREIGN KEY (fkUsuario) REFERENCES Usuario (idUsuario));


-- -----------------------------------------------------
-- Table itemPedido
-- -----------------------------------------------------
CREATE TABLE itemPedido (
  id INT auto_increment,
  fkPedido INT NOT NULL,
  fkProduto INT NOT NULL,
  quantidade INT not NULL,
  PRIMARY KEY (id, fkPedido, fkProduto),
    FOREIGN KEY (fkPedido) REFERENCES Pedido (idPedido),
    FOREIGN KEY (fkProduto) REFERENCES Produto (idProduto));


-- -----------------------------------------------------
-- Table Feedback
-- -----------------------------------------------------
CREATE TABLE Feedback (
  idFeedback INT NOT NULL,
  nota INT not NULL,
  comentario VARCHAR(255),
  fkUsuario INT NOT NULL,
    FOREIGN KEY (fkUsuario)
    REFERENCES Usuario (idUsuario));


-- -----------------------------------------------------
-- Table Imagem
-- -----------------------------------------------------
CREATE TABLE Imagem (
  idImagem INT auto_increment,
  imagem_ur VARCHAR(500) not NULL,
  Produto_idProduto INT NOT NULL,
  PRIMARY KEY (idImagem, Produto_idProduto),
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto));