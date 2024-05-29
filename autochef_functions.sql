SET SERVEROUTPUT ON;

-- FUNÇÃO PARA VALIDAÇÃO DE CPF

CREATE OR REPLACE FUNCTION f_cpf_validation (
    p_cpf tb_user.nr_cpf%TYPE
) RETURN BOOLEAN IS
    v_total   NUMBER := 0;
    v_digit   NUMBER := 0;
BEGIN
    FOR i IN 1..9 LOOP v_total := v_total + substr(p_cpf, i, 1) * ( 11 - i );
    END LOOP;

    v_digit := 11 - MOD(v_total, 11);
    IF v_digit > 9 THEN
        v_digit := 0;
    END IF;
    IF v_digit != substr(p_cpf, 10, 1) THEN
        RETURN false;
    END IF;

    v_digit := 0;
    v_total := 0;
    FOR i IN 1..10 LOOP v_total := v_total + substr(p_cpf, i, 1) * ( 12 - i );
    END LOOP;

    v_digit := 11 - MOD(v_total, 11);
    IF v_digit > 9 THEN
        v_digit := 0;
    END IF;
    IF v_digit != substr(p_cpf, 11, 1) THEN
        RETURN false;
    END IF;

    RETURN true;
EXCEPTION
    WHEN OTHERS THEN
        RETURN false;
END;


-- FUNÇÃO PARA VALIDAÇÃO DE CNPJ

CREATE OR REPLACE FUNCTION f_cnpj_validation (
    p_cnpj tb_restaurant.nr_cnpj%TYPE
) RETURN BOOLEAN IS
    v_total   NUMBER := 0;
    v_digit   NUMBER := 0;
BEGIN
    IF length(p_cnpj) <> 14 THEN
        RETURN false;
    END IF;
    FOR i IN 1..4 LOOP v_total := v_total + substr(p_cnpj, i, 1) * ( 6 - i );
    END LOOP;

    FOR i IN 5..12 LOOP v_total := v_total + substr(p_cnpj, i, 1) * ( 14 - i );
    END LOOP;

    v_digit := 11 - MOD(v_total, 11);
    IF v_digit > 9 THEN
        v_digit := 0;
    END IF;
    IF v_digit != substr(p_cnpj, 13, 1) THEN
        RETURN false;
    END IF;

    v_digit := 0;
    v_total := 0;
    FOR i IN 1..5 LOOP v_total := v_total + substr(p_cnpj, i, 1) * ( 7 - i );
    END LOOP;

    FOR i IN 6..13 LOOP v_total := v_total + substr(p_cnpj, i, 1) * ( 15 - i );
    END LOOP;

    v_digit := 11 - MOD(v_total, 11);
    IF v_digit > 9 THEN
        v_digit := 0;
    END IF;
    IF v_digit != substr(p_cnpj, 14, 1) THEN
        RETURN false;
    END IF;

    RETURN true;
EXCEPTION
    WHEN OTHERS THEN
        RETURN false;
END;


-- FUNÇÕES PARA VALIDAÇÃO DE ENTRADA DE DADOS


-- FUNÇÃO PARA VALIDAR TABELA TB_USER

CREATE OR REPLACE FUNCTION f_validate_tb_user(
	p_ds_email tb_user.ds_email%TYPE,
	p_ds_password tb_user.ds_password%TYPE,
	p_dt_registration tb_user.dt_registration%TYPE,
    p_nr_cpf tb_user.nr_cpf%TYPE,
    p_dt_birth tb_user.dt_birth%TYPE
) RETURN BOOLEAN 
IS
    v_email_pattern VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
BEGIN
    CASE 
        WHEN REGEXP_LIKE(p_ds_email, v_email_pattern) = FALSE THEN RETURN FALSE;
        WHEN LENGTH(p_ds_password) < 8 THEN RETURN FALSE;
        WHEN p_dt_registration > SYSDATE THEN RETURN FALSE;
        WHEN f_cpf_validation(p_nr_cpf) = FALSE THEN RETURN FALSE;
        WHEN p_dt_birth >= SYSDATE THEN RETURN FALSE;
        ELSE RETURN TRUE;
    END CASE;
    EXCEPTION 
        WHEN OTHERS THEN 
            RETURN FALSE;
END;


DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := f_validate_tb_user('lucasaraujo4188@gmail.com', '12345678', '05/05/24', '61228529027', '02/05/24');
    IF v_result = true THEN
        dbms_output.put_line('Inserção de usuário válida');
    ELSE
        dbms_output.put_line('Houve um erro ao validar a inserção de usuário');
    END IF;
END;


-- FUNÇÃO PARA VALIDAR TABELA TB_ORDER

