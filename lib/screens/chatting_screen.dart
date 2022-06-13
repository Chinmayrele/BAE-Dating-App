import 'package:bar_chat_dating_app/data/new_message.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:bar_chat_dating_app/screens/chating.dart';
import 'package:bar_chat_dating_app/screens/heading_chat.dart';
import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  final UserInfos chaterUser;
  const ChattingScreen({Key? key, required this.chaterUser}) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            HeadingChat(chatterUser: widget.chaterUser),
            Chatting(chatterUser: widget.chaterUser),
            NewMessage(chatterUser: widget.chaterUser),
          ],
        ),
      ),
    );
  }
}
