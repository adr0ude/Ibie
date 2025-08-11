# Integração com Supabase

## 1. Visão Geral

O módulo StorageService é responsável por gerenciar o upload e a exclusão de imagens no Supabase Storage, tanto para usuários quanto para atividades.  
Ele é utilizado em dois contextos principais do aplicativo:

- _Cadastro e edição de usuários_ (foto de perfil)
- _Cadastro e edição de atividades_ (imagem associada à atividade)

Em ambos os casos, o upload da imagem é realizado _antes_ do objeto (usuário ou atividade) ser criado no banco de dados.  
Dessa forma, quando o registro é criado, apenas a _URL pública_ gerada pelo Supabase é armazenada, garantindo que o link já esteja disponível e acessível.

---

## 2. Funcionalidades

- _Upload de imagens de usuário_: Envia fotos de perfil para o bucket profile-pictures.
- _Exclusão de imagens de usuário_: Remove fotos antigas ou não utilizadas do bucket profile-pictures.
- _Upload de imagens de atividade_: Envia imagens associadas a atividades para o bucket activity-pictures.
- _Exclusão de imagens de atividade_: Remove imagens antigas ou substituídas do bucket activity-pictures.

---

## 3. Buckets Utilizados

- **profile-pictures** → Armazena imagens de perfil dos usuários.
- **activity-pictures** → Armazena imagens associadas a atividades.
