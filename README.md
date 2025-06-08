# Consumo API CoinMarketCap com Flutter

Repositório para atividade prática da matéria de Programação para Dispositivos Móveis do curso de Análise e Desenvolvimento de Sistemas da Unicesumar.

O projeto consiste no consumo de uma API de criptomoedas para exibição de diversas moedas, listando sua sigla, nome e preços em dólares e reais. O projeto permite realizar a pesquisa de várias moedas simultaneamente.

## Arquitetura

O projeto foi desenvolvido tendo em mente a arquitetura MVVM, com as seguintes camadas:

*   **Data:**
    *   `DataSource (coinmarket_source.dart)`: Responsável por fazer a requisição para a API.
    *   `Repository (coin_repository.dart)`: Processa a resposta da requisição.
*   **Domain:**
    *   Possui a entidade `Coin (coin_entity.dart)` para modelagem da resposta da API.
*   **UI:**
    *   `View (coins_view.dart)`: Consiste na tela com os widgets.
    *   `ViewModel (coins_viewmodel.dart)`: Possui a lógica com o controle de estado.

## Execução

Para executar o projeto, siga os seguintes passos:

1.  Execute `flutter pub get` na raíz do projeto para instalação de dependências.
2.  Use `flutter run` com um emulador para instalar o projeto como Apk, pois a execução em navegador previne o CrossOrigin necessário para conexão com a API.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d16ea02c-e78e-4d4f-a172-1445fb5ffa46" width="300">
  <img src="https://github.com/user-attachments/assets/0248557c-b905-4c8c-8d78-6185071c434a" width="300">
</p>
