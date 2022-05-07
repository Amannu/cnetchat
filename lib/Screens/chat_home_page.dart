
import 'package:cnetchat/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_login.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key,required this.phone}) : super(key: key);
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
              backgroundColor: Colors.white,
              title: const Text("CnetChat",style: TextStyle(color: Colors.black),),
              actions: [
                PopupMenuButton(
                  icon: const Icon(Icons.menu,color: Colors.black,),
                  onSelected: (value) async {
                    switch(value){
                      case 'logout':
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        //Remove String
                        prefs.remove("phone");
                        final route = MaterialPageRoute(builder: (BuildContext context) => MaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(
                            primarySwatch: Colors.blue,
                          ),
                          home: const SafeArea(
                            child: Scaffold(
                              body: Login(),
                            ),
                          ),
                        ));
                        Navigator.of(this.context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
                        break;
                      case 'setting':
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>MaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(
                            primarySwatch: Colors.blue,
                          ),
                          home: SafeArea(
                            child: Scaffold(
                              body: Profile(phone:widget.phone),
                            ),
                          ),
                        )));
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      value:'setting',
                      child: ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Setting'),
                      ),
                    ),
                     const PopupMenuItem(
                     value:'logout',
                      child: ListTile(
                        leading: Icon(Icons.logout,color: Colors.red,),
                        title: Text('Logout',style: TextStyle(color: Colors.red),),
                      ),
                    ),
                  ],
                ),
              ],

            ),
            body: const  Center(child: CircularProgressIndicator(),),
        ),
      );
  }
}



