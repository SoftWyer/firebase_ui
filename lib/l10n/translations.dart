import 'dart:ui' show Locale;

class TranslationBundle {
  const TranslationBundle(this.parent);
  final TranslationBundle? parent;

  String? get welcome => parent?.welcome;

  String? get signUpTitle => parent?.signUpTitle;

  String? get emailLabel => parent?.emailLabel;

  String? get nextButtonLabel => parent?.nextButtonLabel;

  String? get cancelButtonLabel => parent?.cancelButtonLabel;

  String? get passwordLabel => parent?.passwordLabel;

  String? get passwordCheckLabel => parent?.passwordCheckLabel;

  String? get passwordCheckError => parent?.passwordCheckError;

  String? get troubleSigningInLabel => parent?.troubleSigningInLabel;

  String? get signInLabel => parent?.signInLabel;

  String? get signInTitle => parent?.signInTitle;

  String? get passwordInvalidMessage => parent?.passwordInvalidMessage;

  String? get checkEmailLink => parent?.checkEmailLink;

  String? get recoverPasswordTitle => parent?.recoverPasswordTitle;

  String? get recoverHelpLabel => parent?.recoverHelpLabel;

  String? get sendButtonLabel => parent?.sendButtonLabel;

  String? get nameLabel => parent?.nameLabel;

  String? get saveLabel => parent?.saveLabel;

  String? get passwordLengthMessage => parent?.passwordLengthMessage;

  String? get signInGoogle => parent?.signInGoogle;
  String? get signInApple => parent?.signInApple;
  String? get signInEmail => parent?.signInEmail;
  String? get signInGuest => parent?.signInGuest;

  String? get errorOccurred => parent?.errorOccurred;

  allReadyEmailMessage(String email, String providerName) => parent?.allReadyEmailMessage(email, providerName);

  recoverDialog(String email) => parent?.recoverDialog(email);
}

// ignore: camel_case_types
class _Bundle_fr extends TranslationBundle {
  const _Bundle_fr() : super(null);

  @override
  String get welcome => r'Bienvenue';
  @override
  String get signUpTitle => 'Enregistrer un nouvel utilisateur';
  @override
  String get emailLabel => r'Adresse mail';
  @override
  String get passwordLabel => r'Mot de passe';

  @override
  String get passwordCheckLabel => r'Confirmez le mot de passe';

  @override
  String get passwordCheckError => r'Les deux mots de passe sont différents.';

  @override
  String get nextButtonLabel => r'SUIVANT';
  @override
  String get cancelButtonLabel => r'ANNULER';
  @override
  String get signInLabel => r'CONNEXION';

  @override
  String get saveLabel => r'ENREGISTRER';

  @override
  String get signInTitle => r'Connexion';

  @override
  String get troubleSigningInLabel => 'Difficultés à se connecter ?';

  @override
  String get passwordInvalidMessage => 'Le mot de passe est invalide ou l\'utilisateur n\'a pas de mot de passe.';

  @override
  String get recoverPasswordTitle => r'Récupérer mot de passe';

  @override
  String get recoverHelpLabel =>
      r'Obtenez des instructions envoyées à cet e-mail pour expliquer comment réinitialiser votre mot de passe';

  @override
  String get sendButtonLabel => r'ENVOYER';

  @override
  String get nameLabel => r'Nom et prénom';

