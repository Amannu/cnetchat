import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/Providers/chat_user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.phone}) : super(key: key);
  final String phone;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    getuid(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: getProfile(),
    );
  }
  getuid(BuildContext context) async {
    await context.read<ChatUserProvider>().getUserDetails(widget.phone);
  }

  getProfile(){
    if(context.watch<ChatUserProvider>().getUser!=null){
      return Column(
        children: [
          Text(context.watch<ChatUserProvider>().getUser!.phone.toString()),
          Text(context.watch<ChatUserProvider>().getUser!.firstname.toString()),
          Text(context.watch<ChatUserProvider>().getUser!.lastname.toString()),
        ],
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
