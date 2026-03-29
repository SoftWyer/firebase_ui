import 'package:flutter/material.dart';

import 'l10n/localization.dart';
import 'password_view.dart';
import 'utils.dart';

class EmailView extends StatefulWidget {
  final bool? passwordCheck;

  const EmailView(this.passwordCheck, {super.key});

  @override
  State<StatefulWidget> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(FFULocalizations.of(context).welcome!), elevation: 4.0),
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
                  autofocus: true,
                  onSubmitted: _submit,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: FFULocalizations.of(context).emailLabel),
                ),
              ],
            ),
          ),
        );
      },
    ),
    persistentFooterButtons: <Widget>[
      OverflowBar(
        alignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            onPressed: () => _connexion(context),
            child: Row(children: <Widget>[Text(FFULocalizations.of(context).nextButtonLabel!)]),
          ),
        ],
      ),
    ],
  );

  void _submit(String submitted) {
    _connexion(context);
  }

  Future<void> _connexion(BuildContext context) async {
    final String email = _controllerEmail.text;

    // In newer Firebase Auth versions, fetchSignInMethodsForEmail has been removed
    // Security best practice: Don't check if email exists on the client
    // Instead, present login and let Firebase handle authentication

    if (context.mounted) {
      bool? connected = await Navigator.of(context).push(
        MaterialPageRoute<bool>(
          builder: (BuildContext context) {
            return PasswordView(email);
          },
        ),
      );

      if (connected == true && context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<String?> _showDialogSelectOtherProvider(String email, List<String> providers) {
    var providerName = _providersToString(providers);
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(FFULocalizations.of(context).allReadyEmailMessage(email, providerName)!),
              const SizedBox(height: 16.0),
              Column(
                children: providers.map((String p) {
                  return ElevatedButton(
                    child: Row(children: <Widget>[Text(_providerStringToButton(p)!)]),
                    onPressed: () {
                      Navigator.of(context).pop(p);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Row(children: <Widget>[Text(FFULocalizations.of(context).cancelButtonLabel!)]),
            onPressed: () {
              Navigator.of(context).pop('');
            },
          ),
        ],
      ),
    );
  }

  String _providersToString(List<String> providers) {
    return providers
        .map((String provider) {
          ProvidersTypes? type = stringToProvidersType(provider);
          return providersDefinitions(context)[type!]?.name;
        })
        .join(', ');
  }

  String? _providerStringToButton(String provider) {
    ProvidersTypes? type = stringToProvidersType(provider);
    return providersDefinitions(context)[type!]?.label;
  }
}
