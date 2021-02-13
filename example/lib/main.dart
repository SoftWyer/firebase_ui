import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_ui/l10n/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FFULocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr', 'FR'),
        const Locale('en', 'US'),
        const Locale('de', 'DE'),
        const Locale('pt', 'BR'),
        const Locale('es', 'MX'),
      ],
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<User> _listener;

  User _currentUser;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return SignInScreen(
        config: {
          AppleConfig.configName: AppleConfig(
            'https://',
            'funky.glitch.com',
            'signinwithapple',
            'callbacks/signin',
            'com.about.you',
          )
        },
        title: "Demo",
        header: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Text("Demo"),
          ),
        ),
        showBar: true,
        horizontalPadding: 8,
        bottomPadding: 5,
        avoidBottomInset: true,
        color: Color(0x33363636),
        providers: [
          ProvidersTypes.google,
          ProvidersTypes.apple,
          ProvidersTypes.email,
          ProvidersTypes.guest,
        ],
      );
    } else {
      return HomeScreen(user: _currentUser);
    }
  }

  void _checkCurrentUser() async {
    _currentUser = _auth.currentUser;
    _currentUser?.getIdToken(true);

    _listener = _auth.authStateChanges().listen((User user) {
      setState(() {
        _currentUser = user;
      });
    });
  }
}

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue"),
        elevation: 4.0,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: Colors.amber),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Welcome,"),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(user.displayName ?? user.email),
              SizedBox(
                height: 32.0,
              ),
              ElevatedButton(child: Text("DECONNEXION"), onPressed: _logout)
            ],
          )));

  void _logout() {
    signOutProviders();
  }
}
