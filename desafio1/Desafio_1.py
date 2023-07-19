extrato = []
cont_deposito = 0
cont_saque = 0
limite_saque = 0
valor_total = 0
while True:
  opcao = int(input("""
  Digite 1. Para depositar.
  Digite 2. Para sacar.
  Digite 3. Para ver o extrato.
  Digite 4. Sair.
      """))
  match opcao:
    case 1:
      valor_depositado = float(input("Digite o valor que será depositado: "))
      if valor_depositado < 0:
        print("Valor menor que 0, opereração não sucedida!")
      else:
        print(f"Valor: R${valor_depositado} foi depositado com sucesso!")
        valor_total += valor_depositado
        cont_deposito += 1
        extrato.append(f"Deposito {cont_deposito}: R${valor_depositado:.2f}")

    case 2:
      if cont_saque <= 3:
        valor_saque = float(input("Digite o valor que deseja ser sacado: "))
        if valor_saque <= 0:
          print("O valor informado não pode ser sacado, devido ser menor ou igual a R$0,00.")

        else:
          if valor_saque > valor_total:
            print(f"Valor na conta insuficiente, só possui R${valor_total} na conta atualmente.")
          else:
            if limite_saque > 1500:
              print(f"Limite de saque diario ultrapassado, devido isso o saque não foi aprovado, valor permitido para o saque no dia: R${1500 - limite_saque}")
            elif valor_saque > 500:
              print("Valor superior ao limite de R$500,00 por saque, devido isso o saque foi bloqueado.")
            else:
              print(f"Saque liberado no valor de R${valor_saque}")
              cont_saque += 1
              extrato.append(f"Sauqe {cont_saque}:   -R${valor_saque:.2f}")
              valor_total -= valor_saque
      else:
        print("Limite de saques excedido, saque negado, só são permitidos 3 saques por dia.")

    case 3:
      print("=" * 10, " EXTRATO ", "=" * 10)
      if not extrato:
        print("Não foram realizadas movimentações.")
      else:
        for nome in extrato:
          print(nome)
      print(f"Valor Total: R${valor_total}")
      print("="*31)

    case 4:
      break

    case _:
      print(f"Opção {opcao} não existente, escolha uma válida por favor.")





