### _Firebase no Projeto_

O Firebase é a plataforma backend-as-a-service (BaaS) principal do projeto, sendo utilizado para gerenciar a autenticação e persistência de dados.

#### _Serviços Utilizados_

- _Auth_: Responsável por todo o sistema de autenticação, incluindo login e registro de usuários. Utiliza login com e-mail/senha e Google Sign-In.
- _Cloud Firestore_: Banco de dados NoSQL usado para armazenar informações de perfil dos usuários.

#### _Fluxos Importantes_

1.  _Cadastro/Login Manual_
    - A lógica de cadastro e login por e-mail e senha está implementada no arquivo lib/services/auth_service.dart.
    - A função signUpEmail é responsável por criar novos usuários.
    - A função loginEmail lida com o processo de autenticação de usuários já existentes.
2.  _Recuperação de Senha e Logout_
    - O serviço também é responsável por fluxos de manutenção da conta. A função sendPasswordResetEmail permite a recuperação de senha por e-mail, e a função logOutFirebase gerencia o encerramento da sessão do usuário.

#### _Observações_

- As regras de segurança do Firestore estão configuradas para garantir que usuários autenticados só possam ler e escrever seus próprios dados, seguindo o princípio do acesso mínimo.
- O ID do projeto Firebase é ibie-793ca e o storage_bucket associado é ibie-793ca.firebasestorage.app.
