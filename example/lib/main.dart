import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:firebase_ui/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FFULocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
        Locale('de', 'DE'),
        Locale('pt', 'BR'),
        Locale('es', 'MX'),
      ],
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamSubscription<User?> _listener;

  User? _currentUser;

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
            'https',
            'funky.glitch.com',
            'signinwithapple',
            'callbacks/signin',
            'com.about.you',
          )
        },
        title: 'Demo',
        header: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Text('Demo'),
          ),
        ),
        showBar: true,
        horizontalPadding: 8,
        bottomPadding: 5,
        avoidBottomInset: true,
        color: const Color(0x33363636),
        providers: const [
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

    _listener = _auth.authStateChanges().listen((User? user) {
      setState(() {
        _currentUser = user;
      });
    });
  }
}

class HomeScreen extends StatelessWidget {
  final User? user;

  const HomeScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue'),
        elevation: 4.0,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(color: Colors.amber),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome,'),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(user!.displayName ?? user!.email!),
              const SizedBox(
                height: 32.0,
              ),
              ElevatedButton(onPressed: _logout, child: const Text('DECONNEXION'))
            ],
          )));

  void _logout() {
    signOutProviders();
  }
}
