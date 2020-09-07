import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_ui/config.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'email_view.dart';
import 'utils.dart';

class LoginView extends StatefulWidget {
  final List<ProvidersTypes> providers;
  final bool passwordCheck;
  final double bottomPadding;
  final Map<String, Config> config;

  LoginView(
      {Key key, @required this.providers, this.passwordCheck, @required this.bottomPadding, Map<String, Config> config})
      : this.config = config ?? {},
        super(key: key) {
    print("Widget providers are ${this.providers}");
  }

  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<ProvidersTypes, ButtonDescription> _buttons;

  bool _isSigningIn = false;
  User _user;

  _handleEmailSignIn() async {
    _signingIn(true);
    try {
      String value = await Navigator.of(context).push(new MaterialPageRoute<String>(builder: (BuildContext context) {
        return new EmailView(widget.passwordCheck);
      }));

      if (value != null) {
        _followProvider(value);
      }
    } finally {
      _signingIn(false);
    }
  }

  _handleGuestSignIn() async {
    _signingIn(true);
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      _user = authResult.user;
      print(_user);
    } catch (e) {
      showErrorDialog(context, e.details ?? e.message);
    } finally {
      _signingIn(false);
    }
  }

  _handleGoogleSignIn() async {
    _signingIn(true);
    try {
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        if (googleAuth.accessToken != null) {
          try {
            AuthCredential credential =
                GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
            UserCredential authResult = await _auth.signInWithCredential(credential);
            _user = authResult.user;
            print(_user);
          } catch (e) {
            showErrorDialog(context, e.details);
          }
        }
      }
    } finally {
      _signingIn(false);
    }
  }

  /// SoftWyer note:
  ///
  /// All the code below is from the example for the [Sign In With Apple](https://pub.dev/packages/sign_in_with_apple) plugin
  ///
  /// The server code example hosted on Glitch has been modified to return the access and id tokens that Firebase need to authenticate
  /// e.g.
  /// ```
  ///  // 👷🏻‍♀️ TODO: Use the values provided create a new session for the user in your system
  ///  const sessionID = `NEW SESSION ID for ${userID} / ${userEmail} / ${userName}`;
  ///
  ///  response.json({ sessionId: sessionID, idToken: accessToken.id_token, accessToken: accessToken.access_token });
  ///
  /// ```

  _handleAppleSignIn() async {
    assert(widget.config[AppleConfig.configName] != null,
        "You must supply an AppleConfig object in the config map, eg. {AppleConfig.configName: AppleConfig(...)}");
    _signingIn(true);

    var pr = new ProgressDialog(context);
    pr.style(message: 'Validating tokens...');

    try {
      AppleConfig appleConfig = widget.config[AppleConfig.configName];

      // Generate a none and SH256 hash (SoftWyer)
      String nonce = Nonce.createCryptoRandomString();
      Digest hashedNonce = sha256.convert(nonce.codeUnits);

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          clientId: appleConfig.clientId,
          redirectUri: Uri(scheme: appleConfig.scheme, host: appleConfig.host, path: appleConfig.redirectPath),
        ),
        nonce: hashedNonce.toString(),
        // state: 'example-state',
      );

      await pr.show();

      print(credential);

      // This is the endpoint that will convert an authorization code obtained
      // via Sign in with Apple into a session in your system
      // NB: If using Glitch, you might want to pre-warm this endpoint by making a request prior to calling
      // sign-in as Glitch may have put the server to sleep and the nonces at Apple will fail your app if it
      // takes too long to respond.
      final signInWithAppleEndpoint = Uri(
        scheme: appleConfig.scheme,
        host: appleConfig.host,
        path: appleConfig.path,
        queryParameters: <String, String>{
          'code': credential.authorizationCode,
          'firstName': credential.givenName,
          'lastName': credential.familyName,
          'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
          if (credential.state != null) 'state': credential.state,
        },
      );

      final session = await http.Client().post(
        signInWithAppleEndpoint,
      );

      // If we got this far, a session based on the Apple ID credential has been created in your system,
      // and you can now set this as the app's session
      print(session);

      // SoftWyer note
      //
      // This is the section that decodes the session response to retrieve the access and id tokens
      // We can use this to generate an OAuthCredential that can be used with FireBase.
      Map<String, dynamic> appleValidationReponse = jsonDecode(session.body);

      // This no longer works with the latest Firebase Flutter libraries
      // OAuthCredential authCredential = OAuthCredential(
      //   providerId: "apple.com",
      //   signInMethod: "",
      //   idToken: appleValidationReponse['idToken'],
      //   accessToken: appleValidationReponse['accessToken'],
      //   rawNonce: nonce.toString(),
      // );

      final oAuthProvider = OAuthProvider('apple.com');
      final providerCredential = oAuthProvider.credential(
        idToken: appleValidationReponse['idToken'],
        accessToken: appleValidationReponse['accessToken'],
        rawNonce: nonce.toString(),
      );

      // Authenticate with firebase
      UserCredential authResult = await _auth.signInWithCredential(providerCredential);
      _user = authResult.user;
      print(_user);
    } catch (e) {
      print("Exception");
      print(e);
      if (e?.code != AuthorizationErrorCode.canceled) {
        showErrorDialog(context, e?.message ?? "Unknown");
      }
    } finally {
      await pr.hide();

      _signingIn(false);
    }
  }

  // _handleFacebookSignin() async {
  //   FacebookLoginResult result = await facebookLogin.logIn(['email']);
  //   if (result.accessToken != null) {
  //     try {
  //       AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
  //       UserCredential authResult = await _auth.signInWithCredential(credential);
  //       User user = authResult.user;
  //       print(user);
  //     } catch (e) {
  //       showErrorDialog(context, e.details);
  //     }
  //   }
  // }

  void _signingIn(bool isSigningIn) {
    if (_user != null || isSigningIn != _isSigningIn) {
      setState(() {
        _isSigningIn = isSigningIn;
      });
      _user = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _buttons = {
      ProvidersTypes.google: providersDefinitions(context)[ProvidersTypes.google].copyWith(
          onSelected: _isSigningIn ? null : _handleGoogleSignIn, labelColor: _isSigningIn ? Colors.white : null),
      ProvidersTypes.apple: providersDefinitions(context)[ProvidersTypes.apple]
          .copyWith(onSelected: _isSigningIn ? null : _handleAppleSignIn),
      ProvidersTypes.email: providersDefinitions(context)[ProvidersTypes.email]
          .copyWith(onSelected: _isSigningIn ? null : _handleEmailSignIn),
      ProvidersTypes.guest: providersDefinitions(context)[ProvidersTypes.guest]
          .copyWith(onSelected: _isSigningIn ? null : _handleGuestSignIn),
    };

    print("Widget providers are ${widget.providers}");

    return ListView(
      shrinkWrap: false,
      primary: true,
      children: widget.providers.map((p) {
        return Container(padding: EdgeInsets.only(bottom: widget.bottomPadding), child: _buttons[p] ?? new Container());
      }).toList(),
    );
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
