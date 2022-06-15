import 'dart:math';

import 'package:bar_chat_dating_app/providers/info_provider.dart';
import 'package:bar_chat_dating_app/screens/audio_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CallScreens/call_screen.dart';
import '../data/constants.dart';
import '../models/call.dart';
import '../models/log.dart';
import '../resources/call_methods.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial(
      {required String currUserAvatar,
      required String currUserName,
      required String currUserId,
      required String receiverAvatar,
      required String receiverName,
      required String receiverId,
      context}) async {
    Call call = Call(
      callerId: currUserId,
      callerName: currUserName,
      callerPic: currUserAvatar,
      receiverId: receiverId,
      receiverName: receiverName,
      receiverPic: receiverAvatar,
      channelId: Random().nextInt(1000).toString(),
      hasDialled: false,
    );

    Log log = Log(
        callerName: currUserName,
        callerPic: currUserAvatar,
        callStatus: CALL_STATUS_DIALLED,
        receiverName: receiverName,
        receiverPic: receiverAvatar,
        timestamp: DateTime.now().toString(),
        logId: null);

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      FirebaseFirestore.instance
          .collection("profile")
          .doc(currUserId)
          .collection("callLogs")
          .doc(log.timestamp)
          .set({
        "callerName": log.callerName,
        "callerPic": log.callerPic,
        "callStatus": log.callStatus,
        "receiverName": log.receiverName,
        "receiverPic": log.receiverPic,
        "timestamp": log.timestamp
      });

      final result = Provider.of<InfoProviders>(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => result.call_type ? CallScreen(
              call: call,
            ) :  AudioScreen(call: call),
          ));
    }
  }
}
