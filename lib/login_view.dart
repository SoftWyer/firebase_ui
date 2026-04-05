import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/choose_sign_in_up.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sn_progress_dialog/enums/progress_types.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class LoginView extends StatefulWidget {
  final List<ProvidersTypes>? providers;
  final bool? passwordCheck;
  final double bottomPadding;
  final Map<String, Config> config;

  LoginView({
    super.key,
    required this.providers,
    this.passwordCheck,
    required this.bottomPadding,
    Map<String, Config>? config,
  }) : config = config ?? {} {
    print('Widget providers are $providers');
  }

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Map<ProvidersTypes, ButtonDescription> _buttons;

  bool _isSigningIn = false;
  User? _user;

  // Google Sign-In 7.x requires using the singleton instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> _handleEmailSignIn() async {
    _signingIn(true);
    try {
      String? value = await Navigator.of(context).push(
        MaterialPageRoute<String>(
          builder: (BuildContext context) {
            return ChooseSignInUpView();
          },
        ),
      );

      if (value != null) {
        _followProvider(value);
      }
    } finally {
      _signingIn(false);
    }
  }

  Future<void> _handleGuestSignIn() async {
    _signingIn(true);
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      _user = authResult.user;
      print(_user);
    } catch (e) {
      if (mounted) {
        showErrorDialog(context, e.toString());
      }
    } finally {
      _signingIn(false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    _signingIn(true);
    try {
      // Initialize Google Sign-In (required for 7.x)
      await _googleSignIn.initialize();

      // Attempt lightweight authentication first (non-blocking on web)
      final account =
          await _googleSignIn.attemptLightweightAuthentication() ??
          await _googleSignIn.authenticate(scopeHint: ['https://www.googleapis.com/auth/userinfo.email']);

      // Get the idToken from authentication
      final idToken = account.authentication.idToken;

      // Get client authorization for access token
      final clientAuth = await account.authorizationClient.authorizeScopes([
        'https://www.googleapis.com/auth/userinfo.email',
      ]);

      if (idToken != null && clientAuth.accessToken.isNotEmpty) {
        try {
          AuthCredential credential = GoogleAuthProvider.credential(
            idToken: idToken,
            accessToken: clientAuth.accessToken,
          );
          UserCredential authResult = await _auth.signInWithCredential(credential);
          _user = authResult.user;
          print(_user);
        } catch (e) {
          if (mounted) {
            showErrorDialog(context, e.toString());
          }
        }
      }
    } on GoogleSignInException catch (e) {
      // Handle cancellation and other errors specific to google_sign_in 7.x
      if (e.code != GoogleSignInExceptionCode.canceled) {
        if (mounted) {
          showErrorDialog(context, e.toString());
        }
      }
    } catch (e) {
      // Handle any other unexpected errors
      if (mounted) {
        showErrorDialog(context, e.toString());
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

  Future<void> _handleAppleSignIn() async {
    assert(
      widget.config[AppleConfig.configName] != null,
      'You must supply an AppleConfig object in the config map, eg. {AppleConfig.configName: AppleConfig(...)}',
    );
    _signingIn(true);

    var pr = ProgressDialog(context: context);

    try {
      AppleConfig appleConfig = widget.config[AppleConfig.configName] as AppleConfig;

      // Generate a none and SH256 hash (SoftWyer)
      String nonce = Nonce.createCryptoRandomString();
      Digest hashedNonce = sha256.convert(nonce.codeUnits);

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values
          // you entered in the Apple Developer portal during the setup
          clientId: appleConfig.clientId,
          redirectUri: Uri(scheme: appleConfig.scheme, host: appleConfig.host, path: appleConfig.redirectPath),
        ),
        nonce: hashedNonce.toString(),
        // state: 'example-state',
      );

      print(credential);

      pr.show(max: 0, msg: 'Validating tokens...', progressType: ProgressType.determinate);

      // This is the endpoint that will convert an authorization code obtained
      // via Sign in with Apple into a session in your system
      // NB: If using Glitch, you might want to pre-warm this endpoint by making a request prior to calling
      // sign-in as Glitch may have put the server to sleep and the nonces at Apple will fail your app if it
      // takes too long to respond.
      final signInWithAppleEndpoint = Uri(
        scheme: appleConfig.scheme,
        host: appleConfig.host,
        path: appleConfig.path,
        queryParameters: <String, String?>{
          'code': credential.authorizationCode,
          'firstName': credential.givenName,
          'lastName': credential.familyName,
          'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
          if (credential.state != null) 'state': credential.state,
        },
      );

      final session = await http.Client().post(signInWithAppleEndpoint);

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
      print('Exception');
      print(e);
      // if (e.code != AuthorizationErrorCode.canceled) {
      if (mounted) {
        showErrorDialog(context, e.toString());
      }
      // }
    } finally {
      pr.close();

      _signingIn(false);
    }
  }

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
      ProvidersTypes.google: providersDefinitions(context)[ProvidersTypes.google]!.copyWith(
        onSelected: _isSigningIn ? null : _handleGoogleSignIn,
        labelColor: Colors.black,
      ),
      if (!kIsWeb)
        ProvidersTypes.apple: providersDefinitions(
          context,
        )[ProvidersTypes.apple]!.copyWith(onSelected: _isSigningIn ? null : _handleAppleSignIn),
      ProvidersTypes.email: providersDefinitions(
        context,
      )[ProvidersTypes.email]!.copyWith(onSelected: _isSigningIn ? null : _handleEmailSignIn),
      ProvidersTypes.guest: providersDefinitions(
        context,
      )[ProvidersTypes.guest]!.copyWith(onSelected: _isSigningIn ? null : _handleGuestSignIn),
    };

    print('Widget providers are ${widget.providers}');

    return Center(
      child: ListView(
        shrinkWrap: false,
        primary: true,
        children: widget.providers!.map((p) {
          return Container(
            padding: EdgeInsets.only(bottom: widget.bottomPadding, top: p == ProvidersTypes.guest ? 20 : 0),
            child: _buttons[p] ?? Container(),
          );
        }).toList(),
      ),
    );
  }

  void _followProvider(String value) {
    ProvidersTypes? provider = stringToProvidersType(value);
    if (provider == ProvidersTypes.google) {
      _handleGoogleSignIn();
    }
  }
}
