algoritmo "Sistema de Atendimento de Chamados Aprimorado"

// --- Constantes de Limite ---
const
   LIMITE_CHAMADOS = 100
   LIMITE_TECNICOS = 10

// --- Definição dos Tipos (Registros) ---
tipo Chamado
   id: inteiro
   descricao: caractere
   indiceTecnico: inteiro // OTIMIZAÇÃO: Armazena o ÍNDICE do técnico (0 = Nenhum)
   status: caractere // "Aberto", "Em Andamento", "Concluído", "Escalonado"
   prioridade: inteiro // 1 (alta) a 5 (baixa)
   dataAbertura: caractere // Simplificado para simulação
   dataConclusao: caractere
fimTipo

tipo Tecnico
   nome: caractere
   areaEspecializacao: caractere
   chamadosAtendidos: inteiro // Contador de quantos chamados concluíu
fimTipo

// --- Variáveis Globais ---
var
   chamados: vetor[1..LIMITE_CHAMADOS] de Chamado
   tecnicos: vetor[1..LIMITE_TECNICOS] de Tecnico
   totalChamados: inteiro
   totalTecnicos: inteiro
   opcao: inteiro

// --- Procedimento: Pausa a execução ---
procedimento Pausar()
var
   tecla: caractere
inicio
   escreva("\n(Pressione [ENTER] para voltar ao menu...)")
   leia(tecla)
fimprocedimento

// --- Funções Auxiliares de Busca (para validação) ---
funcao buscarTecnicoPorNome(nome: caractere) : inteiro
   var i: inteiro
   para i de 1 até totalTecnicos faca
      se (tecnicos[i].nome = nome) entao
         retorne i
      fimse
   fimpara
   retorne 0
fimfuncao

// Valida se o ID existe e retorna o índice (que é o próprio ID)
funcao buscarChamadoPorID(id: inteiro) : inteiro
   se (id > 0) e (id <= totalChamados) entao
      retorne id
   senao
      retorne 0
   fimse
fimfuncao

// --- Procedimento: Adicionar Técnico (com validação) ---
procedimento adicionarTecnico()
var
   nomeTecnico, areaTecnico: caractere
inicio
   limpatela
   escreva("--- Adicionar Técnico ---\n")
   
   
   se (totalTecnicos >= LIMITE_TECNICOS) entao
      escreva("[ERRO] Limite de (", LIMITE_TECNICOS, ") técnicos atingido!\n")
   senao
      escreva("Nome do Técnico: ")
      leia(nomeTecnico)
      
      // Validação de Duplicidade
      se (buscarTecnicoPorNome(nomeTecnico) > 0) entao
         escreva("\n[ERRO] Já existe um técnico com este nome!\n")
      senao
         escreva("Área de Especialização (ex: Redes, Hardware): ")
         leia(areaTecnico)
         
         totalTecnicos <- totalTecnicos + 1
         tecnicos[totalTecnicos].nome <- nomeTecnico
         tecnicos[totalTecnicos].areaEspecializacao <- areaTecnico
         tecnicos[totalTecnicos].chamadosAtendidos <- 0
         
         escreva("\nTécnico '", nomeTecnico, "' adicionado com sucesso!\n")
      fimse
   fimse
fimprocedimento

// --- Procedimento: Adicionar Chamado (com validação) ---
procedimento adicionarChamado()
var
   prioridadeChamado: inteiro
inicio
   limpatela
   escreva("--- Abrir Novo Chamado ---\n")
   
   se (totalChamados >= LIMITE_CHAMADOS) entao
      escreva("[ERRO] Limite de (", LIMITE_CHAMADOS, ") chamados atingido!\n")
   senao
      totalChamados <- totalChamados + 1
      chamados[totalChamados].id <- totalChamados
      
      escreva("Descrição do Chamado: ")
      leia(chamados[totalChamados].descricao)
      
      // Validação de Prioridade
      prioridadeChamado <- 0
      enquanto (prioridadeChamado < 1) ou (prioridadeChamado > 5) faca
         escreva("Prioridade (1=Alta, 5=Baixa): ")
         leia(prioridadeChamado)
         se (prioridadeChamado < 1) ou (prioridadeChamado > 5) entao
            escreva("[ERRO] A prioridade deve ser um número entre 1 e 5.\n")
         fimse
      fimenquanto
      chamados[totalChamados].prioridade <- prioridadeChamado
      
      // Dados padrão
      chamados[totalChamados].status <- "Aberto"
      chamados[totalChamados].indiceTecnico <- 0 // 0 = Não atribuído
      chamados[totalChamados].dataAbertura <- "12/11/2025" // Placeholder (agora() não existe)
      chamados[totalChamados].dataConclusao <- ""
      
      escreva("\nChamado ID ", totalChamados, " adicionado com sucesso!\n")
   fimse
