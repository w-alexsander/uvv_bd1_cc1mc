-- Remoção do usuário, role, schema e database caso existam.

drop database                                 if exists uvv;
drop schema                                   if exists lojas cascade;
drop role                                     if exists william;

-- Criação do usuário.


CREATE USER  william
     with
     LOGIN
     SUPERUSER
     INHERIT
     CREATEDB
     CREATEROLE
     REPLICATION
     PASSWORD '123456';
 
-- Utilizar meu usuário  
    
 SET ROLE william;

    
-- Criação do database. 

CREATE DATABASE uvv     with
    OWNER  =             william
    ENCODING =          'UTF8'
    LC_COLLATE =        'pt_BR.UTF-8'
    LC_CTYPE =          'pt_BR.UTF-8'
    ALLOW_CONNECTIONS =  'TRUE'
    TEMPLATE = 'template0';

   
COMMENT ON DATABASE uvv                        IS 'Banco de dados UVV com o usuário WIlliam.';
GRANT ALL ON DATABASE uvv                      TO  william;

-- Conexão BD

\setenv PGPASSWORD 123456
\c uvv william;

-- Criação do schema e setagem.

CREATE SCHEMA lojas
AUTHORIZATION william;
ALTER SCHEMA  lojas  OWNER TO william;
ALTER USER                   william
SET SEARCH_PATH TO lojas, "$user", public;

-- TAbela Produtos.


CREATE TABLE lojas.produtos (
                produto_id                    NUMERIC(38)     NOT NULL,
                nome                          VARCHAR(255)    NOT NULL,
                preco_unitario                NUMERIC(10,2)               CONSTRAINT check_preco CHECK (preco_unitario >= 0),
                detalhes                      BYTEA,
                imagem                        BYTEA,
                imagem_mime_type              VARCHAR(512),
                imagem_arquivo                VARCHAR(512),
                imagem_charset                VARCHAR(512),
                imagem_ultima_atualizacao     DATE,
                
                CONSTRAINT produto_pk PRIMARY KEY (produto_id)     
);

ALTER TABLE lojas.produtos        OWNER TO       William;

COMMENT ON TABLE  lojas.produtos                           IS 'Tabela armazena os produtos cadastrados';
COMMENT ON COLUMN lojas.produtos.produto_id                IS 'PK da tabela, armazena o ID do produto.';
COMMENT ON COLUMN lojas.produtos.nome                      IS 'Coluna armazena o nome de cada produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS 'Coluna armazena o preço unitário de cada produto.';
COMMENT ON COLUMN lojas.produtos.detalhes                  IS 'Coluna armazena os detalhes de cada produto.';
COMMENT ON COLUMN lojas.produtos.imagem                    IS 'Coluna armazena a imagem de cada produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS 'Coluna armazena o tipo e o subtipo do arquivo imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS 'Coluna armazena o arquivo da imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_charset            IS 'Coluna armazena o charset da imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Coluna armazena a data da última atualização da imagem do produto.';

-- Tabela Lojas.

CREATE TABLE lojas.lojas (
                loja_id                          NUMERIC(38)   NOT NULL       CONSTRAINT check_loja_id UNIQUE,
                nome                             VARCHAR(255)  NOT NULL,
                endereco_web                     VARCHAR(100)                 CONSTRAINT check_preenchimento CHECK ((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL)),
                endereco_fisico                  VARCHAR(512),
                latitude                         NUMERIC,
                longitude                        NUMERIC,
                logo                             BYTEA,
                logo_mime_type                   VARCHAR(512),
                logo_arquivo                     VARCHAR(512),
                logo_charset                     VARCHAR(512),
                logo_ultima_atualizacao          DATE,
                
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
               
);

ALTER TABLE lojas.lojas                 OWNER TO William;


