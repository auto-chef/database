INSERT INTO tb_user (id_user, nm_user, ds_email, ds_password, dt_registration, dt_birth, nr_cpf)
VALUES (SEQ_TB_USER.NEXTVAL, 'João Silva', 'joao@example.com', 'senha123', TO_DATE('2024-04-07', 'YYYY-MM-DD'), TO_DATE('1990-01-15', 'YYYY-MM-DD'), '12345678901');
 
INSERT INTO tb_user (id_user, nm_user, ds_email, ds_password, dt_registration, dt_birth, nr_cpf)
VALUES (SEQ_TB_USER.NEXTVAL, 'Maria Souza', 'maria@example.com', 'senha456', TO_DATE('2024-04-07', 'YYYY-MM-DD'), TO_DATE('1985-06-20', 'YYYY-MM-DD'), '98765432109');
 
INSERT INTO tb_user (id_user, nm_user, ds_email, ds_password, dt_registration, dt_birth, nr_cpf)
VALUES (SEQ_TB_USER.NEXTVAL, 'Pedro Oliveira', 'pedro@example.com', 'senha789', TO_DATE('2024-04-07', 'YYYY-MM-DD'), TO_DATE('1995-11-30', 'YYYY-MM-DD'), '24680135792');
 
INSERT INTO tb_user (id_user, nm_user, ds_email, ds_password, dt_registration, dt_birth, nr_cpf)
VALUES (SEQ_TB_USER.NEXTVAL, 'Ana Carolina', 'ana@example.com', 'senha900', TO_DATE('2024-04-08', 'YYYY-MM-DD'), TO_DATE('2000-03-12', 'YYYY-MM-DD'), '36925814703');
 
INSERT INTO tb_user (id_user, nm_user, ds_email, ds_password, dt_registration, dt_birth, nr_cpf)
VALUES (SEQ_TB_USER.NEXTVAL, 'Bruno Mendes', 'bruno@example.com', 'senha012', TO_DATE('2024-04-08', 'YYYY-MM-DD'), TO_DATE('1988-08-21', 'YYYY-MM-DD'), '48107539614');
 
INSERT INTO tb_restaurant (id_restaurant, ds_password, ds_email, ds_image_url, nr_cnpj, nm_restaurant, nr_longitude, nr_latitude)
VALUES (SEQ_TB_RESTAURANT.NEXTVAL, 'restsenha123', 'restaurante@example.com', 'https://example.com/image.jpg', '12345678901234', 'Restaurante A', 40.7128, -74.0060);
 
INSERT INTO tb_restaurant (id_restaurant, ds_password, ds_email, ds_image_url, nr_cnpj, nm_restaurant, nr_longitude, nr_latitude)
VALUES (SEQ_TB_RESTAURANT.NEXTVAL, 'restsenha456', 'restaurante2@example.com', 'https://example.com/image2.jpg', '98765432109876', 'Restaurante B', 34.0522, -118.2437);
 
INSERT INTO tb_restaurant (id_restaurant, ds_password, ds_email, ds_image_url, nr_cnpj, nm_restaurant, nr_longitude, nr_latitude)
VALUES (SEQ_TB_RESTAURANT.NEXTVAL, 'restsenha789', 'restaurante3@example.com', 'https://example.com/image3.jpg', '24680135792468', 'Restaurante C', 51.5074, -0.1278);
 
INSERT INTO tb_restaurant (id_restaurant, ds_password, ds_email, ds_image_url, nr_cnpj, nm_restaurant, nr_longitude, nr_latitude)
VALUES (SEQ_TB_RESTAURANT.NEXTVAL, 'restsenha444', 'restaurante4@example.com', 'https://example.com/image4.jpg', '57319846201874', 'Restaurante D', 43.6532, -79.3832);
 
INSERT INTO tb_restaurant (id_restaurant, ds_password, ds_email, ds_image_url, nr_cnpj, nm_restaurant, nr_longitude, nr_latitude)
VALUES (SEQ_TB_RESTAURANT.NEXTVAL, 'restsenha555', 'restaurante5@example.com', 'https://example.com/image5.jpg', '68471239501247', 'Restaurante E', 29.4241, -98.5493);
 
