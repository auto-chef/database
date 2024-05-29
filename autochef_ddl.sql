-- APAGA TODAS AS TABELAS E SEUS CONTEÚDOS PARA EVITAR CONFLITOS COM TABELAS JÁ EXISTENTES

DROP TABLE tb_order CASCADE CONSTRAINTS;
DROP TABLE tb_order_item CASCADE CONSTRAINTS;
DROP TABLE tb_product CASCADE CONSTRAINTS;
DROP TABLE tb_restaurant CASCADE CONSTRAINTS;
DROP TABLE tb_user CASCADE CONSTRAINTS;

-- APAGA TODAS AS SEQUENCES
DROP SEQUENCE SEQ_TB_USER;
DROP SEQUENCE SEQ_TB_ORDER;
DROP SEQUENCE SEQ_TB_ORDER_ITEM;
DROP SEQUENCE SEQ_TB_RESTAURANT;
DROP SEQUENCE SEQ_TB_PRODUCT;

-- CRIAÇÃO DE TABELAS

-- TABELA DO USUÁRIO
CREATE TABLE tb_user (
    id_user         NUMBER(*, 0) NOT NULL,
    nm_user         VARCHAR2(255) NOT NULL,
    ds_email        VARCHAR2(255) NOT NULL UNIQUE,
    ds_password     VARCHAR2(255) NOT NULL,
    dt_registration DATE NOT NULL,
    dt_birth        DATE NOT NULL,
    nr_cpf          VARCHAR2(11) NOT NULL UNIQUE
);
 
COMMENT ON COLUMN tb_user.id_user IS
    'This attribute will prescribe the user id, and will be mandatory and primary';
 
COMMENT ON COLUMN tb_user.nm_user IS
    'This attribute will prescube the name user, and will be mandatory';
 
COMMENT ON COLUMN tb_user.ds_email IS
    'This attribute will prescribe the user''s email, and will be mandatory';
 
COMMENT ON COLUMN tb_user.ds_password IS
    'This attribute will prescribe the user''s password, and will be mandatory';
 
COMMENT ON COLUMN tb_user.dt_registration IS
    'This attribute will prescribe the user''s registration date, and will be mandatory';
 
COMMENT ON COLUMN tb_user.dt_birth IS
    'This attribute will prescribe the user''s birthday, and will be mandatory';
 
COMMENT ON COLUMN tb_user.nr_cpf IS
    'This attribute will prescribe the user''s CPF, and will be mandatory';
 
-- TABELA DO RESTAURANTE
CREATE TABLE tb_restaurant (
    id_restaurant NUMBER(*, 0) NOT NULL,
    ds_password   VARCHAR2(255) NOT NULL,
    ds_email      VARCHAR2(255) NOT NULL UNIQUE,
    ds_image_url  VARCHAR2(255) NOT NULL,
    nr_cnpj       VARCHAR2(14) NOT NULL UNIQUE,
    nm_restaurant VARCHAR2(255) NOT NULL,
    nr_longitude  FLOAT(2) NOT NULL,
    nr_latitude   FLOAT(2) NOT NULL
);
 
COMMENT ON COLUMN tb_restaurant.id_restaurant IS
    'This attribute will prescribe the Restaurant  id, and will be mandatory and primary';
 
COMMENT ON COLUMN tb_restaurant.ds_password IS
    'This attribute will prescribe the Restaurant''s password, and will be mandatory';
 
COMMENT ON COLUMN tb_restaurant.ds_email IS
    'This attribute will prescribe the Restaurant''s email, and will be mandatory';
 
COMMENT ON COLUMN tb_restaurant.ds_image_url IS
    'This attribute will receive the URL of the restaurant image, being mandatory';
 
COMMENT ON COLUMN tb_restaurant.nr_cnpj IS
    'This attribute will receive the restaurant''s CNPJ number, being mandatory';
 
COMMENT ON COLUMN tb_restaurant.nm_restaurant IS
    'This attribute will receive the name of the restaurant, being mandatory';
 
COMMENT ON COLUMN tb_restaurant.nr_longitude IS
    'This attribute will receive the longitude of the restaurant, being mandatory';
 
COMMENT ON COLUMN tb_restaurant.nr_latitude IS
    'This attribute will receive the latitude of the restaurant, being mandatory';
 
ALTER TABLE tb_restaurant ADD CONSTRAINT tb_retaurant_pk PRIMARY KEY ( id_restaurant );
 
