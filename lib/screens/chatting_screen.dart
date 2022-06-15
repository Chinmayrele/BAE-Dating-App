import 'package:bar_chat_dating_app/CallScreens/pickup/pickup_layout.dart';
import 'package:bar_chat_dating_app/data/new_message.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:bar_chat_dating_app/screens/chating.dart';
import 'package:bar_chat_dating_app/screens/heading_chat.dart';
import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  final UserInfos chaterUser;
  final UserInfos userdata;

  const ChattingScreen({Key? key, required this.chaterUser,required this.userdata,}) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PickupLayout(
      scaffold: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              HeadingChat(chatterUser: widget.chaterUser,userdata:widget.userdata),
              Chatting(chatterUser: widget.chaterUser),
              NewMessage(chatterUser: widget.chaterUser),
            ],
          ),
        ),
      ), 
      uid: widget.userdata.userId,
    );
  }
}
