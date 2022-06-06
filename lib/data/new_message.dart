import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String chatterUserId;
  const NewMessage({Key? key, required this.chatterUserId}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();
  void _sendMessage() {
    final logUserId = FirebaseAuth.instance.currentUser!.uid;
    final strCompare = logUserId.compareTo(widget.chatterUserId);
    final docId = strCompare == -1
        ? logUserId + widget.chatterUserId
        : widget.chatterUserId + logUserId;
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(docId)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'senderId': logUserId,
      'receiverId': widget.chatterUserId,
    });
    _controller.clear();
    _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              maxLines: null,
              controller: _controller,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send,
                    ),
                    color: _enteredMessage.trim().isEmpty
                        ? Colors.grey
                        : Colors.pink,
                    onPressed:
                        _enteredMessage.trim().isEmpty ? null : _sendMessage,
                  ),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white24)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white24)),
                  labelText: 'Send a Message...',
                  labelStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                  floatingLabelBehavior: FloatingLabelBehavior.never),
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (val) {
                setState(() {
                  _enteredMessage = val;
                });
              },
            ),
          ),
        ),
        // IconButton(
        //     onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
        //     icon: Icon(
        //       Icons.send,
        //       color:
        //           _enteredMessage.trim().isEmpty ? Colors.white24 : Colors.pink,
        //     ))
      ]),
    );
  }
}
