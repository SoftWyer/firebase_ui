// ignore_for_file: camel_case_types

import 'dart:ui' show Locale;

sealed class TranslationBundle {
  const TranslationBundle();

  String get welcome;

  String get signUpTitle;

  String get emailLabel;

  String get nextButtonLabel;

  String get cancelButtonLabel;

  String get passwordLabel;

  String get passwordCheckLabel;

  String get passwordCheckError;

  String get troubleSigningInLabel;

  String get signInLabel;

  String get signInTitle;

  String get passwordInvalidMessage;

  String get checkEmailLink;

  String get recoverPasswordTitle;

  String get recoverHelpLabel;

  String get checkEmailLinkSaved;

  String get signUpLabel;

  String get sendButtonLabel;

  String get nameLabel;

  String get saveLabel;

  String get passwordLengthMessage;

  String get signInGoogle;
  String get signInApple;
  String get signInEmail;
  String get signInGuest;

  String get errorOccurred;

  String get alreadyHaveAnAccount;

  String get createAnAccount;

  String allReadyEmailMessage(String email, String providerName);

  String recoverDialog(String email);
}

class _Bundle_fr extends TranslationBundle {
  const _Bundle_fr();

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
  String get checkEmailLinkSaved =>
      r'Après avoir enregistré, vérifiez votre courrier électronique pour un lien de réinitialisation du mot de passe, puis reconnectez-vous';

  @override
  String get signUpLabel => r'S inscrire';

  @override
  String get sendButtonLabel => r'ENVOYER';

  @override
  String get nameLabel => r'Nom et prénom';

  @override
  String get errorOccurred => r'Une erreur est survenue';

  @override
  String get alreadyHaveAnAccount => r'Se connecter si vous avez déjà un compte';

  @override
  String get createAnAccount => 'Créer un compte si vous n\'en avez pas un';

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

  @override
  String get checkEmailLink => r'Vérifiez votre courrier électronique pour un lien de réinitialisation du mot de passe';
}

class _Bundle_en extends TranslationBundle {
  const _Bundle_en();

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
  String get checkEmailLinkSaved => r'After saving, check your email for a password reset link and then log in again';

  @override
  String get signUpLabel => r'Sign up';

  @override
  String get sendButtonLabel => r'SEND';

  @override
  String get nameLabel => r'First & last name';

  @override
  String get errorOccurred => r'An error occurred';

  @override
  String get alreadyHaveAnAccount => r'Sign in if you already have an account';

  @override
  String get createAnAccount => 'Create an account if you don\'t have one';

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
  const _Bundle_nl();

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
  String get checkEmailLinkSaved =>
      r'Sla op en controleer vervolgens uw e-mail op een link om uw wachtwoord te resetten en log daarna opnieuw in';

  @override
  String get signUpLabel => r'Aanmelden';

  @override
  String get sendButtonLabel => r'VERZENDEN';

  @override
  String get nameLabel => r'Voornaam & Achternaam';

  @override
  String get errorOccurred => r'Er is een fout opgetreden';

  @override
  String get alreadyHaveAnAccount => r'Meld u aan als u al een account heeft';

  @override
  String get createAnAccount => 'Maak een account aan als u er geen heeft';

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

class _Bundle_de extends TranslationBundle {
  const _Bundle_de();

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
  String get checkEmailLink => r'Überprüfen Sie Ihre E-Mail auf einen Link zum Zurücksetzen des Passworts';

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
  String get checkEmailLinkSaved =>
      r'Nach dem Speichern überprüfen Sie Ihre E-Mail auf einen Link zum Zurücksetzen des Passworts und melden Sie sich erneut an';

  @override
  String get signUpLabel => r'Registrieren';

  @override
  String get sendButtonLabel => r'SENDEN';

  @override
  String get nameLabel => r'Vor- & Nachname';

  @override
  String get errorOccurred => r'Ein Fehler ist aufgetreten';

  @override
  String get alreadyHaveAnAccount => r'Melden Sie sich an, wenn Sie bereits ein Konto haben';

  @override
  String get createAnAccount => 'Erstellen Sie ein Konto, wenn Sie kein haben';

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

class _Bundle_pt extends TranslationBundle {
  const _Bundle_pt();

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
  String get checkEmailLink => r'Verifique seu e-mail em busca de um link de redefinição de senha';

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
  String get checkEmailLinkSaved =>
      r'Depois de salvar, verifique seu e-mail em busca de um link de redefinição de senha e faça login novamente';

  @override
  String get signUpLabel => r'Cadastrar';

  @override
  String get sendButtonLabel => r'ENVIAR';

  @override
  String get nameLabel => r'Nome e sobrenome';

  @override
  String get errorOccurred => r'Ocorreu um erro';

  @override
  String get alreadyHaveAnAccount => r'Faça login se já tiver uma conta';

  @override
  String get createAnAccount => 'Crie uma conta se não tiver uma';

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

class _Bundle_es extends TranslationBundle {
  const _Bundle_es();

  @override
  String get welcome => r'Bienvenido';
  @override
  String get signUpTitle => r'Registrar nuevo usuario';
  @override
  String get emailLabel => r'Email';
  @override
  String get passwordLabel => r'Contraseña';

  @override
  String get passwordCheckLabel => r'Confirma la contraseña';

  @override
  String get checkEmailLink => r'Verifique su correo electrónico en busca de un vínculo para restablecer la contraseña';

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
  String get checkEmailLinkSaved =>
      r'Después de guardar, revise su correo electrónico en busca de un vínculo para restablecer la contraseña e inicie sesión nuevamente';

  @override
  String get signUpLabel => r'Registrarse';

  @override
  String get sendButtonLabel => r'ENVIAR';

  @override
  String get nameLabel => r'Nombres y apellidos';

  @override
  String get errorOccurred => r'Occurió un error';

  @override
  String get alreadyHaveAnAccount => r'Inicia sesión si ya tienes una cuenta';

  @override
  String get createAnAccount => 'Crea una cuenta si no tienes una';

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

class _Bundle_ja extends TranslationBundle {
  const _Bundle_ja();

  @override
  String get welcome => r'ようこそ';
  @override
  String get signUpTitle => r'新規登録';
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
  String get checkEmailLinkSaved => r'保存後、メールでパスワードリセットリンクを確認し、再度ログインしてください';

  @override
  String get signUpLabel => r'新規登録';

  @override
  String get sendButtonLabel => r'送信';

  @override
  String get nameLabel => r'名前と姓';

  @override
  String get errorOccurred => r'エラーが発生しました';

  @override
  String get alreadyHaveAnAccount => r'すでにアカウントをお持ちの場合はサインインしてください';

  @override
  String get createAnAccount => r'アカウントをお持ちでない場合はアカウントを作成してください';

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
