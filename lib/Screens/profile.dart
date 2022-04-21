import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.phone}) : super(key: key);
  final String phone;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.phone).get(),
    builder:
    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.hasError) {
    return const Center(child: Text("Something went wrong"));
    }

    if (snapshot.hasData && !snapshot.data!.exists) {
    return const Center(child: Text("Document does not exist"));
    }

    if (snapshot.connectionState == ConnectionState.done) {
    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Full Name: ${data['firstname']} ${data['lastname']}"),
        Text("Phone Number: ${data['phone']}"),
      ],
    );
    }

    return const Center(child: Text("loading"));
    },);
  }
}
