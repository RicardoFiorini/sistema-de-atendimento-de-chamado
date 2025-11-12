# 📞 Sistema de Atendimento de Chamados (Help Desk)

Este é um algoritmo de console robusto que simula um sistema de Help Desk de TI, implementado em Portugol. O projeto foca na **normalização de dados**, **integridade de status** e **relatórios precisos**.

Este algoritmo foi refatorado para corrigir falhas de lógica, implementar validações de dados e adicionar funcionalidades essenciais que estavam faltando.



## ✨ Funcionalidades Principais

* **1. Adicionar Técnico:**
    * Permite o cadastro de membros da equipe de suporte.
    * **Validação:** Impede o cadastro de técnicos com **nomes duplicados**.

* **2. Adicionar Chamado:**
    * Permite a abertura de novos tickets de suporte (com descrição).
    * **Validação:** Força o usuário a inserir uma prioridade válida (um número de 1 a 5).

* **3. Atribuir Técnico a Chamado:**
    * O núcleo do sistema. O usuário seleciona um chamado "Aberto" e o atribui a um técnico da lista, mudando o status para "Em Andamento".
    * **Validação:** Impede a atribuição de chamados que não estejam "Abertos".

* **4. Atualizar Status de Chamado:**
    * Permite que um chamado "Em Andamento" seja movido para "Concluído" ou "Escalonado".
    * **Lógica de Desempenho:** Ao concluir um chamado, o sistema incrementa o contador de `chamadosAtendidos` do técnico responsável.

* **5. Listar Todos os Chamados (Nova Funcionalidade):**
    * Uma funcionalidade essencial que estava faltando. Exibe uma tabela formatada de *todos* os chamados no sistema, mostrando ID, Prioridade, Status, o Responsável e a Descrição.

* **6. Gerar Sumário (Dashboard):**
    * Um relatório gerencial que calcula e exibe o *estado atual* da fila de atendimento (quantos estão Abertos, Em Andamento, Concluídos, etc.).
    * Também exibe um placar de desempenho, mostrando quantos chamados cada técnico concluiu.

## 🏛️ Estrutura e Lógica Aprimorada

Este algoritmo foi significativamente aprimorado com base em conceitos de banco de dados e lógica de sistemas:

### 1. Normalização de Dados (A Melhoria Crítica)

* **Problema Original:** O `tipo Chamado` armazenava `tecnicoResponsavel : caractere` (o *nome* do técnico).
* **Solução Aprimorada:** O `tipo Chamado` agora armazena `indiceTecnico : inteiro`. Em vez de salvar o nome "Ricardo", o sistema salva o ID `1`. Isso garante integridade total, é mais rápido e é a forma como sistemas reais funcionam.

### 2. Lógica de Relatórios (Mais Precisão, Menos Bugs)

* **Problema Original:** O sistema usava uma variável global `relatorio` que era incrementada manualmente em diferentes funções (ex: `concluirChamado`). Isso é frágil e propenso a bugs (se um chamado fosse reaberto, o contador estaria errado).
* **Solução Aprimorada:** O `tipo Relatorio` foi **completamente removido**. O procedimento `gerarSumario` (o novo relatório) agora calcula todas as estatísticas (Abertos, Em Andamento, Concluídos, etc.) *do zero* no momento em que é chamado. Ele lê o status de todos os chamados e conta. Isso garante 100% de precisão o tempo todo.

### 3. Correção da Data (`agora()`)
* O Portugol (VisualG) não possui uma função `agora()` para datas. Para manter a estrutura de dados sem quebrar o algoritmo, a função foi substituída por *strings* de placeholder (ex: "12/11/2025") para simular o registro da data.

## 🚀 Como Executar

Para executar este algoritmo, você precisará de um interpretador de Portugol.

1.  **VisualG (Recomendado):**
    * Baixe e instale o [VisualG](http://visualg.com.br/cli/).
    * Copie o código-fonte (`.alg`) do arquivo.
    * Abra o VisualG e cole o código.
    * Pressione **F9** (ou clique em "Rodar") para executar o programa.
