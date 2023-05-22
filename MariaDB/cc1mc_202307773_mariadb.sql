-- Dropar tabelas e usuários caso existam.

DROP database IF EXISTS uvv;
DROP USER IF EXISTS william@localhost;

flush privileges;

-- Criação do user com permissões.

CREATE USER 'william'@'localhost' IDENTIFIED BY '';

-- Criação do banco de dados e uso.

CREATE database uvv;
use uvv;
GRANT ALL PRIVILEGES ON uvv TO 'william'@'localhost';

-- Tabelas

-- Tabela produtos

CREATE TABLE produtos (
                produto_id                         NUMERIC(38)                 NOT NULL,
                nome                               VARCHAR(255)                NOT NULL,
                preco_unitario                     NUMERIC(10,2),
                detalhes                           LONGBLOB,
                imagem                             LONGBLOB,
                imagem_mime_type                   VARCHAR(512),
                imagem_arquivo                     VARCHAR(512),
                imagem_charset                     VARCHAR(512),
                imagem_ultima_atualizacao          DATE,
                
                PRIMARY KEY (produto_id)
);

ALTER TABLE produtos                                                          COMMENT             'Tabela armazena os produtos cadastrados';
ALTER TABLE produtos MODIFY COLUMN produto_id                NUMERIC(38)      COMMENT              'PK da tabela, armazena o ID do produto.';
ALTER TABLE produtos MODIFY COLUMN nome                      VARCHAR(255)     COMMENT             'Coluna armazena o nome de cada produto.';
ALTER TABLE produtos MODIFY COLUMN preco_unitario            NUMERIC(10, 2)   COMMENT             'Coluna armazena o preço unitário de cada produto.';
ALTER TABLE produtos MODIFY COLUMN detalhes                  BLOB             COMMENT             'Coluna armazena os detalhes de cada produto.';
ALTER TABLE produtos MODIFY COLUMN imagem                    BLOB             COMMENT             'Coluna armazena a imagem de cada produto.';
ALTER TABLE produtos MODIFY COLUMN imagem_mime_type          VARCHAR(512)     COMMENT             'Coluna armazena o tipo e o subtipo do arquivo imagem.';
ALTER TABLE produtos MODIFY COLUMN imagem_arquivo            VARCHAR(512)     COMMENT             'Coluna armazena o arquivo da imagem.';
ALTER TABLE produtos MODIFY COLUMN imagem_charset            VARCHAR(512)     COMMENT             'Coluna armazena o charset da imagem.';
ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE             COMMENT             'Coluna armazena data da última atualização de foto.';


-- Tabela lojas

CREATE TABLE lojas (
                loja_id                                      NUMERIC(38)        NOT NULL,
                nome                                         VARCHAR(255)       NOT NULL,
                endereco_web                                 VARCHAR(100),
                endereco_fisico                              VARCHAR(512),
                latitude                                     NUMERIC,
                longitude                                    NUMERIC,
                logo                                         LONGBLOB,
                logo_mime_type                               VARCHAR(512),
                logo_arquivo                                 VARCHAR(512),
                logo_charset                                 VARCHAR(512),
                logo_ultima_atualizacao                      DATE,
                
                PRIMARY KEY (loja_id)
);

ALTER TABLE lojas                                                              COMMENT             'Tabela que mostra os dados da loja cadastrada.';
ALTER TABLE lojas MODIFY COLUMN loja_id                      NUMERIC(38)       COMMENT             'PK da tabela que identifica o ID da loja.';
ALTER TABLE lojas MODIFY COLUMN nome                         VARCHAR(255)      COMMENT             'Coluna mostra o nome da loja cadastrada.';
ALTER TABLE lojas MODIFY COLUMN endereco_web                 VARCHAR(100)      COMMENT             'Coluna mostra o endereço web registrado da loja.';
ALTER TABLE lojas MODIFY COLUMN endereco_fisico              VARCHAR(512)      COMMENT             'Coluna mostra o endereço físico cadastrado da loja.';
ALTER TABLE lojas MODIFY COLUMN latitude                     NUMERIC           COMMENT             'Coluna mostra a latitude geográfica da loja cadastrada.';
ALTER TABLE lojas MODIFY COLUMN longitude                    NUMERIC           COMMENT             'Coluna mostra a longitude geográfica da loja cadastrada.';
ALTER TABLE lojas MODIFY COLUMN logo                         BLOB              COMMENT             'Coluna armazena a logo da loja cadastrada.';
ALTER TABLE lojas MODIFY COLUMN logo_mime_type               VARCHAR(512)      COMMENT             'btipo do arquivo imagem.';
ALTER TABLE lojas MODIFY COLUMN logo_arquivo                 VARCHAR(512)      COMMENT             'Coluna armazena o arquivo da logo.';
ALTER TABLE lojas MODIFY COLUMN logo_charset                 VARCHAR(512)      COMMENT             'Coluna armazena o charset da logo, desde a ASCII para UTF-8.';
ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao      DATE              COMMENT             'Coluna armazena a data da última atualização da logo.';


