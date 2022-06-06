import 'package:bar_chat_dating_app/data/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatting extends StatefulWidget {
  final String chatterUserId;
  const Chatting({Key? key, required this.chatterUserId}) : super(key: key);

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  @override
  Widget build(BuildContext context) {
  final logUserId = FirebaseAuth.instance.currentUser!.uid;
  final strCompare = logUserId.compareTo(widget.chatterUserId);
    final docId = strCompare == -1
        ? logUserId + widget.chatterUserId
        : widget.chatterUserId + logUserId;
    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      padding: const EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatRoom')
            .doc(docId)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, streamSnapshots) {
          if (streamSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = streamSnapshots.data!.docs;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, index) {
              return MessageBubble(
                text: chatDocs[index]['text'],
                isMe: chatDocs[index]['senderId'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                // key: ValueKey(chatDocs[index].data().toString())
              );
            },
            itemCount: chatDocs.length,
          );
        },
      ),
    );
  }
}