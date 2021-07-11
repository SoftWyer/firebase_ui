import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum ProvidersTypes { email, google, apple, guest, phone }

final GoogleSignIn googleSignIn = GoogleSignIn();

ProvidersTypes stringToProvidersType(String value) {
  if (value.toLowerCase().contains('google')) return ProvidersTypes.google;
  if (value.toLowerCase().contains('apple')) return ProvidersTypes.apple;
  if (value.toLowerCase().contains('password')) return ProvidersTypes.email;
  if (value.toLowerCase().contains('guest')) return ProvidersTypes.guest;
  return null;
}

// Description button
class ButtonDescription extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color color;
  final String logo;
  final IconData icon;
  final String name;
  final VoidCallback onSelected;

  const ButtonDescription(
      {@required this.label,
      @required this.name,
      this.logo,
      this.icon,
      this.onSelected,
      this.labelColor = Colors.grey,
      this.color = Colors.white});

  ButtonDescription copyWith({
    String label,
    Color labelColor,
    Color color,
    String logo,
    IconData icon,
    String name,
    VoidCallback onSelected,
  }) {
    return ButtonDescription(
        label: label ?? this.label,
        labelColor: labelColor ?? this.labelColor,
        color: color ?? this.color,
        logo: logo ?? this.logo,
        icon: icon ?? this.icon,
        name: name ?? this.name,
        onSelected: onSelected ?? this.onSelected);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
              child: icon != null
                  ? Icon(icon, color: labelColor, size: 30)
                  : Image.asset('assets/$logo', package: 'firebase_ui', height: 30),
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: labelColor),
              ),
            ),
          ],
        ),
        onPressed: onSelected ?? null);
  }
}

Map<ProvidersTypes, ButtonDescription> providersDefinitions(BuildContext context) => {
      ProvidersTypes.google: ButtonDescription(
          color: Theme.of(context).cardColor,
          logo: "go-logo.png",
          label: FFULocalizations.of(context).signInGoogle,
          name: "Google",
          labelColor: Colors.black87),
      ProvidersTypes.apple: ButtonDescription(
          color: Colors.black,
          logo: "apple.png",
          label: FFULocalizations.of(context).signInApple,
          name: "Apple",
          labelColor: Colors.white),
      ProvidersTypes.email: ButtonDescription(
          color: const Color.fromRGBO(219, 68, 55, 1.0),
          logo: "email-logo.png",
          label: FFULocalizations.of(context).signInEmail,
          name: "Email",
          labelColor: Colors.white),
      ProvidersTypes.guest: ButtonDescription(
          color: const Color.fromRGBO(244, 180, 0, 1.0),
          icon: Icons.person,
          label: FFULocalizations.of(context).signInGuest,
          name: "guest",
          labelColor: Colors.white),
    };

Future<Null> showErrorDialog(BuildContext context, String message, {String title, bool barrierDismissible = false}) {
  return showDialog<Null>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message ?? FFULocalizations.of(context).errorOccurred),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Row(
            children: <Widget>[
              Text(FFULocalizations.of(context).cancelButtonLabel),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

Future<void> signOutProviders() async {
  var currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    await signOut(currentUser.providerData);
  }

  return await FirebaseAuth.instance.signOut();
}

Future<dynamic> signOut(Iterable providers) async {
  return Future.forEach(providers, (p) async {
    switch (p.providerId) {
      // case 'facebook.com':
      //   await facebookLogin.logOut();
      //   break;
      case 'google.com':
        await googleSignIn.signOut();
        break;
    }
  });
}

///
/// Class to generate a random Nonce of arbitrary length
class Nonce {
  static final Random _random = Random.secure();

  static List<int> createCryptoRandomInt([int length = 32]) => List<int>.generate(length, (i) => _random.nextInt(256));

  static String createCryptoRandomString([int length = 32]) => base64Url.encode(Nonce.createCryptoRandomInt(length));
}
