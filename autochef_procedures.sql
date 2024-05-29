SET SERVEROUTPUT ON;

-- PROCEDURES DA TABELA TB_USER

-- INSERT

CREATE OR REPLACE PROCEDURE add_user (
    p_nm_user           IN    tb_user.nm_user%TYPE,
    p_ds_email          IN    tb_user.ds_email%TYPE,
    p_ds_password       IN    tb_user.ds_password%TYPE,
    p_dt_registration   IN    tb_user.dt_registration%TYPE,
    p_dt_birth          IN    tb_user.dt_birth%TYPE,
    p_nr_cpf            IN    tb_user.nr_cpf%TYPE,
    p_result            OUT   INT
) IS
BEGIN
    IF f_validate_tb_user(p_ds_email, p_ds_password, p_dt_registration, p_nr_cpf, p_dt_birth) <> false THEN
        INSERT INTO tb_user (
            id_user,
            nm_user,
            ds_email,
            ds_password,
            dt_birth,
            dt_registration,
            nr_cpf
        ) VALUES (
            seq_tb_user.NEXTVAL,
            p_nm_user,
            p_ds_email,
            p_ds_password,
            p_dt_birth,
            p_dt_registration,
            p_nr_cpf
        );

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    add_user('Lucas Araujo', 'lucas@gmail.com', 'Fiap@2024', '01/05/24', '09/11/01',
             '19599185080', v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Inserção de usuário realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na inserção de usuário');
    END IF;
END;

-- DELETE

CREATE OR REPLACE PROCEDURE remove_user (
    p_id_user   IN    tb_user.id_user%TYPE,
    p_result    OUT   INT
) IS
BEGIN
    DELETE FROM tb_user tbu
    WHERE
        tbu.id_user = p_id_user;

    COMMIT;
    p_result := 1;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    remove_user(6, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Remoção de usuário realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na remoção de usuário');
    END IF;
END;

-- UPDATE

CREATE OR REPLACE PROCEDURE update_user (
    p_id_user           IN    tb_user.id_user%TYPE,
    p_nm_user           IN    tb_user.nm_user%TYPE,
    p_ds_email          IN    tb_user.ds_email%TYPE,
    p_ds_password       IN    tb_user.ds_password%TYPE,
    p_dt_registration   IN    tb_user.dt_registration%TYPE,
    p_dt_birth          IN    tb_user.dt_birth%TYPE,
    p_nr_cpf            IN    tb_user.nr_cpf%TYPE,
    p_result            OUT   INT
) IS
BEGIN
    IF f_validate_tb_user(p_ds_email, p_ds_password, p_dt_registration, p_nr_cpf, p_dt_birth) <> false THEN
        UPDATE tb_user tbu
        SET
            tbu.nm_user = p_nm_user,
            tbu.ds_email = p_ds_email,
            tbu.ds_password = p_ds_password,
            tbu.dt_registration = p_dt_registration,
            tbu.nr_cpf = p_nr_cpf,
            tbu.dt_birth = p_dt_birth
        WHERE
            tbu.id_user = p_id_user;

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    update_user(10, 'Lucas Araujo (EDITADO)', 'lucas@gmail.com', '2024@Fiap', '01/05/24',
                '09/11/04', '77941949032', v_result);

    IF v_result = 1 THEN
        dbms_output.put_line('Atualização de usuário realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na atualização de usuário');
    END IF;

END;


-- PROCEDURES DA TABELA TB_ORDER

-- INSERT

CREATE OR REPLACE PROCEDURE add_order (
    p_id_user         IN    tb_order.id_user%TYPE,
    p_id_restaurant   IN    tb_order.id_restaurant%TYPE,
    p_st_order        IN    tb_order.st_order%TYPE,
    p_result          OUT   INT
) IS
BEGIN
    IF f_validate_tb_order(p_id_user, p_id_restaurant, p_st_order) <> false THEN
        INSERT INTO tb_order (
            id_order,
            id_user,
            id_restaurant,
            st_order
        ) VALUES (
            seq_tb_order.NEXTVAL,
            p_id_user,
            p_id_restaurant,
            p_st_order
        );

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    add_order(4, 2, 'DELIVERED', v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Inserção de pedido realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na inserção de pedido');
    END IF;

END;

-- DELETE

CREATE OR REPLACE PROCEDURE remove_order (
    p_id_order   IN    tb_order.id_order%TYPE,
    p_result     OUT   INT
) IS
BEGIN
    DELETE FROM tb_order tbo
    WHERE
        tbo.id_order = p_id_order;

    COMMIT;
    p_result := 1;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    remove_order(7, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Remoção de pedido realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na remoção de pedido');
    END IF;
END;

-- UPDATE

CREATE OR REPLACE PROCEDURE update_order (
    p_id_order        IN    tb_order.id_order%TYPE,
    p_id_user         IN    tb_order.id_user%TYPE,
    p_id_restaurant   IN    tb_order.id_restaurant%TYPE,
    p_st_order        IN    tb_order.st_order%TYPE,
    p_ds_feedback     IN    tb_order.ds_feedback%TYPE,
    p_nr_rate         IN    tb_order.nr_rate%TYPE,
    p_result          OUT   INT
) IS
BEGIN
    IF f_validate_tb_order(p_id_user, p_id_restaurant, p_st_order) <> false THEN
        UPDATE tb_order tbo
        SET
            tbo.id_user = p_id_user,
            tbo.id_restaurant = p_id_restaurant,
            tbo.st_order = p_st_order,
            tbo.ds_feedback = p_ds_feedback,
            tbo.nr_rate = p_nr_rate
        WHERE
            tbo.id_order = p_id_order;

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    update_order(2, 2, 5, 'DELIVERED', 'Refeição muito bem preparada!',
                 4, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Atualização de pedido realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na atualização de pedido');
    END IF;

END;



-- PROCEDURES DA TABELA TB_ORDER_ITEM

-- INSERT

CREATE OR REPLACE PROCEDURE add_order_item (
    p_id_order     IN    tb_order_item.id_order%TYPE,
    p_id_product   IN    tb_order_item.id_product%TYPE,
    p_result       OUT   INT
) IS
BEGIN
    IF f_validate_tb_order_item(p_id_order, p_id_product) <> false THEN
        INSERT INTO tb_order_item (
            id_item,
            id_order,
            id_product
        ) VALUES (
            seq_tb_order_item.NEXTVAL,
            p_id_order,
            p_id_product
        );

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE 
    v_result INT;
BEGIN
    add_order_item(4, 2, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Inserção de item de pedido realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na inserção de item de pedido');
    END IF;
END;


-- DELETE

CREATE OR REPLACE PROCEDURE remove_order_item (
    p_id_item   IN    tb_order_item.id_item%TYPE,
    p_result    OUT   INT
) IS
BEGIN
    DELETE FROM tb_order_item tboi
    WHERE
        tboi.id_item = p_id_item;

    COMMIT;
    p_result := 1;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    remove_order_item(6, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Remoção de item de pedido realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na remoção de item de pedido');
    END IF;

END;


-- UPDATE

CREATE OR REPLACE PROCEDURE update_order_item (
    p_id_item           IN    tb_order_item.id_item%TYPE,
    p_id_order          IN    tb_order_item.id_order%TYPE,
    p_id_product        IN    tb_order_item.id_product%TYPE,
    p_ds_order_chance   IN    tb_order_item.ds_order_chance%TYPE,
    p_ds_amount         IN    tb_order_item.ds_amount%TYPE,
    p_result            OUT   INT
) IS
BEGIN
    IF f_validate_tb_order_item(p_id_order, p_id_product) <> false THEN
        UPDATE tb_order_item tboi
        SET
            tboi.id_order = p_id_order,
            tboi.id_product = p_id_product,
            tboi.ds_order_chance = p_ds_order_chance,
            tboi.ds_amount = p_ds_amount
        WHERE
            tboi.id_item = p_id_item;

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    update_order_item(3, 4, 4, 'Tirar cebola', 10,
                      v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Atualização de item de pedido realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na atualização de item de pedido');
    END IF;

END;


-- PROCEDURES DA TABELA TB_PRODUCT

-- INSERT

CREATE OR REPLACE PROCEDURE add_product (
    p_id_restaurant   IN    tb_product.id_restaurant%TYPE,
    p_ds_image_url    IN    tb_product.ds_image_url%TYPE,
    p_nm_product      IN    tb_product.nm_product%TYPE,
    p_nr_price        IN    tb_product.nr_price%TYPE,
    p_ds_category     IN    tb_product.ds_category%TYPE,
    p_result          OUT   INT
) IS
BEGIN
    IF f_validate_tb_product(p_id_restaurant) <> false THEN
        INSERT INTO tb_product (
            id_product,
            id_restaurant,
            ds_image_url,
            nm_product,
            nr_price,
            ds_category
        ) VALUES (
            seq_tb_product.NEXTVAL,
            p_id_restaurant,
            p_ds_image_url,
            p_nm_product,
            p_nr_price,
            p_ds_category
        );

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;


DECLARE 
    v_result INT;
BEGIN
    add_product(1, 'https://example.com/product.jpg', 'Produto Exemplo', 1, 'Comida', v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Inserção de produto realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na inserção de produto');
    END IF;
END;


-- DELETE

CREATE OR REPLACE PROCEDURE remove_product (
    p_id_product   IN    tb_product.id_product%TYPE,
    p_result       OUT   INT
) IS
BEGIN
    DELETE FROM tb_product tbp
    WHERE
        tbp.id_product = p_id_product;

    COMMIT;
    p_result := 1;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE 
    v_result INT;
BEGIN
    remove_product(10, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Remoção de produto realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na remoção de produto');
    END IF;
END;


-- UPDATE

CREATE OR REPLACE PROCEDURE update_product (
    p_id_product      IN    tb_product.id_product%TYPE,
    p_id_restaurant   IN    tb_product.id_restaurant%TYPE,
    p_ds_image_url    IN    tb_product.ds_image_url%TYPE,
    p_nm_product      IN    tb_product.nm_product%TYPE,
    p_nr_price        IN    tb_product.nr_price%TYPE,
    p_ds_category     IN    tb_product.ds_category%TYPE,
    p_result          OUT   INT
) IS
BEGIN
    IF f_validate_tb_product(p_id_restaurant) <> false THEN
        UPDATE tb_product tbo
        SET
            id_restaurant = p_id_restaurant,
            ds_image_url = p_ds_image_url,
            nm_product = p_nm_product,
            nr_price = p_nr_price,
            ds_category = p_ds_category
        WHERE
            tbo.id_product = p_id_product;

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE
    v_result INT;
BEGIN
    update_product(10, 2, 'https://fiap.com.br', 'Produto Editado', 1,
                   'Fast Food', v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Atualização de produto realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na atualização de produto');
    END IF;

END;


-- PROCEDURES DA TABELA TB_RESTAURANT

-- INSERT

CREATE OR REPLACE PROCEDURE add_restaurant (
    p_ds_password     IN    tb_restaurant.ds_password%TYPE,
    p_ds_email        IN    tb_restaurant.ds_email%TYPE,
    p_ds_image_url    IN    tb_restaurant.ds_image_url%TYPE,
    p_nr_cnpj         IN    tb_restaurant.nr_cnpj%TYPE,
    p_nm_restaurant   IN    tb_restaurant.nm_restaurant%TYPE,
    p_nr_longitude    IN    tb_restaurant.nr_longitude%TYPE,
    p_nr_latitude     IN    tb_restaurant.nr_latitude%TYPE,
    p_result          OUT   INT
) IS
BEGIN
    IF f_validate_tb_restaurant(p_ds_password, p_ds_email, p_nr_cnpj) <> false THEN
        INSERT INTO tb_restaurant (
            id_restaurant,
            ds_password,
            ds_email,
            ds_image_url,
            nr_cnpj,
            nm_restaurant,
            nr_longitude,
            nr_latitude
        ) VALUES (
            seq_tb_restaurant.NEXTVAL,
            p_ds_password,
            p_ds_email,
            p_ds_image_url,
            p_nr_cnpj,
            p_nm_restaurant,
            p_nr_longitude,
            p_nr_latitude
        );

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE 
    v_result INT;
BEGIN
    add_restaurant('Senha123', 'restaurante@email.com', 'http://restaurante.com/imagem.png', '34007795000181', 'Restaurante Exemplo', 55, 5, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Inserção de restaurante realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na inserção de restaurante');
    END IF;
END;


-- DELETE

CREATE OR REPLACE PROCEDURE remove_restaurant (
    p_id_restaurant   IN    tb_restaurant.id_restaurant%TYPE,
    p_result          OUT   INT
) IS
BEGIN
    DELETE FROM tb_restaurant tbr
    WHERE
        tbr.id_restaurant = p_id_restaurant;

    COMMIT;
    p_result := 1;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE 
    v_result INT;
BEGIN
    remove_restaurant(24, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Remoção de restaurante realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na remoção de restaurante');
    END IF;
END;


-- UPDATE

CREATE OR REPLACE PROCEDURE update_restaurant (
    p_id_restaurant   IN    tb_restaurant.id_restaurant%TYPE,
    p_ds_password     IN    tb_restaurant.ds_password%TYPE,
    p_ds_email        IN    tb_restaurant.ds_email%TYPE,
    p_ds_image_url    IN    tb_restaurant.ds_image_url%TYPE,
    p_nr_cnpj         IN    tb_restaurant.nr_cnpj%TYPE,
    p_nm_restaurant   IN    tb_restaurant.nm_restaurant%TYPE,
    p_nr_longitude    IN    tb_restaurant.nr_longitude%TYPE,
    p_nr_latitude     IN    tb_restaurant.nr_latitude%TYPE,
    p_result          OUT   INT
) IS
BEGIN
    IF f_validate_tb_restaurant(p_ds_password, p_ds_email, p_nr_cnpj) <> false THEN
        UPDATE tb_restaurant tbr
        SET
            ds_password = p_ds_password,
            ds_email = p_ds_email,
            ds_image_url = p_ds_image_url,
            nr_cnpj = p_nr_cnpj,
            nm_restaurant = p_nm_restaurant,
            nr_longitude = p_nr_longitude,
            nr_latitude = p_nr_latitude
        WHERE
            tbr.id_restaurant = p_id_restaurant;

        COMMIT;
        p_result := 1;
    ELSE
        p_result := 0;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        p_result := 0;
END;

DECLARE 
    v_result INT;
BEGIN
    update_restaurant(24, '12345678', 'restaurantecomilao@email.com', 'http://restaurantecomilao.com/imagem.png', '09660427000190', 'Restaurante Comilão', 44, 2, v_result);
    IF v_result = 1 THEN
        dbms_output.put_line('Atualização de restaurante realizada com sucesso');
    ELSE
        dbms_output.put_line('Houve um erro na atualização de restaurante');
    END IF;
END;


-- PROCEDURE PARA PEGAR O PRODUTO MAIS PEDIDO POR UM CLIENTE EM ESPECÍFICO

CREATE OR REPLACE PROCEDURE most_requested_product_by_customer (
    p_id_user      IN    tb_user.id_user%TYPE,
    p_nm_product   OUT   tb_product.nm_product%TYPE
) IS

    CURSOR cur_product_by_customer (
        param_id_user tb_user.id_user%TYPE
    ) IS
    SELECT
        *
    FROM
        (
            SELECT
                tboi.id_product,
                COUNT(tboi.id_product) AS total_items,
                tbp.nm_product
            FROM
                tb_user         tbu
                INNER JOIN tb_order        tbo ON tbo.id_user = tbu.id_user
                INNER JOIN tb_order_item   tboi ON tboi.id_order = tbo.id_order
                INNER JOIN tb_product      tbp ON tbp.id_product = tboi.id_product
            WHERE
                tbu.id_user = param_id_user
            GROUP BY
                tboi.id_product,
                tbp.nm_product
            ORDER BY
                COUNT(tboi.id_product) DESC
        )
    WHERE
        ROWNUM = 1;

    v_product_name    tb_product.nm_product%TYPE;
    v_total_items     NUMBER;
    v_id_product      tb_order_item.id_product%TYPE;
    v_error_message   VARCHAR2(4000);
BEGIN
    OPEN cur_product_by_customer(p_id_user);
    LOOP
        FETCH cur_product_by_customer INTO
            v_id_product,
            v_total_items,
            v_product_name;
        EXIT WHEN cur_product_by_customer%notfound;
    END LOOP;

    p_nm_product := v_product_name;
    CLOSE cur_product_by_customer;
EXCEPTION
    WHEN OTHERS THEN
        v_error_message := sqlerrm;
        dbms_output.put_line('Erro: ' || v_error_message);
END;

DECLARE 
    v_nm_product tb_product.nm_product%TYPE;
BEGIN
    most_requested_product_by_customer(5, v_nm_product);
    dbms_output.put_line(v_nm_product);
END;



-- LISTA TODOS OS PEDIDOS DE UM RESTAURANTE EM ESPECÍFICO QUE AINDA NÃO FORAM ENTREGUES 
-- REGRA DE NEGÓCIO: O sistema deve garantir que todos os pedidos de um restaurante sejam entregues no prazo, 
-- minimizando o tempo de espera dos clientes e melhorando a eficiência operacional.

CREATE OR REPLACE PROCEDURE not_delivered_orders (
    p_id_restaurant IN tb_restaurant.id_restaurant%TYPE
) IS

    CURSOR cur_not_delivered_orders (
        param_id_restaurant tb_restaurant.id_restaurant%TYPE
    ) IS
    SELECT
        tbo.id_order,
        COUNT(tboi.id_item) AS total_itens,
        SUM(coalesce(tboi.ds_amount, 1) * tbp.nr_price) AS total_price
    FROM
        tb_user         tbu
        INNER JOIN tb_order        tbo ON tbu.id_user = tbo.id_user
        INNER JOIN tb_restaurant   tbr ON tbr.id_restaurant = tbo.id_restaurant
        INNER JOIN tb_order_item   tboi ON tbo.id_order = tboi.id_order
        INNER JOIN tb_product      tbp ON tbp.id_product = tboi.id_product
    WHERE
        tbo.st_order <> 'DELIVERED'
        AND tbo.id_restaurant = param_id_restaurant
    GROUP BY
        tbo.id_order
    ORDER BY
        COUNT(tboi.id_item);

    v_id_order        tb_order.id_order%TYPE;
    v_total_itens     NUMBER;
    v_total_price     tb_product.nr_price%TYPE;
    v_error_message   VARCHAR2(4000);
BEGIN
    OPEN cur_not_delivered_orders(p_id_restaurant);
    LOOP
        FETCH cur_not_delivered_orders INTO
            v_id_order,
            v_total_itens,
            v_total_price;
        EXIT WHEN cur_not_delivered_orders%notfound;
        dbms_output.put_line('ID DO PEDIDO: '
                             || v_id_order
                             || ' | TOTAL DE ITENS: '
                             || v_total_itens
                             || ' | PREÇO TOTAL: '
                             || v_total_price);

    END LOOP;

    CLOSE cur_not_delivered_orders;
EXCEPTION
    WHEN OTHERS THEN
        v_error_message := sqlerrm;
        dbms_output.put_line('Erro: ' || v_error_message);
END;

EXECUTE not_delivered_orders(1);





