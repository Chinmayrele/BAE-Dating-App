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





// // import 'package:firebase_chat_example/api/firebase_api.dart';
// // import 'package:firebase_chat_example/model/user.dart';
// // import 'package:firebase_chat_example/widget/chat_body_widget.dart';
// // import 'package:firebase_chat_example/widget/chat_header_widget.dart';
// import 'package:bar_chat_dating_app/models/user_info.dart';
// import 'package:flutter/material.dart';

// import '../data/firebase_api.dart';

// class ChatsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: Colors.blue,
//         body: SafeArea(
//           child: StreamBuilder<List<UserInfos>>(
//             stream: FirebaseApi.getUsers(),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   return Center(child: CircularProgressIndicator());
//                 default:
//                   if (snapshot.hasError) {
//                     print(snapshot.error);
//                     return buildText('Something Went Wrong Try later');
//                   } else {
//                     final users = snapshot.data;

//                     if (users.isEmpty) {
//                       return buildText('No Users Found');
//                     } else
//                       return Column(
//                         children: [
//                           ChatHeaderWidget(users: users),
//                           ChatBodyWidget(users: users)
//                         ],
//                       );
//                   }
//               }
//             },
//           ),
//         ),
//       );

//   Widget buildText(String text) => Center(
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       );
// }
