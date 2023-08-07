import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'package:my_project/app/view/addTodo/addTodo.dart';
import 'package:my_project/app/view/auth/register.dart';
=======
>>>>>>> 4603d33e82c384cf65da806022be1c61b7294f52
//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'app/view/auth/login.dart';
import 'app/view/home/home.dart';

import 'firebase_options.dart';

<<<<<<< HEAD
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth auth = FirebaseAuth.instance;
=======
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
>>>>>>> 4603d33e82c384cf65da806022be1c61b7294f52
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/add': (context) => AddTodo(),
        '/home': (context) => HomePage(),
      },
      home: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
            );
          } else {
            if (snapshot.data == null) {
              return LoginPage();
            } else {
              return HomePage();
            }
          }
        },
      ),
    );
  }
<<<<<<< HEAD
=======

  RegisterPage() {}

  AddTodo() {}
>>>>>>> 4603d33e82c384cf65da806022be1c61b7294f52
}
