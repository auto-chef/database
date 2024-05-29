from datetime import datetime

import cx_Oracle

import json

path = r"./env.json"

with open(path, "r") as file:
    data = json.load(file)

user = data["user"]
password = data["password"]

dsn = cx_Oracle.makedsn(host='oracle.fiap.com.br', port=1521, sid='ORCL')

conn = cx_Oracle.connect(user=user, password=password, dsn=dsn)

cursor = conn.cursor()


def parse_date(date_str):
    return datetime.strptime(date_str, "%d/%m/%y")

while True:
    print("========================================================")
    print("Bem vindo ao Autochef!")
    print("========================================================")
    print()
    print("Selecione uma opção:")
    print()
    print("[1] - Inserir dados na tabela TB_USER")
    print("[2] - Inserir dados na tabela TB_ORDER")
    print("[3] - Inserir dados na tabela TB_ORDER_ITEM")
    print("[4] - Inserir dados na tabela TB_PRODUCT")
    print("[5] - Inserir dados na tabela de TB_RESTAURANT")
    print("[6] - Sair")
    print()

    option = input("Digite a opção escolhida: ")

    match option:
        case "1":
            while True:
                try:
                    print()

                    p_nm_user = input("Digite o nome do usuário: ")
                    p_ds_email = input("Digite o e-mail: ")
                    p_ds_password = input("Digite a senha: ")
                    p_dt_registration = parse_date(input("Digite a data de cadastro (dd/mm/aa): "))
                    p_dt_birth = parse_date(input("Digite a data de nascimento (dd/mm/aa): "))
                    p_nr_cpf = input("Digite o CPF (sem pontuação): ")
                    p_result = cursor.var(int)

                    cursor.callproc('add_user',
                                    [p_nm_user, p_ds_email, p_ds_password, p_dt_registration, p_dt_birth, p_nr_cpf,
                                     p_result])

                    if p_result.getvalue() != 1:
                        raise Exception

                    answer = input("Usuário criado com sucesso! Deseja continuar? (S/N) ")
                    print()

                    if answer.lower() != 's':
                        break

                except Exception as error:
                    answer = input("Houve um erro ao inserir dados na tabela TB_USER. Deseja tentar novamente? (S/N) ")
                    if answer.lower() != 's':
                        break

        case "2":
            while True:
                try:
                    print()

                    p_id_user = input("Digite o ID do usuário: ")
                    p_id_restaurant = input("Digite o ID do restaurante: ")
                    p_st_order = input("Digite o status do pedido ('ACCEPTED', 'DELIVERED', 'PENDING', 'REJECTED') : ")
                    p_result = cursor.var(int)

                    cursor.callproc('add_order', [p_id_user, p_id_restaurant, p_st_order, p_result])

                    if p_result.getvalue() != 1:
                        raise Exception

                    answer = input("Pedido criado com sucesso! Deseja continuar? (S/N) ")
                    print()

                    if answer.lower() != 's':
                        break

                except Exception as error:
                    answer = input(
                        "Houve um erro ao inserir dados na tabela TB_ORDER. Deseja tentar novamente? (S/N) ")
                    if answer.lower() != 's':
                        break

        case "3":
            while True:
                try:
                    print()

                    p_id_order = input("Digite o ID do pedido: ")
                    p_id_product = input("Digite o ID do produto: ")
                    p_result = cursor.var(int)

                    cursor.callproc('add_order_item', [p_id_order, p_id_product, p_result])

                    if p_result.getvalue() != 1:
                        raise Exception

                    answer = input("Item de pedido criado com sucesso! Deseja continuar? (S/N) ")
                    print()

                    if answer.lower() != 's':
                        break

                except Exception as error:
                    answer = input(
                        "Houve um erro ao inserir dados na tabela TB_ORDER_ITEM. Deseja tentar novamente? (S/N) ")
                    if answer.lower() != 's':
                        break

        case "4":
            while True:
                try:
                    print()

                    p_id_restaurant = input("Digite o ID do restaurante: ")
                    p_ds_image_url = input("Digite a url da imagem do produto: ")
                    p_nm_product = input("Digite o nome do produto: ")
                    p_nr_price = float(input("Digite o preço do produto: "))
                    p_ds_category = input("Digite a categoria do produto: ")

                    p_result = cursor.var(int)

                    cursor.callproc('add_product', [p_id_restaurant, p_ds_image_url, p_nm_product, p_nr_price, p_ds_category, p_result])

                    if p_result.getvalue() != 1:
                        raise Exception

                    answer = input("Produto criado com sucesso! Deseja continuar? (S/N) ")
                    print()

                    if answer.lower() != 's':
                        break

                except Exception as error:
                    answer = input(
                        "Houve um erro ao inserir dados na tabela TB_PRODUCT. Deseja tentar novamente? (S/N) ")
                    if answer.lower() != 's':
                        break

        case "5":
            while True:
                try:
                    print()

                    p_ds_password = input("Digite a senha: ")
                    p_ds_email = input("Digite o email: ")
                    p_ds_image_url = input("Digite a URL da imagem do restaurante: ")
                    p_nr_cnpj = input("Digite o CNPJ do restaurante (sem pontuação): ")
                    p_nm_restaurant = input("Digite o nome do restaurante: ")
                    p_nr_longitude = input("Digite a longitude do restaurante: ")
                    p_nr_latitude = input("Digite a latitude do restaurante: ")

                    p_result = cursor.var(int)

                    cursor.callproc('add_restaurant',
                                    [p_ds_password, p_ds_email, p_ds_image_url, p_nr_cnpj, p_nm_restaurant, p_nr_longitude, p_nr_latitude, p_result])

                    if p_result.getvalue() != 1:
                        raise Exception

                    answer = input("Restaurante criado com sucesso! Deseja continuar? (S/N) ")
                    print()

                    if answer.lower() != 's':
                        break

                except Exception as error:
                    answer = input(
                        "Houve um erro ao inserir dados na tabela TB_RESTAURANT. Deseja tentar novamente? (S/N) ")
                    if answer.lower() != 's':
                        break
        case "6":
            cursor.close()
            conn.close()
            break

        case _:
            print("Opção inválida! Tente Novamente")
