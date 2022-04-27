import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/chat_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CnetChat());
}

class CnetChat extends StatelessWidget {
  const CnetChat({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
    body: const Login(),
    ),
      ),
    );
  }
}

