

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_home_page.dart';
import 'chat_register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 10,left: 10),
        height: 272,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10)
        ),
          child: Column(
            children:  [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: phoneController,
              style: TextStyle(
                  fontFamily: "SignikaSemiBold",
                  fontSize: 16.0,
                  color: Colors.black),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                    size: 22.0,
                  ),
                  hintText: "Enter Phone Number",
                  hintStyle: TextStyle(
                      fontFamily: "SignikaSemiBold",
                      fontSize: 18.0)),
          ),
            ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                      fontFamily: "SignikaSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.password,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                          fontFamily: "SignikaSemiBold",
                          fontSize: 18.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child:  MaterialButton(
                  minWidth: 100,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
                  color: Colors.transparent,
                  child: Text('LogIn',
                      style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 18.0, color: Colors.black)),
                  onPressed: () async {
                    DocumentSnapshot users=await FirebaseFirestore.instance.collection('users').doc(phoneController.text).get();
                    if(users.exists){
                      Map<String, dynamic> data = users.data() as Map<String, dynamic>;
                      if(passwordController.text==data['password']){
                        print('Succesful');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>ChatHomePage(phone: phoneController.text,)));
                      }
                      else{
                        print('wrong credentials');
                      }
                    }
                    else{
                      print('wrong credentials');
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Doesn't have account?",
                      style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 16.0, color: Colors.black)),
                  MaterialButton(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Text('Register',
                        style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 18.0, color: Colors.black)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>MaterialApp(
                            debugShowCheckedModeBanner: false,
                            theme: ThemeData(
                              primarySwatch: Colors.blue,
                            ),
                            home: SafeArea(
                              child: Scaffold(
                                body: const Register(),
                              ),
                            ),
                          )));
                    },
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
