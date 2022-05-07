import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_home_page.dart';
import 'chat_login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var phonenumberexist=false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(right: 10,left: 10),
        height: 508,
        decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(10)
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children:  [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                      return 'invalid first name';
                    }
                    return null;
                  },
                  controller: firstNameController,
                  style: const TextStyle(
                      fontFamily: "SignikaSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: const InputDecoration(
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
                      return 'invalid last name';
                    }
                    return null;
                  },
                  controller: lastNameController,
                  style: const TextStyle(
                      fontFamily: "SignikaSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: const InputDecoration(
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                    if (value == null || value.isEmpty || value.length!=10 || !value.startsWith('09')) {
                      return 'invalid phone number';
                    }
                    return null;
                  },
                  controller: phoneController,
                  style: const TextStyle(
                      fontFamily: "SignikaSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: "Phone Number(09..10 digits)",
                      hintStyle: TextStyle(
                          fontFamily: "SignikaSemiBold",
                          fontSize: 18.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value){
                    if (value == null || value.isEmpty || value.length<8) {
                      return 'password must contain more than 8 characters. ';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(
                      fontFamily: "SignikaSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: const InputDecoration(
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
                padding: const EdgeInsets.all(10.0),
                child:  MaterialButton(
                  minWidth: 100,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
                  color: Colors.transparent,
                  child: const Text('Register',
                      style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 18.0, color: Colors.black)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                    DocumentSnapshot users=await FirebaseFirestore.instance.collection('users').doc(phoneController.text).get();
                    if(users.exists){
                      setState(() {
                        phonenumberexist=true;
                      });
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
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("phone", phoneController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>ChatHomePage(phone: phoneController.text,)));
                    }}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(phonenumberexist?'Phone Number Exists!':'',style: const TextStyle(color: Colors.red),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account?",
                      style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 16.0, color: Colors.black)),
                  MaterialButton(
                    elevation: 0,
                    color: Colors.transparent,
                    child: const Text('Log In',
                        style: TextStyle(fontFamily: "SignikaSemiBold",fontSize: 18.0, color: Colors.black)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>MaterialApp(
                          debugShowCheckedModeBanner: false,
                          theme: ThemeData(
                            primarySwatch: Colors.blue,
                          ),
                          home: const SafeArea(
                            child: Scaffold(
                              body: Login(),
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
