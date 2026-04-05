import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'l10n/localization.dart';
import 'utils.dart';

String _randomString(int length) {
  var rand = Random();
  var codeUnits = List.generate(length, (index) {
    return rand.nextInt(33) + 89;
  });

  return String.fromCharCodes(codeUnits);
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerDisplayName;

  final _focusEmail = FocusNode();

  bool _valid = false;

  @override
  dispose() {
    _focusEmail.dispose();
    _controllerEmail.dispose();
    _controllerDisplayName.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerDisplayName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FFULocalizations.of(context).signUpTitle), elevation: 4.0),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 8.0),
                  Text(FFULocalizations.of(context).checkEmailLinkSaved),
                  TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    autocorrect: false,
                    onChanged: (_) => _checkValid(),
                    decoration: InputDecoration(labelText: FFULocalizations.of(context).emailLabel),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _controllerDisplayName,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    onChanged: (_) => _checkValid(),
                    decoration: InputDecoration(labelText: FFULocalizations.of(context).nameLabel),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _valid ? () => _connexion(context) : null,
            child: Row(children: [Text(FFULocalizations.of(context).signUpLabel)]),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
    );
  }

  Future<void> _connexion(BuildContext context) async {
    String email = _controllerEmail.text;

    final auth = FirebaseAuth.instance;
    try {
      final authResult = await auth.createUserWithEmailAndPassword(email: email, password: _randomString(16));
      final user = authResult.user!;
      try {
        await user.updateDisplayName(_controllerDisplayName.text);

        auth.sendPasswordResetEmail(email: email);

        auth.signOut();

        if (context.mounted) {
          Navigator.pop(context, true);
          Navigator.of(context).push(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                return PasswordView(email: email);
              },
            ),
          );
        }
      } catch (e) {
        String msg = 'An error occurred: $e';
        print(msg);
      }
    } on PlatformException catch (e) {
      print(e);
      if (context.mounted) {
        String? msg = e.message;
        showErrorDialog(context, msg);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (context.mounted) {
        String? msg = e.message;
        showErrorDialog(context, msg);
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        String msg = 'An error occurred: $e';
        showErrorDialog(context, msg);
      }
    }
  }

  void _checkValid() {
    setState(() {
      _valid = _controllerDisplayName.text.isNotEmpty && _controllerEmail.text.isNotEmpty;
    });
  }
}