-- TABELA DO PRODUTO
CREATE TABLE tb_product (
    id_product    NUMBER(*, 0) NOT NULL,
    id_restaurant NUMBER(*, 0) NOT NULL,
    ds_image_url  VARCHAR2(255) NOT NULL,
    nm_product    VARCHAR2(255) NOT NULL,
    nr_price      NUMBER(5, 2) NOT NULL,
    ds_category   VARCHAR2(255) NOT NULL
);
 
COMMENT ON COLUMN tb_product.ds_image_url IS
    'This attribute will receive the URL of the product image, being mandatory';
 
COMMENT ON COLUMN tb_product.nm_product IS
    'This attribute will receive the name of the product, being mandatory';
 
COMMENT ON COLUMN tb_product.nr_price IS
    'This attribute will receive the price of the product, being mandatory';
 
COMMENT ON COLUMN tb_product.ds_category IS
    'This attribute will receive the product type, being mandatory';
 
ALTER TABLE tb_product ADD CONSTRAINT tb_product_pk PRIMARY KEY ( id_product );
 
-- TABELA DOS ITEMS DE PEDIDO
CREATE TABLE tb_order_item (
    id_item         NUMBER(*, 0) NOT NULL,
    id_order        NUMBER(*, 0) NOT NULL,
    id_product      NUMBER(*, 0) NOT NULL,
    ds_order_chance VARCHAR2(255),
    ds_amount       NUMBER(3)
);
 
COMMENT ON COLUMN tb_order_item.ds_order_chance IS
    'This attribute will receive changes to the order';
 
COMMENT ON COLUMN tb_order_item.ds_amount IS
    'This attribute will receive the number of changes for each product';
 
ALTER TABLE tb_order_item ADD CONSTRAINT tb_order_item_pk PRIMARY KEY ( id_item );
 
-- TABELA DE PEDIDO
CREATE TABLE tb_order (
    id_order      NUMBER(*, 0) NOT NULL,
    id_user       NUMBER(*, 0) NOT NULL,
    id_restaurant NUMBER(*, 0) NOT NULL,
    st_order      VARCHAR2(255) NOT NULL,
    ds_feedback   VARCHAR2(355),
    nr_rate       NUMBER(1)
);
 
ALTER TABLE tb_order
    ADD CONSTRAINT status CHECK ( st_order IN ( 'ACCEPTED', 'DELIVERED', 'PENDING', 'REJECTED' ) );
 
COMMENT ON COLUMN tb_order.id_order IS
    'This attribute will prescribe the order, and will be mandatory and primary';
 
COMMENT ON COLUMN tb_order.st_order IS
    'This attribute will receive the Status of the order, namely PENDING, ACCEPTED, REJECTED, DELIVERED. This attribute is mandatory'
    ;
 
COMMENT ON COLUMN tb_order.ds_feedback IS
    'This attribute will receive the feedback description, being mandatory';
 
COMMENT ON COLUMN tb_order.nr_rate IS
    'This attribute will receive the user''s rating, being mandatory';
 
ALTER TABLE tb_order ADD CONSTRAINT tb_oder_pk PRIMARY KEY ( id_order );
 
ALTER TABLE tb_user ADD CONSTRAINT tb_usuario_pk PRIMARY KEY ( id_user );
 
ALTER TABLE tb_order_item
    ADD CONSTRAINT fk_order_od_item FOREIGN KEY ( id_order )
        REFERENCES tb_order ( id_order ) ON DELETE CASCADE;
 
ALTER TABLE tb_order_item
    ADD CONSTRAINT fk_prod_od_item FOREIGN KEY ( id_product )
        REFERENCES tb_product ( id_product ) ON DELETE CASCADE;
 
ALTER TABLE tb_order
    ADD CONSTRAINT fk_rest_order FOREIGN KEY ( id_restaurant )
        REFERENCES tb_restaurant ( id_restaurant ) ON DELETE CASCADE;
 
ALTER TABLE tb_product
    ADD CONSTRAINT fk_rest_prod FOREIGN KEY ( id_restaurant )
        REFERENCES tb_restaurant ( id_restaurant ) ON DELETE CASCADE;
 
ALTER TABLE tb_order
    ADD CONSTRAINT fk_usuario_order FOREIGN KEY ( id_user )
        REFERENCES tb_user ( id_user ) ON DELETE CASCADE;
        
        
 
CREATE SEQUENCE SEQ_TB_USER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999
    CYCLE;

CREATE SEQUENCE SEQ_TB_ORDER
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999
    CYCLE;
    
CREATE SEQUENCE SEQ_TB_ORDER_ITEM
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999
    CYCLE;

CREATE SEQUENCE SEQ_TB_RESTAURANT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999
    CYCLE;
    
CREATE SEQUENCE SEQ_TB_PRODUCT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999999999
    CYCLE;