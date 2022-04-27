
import 'package:cnetchat/Screens/profile.dart';
import 'package:flutter/material.dart';

import 'chat_login.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key, required this.phone,}) : super(key: key);
  final String phone;
  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("CnetChat"),
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (BuildContext context) => MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        primarySwatch: Colors.blue,
                      ),
                      home: SafeArea(
                        child: Scaffold(
                          body: const Login(),
                        ),
                      ),
                    ));
                    Navigator.of(this.context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
                  },
                )
              ],
            ),

          ),
          body: Profile(phone: widget.phone)),
    );
  }
}
