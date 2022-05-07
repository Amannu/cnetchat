import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ChatUserProvider with ChangeNotifier {
  ChatUserModel? _user;

  ChatUserModel? get getUser => _user;

  getUserDetails(String? phone) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(phone)
        .get();
    _user = ChatUserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    notifyListeners();
  }
}

class ChatUserModel {
  String? firstname;
  String? lastname;
  String? phone;
  String? password;

  ChatUserModel({
    this.firstname,
    this.lastname,
    this.phone,
    this.password,
  });

  Map toMap(ChatUserModel user) {
    var data = <String, dynamic>{};
    data['firstname'] = user.firstname;
    data['lastname'] = user.lastname;
    data['phone'] = user.phone;
    data["password"] = user.password;
    return data;
  }

  // Named constructor
  ChatUserModel.fromMap(Map<String, dynamic> mapData) {
    firstname = mapData['firstname'];
    lastname = mapData['lastname'];
    phone = mapData['phone'];
    password = mapData['password'];
  }
}
