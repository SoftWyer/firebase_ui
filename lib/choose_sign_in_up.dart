import 'package:firebase_ui/sign_up_view.dart';
import 'package:flutter/material.dart';

import 'l10n/localization.dart';
import 'password_view.dart';

class ChooseSignInUpView extends StatelessWidget {
  const ChooseSignInUpView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(FFULocalizations.of(context).welcome), elevation: 4.0),
    body: Builder(
      builder: (BuildContext context) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(FFULocalizations.of(context).alreadyHaveAnAccount),
                OutlinedButton(
                  autofocus: true,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute<bool>(
                        builder: (BuildContext context) {
                          return PasswordView();
                        },
                      ),
                    );
                  },
                  child: Text(FFULocalizations.of(context).signInTitle),
                ),
                const SizedBox(height: 16.0),
                Text(FFULocalizations.of(context).createAnAccount),
                OutlinedButton(
                  autofocus: true,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute<bool>(
                        builder: (BuildContext context) {
                          return SignUpView();
                        },
                      ),
                    );
                  },
                  child: Text(FFULocalizations.of(context).signUpLabel),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
