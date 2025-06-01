-- ENUMs como VARCHAR
-- Certifique-se de validar os valores no backend

-- ESSE SCRIPT NÃO ESTA TOTALMENTE CORRETO !!

CREATE TABLE Usuario (
    id INT PRIMARY KEY IDENTITY,
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
    id INT PRIMARY KEY IDENTITY,
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
    id INT PRIMARY KEY IDENTITY,
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
    id INT PRIMARY KEY IDENTITY,
    data_hora DATETIME,
    data_pagamento DATE,
    data_conclusao DATE,
    tipo_frete VARCHAR(50),
    valor_frete FLOAT,
    valor_total FLOAT,
    status VARCHAR(50),
    usuario_id INT FOREIGN KEY REFERENCES Usuario(id)
    -- Adicionar chave estrangeira para Entrega se for relacionamento um-para-um
    -- entrega_id INT UNIQUE FOREIGN KEY REFERENCES Entrega(id)
);

CREATE TABLE Item_Pedido ( -- Renomeado para ItemPedido
    id INT PRIMARY KEY IDENTITY,
    pedido_id INT FOREIGN KEY REFERENCES Pedido(id),
    produto_id INT FOREIGN KEY REFERENCES Produto(id),
    quantidade INT
);

CREATE TABLE Feedback (
    id INT PRIMARY KEY IDENTITY,
    comentario TEXT,
    pedido_id INT FOREIGN KEY REFERENCES Pedido(id),
    usuario_id INT FOREIGN KEY REFERENCES Usuario(id),
    item_Pedido_id INT FOREIGN KEY REFERENCES Item_Pedido(id) -- Referenciando a tabela renomeada
);

CREATE TABLE Imagem (
    id INT PRIMARY KEY IDENTITY,
    produto_id INT FOREIGN KEY REFERENCES Produto(id),
    imagemUrl VARCHAR(500)
);

CREATE TABLE ImagensFeedback (
    id INT PRIMARY KEY IDENTITY,
    feedback_id INT FOREIGN KEY REFERENCES Feedback(id),
    -- Considerar remover as próximas chaves estrangeiras se não forem estritamente necessárias
    pedido_id INT FOREIGN KEY REFERENCES Pedido(id),
    usuario_id INT FOREIGN KEY REFERENCES Usuario(id),
    item_pedido_id INT FOREIGN KEY REFERENCES Item_Pedido(id), -- Referenciando a tabela renomeada
    imagem_url VARCHAR(500)
);

CREATE TABLE Entrega (
    id INT PRIMARY KEY IDENTITY,
    previsto_para VARCHAR(100),
    status VARCHAR(50),
    codigo_rastreio VARCHAR(100),
    data_hora_envio DATETIME,
    endereco_id INT FOREIGN KEY REFERENCES Endereco(id)
    -- Adicionar chave estrangeira para Pedido se for relacionamento um-para-um e a FK estiver aqui
    -- pedido_id INT UNIQUE FOREIGN KEY REFERENCES Pedido(id)
);