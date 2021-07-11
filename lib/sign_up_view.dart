import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
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
  final String email;
  final bool passwordCheck;

  SignUpView(this.email, this.passwordCheck, {Key key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerDisplayName;
  // TextEditingController _controllerPassword;
  // TextEditingController _controllerCheckPassword;

  final FocusNode _focusPassword = FocusNode();

  bool _valid = false;

  @override
  dispose() {
    _focusPassword.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _controllerEmail = TextEditingController(text: widget.email);
    _controllerDisplayName = TextEditingController();
    // _controllerPassword = TextEditingController();
    // _controllerCheckPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _controllerEmail.text = widget.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(FFULocalizations.of(context).signUpTitle),
        elevation: 4.0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 8.0),
                Text(
                  'After saving, check your email for a password reset link and then log in again',
                ),
                TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onSubmitted: _submit,
                  decoration: InputDecoration(labelText: FFULocalizations.of(context).emailLabel),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _controllerDisplayName,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onChanged: _checkValid,
                  onSubmitted: _submitDisplayName,
                  decoration: InputDecoration(labelText: FFULocalizations.of(context).nameLabel),
                ),
                const SizedBox(height: 8.0),
                // TextField(
                //   controller: _controllerPassword,
                //   obscureText: true,
                //   autocorrect: false,
                //   onSubmitted: _submit,
                //   focusNode: _focusPassword,
                //   decoration: InputDecoration(labelText: FFULocalizations.of(context).passwordLabel),
                // ),
                // !widget.passwordCheck
                //     ? Container()
                //     : TextField(
                //         controller: _controllerCheckPassword,
                //         obscureText: true,
                //         autocorrect: false,
                //         decoration: InputDecoration(labelText: FFULocalizations.of(context).passwordCheckLabel),
                //       ),
              ],
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
                onPressed: _valid ? () => _connexion(context) : null,
                child: Row(
                  children: <Widget>[
                    Text(FFULocalizations.of(context).saveLabel),
                  ],
                )),
          ],
        )
      ],
    );
  }

  _submitDisplayName(String submitted) {
    FocusScope.of(context).requestFocus(_focusPassword);
  }

  _submit(String submitted) {
    _connexion(context);
  }

  _connexion(BuildContext context) async {
    // if (widget.passwordCheck && _controllerPassword.text != _controllerCheckPassword.text) {
    //   showErrorDialog(context, FFULocalizations.of(context).passwordCheckError);
    //   return;
    // }

    String email = _controllerEmail.text;

    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: _randomString(16),
      );
      User user = authResult.user;
      try {
        await user.updateDisplayName(_controllerDisplayName.text);

        _auth.sendPasswordResetEmail(
          email: email,
        );

        _auth.signOut();

        Navigator.pop(context, true);
      } catch (e) {
        String msg = "An error occurred: $e";
        print(msg);
        // showErrorDialog(context, msg);
      }
    } on PlatformException catch (e) {
      print(e);
      //TODO improve errors catching
      String msg = e?.message;
      showErrorDialog(context, msg);
    }
  }

  void _checkValid(String value) {
    setState(() {
      _valid = _controllerDisplayName.text.isNotEmpty;
    });
  }
}
