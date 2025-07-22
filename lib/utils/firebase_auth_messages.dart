String getFirebaseAuthErrorMessage(String code) {
    return switch (code) {
      'invalid-email' => 'O e-mail informado não é válido',
      'user-disabled' => 'Esta conta foi desativada',
      'user-not-found' => 'Nenhuma conta foi encontrada com este e-mail',
      'wrong-password' => 'A senha está incorreta',
      'email-already-in-use' => 'Este e-mail já está em uso',
      'operation-not-allowed' => 'Esta operação não está disponível',
      'weak-password' => 'A senha é muito fraca',
      'account-exists-with-different-credential' => 'Já existe uma conta com este e-mail usando outro método de login',
      'invalid-credential' => 'Credenciais inválidas ou expiradas',
      'invalid-verification-code' => 'Código de verificação inválido',
      'invalid-verification-id' => 'ID de verificação inválido',
      'too-many-requests' => 'Muitas tentativas. Tente novamente mais tarde.',
      'network-request-failed' => 'Sem conexão. Verifique sua internet.',
      _ => 'Erro de autenticação. Tente novamente.',
    };
  }