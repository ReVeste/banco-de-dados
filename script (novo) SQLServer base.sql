


CREATE TABLE Usuario (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(255),
    cpf VARCHAR(14),
    telefone VARCHAR(20),
    email VARCHAR(255),
    senha VARCHAR(255),
    tipo VARCHAR(50),
    ativo BIT,
    data_cadastro DATE,
    imagem_url VARCHAR(500)
);

CREATE TABLE Endereco (
    id INT PRIMARY KEY IDENTITY(1,1),
    apelido VARCHAR(100),
    cep VARCHAR(10),
    rua VARCHAR(255),
    numero INT,
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    usuario_id INT FOREIGN KEY REFERENCES Usuario(id)
);

CREATE TABLE Produto (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(255),
    marca VARCHAR(100),
    descricao TEXT,
    preco FLOAT,
    categoria VARCHAR(50),
    qtd_estoque INT,
    tamanho VARCHAR(50),
    status VARCHAR(50),
    data_cadastro DATE,
    data_venda DATE
);

CREATE TABLE Pedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    data_hora DATETIME,
    data_pagamento DATE,
    data_conclusao DATE,
    tipo_frete VARCHAR(50),
    valor_frete FLOAT,
    valor_total FLOAT,
    status VARCHAR(50),
    usuario_id INT FOREIGN KEY REFERENCES Usuario(id)
);

CREATE TABLE item_pedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    pedido_id INT FOREIGN KEY REFERENCES Pedido(id),
    produto_id INT FOREIGN KEY REFERENCES Produto(id),
    quantidade INT
);

CREATE TABLE Feedback (
    id INT PRIMARY KEY IDENTITY(1,1),
    comentario TEXT,
    pedido_id INT FOREIGN KEY REFERENCES Pedido(id),
    usuario_id INT FOREIGN KEY REFERENCES Usuario(id),
);

CREATE TABLE Imagem (
    id INT PRIMARY KEY IDENTITY(1,1),
    produto_id INT FOREIGN KEY REFERENCES Produto(id),
    imagem_url VARCHAR(500)
);

CREATE TABLE imagens_feedback (
    id INT PRIMARY KEY IDENTITY(1,1),
    feedback_id INT FOREIGN KEY REFERENCES Feedback(id),
    pedido_id INT FOREIGN KEY REFERENCES Pedido(id),
    usuario_id INT FOREIGN KEY REFERENCES Usuario(id),
    imagem_url VARCHAR(500)
);

CREATE TABLE Entrega (
    id INT PRIMARY KEY IDENTITY(1,1),
    previsto_para VARCHAR(100),
    status VARCHAR(50),
    codigo_rastreio VARCHAR(100),
    data_hora_envio DATETIME,
    endereco_id INT FOREIGN KEY REFERENCES Endereco(id)
);