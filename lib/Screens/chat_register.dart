

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnetchat/Screens/chat.dart';
import 'package:flutter/material.dart';

import 'chat_home_page.dart';
import 'chat_login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 10,left: 10),
        height: 388,
        decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children:  [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: firstNameController,
                style: TextStyle(
                    fontFamily: "SignikaSemiBold",
                    fontSize: 16.0,
                    color: Colors.black),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_add,
                      color: Colors.black,
                      size: 22.0,
                    ),
                    hintText: "Enter Your First Name",
                    hintStyle: TextStyle(
                        fontFamily: "SignikaSemiBold",
                        fontSize: 18.0)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: lastNameController,
                style: TextStyle(
                    fontFamily: "SignikaSemiBold",
                    fontSize: 16.0,
                    color: Colors.black),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_add_alt,
                      color: Colors.black,
                      size: 22.0,
                    ),
                    hintText: "Enter Your Last Name",
                    hintStyle: TextStyle(
                        fontFamily: "SignikaSemiBold",
                        fontSize: 18.0)),
              ),
            ),
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
                    hintText: "Enter New Password",
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
                child: Text('Register',
                    style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 18.0, color: Colors.black)),
                onPressed: () async {
                  DocumentSnapshot users=await FirebaseFirestore.instance.collection('users').doc(phoneController.text).get();
                  if(users.exists){
                    print('available');
                    firstNameController.clear();
                    lastNameController.clear();
                    phoneController.clear();
                    passwordController.clear();
                  }
                  else{
                    CollectionReference _users = FirebaseFirestore.instance.collection('users');
                    _users
                        .doc(phoneController.text)
                        .set({
                      'firstname': firstNameController.text,
                      'lastname': lastNameController.text,
                      'phone': phoneController.text,
                      'password':passwordController.text
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>ChatHomePage(phone: phoneController.text,)));
                    print('Registered');
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account?",
                    style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 16.0, color: Colors.black)),
                MaterialButton(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Text('Log In',
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
                            body: const Login(),
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