CREATE OR REPLACE FUNCTION f_validate_tb_order (
    p_id_user         tb_order.id_user%TYPE,
    p_id_restaurant   tb_order.id_restaurant%TYPE,
    p_st_order        tb_order.st_order%TYPE
) RETURN BOOLEAN IS
    v_check_id_user         tb_user.id_user%TYPE;
    v_check_id_restaurant   tb_restaurant.id_restaurant%TYPE;
BEGIN
    SELECT
        tbu.id_user
    INTO v_check_id_user
    FROM
        tb_user tbu
    WHERE
        tbu.id_user = p_id_user;

    SELECT
        tbr.id_restaurant
    INTO v_check_id_restaurant
    FROM
        tb_restaurant tbr
    WHERE
        tbr.id_restaurant = p_id_restaurant;

    IF p_st_order NOT IN (
        'ACCEPTED',
        'DELIVERED',
        'PENDING',
        'REJECTED'
    ) THEN
        RETURN false;
    END IF;

    RETURN true;
EXCEPTION
    WHEN no_data_found THEN
        RETURN false;
    WHEN OTHERS THEN
        RETURN false;
END;

DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := f_validate_tb_order(2, 2, 'PENDING');
    IF v_result = true THEN
        dbms_output.put_line('Inserção de pedido válida');
    ELSE
        dbms_output.put_line('Houve um erro ao validar a inserção de pedido');
    END IF;
END;


-- FUNÇÃO PARA VALIDAR TABELA TB_ORDER_ITEM

CREATE OR REPLACE FUNCTION f_validate_tb_order_item (
    p_id_order     tb_order_item.id_order%TYPE,
    p_id_product   tb_order_item.id_product%TYPE
) RETURN BOOLEAN IS
    v_check_id_order     tb_order.id_order%TYPE;
    v_check_id_product   tb_product.id_product%TYPE;
BEGIN
    SELECT
        tbo.id_order
    INTO v_check_id_order
    FROM
        tb_order tbo
    WHERE
        tbo.id_order = p_id_order;

    SELECT
        tbp.id_product
    INTO v_check_id_product
    FROM
        tb_product tbp
    WHERE
        tbp.id_product = p_id_product;

    RETURN true;
EXCEPTION
    WHEN no_data_found THEN
        RETURN false;
    WHEN OTHERS THEN
        RETURN false;
END;

DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := f_validate_tb_order_item(2, 2);
    IF v_result = true THEN
        dbms_output.put_line('Inserção de item de pedido válida');
    ELSE
        dbms_output.put_line('Houve um erro ao validar a inserção de item de pedido');
    END IF;
END;


-- FUNÇÃO PARA VALIDAR TABELA TB_PRODUCT

CREATE OR REPLACE FUNCTION f_validate_tb_product (
    p_id_restaurant tb_product.id_restaurant%TYPE
) RETURN BOOLEAN IS
    v_check_id_restaurant tb_restaurant.id_restaurant%TYPE;
BEGIN
    SELECT
        tbr.id_restaurant
    INTO v_check_id_restaurant
    FROM
        tb_restaurant tbr
    WHERE
        tbr.id_restaurant = p_id_restaurant;

    RETURN true;
EXCEPTION
    WHEN no_data_found THEN
        RETURN false;
    WHEN OTHERS THEN
        RETURN false;
END;

DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := f_validate_tb_product(4);
    IF v_result = true THEN
        dbms_output.put_line('Inserção de produto válida');
    ELSE
        dbms_output.put_line('Houve um erro ao validar a inserção de produto');
    END IF;
END;


-- FUNÇÃO PARA VALIDAR TABELA TB_RESTAURANT

CREATE OR REPLACE FUNCTION f_validate_tb_restaurant (
    p_ds_password   tb_restaurant.ds_password%TYPE,
    p_ds_email      tb_restaurant.ds_email%TYPE,
    p_nr_cnpj       tb_restaurant.nr_cnpj%TYPE
) RETURN BOOLEAN IS
    v_email_pattern VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
BEGIN
    CASE
        WHEN regexp_like(p_ds_email, v_email_pattern) = false THEN
            RETURN false;
        WHEN length(p_ds_password) < 8 THEN
            RETURN false;
        WHEN f_cnpj_validation(p_nr_cnpj) = false THEN
            RETURN false;
        ELSE
            RETURN true;
    END CASE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN false;
END;


DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := f_validate_tb_restaurant('65842879', 'lucas@email.com', '06377905000161');
    IF v_result = true THEN
        dbms_output.put_line('Inserção de restaurante válida!');
    ELSE
        dbms_output.put_line('Houve um erro ao validar a inserção de restaurante');
    END IF;
END;