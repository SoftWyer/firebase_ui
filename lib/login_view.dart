import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'email_view.dart';
import 'utils.dart';

class LoginView extends StatefulWidget {
  final List<ProvidersTypes> providers;
  final bool passwordCheck;
  final double bottomPadding;

  LoginView(
      {Key key,
      @required this.providers,
      this.passwordCheck,
      @required this.bottomPadding})
      : super(key: key);

  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<ProvidersTypes, ButtonDescription> _buttons;

  _handleEmailSignIn() async {
    String value = await Navigator.of(context).push(new MaterialPageRoute<String>(builder: (BuildContext context) {
      return new EmailView(widget.passwordCheck);
    }));

    if (value != null) {
      _followProvider(value);
    }
  }

  _handleGuestSignIn() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser user = authResult.user;
      print(user);
    } catch (e) {
      showErrorDialog(context, e.details ?? e.message);
    }
  }

  _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken != null) {
        try {
          AuthCredential credential =
              GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          AuthResult authResult = await _auth.signInWithCredential(credential);
          FirebaseUser user = authResult.user;
          print(user);
        } catch (e) {
          showErrorDialog(context, e.details);
        }
      }
    }
  }

  // _handleFacebookSignin() async {
  //   FacebookLoginResult result = await facebookLogin.logIn(['email']);
  //   if (result.accessToken != null) {
  //     try {
  //       AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
  //       AuthResult authResult = await _auth.signInWithCredential(credential);
  //       FirebaseUser user = authResult.user;
  //       print(user);
  //     } catch (e) {
  //       showErrorDialog(context, e.details);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    _buttons = {
      // ProvidersTypes.facebook:
      //     providersDefinitions(context)[ProvidersTypes.facebook].copyWith(onSelected: _handleFacebookSignin),
      ProvidersTypes.google:
          providersDefinitions(context)[ProvidersTypes.google].copyWith(onSelected: _handleGoogleSignIn),
      ProvidersTypes.email:
          providersDefinitions(context)[ProvidersTypes.email].copyWith(onSelected: _handleEmailSignIn),
      ProvidersTypes.guest:
          providersDefinitions(context)[ProvidersTypes.guest].copyWith(onSelected: _handleGuestSignIn),
    };

    return new Container(
        // padding: widget.padding,
        child: new Column(
            children: widget.providers.map((p) {
      return new Container(
          padding: EdgeInsets.only(bottom: widget.bottomPadding), child: _buttons[p] ?? new Container());
    }).toList()));
  }

  void _followProvider(String value) {
    ProvidersTypes provider = stringToProvidersType(value);
    // if (provider == ProvidersTypes.facebook) {
    //   _handleFacebookSignin();
    // } else
    if (provider == ProvidersTypes.google) {
      _handleGoogleSignIn();
    }
  }
}
