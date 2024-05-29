DROP FUNCTION f_cpf_validation;
DROP FUNCTION f_cnpj_validation;
DROP FUNCTION f_validate_tb_user;
DROP FUNCTION f_validate_tb_order;
DROP FUNCTION f_validate_tb_order_item;
DROP FUNCTION f_validate_tb_product;
DROP FUNCTION f_validate_tb_restaurant;

DROP PROCEDURE add_user;
DROP PROCEDURE remove_user;
DROP PROCEDURE update_user;

DROP PROCEDURE add_order;
DROP PROCEDURE remove_order;
DROP PROCEDURE update_order;

DROP PROCEDURE add_order_item;
DROP PROCEDURE remove_order_item;
DROP PROCEDURE update_order_item;

DROP PROCEDURE add_product;
DROP PROCEDURE remove_product;
DROP PROCEDURE update_product;

DROP PROCEDURE add_restaurant;
DROP PROCEDURE remove_restaurant;
DROP PROCEDURE update_restaurant;

DROP PROCEDURE most_requested_product_by_customer;
DROP PROCEDURE not_delivered_orders;

DROP TABLE tb_order CASCADE CONSTRAINTS;
DROP TABLE tb_order_item CASCADE CONSTRAINTS;
DROP TABLE tb_product CASCADE CONSTRAINTS;
DROP TABLE tb_restaurant CASCADE CONSTRAINTS;
DROP TABLE tb_user CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_TB_USER;
DROP SEQUENCE SEQ_TB_ORDER;
DROP SEQUENCE SEQ_TB_ORDER_ITEM;
DROP SEQUENCE SEQ_TB_RESTAURANT;
DROP SEQUENCE SEQ_TB_PRODUCT;
