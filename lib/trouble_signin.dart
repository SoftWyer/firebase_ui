import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'l10n/localization.dart';
import 'utils.dart';

class TroubleSignIn extends StatefulWidget {
  final String email;

  const TroubleSignIn(this.email, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TroubleSignInState();
}

class _TroubleSignInState extends State<TroubleSignIn> {
  TextEditingController? _controllerEmail;

  @override
  initState() {
    super.initState();
    _controllerEmail = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    _controllerEmail!.text = widget.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(FFULocalizations.of(context).recoverPasswordTitle!),
        elevation: 4.0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: FFULocalizations.of(context).emailLabel),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        FFULocalizations.of(context).recoverHelpLabel!,
                        style: Theme.of(context).textTheme.caption,
                      )),
                  //const SizedBox(height: 5.0),
                ],
              ),
            ),
          );
        },
      ),
      persistentFooterButtons: <Widget>[
        ButtonBar(
          alignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
                onPressed: () => _send(context),
                child: Row(
                  children: <Widget>[
                    Text(FFULocalizations.of(context).sendButtonLabel!),
                  ],
                )),
          ],
        )
      ],
    );
  }

  _send(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: _controllerEmail!.text);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (exception) {
      showErrorDialog(context, exception.toString());
    }

    if (mounted) {
      showErrorDialog(context, FFULocalizations.of(context).recoverDialog(_controllerEmail!.text));
    }
  }
}
