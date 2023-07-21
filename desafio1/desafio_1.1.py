import textwrap
def menu():
    opcao = int(input(textwrap.dedent("""
    =============== MENU ===============
    Digite 1.\tPara depositar.
    Digite 2.\tPara sacar.
    Digite 3.\tPara ver o extrato.
    Digite 4.\tPara Cadastrar usuário (cliente).
    Digite 5.\tPara cadastar conta bancária.
    Digite 6.\tPara mostrar a lista de usuários.
    Digite 7.\tPara mostar a lista de contas.
    Digite 8.\tSair.
        """)))
    return opcao

def deposito():
    valor_depositado = float(input("Digite o valor que será depositado: "))
    if valor_depositado < 0:
        print("Valor menor que 0, opereração não sucedida!")
        return 0
    else:
        print(f"Valor: R${valor_depositado} foi depositado com sucesso!")
        return valor_depositado

def saque(*, valor, cont, limite_saque):
    if cont < 3:
        valor_saque = float(input("Digite o valor que deseja ser sacado: "))
        if valor_saque <= 0:
            print("O valor informado não pode ser sacado, devido ser menor ou igual a R$0,00.")
        else:
            if valor_saque > valor:
                print(f"Valor na conta insuficiente, só possui R${valor} na conta atualmente.")
            else:
                if limite_saque > 1500:
                    print(f"Limite de saque diario ultrapassado, devido isso o saque não foi aprovado, valor permitido para o saque no dia: R${1500 - limite_saque}")
                elif valor_saque > 500:
                    print("Valor superior ao limite de R$500,00 por saque, devido isso o saque foi bloqueado.")
                else:
                    print(f"Saque liberado no valor de R${valor_saque}")
                    return valor_saque
    else:
        print("Limite de saques excedido, saque negado, só são permitidos 3 saques por dia.")
        return 0
    
def extrato_total(valor, /, *, extrato):
    print("=" * 10, " EXTRATO ", "=" * 10)
    if not extrato:
        print("Não foram realizadas movimentações.")
    else:
        for nome in extrato:
            print(f"\t{nome}")
    print(f"Valor Total:\t R${valor}")
    print("="*31)

def cadastro_usuario(lista_dados):
    cpf = str(input("Digite seu CPF: "))
    usuario = filtro(lista_dados, cpf)
    if usuario:
        print(f"Usuario {usuario} já cadastrado!")
    else:
        nome = str(input("Digite seu nome: "))
        data_de_nascimento = str(input("Digite sua data de nascimento : "))
        rua = str(input("Digite o nome do seu Logradouro(rua): "))
        numero_casa = str(input("Digite o número da sua casa: "))
        bairro = str(input("Digite o seu bairro: "))
        cidade = str(input("Digite o nome da sua cidade: "))
        estado = str(input("Digite a sigla do se estado: "))
        endereco = rua + ", "+numero_casa+ " - "+ bairro+ " - "+ cidade+ "/"+ estado
        dados = {"nome" : nome, "data de nascimento" : data_de_nascimento, "cpf" : cpf, "endereço": endereco}
        return dados
    
def filtro(lista_dados, cpf):
    for lista in lista_dados:
        if lista["cpf"] == cpf:
            return lista["nome"]
        else:
            None

def criar_conta(agencia, numero_conta, lista_dados):
    cpf = str(input("Informe o cpf do usuário: "))
    usuario = filtro(lista_dados, cpf)
    if usuario:
        print("Conta criada com sucesso!")
        return {"agencia": agencia, "numero_conta": numero_conta, "usuario": usuario}
    else:
        print("Usuario não encontrado, impossivel criar conta!")

def listar_contas(contas):
    for conta in contas:
        linha = f"""
            Agência:\t{conta['agencia']}
            C/C:\t{conta['numero_conta']}
            Titular:\t{conta['usuario']}
        """
        print("="*100)
        print(textwrap.dedent(linha))
        
def main ():
    AGENCIA = "0001"
    contas = []
    extrato = []
    cont_saque = 0
    saque_total = 0
    valor_total = float()
    lista_dados = []
    while True:
        opcao = menu()
        match opcao:
            case 1:
                auxiliar_valor = deposito()
                valor_total += auxiliar_valor
                extrato.append(f"Deposito: R${auxiliar_valor:.2f}")
            case 2:
                cont_saque += 1
                auxiliar_valor = saque(
                    valor=valor_total, 
                    cont=cont_saque, 
                    limite_saque=saque_total,
                    )
                if auxiliar_valor == None:
                    auxiliar_valor = 0
                saque_total += auxiliar_valor
                valor_total -= auxiliar_valor
                extrato.append(f"Sauqe:   -R${auxiliar_valor:.2f}")
            case 3:
                extrato_total(valor_total, extrato=extrato)
            case 4:
                lista_dados.append(cadastro_usuario(lista_dados))
            case 5:
                numero_conta = len(contas) + 1
                conta = criar_conta(AGENCIA, numero_conta, lista_dados)
                if conta:
                    contas.append(conta)
            case 6:
                for lista in lista_dados:
                    print(lista)
            case 7: 
                listar_contas(contas)
            case 8:
                break
            case _:
                print(f"Opção {opcao} não existente, escolha uma válida por favor.")

main()