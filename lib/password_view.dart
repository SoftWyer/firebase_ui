import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'l10n/localization.dart';
import 'trouble_signin.dart';
import 'utils.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({this.email, super.key});

  final String? email;

  @override
  State<StatefulWidget> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerPassword;

  @override
  initState() {
    super.initState();
    _controllerEmail = TextEditingController(text: widget.email);
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FFULocalizations.of(context).signInTitle), elevation: 4.0),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: FFULocalizations.of(context).emailLabel),
                  ),
                  TextField(
                    controller: _controllerPassword,
                    onSubmitted: _submit,
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: FFULocalizations.of(context).passwordLabel),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: _handleLostPassword,
                    child: Text(FFULocalizations.of(context).troubleSigningInLabel),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      resizeToAvoidBottomInset: true,
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => _connexion(context),
            child: Row(children: [Text(FFULocalizations.of(context).signInLabel)]),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
    );
  }

  void _submit(String submitted) {
    _connexion(context);
  }

  void _handleLostPassword() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return TroubleSignIn(_controllerEmail.text);
        },
      ),
    );
  }

  Future<void> _connexion(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    User? user;
    try {
      authResult = await auth.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      user = authResult.user;
      print(user);
    } catch (exception) {
      if (context.mounted) {
        String? msg = FFULocalizations.of(context).passwordInvalidMessage;
        showErrorDialog(context, msg);
      }
    }

    if (user != null) {
      if (user.emailVerified && context.mounted) {
        Navigator.pop(context, true);
      } else if (context.mounted) {
        showErrorDialog(context, FFULocalizations.of(context).checkEmailLink);
      }
    }
  }
}
