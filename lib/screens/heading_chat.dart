import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:flutter/material.dart';

class HeadingChat extends StatelessWidget {
  final UserInfos chatterUser;
  const HeadingChat({Key? key, required this.chatterUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(children: [
        const SizedBox(width: 8),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:const  Icon(
              Icons.arrow_back,
              color: Colors.pink,
              size: 28,
            )),
        Text(
          chatterUser.name,
          style:const  TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          child:const  Icon(
            Icons.phone,
            color: Colors.pink,
            size: 28,
          ),
        ),
        const SizedBox(width: 15),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.videocam_rounded,
            color: Colors.pink,
            size: 28,
          ),
        ),
        const SizedBox(width: 22),
      ]),
    );
  }
}
