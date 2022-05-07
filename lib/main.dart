import 'package:cnetchat/Services/Providers/chat_user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/chat_home_page.dart';
import 'Screens/chat_login.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone = prefs.getString('phone');
  runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ChatUserProvider()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,home: phone == null ? const CnetChatLogIn() : CnetChat(phone: phone,))));
}

class CnetChatLogIn extends StatelessWidget {
  const CnetChatLogIn({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: Scaffold(
            body: Login(),
          ),
        ),
      ),
    );
  }
}
class CnetChat extends StatelessWidget {
  const CnetChat({Key? key,required this.phone}) : super(key: key);
  final String phone;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChatHomePage(phone: phone.toString())
      );
  }
}