  @override
  String get errorOccurred => r'Une erreur est survenue';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''Vous avez déjà utilisé $email.
Connectez-vous avec $providerName pour continuer.''';
  }

  @override
  recoverDialog(String email) {
    return 'Suivez les instructions envoyées à $email pour retrouver votre mot de passe';
  }

  @override
  String get passwordLengthMessage => r'Le mot de passe doit comporter 6 caractères ou plus';

  @override
  String get signInGoogle => r'Connexion avec Google';

  @override
  String get signInApple => r'Connexion avec Apple';

  @override
  String get signInEmail => r'Connexion avec email';

  @override
  String get signInGuest => r"Continuer en tant qu'invité";
}

// ignore: camel_case_types
class _Bundle_en extends TranslationBundle {
  const _Bundle_en() : super(null);

  @override
  String get welcome => r'Welcome';
  @override
  String get signUpTitle => 'Register new user';
  @override
  String get emailLabel => r'Email';
  @override
  String get passwordLabel => r'Password';

  @override
  String get passwordCheckLabel => r'Confirm the password';

  @override
  String get checkEmailLink => r'Check email for password reset link';

  @override
  String get passwordCheckError => r'The two passwords are different';

  @override
  String get nextButtonLabel => r'NEXT';
  @override
  String get cancelButtonLabel => r'CANCEL';
  @override
  String get signInLabel => r'SIGN IN';
  @override
  String get signInTitle => r'Sign in';

  @override
  String get saveLabel => r'SAVE';

  @override
  String get troubleSigningInLabel => 'Trouble signing in ?';

  @override
  String get passwordInvalidMessage => 'The password is invalid or the user does not have password.';

  @override
  String get recoverPasswordTitle => r'Recover password';

  @override
  String get recoverHelpLabel => r'Get instructions sent to this email that explain how to reset your password';

  @override
  String get sendButtonLabel => r'SEND';

  @override
  String get nameLabel => r'First & last name';

  @override
  String get errorOccurred => r'An error occurred';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''You have already used $email.
Sign in with $providerName to continue.''';
  }

  @override
  recoverDialog(String email) {
    return 'Follow the instructions sent to $email to recover your password';
  }

  @override
  String get passwordLengthMessage => r'The password must be 6 characters long or more';

  @override
  String get signInGoogle => r'Sign in with Google';

  @override
  String get signInApple => r'Sign in with Apple';

  @override
  String get signInEmail => r'Sign in with email';

  @override
  String get signInGuest => r'Continue as a guest';
}

class _Bundle_nl extends TranslationBundle {
  const _Bundle_nl() : super(null);

  @override
  String get welcome => r'Welkom';
  @override
  String get signUpTitle => 'Registreer nieuwe gebruiker';
  @override
  String get emailLabel => r'E-mailadres';
  @override
  String get passwordLabel => r'Wachtwoord';

  @override
  String get passwordCheckLabel => r'Bevestig wachtwoord';

  @override
  String get checkEmailLink => r'Controleer uw e-mail op een link om uw wachtwoord te resetten';

  @override
  String get passwordCheckError => r'De wachtwoorden zijn verschillend';

  @override
  String get nextButtonLabel => r'VOLGENDE';
  @override
  String get cancelButtonLabel => r'ANNULEREN';
  @override
  String get signInLabel => r'INLOGGEN';
  @override
  String get signInTitle => r'Inloggen';

  @override
  String get saveLabel => r'OPSLAAN';

  @override
  String get troubleSigningInLabel => 'Problemen met inloggen?';

  @override
  String get passwordInvalidMessage => 'Het wachtwoord is ongeldig of de gebruiker heeft geen wachtwoord ingesteld.';

  @override
  String get recoverPasswordTitle => r' Wachtwoord herstellen';

  @override
  String get recoverHelpLabel =>
      r'Ontvang instructies via dit e-mailadres die uitleggen hoe u uw wachtwoord kunt resetten';

  @override
  String get sendButtonLabel => r'VERZENDEN';

  @override
  String get nameLabel => r'Voornaam & Achternaam';

  @override
  String get errorOccurred => r'Er is een fout opgetreden';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return 'U heeft dit e-mailadres $email al gebruikt. Meld u aan met $providerName om door te gaan.';
  }

  @override
  recoverDialog(String email) {
    return 'Volg de instructies die naar $email zijn gestuurd om uw wachtwoord te herstellen.';
  }

  @override
  String get passwordLengthMessage => r'Het wachtwoord moet minimaal 6 tekens lang zijn.';

  @override
  String get signInGoogle => r'Inloggen met Google';

  @override
  String get signInApple => r'Inloggen met Apple';

  @override
  String get signInEmail => r'Inloggen met e-mail';

  @override
  String get signInGuest => r'Doorgaan als gast';
}

// ignore: camel_case_types
class _Bundle_de extends TranslationBundle {
  const _Bundle_de() : super(null);

  @override
  String get welcome => r'Willkommen';
  @override
  String get signUpTitle => 'Neuen Benutzer registrieren';
  @override
  String get emailLabel => r'Email';
  @override
  String get passwordLabel => r'Passwort';