COMMENT ON TABLE  lojas.lojas                          IS 'Tabela que mostra os dados da loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.loja_id                  IS 'PK da tabela que identifica o ID da loja.';
COMMENT ON COLUMN lojas.lojas.nome                     IS 'Coluna mostra o nome da loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.endereco_web             IS 'Coluna mostra o endereço web registrado da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico          IS 'Coluna mostra o endereço físico cadastrado da loja.';
COMMENT ON COLUMN lojas.lojas.latitude                 IS 'Coluna mostra a latitude geográfica da loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.longitude                IS 'Coluna mostra a longitude geográfica da loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.logo                     IS 'Coluna armazena a logo da loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type           IS 'btipo do arquivo imagem.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo             IS 'Coluna armazena o arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset             IS 'Coluna armazena o charset da logo, desde a ASCII para UTF-8.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao  IS 'Coluna armazena a data da última atualização da logo.';

-- Tabela Estoques.

CREATE TABLE lojas.estoques (
                estoque_id                         NUMERIC(38)       NOT null      CONSTRAINT check_loja_id            UNIQUE,
                loja_id                            NUMERIC(38)       NOT null      CONSTRAINT check_loja_id_estoque    UNIQUE, 
                produto_id                         NUMERIC(38)       NOT null      CONSTRAINT check_loja_id            UNIQUE,
                quantidade                         NUMERIC(38)       NOT NULL      CONSTRAINT check_quantidade_estoque CHECK (quantidade > 0),
                
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

ALTER TABLE lojas.estoques                OWNER TO William;


COMMENT ON TABLE lojas.estoques                       IS 'Tabela armazena produtos e quantidades de produtos em estoque.';
COMMENT ON COLUMN lojas.estoques.estoque_id           IS 'PK da tabela com o ID do estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id              IS 'PK da tabela que identifica o ID da loja.';
COMMENT ON COLUMN lojas.estoques.produto_id           IS 'Coluna armazena o ID do produto.';
COMMENT ON COLUMN lojas.estoques.quantidade           IS 'Coluna armazena a quantidade de produtos.';

-- Tabela Clientes.

CREATE TABLE lojas.clientes (
                cliente_id                         NUMERIC(38)       NOT NULL     CONSTRAINT check_cliente_id       UNIQUE,
                email                              VARCHAR(255)      NOT NULL     CONSTRAINT check_email            UNIQUE,
                nome                               VARCHAR(255)      NOT NULL,
                telefone1                          VARCHAR(20),
                telefone2                          VARCHAR(20),
                telefone3                          VARCHAR(20),
                
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

ALTER TABLE lojas.clientes               OWNER TO William;


COMMENT ON TABLE lojas.clientes                      IS 'Tabela que identifica os dados pessoais dos clientes cadastrados.';
COMMENT ON COLUMN lojas.clientes.cliente_id          IS 'PK da tabela identifica o ID de cada cliente.';
COMMENT ON COLUMN lojas.clientes.email               IS 'E-mail de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.clientes.nome                IS 'Identifica o nome completo de cada cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1           IS 'Primeiro telefone de contato para o cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2           IS 'Segundo telefone de contato para o cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3           IS 'Terceiro telefone de contato para o cliente.';

-- Tabela  Envios.

CREATE TABLE lojas.envios (
                envio_id                         NUMERIC(38)       NOT NULL      CONSTRAINT check_envio_id            UNIQUE,
                loja_id                          NUMERIC(38)       NOT NULL      CONSTRAINT check_loja_id_envios      UNIQUE,
                cliente_id                       NUMERIC(38)       NOT NULL      CONSTRAINT check_cliente_id_envios   UNIQUE,
                endereco_entrega                 VARCHAR(512)      NOT NULL,
                status                           VARCHAR(15)       NOT NULL,
                
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

ALTER TABLE lojas.envios                OWNER TO William;


COMMENT ON TABLE lojas.envios                        IS 'Tabela armazena os dados relacionados ao envio de pedidos dos clientes.';
COMMENT ON COLUMN lojas.envios.envio_id              IS 'PK da tabela com o ID de cada envio.';
COMMENT ON COLUMN lojas.envios.loja_id               IS 'PK da tabela que identifica o ID da loja.';
COMMENT ON COLUMN lojas.envios.cliente_id            IS 'PK da tabela identifica o ID de cada cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega      IS 'Coluna mostra o endereço de entrega do pedido enviado.';
COMMENT ON COLUMN lojas.envios.status                IS 'Coluna mostra o status do pedido enviado.';

-- Tabela Pedidos.

CREATE TABLE lojas.pedidos (
                pedido_id                       NUMERIC(38)    NOT NULL      CONSTRAINT check_pedido_id_pedidos   UNIQUE,
                data_hora                       TIMESTAMP      NOT NULL,
                cliente_id                      NUMERIC(38)    NOT NULL      CONSTRAINT check_cliente_id_pedidos  UNIQUE,
                status                          VARCHAR(15)    NOT NULL, 
                loja_id                         NUMERIC(38)    NOT NULL      CONSTRAINT check_loja_id_pedidos     UNIQUE,
                
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

ALTER TABLE lojas.pedidos              OWNER TO William;


COMMENT ON TABLE lojas.pedidos                    IS 'Tabela de pedidos realizados pela tabela Clientes.';
COMMENT ON COLUMN lojas.pedidos.pedido_id         IS 'PK da tabela, mostra o ID de cada pedido';
COMMENT ON COLUMN lojas.pedidos.data_hora         IS 'Coluna registra a data e hora do pedido feito.';
COMMENT ON COLUMN lojas.pedidos.cliente_id        IS 'FK da tabela identifica o ID de cada cliente.';
COMMENT ON COLUMN lojas.pedidos.status            IS 'Coluna da tabela identifica o status do pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id           IS 'FK da tabela identifica o ID da loja.';

-- Tabela Pedidos Itens.

CREATE TABLE lojas.pedidos_itens (
                pedido_id                       NUMERIC(38)     NOT NULL       CONSTRAINT check_pedido_id_itens  UNIQUE,
                produto_id                      NUMERIC(38)     NOT NULL       CONSTRAINT check_produto_id_itens UNIQUE,      
                quantidade                      NUMERIC(38)     NOT NULL       CONSTRAINT check_quantidade_ITENS CHECK (quantidade > 0),
                envio_id                        NUMERIC(38)     NOT NULL       CONSTRAINT check_envio_id_itens   UNIQUE,
                numero_da_linha                 VARCHAR(38)     NOT NULL,
                preco_unitario                  NUMERIC(10,2)   NOT NULL       CONSTRAINT check_preco_itens      CHECK (preco_unitario >= 0),
                
                CONSTRAINT pedido_id_1 PRIMARY KEY (pedido_id, produto_id)
);

ALTER TABLE lojas.pedidos_itens          OWNER TO William;


COMMENT ON TABLE lojas.pedidos_itens                       IS 'Tabela mostra os itens dos pedidos relacionados a tabela envios.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id            IS 'PFK da tabela, armazena o ID de cada pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id           IS 'PFK da tabela, armazena o ID de cada produto.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade           IS 'Coluna armazena a quantidade de produtos de um pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id             IS 'PK da tabela com o ID de cada envio.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha      IS 'Coluna armazena o número da linha do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario       IS 'Coluna armazena o preço unitário de cada produto.';

-- Restrições fora das tabelas acimas

ALTER TABLE lojas.envios
ADD CONSTRAINT check_status_envios 
CHECK (status IN ('Cancelado', 'Completo', 'Aberto', 'Pago', 'Reembolsado', 'Enviado'));


ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status_pedidos 
CHECK (status IN ('Criado', 'Enviado', 'Entregue', 'Em trânsito'));



-- FK'S


ALTER TABLE lojas.estoques                                       ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens                                  ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos                                        ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios                                         ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques                                       ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos                                        ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios                                         ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens                                  ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens                                  ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
