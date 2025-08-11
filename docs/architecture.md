# Arquitetura do aplicativo Ibiê

Este documento descreve a organização de pastas que foram utilizadas para prouzir o aplicativo, explicando mais especificamente a função de cada diretório incluso na pasta lib/ do projeto.

### Definição da Arquitetura

Este projeto adota uma arquitetura modular em camadas, seguindo princípios próximos ao MVVM (Model–View–ViewModel) e ao Clean Architecture simplificado. A estrutura separa claramente configuração, dados, apresentação e utilitários, organizando o código por responsabilidade.

## Estrutura Geral

    lib/
    │
    ├── config/
    │ ├── my_app.dart
    │ └── routes.dart
    │
    ├── data/
    │ ├── repositories/
    │ ├── services/
    │ └── models/
    │
    ├── ui/
    │ ├── activities/
    │ ├── activity_form/
    │ ├── auth/
    │ ├── home/
    │ ├── profile/
    │ └── widgets/
    │
    ├── utils/
    │
    └── main.dart

## Descrição de pastas e arquivos

### config/

Contém arquivos centrais do aplicativo:
my_app.dart é o arquivo responsável por inicializar a aplicação Flutter e registrar todos os serviços e repositórios necessários para o funcionamento do app.

routes.dart define o mapeamento de rotas nomeadas do aplicativo, conectando as URLs internas a páginas específicas, injentando seus ViewModels e dependência necessárias.

### data/

Camada de dados que contém serviços e repositórios. Representando o gerenciamento de dados e a comunicação com APIs, respectivamente.

### models/

Classes que representam as estruturas de dados utilizadas no aplicativo. Incluindo a estrutura de dados dos usuários e as atividades que são registradas.

### ui/

Organiza a camada de apresentação do aplicativo em módulos e páginas. Nela é armazenada os widgets utilizados na aplicação, além de separar em pastas cada página de acordo com seus respectivos escopos. Como por exemplo, todas as páginas relacionadas as atividades, ou todas as páginas relacionadas ao perfil do usuário.

### utils/

Funções utilitárias e auxiliadoras que podem ser utilizadas em todo o projeto.

### main.dart

Ponto de entrada da aplicação, responsável pela inicialização do Flutter, pela configuração de serviços externos - como o banco de dados utilizado e seus respectivos recursos - e a própria execução da aplicação.