fimprocedimento

// --- Procedimento: Atribuir Técnico a Chamado ---
procedimento atribuirTecnico()
var
   idChamado, idTecnico, i: inteiro
inicio
   limpatela
   escreva("--- Atribuir Chamado --- \n")
   
   se (totalTecnicos = 0) ou (totalChamados = 0) entao
      escreva("[ERRO] É preciso ter pelo menos um técnico E um chamado cadastrado.\n")
      retorne
   fimse
   
   escreva("Digite o ID do Chamado a ser atribuído: ")
   leia(idChamado)
   
   idChamado <- buscarChamadoPorID(idChamado) // Valida o ID
   
   se (idChamado = 0) entao
      escreva("\n[ERRO] Chamado inválido.\n")
   senao se (chamados[idChamado].status <> "Aberto") entao
      escreva("\n[ERRO] Este chamado não está 'Aberto'. (Status: ", chamados[idChamado].status, ")\n")
   senao
      // Lista os técnicos disponíveis
      escreva("\n--- Técnicos Disponíveis ---\n")
      para i de 1 até totalTecnicos faca
         escreva(i, ": ", tecnicos[i].nome, " (", tecnicos[i].areaEspecializacao, ")\n")
      fimpara
      
      idTecnico <- 0
      enquanto (idTecnico < 1) ou (idTecnico > totalTecnicos) faca
         escreva("Escolha o ID do técnico: ")
         leia(idTecnico)
      fimenquanto
      
      // Atribui o chamado
      chamados[idChamado].indiceTecnico <- idTecnico // Armazena o ÍNDICE
      chamados[idChamado].status <- "Em Andamento"
      
      escreva("\nChamado ", idChamado, " atribuído a '", tecnicos[idTecnico].nome, "' com sucesso!\n")
   fimse
fimprocedimento

// --- Procedimento: Atualizar Status de Chamado (Novo) ---
// (Combina Concluir e Escalonar em um só)
procedimento atualizarStatusChamado()
var
   idChamado, opStatus, idTecnico: inteiro
   novoStatus: caractere
inicio
   limpatela
   escreva("--- Atualizar Status de Chamado ---\n")
   
   escreva("Digite o ID do Chamado: ")
   leia(idChamado)
   
   idChamado <- buscarChamadoPorID(idChamado) // Valida o ID
   
   se (idChamado = 0) entao
      escreva("\n[ERRO] Chamado inválido.\n")
   senao se (chamados[idChamado].status = "Aberto") entao
      escreva("\n[ERRO] Atribua um técnico antes de atualizar o status.\n")
   senao se (chamados[idChamado].status = "Concluído") ou (chamados[idChamado].status = "Escalonado") entao
      escreva("\n[AVISO] Este chamado já está finalizado (", chamados[idChamado].status, ").\n")
   senao
      // Se o chamado está "Em Andamento"
      escreva("Chamado: ", chamados[idChamado].descricao, "\n")
      
      opStatus <- 0
      enquanto (opStatus < 1) ou (opStatus > 2) faca
         escreva("Selecione o novo status:\n")
         escreva("1. Concluído\n")
         escreva("2. Escalonado\n")
         escreva("Opção: ")
         leia(opStatus)
      fimenquanto
      
      se (opStatus = 1) entao
         chamados[idChamado].status <- "Concluído"
         chamados[idChamado].dataConclusao <- "12/11/2025" // Placeholder
         
         // Incrementa o contador do técnico responsável
         idTecnico <- chamados[idChamado].indiceTecnico
         se (idTecnico > 0) entao // Segurança
            tecnicos[idTecnico].chamadosAtendidos <- tecnicos[idTecnico].chamadosAtendidos + 1
         fimse
         
         escreva("\nChamado CONCLUÍDO com sucesso!\n")
      senao
         chamados[idChamado].status <- "Escalonado"
         escreva("\nChamado ESCALONADO com sucesso!\n")
      fimse
   fimse
fimprocedimento

// --- Procedimento: Listar Todos os Chamados (NOVO) ---
procedimento listarChamados()
var
   i, idTecnico: inteiro
   nomeTecnico: caractere
   c: Chamado // Variável auxiliar
