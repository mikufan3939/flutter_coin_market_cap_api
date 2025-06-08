# Consumo API CoinMarketCap com Flutter

Repositório para atividade prática da matéria de Programação para Dispositivos Móveis do curso de Análise e Desenvolvimento de Sistemas da Unicesumar.

O projeto consiste no consumo de uma API de criptomoedas para exibição de diversas moedas, listando sua sigla, nome e preços em dólares e reais. O projeto permite realizar a pesquisa de várias moedas simultaneamente.

## Arquitetura

O projeto foi desenvolvido tendo em mente a arquitetura MVVM, com as seguintes camadas:

*   **Data:**
    *   `DataSource`: Responsável por fazer a requisição para a API.
    *   `Repository`: Processa a resposta da requisição.
*   **Domain:**
    *   Possui a entidade `Coin` para modelagem da resposta da API.
*   **UI:**
    *   `View`: Consiste na tela com os widgets.
    *   `ViewModel`: Possui a lógica com o controle de estado.

## Execução

Para executar o projeto, siga os seguintes passos:

1.  Execute `flutter pub get` na raíz do projeto para instalação de dependências.
2.  Use `flutter run` com um emulador para rodar o projeto, pois a execução em navegador previne o CrossOrigin necessário para conexão com a API.
