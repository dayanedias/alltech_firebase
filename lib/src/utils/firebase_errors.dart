String getErrorString(String code){

  print("Error - ${code}");

  switch (code) {
    case 'weak-password':
      return 'Sua senha é muito fraca.';

    case 'invalid-email':
      return 'Seu e-mail é inválido.';

    case 'account-exists-with-different-credential':
      return 'E-mail já está sendo utilizado em outra conta.';

    case 'invalid-credential':
      return 'Seu e-mail é inválido.';

    case 'wrong-password':
      return 'Senha incorreta.';

    case 'user-not-found':
      return 'Usuário não cadastrado';

    case 'user-disabled':
      return 'Este usuário foi desabilitado.';

    case 'operation-not-allowed':
      return 'Muitas solicitações. Tente novamente mais tarde.';

    case 'operation-not-allowed':
      return 'Operação não permitida.';

    default:
      return 'Um erro indefinido ocorreu.';
  }
}