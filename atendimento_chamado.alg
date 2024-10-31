algoritmo "Sistema de Atendimento de Chamados"

// Estruturas para Chamados, Técnicos e Relatórios

tipo Chamado
    id : inteiro
    descricao : caractere
    tecnicoResponsavel : caractere
    status : caractere // "Aberto", "Em Andamento", "Concluído", "Escalonado"
    prioridade : inteiro // 1 (alta) a 5 (baixa)
    dataAbertura : caractere
    dataConclusao : caractere
fimTipo

tipo Tecnico
    nome : caractere
    areaEspecializacao : caractere
    chamadoAtendido : inteiro
fimTipo

tipo Relatorio
    totalChamados : inteiro
    chamadosConcluidos : inteiro
    chamadosEmAndamento : inteiro
    chamadosEscalonados : inteiro
fimTipo

// Variáveis Globais
vetor chamados[1..100] : Chamado
vetor tecnicos[1..10] : Tecnico
relatorio : Relatorio
totalChamados : inteiro
totalTecnicos : inteiro
opcao : inteiro

// Inicialização
inicio
    totalChamados ← 0
    totalTecnicos ← 0
    relatorio.totalChamados ← 0
    relatorio.chamadosConcluidos ← 0
    relatorio.chamadosEmAndamento ← 0
    relatorio.chamadosEscalonados ← 0

    // Função para adicionar um técnico
    funcao adicionarTecnico()
        totalTecnicos ← totalTecnicos + 1
        escreva("Nome do Técnico: ")
        leia(tecnicos[totalTecnicos].nome)
        escreva("Área de Especialização: ")
        leia(tecnicos[totalTecnicos].areaEspecializacao)
        tecnicos[totalTecnicos].chamadoAtendido ← 0
        escreva("Técnico adicionado com sucesso!\n")
    fimfuncao

    // Função para adicionar um chamado
    funcao adicionarChamado()
        totalChamados ← totalChamados + 1
        chamados[totalChamados].id ← totalChamados
        escreva("Descrição do Chamado: ")
        leia(chamados[totalChamados].descricao)
        escreva("Prioridade (1 a 5, sendo 1 a mais alta): ")
        leia(chamados[totalChamados].prioridade)
        chamados[totalChamados].status ← "Aberto"
        chamados[totalChamados].dataAbertura ← agora() // captura data atual
        chamados[totalChamados].tecnicoResponsavel ← "Nenhum"
        escreva("Chamado adicionado com sucesso!\n")
    fimfuncao

    // Função para atribuir um técnico a um chamado
    funcao atribuirTecnico()
        idChamado : inteiro
        escreva("Informe o ID do Chamado a ser atribuído: ")
        leia(idChamado)

        se (idChamado > 0) e (idChamado <= totalChamados) então
            escreva("Selecione o Técnico:\n")
            para i de 1 até totalTecnicos faça
                escreva(i, ": ", tecnicos[i].nome, " - ", tecnicos[i].areaEspecializacao, "\n")
            fimpara
            escreva("Escolha um técnico pelo número: ")
            inteiro escolhaTecnico
            leia(escolhaTecnico)

            se (escolhaTecnico > 0) e (escolhaTecnico <= totalTecnicos) então
                chamados[idChamado].tecnicoResponsavel ← tecnicos[escolhaTecnico].nome
                chamados[idChamado].status ← "Em Andamento"
                tecnicos[escolhaTecnico].chamadoAtendido ← tecnicos[escolhaTecnico].chamadoAtendido + 1
                escreva("Técnico atribuído com sucesso!\n")
            senão
                escreva("Técnico inválido.\n")
            fimse
        senão
            escreva("Chamado inválido.\n")
        fimse
    fimfuncao

    // Função para concluir um chamado
    funcao concluirChamado()
        idChamado : inteiro
        escreva("Informe o ID do Chamado a ser concluído: ")
        leia(idChamado)

        se (idChamado > 0) e (idChamado <= totalChamados) então
            chamados[idChamado].status ← "Concluído"
            chamados[idChamado].dataConclusao ← agora() // captura data atual
            relatorio.chamadosConcluidos ← relatorio.chamadosConcluidos + 1
            escreva("Chamado concluído com sucesso!\n")
        senão
            escreva("Chamado inválido.\n")
        fimse
    fimfuncao

    // Função para escalar um chamado
    funcao escalarChamado()
        idChamado : inteiro
        escreva("Informe o ID do Chamado a ser escalonado: ")
        leia(idChamado)

        se (idChamado > 0) e (idChamado <= totalChamados) então
            chamados[idChamado].status ← "Escalonado"
            relatorio.chamadosEscalonados ← relatorio.chamadosEscalonados + 1
            escreva("Chamado escalonado com sucesso!\n")
        senão
            escreva("Chamado inválido.\n")
        fimse
    fimfuncao

    // Função para gerar relatórios
    funcao gerarRelatorio()
        relatorio.totalChamados ← totalChamados
        relatorio.chamadosEmAndamento ← 0

        para i de 1 até totalChamados faça
            escolha chamados[i].status
                caso "Em Andamento"
                    relatorio.chamadosEmAndamento ← relatorio.chamadosEmAndamento + 1
                fimescolha
        fimpara

        escreva("\n=== Relatório de Atendimento ===\n")
        escreva("Total de Chamados: ", relatorio.totalChamados, "\n")
        escreva("Chamados Concluídos: ", relatorio.chamadosConcluidos, "\n")
        escreva("Chamados Em Andamento: ", relatorio.chamadosEmAndamento, "\n")
        escreva("Chamados Escalonados: ", relatorio.chamadosEscalonados, "\n")
    fimfuncao

    // Menu Principal
    repita
        escreva("\n=== Sistema de Atendimento de Chamados ===\n")
        escreva("1. Adicionar Técnico\n")
        escreva("2. Adicionar Chamado\n")
        escreva("3. Atribuir Técnico a Chamado\n")
        escreva("4. Concluir Chamado\n")
        escreva("5. Escalonar Chamado\n")
        escreva("6. Gerar Relatório\n")
        escreva("0. Sair\n")
        escreva("Escolha uma opção: ")
        leia(opcao)

        escolha opcao
            caso 1
                adicionarTecnico()
            caso 2
                adicionarChamado()
            caso 3
                atribuirTecnico()
            caso 4
                concluirChamado()
            caso 5
                escalarChamado()
            caso 6
                gerarRelatorio()
            caso 0
                escreva("Saindo do Sistema de Atendimento de Chamados...\n")
            caso contrário
                escreva("Opção inválida.\n")
        fimescolha
    até opcao = 0

fimalgoritmo