  @override
  String get passwordCheckLabel => r'Bestätigen Sie das Passwort';

  @override
  String get checkEmailLink => r'Check email for password reset link';

  @override
  String get passwordCheckError => r'Die zwei Passwörter sind unterschiedlich';

  @override
  String get nextButtonLabel => r'WEITER';
  @override
  String get cancelButtonLabel => r'ABBRUCH';
  @override
  String get signInLabel => r'ANMELDEN';
  @override
  String get signInTitle => r'Anmelden';

  @override
  String get saveLabel => r'SPEICHERN';

  @override
  String get troubleSigningInLabel => 'Probleme beim Anmelden?';

  @override
  String get passwordInvalidMessage => 'Das Passwort ist ungültig oder der Bentutzer hat kein Passwort.';

  @override
  String get recoverPasswordTitle => r'Passwort wiederherstellen';

  @override
  String get recoverHelpLabel => r'Erhalte Anweisungen zum Wiederherstellen des Passworts an diese Email';

  @override
  String get sendButtonLabel => r'SENDEN';

  @override
  String get nameLabel => r'Vor- & Nachname';

  @override
  String get errorOccurred => r'Ein Fehler ist aufgetreten';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''$email wurde bereits genutzt.
Mit $providerName anmelden um fortzufarhen.''';
  }

  @override
  recoverDialog(String email) {
    return 'Befolge die Anweisungen, welche an $email gesendet wurden um das Passswort wiederherzustellen';
  }

  @override
  String get passwordLengthMessage => r'Das Passwort muss 6 oder mehr Zeichen haben';

  @override
  String get signInGoogle => r'Mit Google anmelden';

  @override
  String get signInApple => r'Mit Apple anmelden';

  @override
  String get signInEmail => r'Mit Email anmelden';

  @override
  String get signInGuest => r'Als Gast fortfahren';
}

// ignore: camel_case_types
class _Bundle_pt extends TranslationBundle {
  const _Bundle_pt() : super(null);

  @override
  String get welcome => r'Bem-Vindo';
  @override
  String get signUpTitle => 'Registrar novo usuário';
  @override
  String get emailLabel => r'E-mail';
  @override
  String get passwordLabel => r'Senha';

  @override
  String get passwordCheckLabel => r'Confirme a senha';

  @override
  String get checkEmailLink => r'Check email for password reset link';

  @override
  String get passwordCheckError => r'As senhas são diferentes';

  @override
  String get nextButtonLabel => r'PRÓXIMA';
  @override
  String get cancelButtonLabel => r'CANCELAR';
  @override
  String get signInLabel => r'FAZER LOGIN';
  @override
  String get signInTitle => r'Fazer login';

  @override
  String get saveLabel => r'SALVAR';

  @override
  String get troubleSigningInLabel => 'Problemas ao fazer login ?';

  @override
  String get passwordInvalidMessage => 'A senha é inválida ou o usuário não possui uma senha.';

  @override
  String get recoverPasswordTitle => r'Recuperar a senha';

  @override
  String get recoverHelpLabel =>
      r'Siga as instruções enviadas para esse e-mail para descobrir como redefinir sua senha';

  @override
  String get sendButtonLabel => r'ENVIAR';

  @override
  String get nameLabel => r'Nome e sobrenome';

  @override
  String get errorOccurred => r'Ocorreu um erro';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''Você já usou o e-mail $email.
Faça login com o $providerName para continuar.''';
  }

  @override
  recoverDialog(String email) {
    return 'Siga as instruções enviadas para $email para recuperar sua senha';
  }

  @override
  String get passwordLengthMessage => r'A senha deve ter pelo menos 6 caracteres';

  @override
  String get signInGoogle => r'Login com o Google';

  @override
  String get signInApple => r'Login com o Apple';

  @override
  String get signInEmail => r'Login com o e-mail';

  @override
  String get signInGuest => r'Continuar como convidado';
}

// ignore: camel_case_types
class _Bundle_es extends TranslationBundle {
  const _Bundle_es() : super(null);

  @override
  String get welcome => r'Bienvenido';
  @override
  String get emailLabel => r'Email';
  @override
  String get passwordLabel => r'Contraseña';