INSERT INTO tb_product (id_product, id_restaurant, ds_image_url, nm_product, nr_price, ds_category)
VALUES (SEQ_TB_PRODUCT.NEXTVAL, 1, 'https://example.com/product.jpg', 'Produto 1', 10.50, 'Comida');
 
INSERT INTO tb_product (id_product, id_restaurant, ds_image_url, nm_product, nr_price, ds_category)
VALUES (SEQ_TB_PRODUCT.NEXTVAL, 1, 'https://example.com/product2.jpg', 'Produto 2', 8.75, 'Bebida');
 
INSERT INTO tb_product (id_product, id_restaurant, ds_image_url, nm_product, nr_price, ds_category)
VALUES (SEQ_TB_PRODUCT.NEXTVAL, 2, 'https://example.com/product3.jpg', 'Produto 3', 15.00, 'Sobremesa');
 
INSERT INTO tb_product (id_product, id_restaurant, ds_image_url, nm_product, nr_price, ds_category)
VALUES (SEQ_TB_PRODUCT.NEXTVAL, 1, 'https://example.com/product4.jpg', 'Produto 4', 12.00, 'Comida');
 
INSERT INTO tb_product (id_product, id_restaurant, ds_image_url, nm_product, nr_price, ds_category)
VALUES (SEQ_TB_PRODUCT.NEXTVAL, 2, 'https://example.com/product5.jpg', 'Produto 5', 7.50, 'Bebida');
 
INSERT INTO tb_order (id_order, id_user, id_restaurant, st_order, ds_feedback, nr_rate)
VALUES (SEQ_TB_ORDER.NEXTVAL, 1, 1, 'PENDING', 'Pedido aguardando confirmação', 4);
 
INSERT INTO tb_order (id_order, id_user, id_restaurant, st_order, ds_feedback, nr_rate)
VALUES (SEQ_TB_ORDER.NEXTVAL, 2, 2, 'ACCEPTED', 'Pedido confirmado e em preparo', 5);
 
INSERT INTO tb_order (id_order, id_user, id_restaurant, st_order, ds_feedback, nr_rate)
VALUES (SEQ_TB_ORDER.NEXTVAL, 3, 3, 'DELIVERED', 'Pedido entregue com sucesso', 4);
 
INSERT INTO tb_order (id_order, id_user, id_restaurant, st_order, ds_feedback, nr_rate)
VALUES (SEQ_TB_ORDER.NEXTVAL, 4, 1, 'PENDING', 'Novo pedido do usuário Ana Carolina', 3);
 
INSERT INTO tb_order (id_order, id_user, id_restaurant, st_order, ds_feedback, nr_rate)
VALUES (SEQ_TB_ORDER.NEXTVAL, 5, 2, 'DELIVERED', 'Pedido finalizado com sucesso', 5);
 
INSERT INTO tb_order_item (id_item, id_order, id_product, ds_order_chance, ds_amount)
VALUES (SEQ_TB_ORDER_ITEM.NEXTVAL, 1, 1, 'Sem cebola', 2);
 
INSERT INTO tb_order_item (id_item, id_order, id_product, ds_order_chance, ds_amount)
VALUES (SEQ_TB_ORDER_ITEM.NEXTVAL, 1, 2, NULL, 1);
 
INSERT INTO tb_order_item (id_item, id_order, id_product, ds_order_chance, ds_amount)
VALUES (SEQ_TB_ORDER_ITEM.NEXTVAL, 2, 3, 'Adicionar açúcar', 3);
 
INSERT INTO tb_order_item (id_item, id_order, id_product, ds_order_chance, ds_amount)
VALUES (SEQ_TB_ORDER_ITEM.NEXTVAL, 4, 1, 'Extra de molho', 1);
 
INSERT INTO tb_order_item (id_item, id_order, id_product, ds_order_chance, ds_amount)
VALUES (SEQ_TB_ORDER_ITEM.NEXTVAL, 5, 4, NULL, 2);
 
COMMIT;