-- Verifica e exclui as tabelas caso já existam, para evitar conflitos
IF OBJECT_ID('dbo.imagensFeedback', 'U') IS NOT NULL DROP TABLE dbo.imagensFeedback;
IF OBJECT_ID('dbo.Imagem', 'U') IS NOT NULL DROP TABLE dbo.Imagem;
IF OBJECT_ID('dbo.Feedback', 'U') IS NOT NULL DROP TABLE dbo.Feedback;
IF OBJECT_ID('dbo.itemPedido', 'U') IS NOT NULL DROP TABLE dbo.itemPedido;
IF OBJECT_ID('dbo.Pedido', 'U') IS NOT NULL DROP TABLE dbo.Pedido;
IF OBJECT_ID('dbo.Entrega', 'U') IS NOT NULL DROP TABLE dbo.Entrega;
IF OBJECT_ID('dbo.Produto', 'U') IS NOT NULL DROP TABLE dbo.Produto;
IF OBJECT_ID('dbo.Endereco', 'U') IS NOT NULL DROP TABLE dbo.Endereco;
IF OBJECT_ID('dbo.Usuario', 'U') IS NOT NULL DROP TABLE dbo.Usuario;
GO

-- Criação da tabela Usuario
IF OBJECT_ID('dbo.Usuario', 'U') IS NULL
BEGIN
		CREATE TABLE dbo.usuario (
		id INT IDENTITY(1,1) PRIMARY KEY,  -- Coluna id com auto incremento
		nome VARCHAR(255) ,        -- Nome do usuário
		cpf CHAR(11) ,              -- CPF do usuário
		telefone CHAR(11) ,         -- Telefone do usuário
		email VARCHAR(255) ,       -- Email do usuário
		senha VARCHAR(255) ,       -- Senha do usuário
		tipo NVARCHAR(45),         -- Tipo de usuário (usando enum como string)
		ativo BIT,                          -- Status ativo ou inativo
        data_cadastro DATE ,
		imagem_url NVARCHAR(255)            -- URL da imagem do usuário
	);
END
GO

ALTER TABLE dbo.usuario
ADD CONSTRAINT chk_tipo CHECK (tipo IN ('cliente', 'admin', 'funcionario', 'tecnico'));
GO

-- Criação da tabela Endereco
IF OBJECT_ID('dbo.Endereco', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Endereco (
        id INT IDENTITY(1,1) PRIMARY KEY,
        apelido VARCHAR(100) ,
        cep CHAR(8) ,
        rua VARCHAR(100) ,
        numero VARCHAR(10) ,
        complemento VARCHAR(100),
        bairro VARCHAR(100) ,
        cidade VARCHAR(100) ,
        uf CHAR(2) ,
        usuario_id INT ,
        FOREIGN KEY (usuario_id) REFERENCES dbo.Usuario (id)
    );
END
GO

-- Criação da tabela Produto
IF OBJECT_ID('dbo.Produto', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Produto (
        id INT IDENTITY(1,1) PRIMARY KEY,
        nome VARCHAR(100) ,
        marca VARCHAR(45),
        descricao TEXT ,
        preco DECIMAL(18, 2) ,
        categoria VARCHAR(45) ,
        qtd_estoque INT ,
        tamanho VARCHAR(10) ,
        status VARCHAR(10) 
            CHECK (status IN ('RESERVADO', 'DISPONIVEL', 'VENDIDO', 'AVALIADO')),
        data_cadastro DATE,
        data_venda DATE
    );
END
GO

-- Criação da tabela Entrega
IF OBJECT_ID('dbo.Entrega', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Entrega (
        id INT IDENTITY(1,1) PRIMARY KEY,
        previsto_para DATE ,
        status VARCHAR(45) ,
        codigo_rastreio VARCHAR(45) ,
        data_hora_envio DATETIME ,
        endereco_id INT ,
        FOREIGN KEY (endereco_id) REFERENCES dbo.Endereco (id)
    );
END
GO

-- Criação da tabela Pedido
IF OBJECT_ID('dbo.Pedido', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Pedido (
        id INT IDENTITY(1,1) PRIMARY KEY,
        data_hora DATETIME ,
        data_pagamento DATE ,
        data_conclusao DATE ,
        tipo_frete VARCHAR(45) ,
        valor_frete DECIMAL(18, 2) ,
        valor_total DECIMAL(18, 2) ,
        status VARCHAR(45) ,
        usuario_id INT ,
        FOREIGN KEY (usuario_id) REFERENCES dbo.Usuario (id)
    );
END
GO

-- Criação da tabela item_pedido
IF OBJECT_ID('dbo.item_pedido', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.item_pedido  (
        id INT IDENTITY(1,1),
        pedido_id INT ,
        produto_id INT ,
        quantidade INT ,
        PRIMARY KEY (id, pedido_id, produto_id),
        FOREIGN KEY (pedido_id) REFERENCES dbo.Pedido (id),
        FOREIGN KEY (produto_id) REFERENCES dbo.Produto (id)
    );
END
GO

-- Criação da tabela Feedback
IF OBJECT_ID('dbo.Feedback', 'U') IS NULL
BEGIN   
    CREATE TABLE dbo.Feedback (
        id INT IDENTITY(1,1) PRIMARY KEY ,
        comentario VARCHAR(255),
        pedido_id INT ,
        usuario_id INT ,
        item_pedido_id INT ,

        FOREIGN KEY (item_pedido_id, pedido_id, produto_id) REFERENCES dbo.item_pedido(id, pedido_id, produto_id),
        FOREIGN KEY (usuario_id) REFERENCES dbo.Usuario (id)
    );
END
GO

-- Criação da tabela ImagensFeedback
IF OBJECT_ID('dbo.ImagensFeedback', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.ImagensFeedback (
        idImagensFeedback INT IDENTITY(1,1) PRIMARY KEY,
        feedback_id INT,
        pedido_id INT,
        usuario_id INT,
        itemPedido_id INT,
        ImagemUrl VARCHAR(500),

        FOREIGN KEY (feedback_id) REFERENCES dbo.Feedback(id),
        FOREIGN KEY (pedido_id) REFERENCES dbo.Pedido(id),
        FOREIGN KEY (usuario_id) REFERENCES dbo.Usuario(id),
        FOREIGN KEY (itemPedido_id) REFERENCES dbo.ItemPedido(id)
    );
END
GO

-- Criação da tabela Imagem
IF OBJECT_ID('dbo.Imagem', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Imagem (
        id INT IDENTITY(1,1),
        imagem_url VARCHAR(500) ,
        produto_id INT ,
        PRIMARY KEY (id, produto_id),
        FOREIGN KEY (produto_id) REFERENCES dbo.Produto (id)
    );
END
GO