inicio
   limpatela
   escreva("=================================================================================\n")
   escreva("=                           LISTA DE CHAMADOS                               =\n")
   escreva("=================================================================================\n")
   escreva("ID | Prio | Status        | Responsável        | Descrição\n")
   escreva("---------------------------------------------------------------------------------\n")
   
   se (totalChamados = 0) entao
      escreva("  (Nenhum chamado cadastrado)\n")
   fimse
   
   para i de 1 até totalChamados faca
      c <- chamados[i] // Pega o chamado
      
      // Busca o nome do técnico (ou "Nenhum")
      idTecnico <- c.indiceTecnico
      se (idTecnico = 0) entao
         nomeTecnico <- "(Nenhum)"
      senao
         nomeTecnico <- tecnicos[idTecnico].nome
      fimse
      
      escreva(c.id:2, " | ")
      escreva(c.prioridade:4, " | ")
      escreva(c.status:13, " | ")
      escreva(nomeTecnico:18, " | ")
      escreva(c.descricao, "\n")
      
   fimpara
   escreva("=================================================================================\n")
fimprocedimento

// --- Procedimento: Gerar Sumário (Relatório Aprimorado) ---
procedimento gerarSumario()
var
   i, abertos, emAndamento, concluidos, escalonados: inteiro
inicio
   limpatela
   escreva("=========================================\n")
   escreva("=       SUMÁRIO DE ATENDIMENTO        =\n")
   escreva("=========================================\n")
   
   
   // --- LÓGICA DE RELATÓRIO APRIMORADA ---
   // Calcula as estatísticas do zero, garantindo 100% de precisão
   abertos <- 0
   emAndamento <- 0
   concluidos <- 0
   escalonados <- 0
   
   para i de 1 até totalChamados faca
      escolha chamados[i].status
         caso "Aberto"
            abertos <- abertos + 1
         caso "Em Andamento"
            emAndamento <- emAndamento + 1
         caso "Concluído"
            concluidos <- concluidos + 1
         caso "Escalonado"
            escalonados <- escalonados + 1
      fimescolha
   fimpara
   
   escreva("Total de Chamados: ", totalChamados, "\n")
   escreva("-----------------------------------------\n")
   escreva("Chamados Abertos (aguardando): ", abertos, "\n")
   escreva("Chamados Em Andamento: ", emAndamento, "\n")
   escreva("Chamados Concluídos: ", concluidos, "\n")
   escreva("Chamados Escalonados: ", escalonados, "\n")
   escreva("=========================================\n")
   
   escreva("\n--- Desempenho dos Técnicos (Concluídos) ---\n")
   para i de 1 até totalTecnicos faca
      escreva(tecnicos[i].nome, ": ", tecnicos[i].chamadosAtendidos, " chamados\n")
   fimpara
   escreva("=========================================\n")
fimprocedimento

// --- Bloco Principal (Início da Execução) ---
inicio
   totalChamados <- 0
   totalTecnicos <- 0
   opcao <- -1
   
   // Menu Principal
   repita
      limpatela
      escreva("=========================================\n")
      escreva("=   Sistema de Atendimento de Chamados  =\n")
      escreva("=========================================\n")
      escreva(" Técnicos: ", totalTecnicos, "/", LIMITE_TECNICOS, " | Chamados: ", totalChamados, "/", LIMITE_CHAMADOS, "\n")
      escreva("=========================================\n")
      escreva("1. Adicionar Técnico\n")
      escreva("2. Adicionar Chamado\n")
      escreva("3. Atribuir Técnico a Chamado\n")
      escreva("4. Atualizar Status de Chamado (Concluir/Escalonar)\n")
      escreva("5. Listar Todos os Chamados (Relatório Detalhado)\n")
      escreva("6. Gerar Sumário (Dashboard)\n")
      escreva("0. Sair\n")
      escreva("-----------------------------------------\n")
      escreva("Escolha uma opção: ")
      leia(opcao)

      escolha opcao
         caso 1
            adicionarTecnico()
            Pausar()
         caso 2
            adicionarChamado()
            Pausar()
         caso 3
            atribuirTecnico()
            Pausar()
         caso 4
            atualizarStatusChamado()
            Pausar()
         caso 5
            listarChamados()
            Pausar()
         caso 6
            gerarSumario()
            Pausar()
         caso 0
            escreva("\nSaindo do Sistema de Atendimento de Chamados...\n")
         padrão
            escreva("\n[ERRO] Opção inválida.\n")
            Pausar()
      fimescolha
      
   até (opcao = 0)
fimalgoritmo
