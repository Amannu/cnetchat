import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnetchat/Screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatUser extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String phone;
  final String password;
  const ChatUser(this.firstname,this.lastname,this.phone,this.password);

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .doc(widget.phone)
          .set({
        'firstname': widget.firstname,
        'lastname': widget.lastname,
        'phone': widget.phone,
        'password':widget.password
      });
    }
    addUser();
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          addUser();
          return Scaffold(
              appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              title: const Text(
              "CnetChat",
              style: TextStyle(
              color: Color(0xFF1E1E1E),
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          ),
          ),),
            body: Profile(phone:widget.phone),
          );
        });

  }
}