  @override
  String get passwordCheckLabel => r'Confirma la contraseña';

  @override
  String get checkEmailLink => r'Check email for password reset link';

  @override
  String get passwordCheckError => r'Las contraseñas no coinciden';

  @override
  String get nextButtonLabel => r'SIGUIENTE';
  @override
  String get cancelButtonLabel => r'CANCELAR';
  @override
  String get signInLabel => r'ENTRAR';
  @override
  String get signInTitle => r'Entrar';

  @override
  String get saveLabel => r'GUARDAR';

  @override
  String get troubleSigningInLabel => 'Problemas para entrar ?';

  @override
  String get passwordInvalidMessage => 'La contraseña es inválida o el usuario no tiene contraseña.';

  @override
  String get recoverPasswordTitle => r'Recuperar contraseña';

  @override
  String get recoverHelpLabel =>
      r'Sigue las instrucciones enviadas a este email para descubrir cómo reiniciar tu contraseña';

  @override
  String get sendButtonLabel => r'ENVIAR';

  @override
  String get nameLabel => r'Nombres y apellidos';

  @override
  String get errorOccurred => r'Occurió un error';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''Ya has usado el email $email.
Entra con $providerName para continuar.''';
  }

  @override
  recoverDialog(String email) {
    return 'Siga las instrucciones enviadas a $email para recuperar tu contraseña';
  }

  @override
  String get passwordLengthMessage => r'La contraseña debe tener 6 o más caracteres';

  @override
  String get signInGoogle => r'Entrar con Google';

  @override
  String get signInApple => r'Entrar con Apple';

  @override
  String get signInEmail => r'Entrar con email';

  @override
  String get signInGuest => r'Continua como invitado';
}

// ignore: camel_case_types
class _Bundle_ja extends TranslationBundle {
  const _Bundle_ja() : super(null);

  @override
  String get welcome => r'ようこそ';
  @override
  String get emailLabel => r'メールアドレス';
  @override
  String get passwordLabel => r'パスワード';

  @override
  String get passwordCheckLabel => r'パスワードを確認';

  @override
  String get checkEmailLink => r'パスワードリセットリンクのメールをご確認ください';

  @override
  String get passwordCheckError => r'パスワードが一致しません';

  @override
  String get nextButtonLabel => r'次へ';
  @override
  String get cancelButtonLabel => r'キャンセル';
  @override
  String get signInLabel => r'サインイン';
  @override
  String get signInTitle => r'サインイン';

  @override
  String get saveLabel => r'保存';

  @override
  String get troubleSigningInLabel => 'サインインに問題がありますか？';

  @override
  String get passwordInvalidMessage => 'パスワードが無効であるか、ユーザーがパスワードを設定していません。';

  @override
  String get recoverPasswordTitle => r'パスワードを復元';

  @override
  String get recoverHelpLabel => r'このメールアドレスに、パスワードのリセット方法を説明した手順を送信します';

  @override
  String get sendButtonLabel => r'送信';

  @override
  String get nameLabel => r'名前と姓';

  @override
  String get errorOccurred => r'エラーが発生しました';

  @override
  allReadyEmailMessage(String email, String providerName) {
    return '''すでに $email を使用しています。
    続行するには、$providerName でサインインしてください。''';
  }

  @override
  recoverDialog(String email) {
    return 'に送信された手順に従ってパスワードを復元してください';
  }

  @override
  String get passwordLengthMessage => r'パスワードは 6 文字以上でなければなりません';

  @override
  String get signInGoogle => r'Google でサインイン';

  @override
  String get signInApple => r'Apple でサインイン';

  @override
  String get signInEmail => r'メールでサインイン';

  @override
  String get signInGuest => r'ゲストとして続行';
}

TranslationBundle translationBundleForLocale(Locale locale) {
  switch (locale.languageCode) {
    case 'fr':
      return const _Bundle_fr();
    case 'en':
      return const _Bundle_en();
    case 'de':
      return const _Bundle_de();
    case 'pt':
      return const _Bundle_pt();
    case 'es':
      return const _Bundle_es();
    case 'ja':
      return const _Bundle_ja();
    case 'nl':
      return const _Bundle_nl();
  }
  return const _Bundle_en();
}
