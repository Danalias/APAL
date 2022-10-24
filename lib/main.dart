import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authentication/firebase_options.dart';
import 'authentication/sign_in.dart';
import 'authentication/sign_up.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const Loading(),
        '/navigation': (BuildContext context) => const Navigation(),
        '/connexion': (BuildContext context) => const SignIn(),
        '/inscription': (BuildContext context) => const SignUp(),
        '/annonces': (BuildContext context) => const Annonces(),
      },
    );
  }
}

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading>
  with TickerProviderStateMixin {
    late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    late final Animation<double> _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState((){ }));
    final TickerFuture ticker = _controller.repeat();
    ticker.timeout(const Duration(seconds: 3 * 3), onTimeout: () {
      _controller.stop();
      Navigator.pushNamed(context, '/navigation');
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png',
              height: MediaQuery.of(context).size.width * 0.85,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 23, 29, 83),
    );
  }
}


class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return const Annonces();
        } else {
          return const SignIn();
        } 
      },
    ),
  );
}

class Annonces extends StatelessWidget {
  const Annonces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.arrow_back, size: 32),
          label: const Text("Déconnexion"),
          onPressed: () => FirebaseAuth.instance.signOut(),
        ),
      ),
    );
  }
}