-- Tabela estoques

CREATE TABLE estoques (
                estoque_id                               NUMERIC(38)        NOT NULL,
                loja_id                                  NUMERIC(38)        NOT NULL,
                produto_id                               NUMERIC(38)        NOT NULL,
                quantidade                               NUMERIC(38)        NOT NULL,
                
                PRIMARY KEY (estoque_id)
);

ALTER TABLE estoques                                                COMMENT                       'Tabela armazena produtos e quantidades de produtos em estoque.';
ALTER TABLE estoques MODIFY COLUMN estoque_id           NUMERIC(38) COMMENT                       'PK da tabela com o ID do estoque.';
ALTER TABLE estoques MODIFY COLUMN loja_id              NUMERIC(38) COMMENT                       'PK da tabela que identifica o ID da loja.';
ALTER TABLE estoques MODIFY COLUMN produto_id           NUMERIC(38) COMMENT                       'Coluna armazena o ID do produto.';
ALTER TABLE estoques MODIFY COLUMN quantidade           NUMERIC(38) COMMENT                       'Coluna armazena a quantidade de produtos.';


-- Tabela clientes

CREATE TABLE clientes (
                cliente_id                                 NUMERIC(38)     NOT NULL,
                email                                      VARCHAR(255)    NOT NULL,
                nome                                       VARCHAR(255)    NOT NULL,
                telefone1                                  VARCHAR(20),
                telefone2                                  VARCHAR(20),
                telefone3                                  VARCHAR(20),
                
                PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes                                                 COMMENT                       'Tabela que identifica os dados pessoais dos clientes cadastrados.';
ALTER TABLE clientes MODIFY COLUMN cliente_id          NUMERIC(38)   COMMENT                       'PK da tabela identifica o ID de cada cliente.';
ALTER TABLE clientes MODIFY COLUMN email               VARCHAR(255)  COMMENT                       'E-mail de cada cliente cadastrado.';
ALTER TABLE clientes MODIFY COLUMN nome                VARCHAR(255)  COMMENT                       'Identifica o nome completo de cada cliente.';
ALTER TABLE clientes MODIFY COLUMN telefone1           VARCHAR(20)   COMMENT                       'Primeiro telefone de contato para o cliente.';
ALTER TABLE clientes MODIFY COLUMN telefone2           VARCHAR(20)   COMMENT                       'Segundo telefone de contato para o cliente.';
ALTER TABLE clientes MODIFY COLUMN telefone3           VARCHAR(20)   COMMENT                       'Terceiro telefone de contato para o cliente.';


-- Tabela envios

CREATE TABLE envios (
                envio_id                              NUMERIC(38)  NOT NULL,
                loja_id                               NUMERIC(38)  NOT NULL,
                cliente_id                            NUMERIC(38)  NOT NULL,
                endereco_entrega                      VARCHAR(512) NOT NULL,
                status                                VARCHAR(15)  NOT NULL,
                PRIMARY KEY (envio_id)
);

ALTER TABLE envios                                                     COMMENT                       'Tabela armazena os dados relacionados ao envio de pedidos dos clientes.';
ALTER TABLE envios MODIFY COLUMN envio_id          NUMERIC(38)         COMMENT                       'PK da tabela com o ID de cada envio.';
ALTER TABLE envios MODIFY COLUMN loja_id           NUMERIC(38)         COMMENT                       'PK da tabela que identifica o ID da loja.';
ALTER TABLE envios MODIFY COLUMN cliente_id        NUMERIC(38)         COMMENT                       'PK da tabela identifica o ID de cada cliente.';
ALTER TABLE envios MODIFY COLUMN endereco_entrega  VARCHAR(512)        COMMENT                       'Coluna mostra o endereço de entrega do pedido enviado.';
ALTER TABLE envios MODIFY COLUMN status            VARCHAR(15)         COMMENT                       'Coluna mostra o status do pedido enviado.';


-- Tabela pedidos

CREATE TABLE pedidos (
                pedido_id                       NUMERIC(38)  NOT NULL,
                data_hora                       DATETIME     NOT NULL,
                cliente_id                      NUMERIC(38)  NOT NULL,
                status                          VARCHAR(15)  NOT NULL,
                loja_id                         NUMERIC(38)  NOT NULL,
                
                PRIMARY KEY (pedido_id)
);

ALTER TABLE pedidos                                               COMMENT                       'Tabela de pedidos realizados pela tabela Clientes.';
ALTER TABLE pedidos MODIFY COLUMN pedido_id         NUMERIC(38)   COMMENT                       'PK da tabela, armazena o id dos pedidos.';
ALTER TABLE pedidos MODIFY COLUMN data_hora         TIMESTAMP     COMMENT                       'Coluna registra a data e hora do pedido feito.';
ALTER TABLE pedidos MODIFY COLUMN cliente_id        NUMERIC(38)   COMMENT                       'FK da tabela identifica o ID de cada cliente.';
ALTER TABLE pedidos MODIFY COLUMN status            VARCHAR(15)   COMMENT                       'Coluna da tabela identifica o status do pedido.';
ALTER TABLE pedidos MODIFY COLUMN loja_id           NUMERIC(38)   COMMENT                       'FK da tabela identifica o ID da loja.';


-- Tabela pedidos_itens

CREATE TABLE pedidos_itens (
                pedido_id                          NUMERIC(38)   NOT NULL,
                produto_id                         NUMERIC(38)   NOT NULL,
                quantidade                         NUMERIC(38)   NOT NULL,
                numero_da_linha                    VARCHAR(38)   NOT NULL,
                preco_unitario                     NUMERIC(10,2) NOT NULL,
                envio_id                           NUMERIC(38),
                
                PRIMARY KEY (pedido_id, produto_id)
);

ALTER TABLE pedidos_itens                                                  COMMENT                       'Tabela mostra os itens dos pedidos relacionados a tabela envios.';
ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id           NUMERIC(38)    COMMENT                       'PFK da tabela, armazena o ID de cada pedido.';
ALTER TABLE pedidos_itens MODIFY COLUMN produto_id          NUMERIC(38)    COMMENT                       'PFK da tabela, armazena o ID de cada produto.';
ALTER TABLE pedidos_itens MODIFY COLUMN quantidade          NUMERIC(38)    COMMENT                       'Coluna armazena a quantidade de produtos de um pedido.';
ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha     VARCHAR(38)    COMMENT                       'Coluna armazena o número da linha do pedido.';
ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario      NUMERIC(10, 2) COMMENT                       'Coluna armazena o preço unitário de cada produto.';
ALTER TABLE pedidos_itens MODIFY COLUMN envio_id            NUMERIC(38)    COMMENT                       'PK da tabela com o ID de cada envio.';

-- Restrições

ALTER TABLE produtos
ADD CONSTRAINT uvv_lojas_produtos_preco
CHECK (preco_unitario  >= 0);

ALTER TABLE pedidos_itens
ADD CONSTRAINT uvv_lojas_pedidos_itens_preco
CHECK (preco_unitario  >= 0);

ALTER TABLE lojas
ADD CONSTRAINT uvv_lojas_lojas_umououtro
CHECK ((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL));

ALTER TABLE estoques
ADD CONSTRAINT uvv_lojas_estoques_quantidade
CHECK (quantidade  >= 0);

ALTER TABLE pedidos_itens
ADD CONSTRAINT uvv_lojas_pedidos_itens_quantidade
CHECK (quantidade  >= 0);

-- FK's


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
