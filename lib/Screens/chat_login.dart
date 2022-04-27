

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'chat_home_page.dart';
import 'chat_register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var wrongcredential=false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 10,left: 10),
        height: 350,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10)
        ),
          child: Form(
            key: _formKey,
            child: Column(
              children:  [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length!=10) {
                      return '10 digit phone number';
                    }
                    return null;
                  },
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password field can not be empty';
                      }
                      return null;
                    },
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
                    if (_formKey.currentState!.validate()){
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
                          setState(() {
                            wrongcredential=true;
                          });
                          print('wrong credentials');
                        }
                      }
                      else{
                        setState(() {
                          wrongcredential=true;
                        });
                        print('wrong credentials');
                      }}
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(wrongcredential?'Wrong Credentials!':'',style: TextStyle(color: Colors.red),),
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
      ),
    );
  }
}
