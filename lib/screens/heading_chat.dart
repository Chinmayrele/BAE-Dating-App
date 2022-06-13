import 'dart:convert';
import 'dart:developer';

import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class HeadingChat extends StatelessWidget {
  final UserInfos chatterUser;
  const HeadingChat({Key? key, required this.chatterUser}) : super(key: key);
  final int appID = 262329406;
  final String roomID = "123456";

  // TODO Heroku server url for example
  // Get the server from: https://github.com/ZEGOCLOUD/dynamic_token_server_nodejs
  final String tokenServerUrl =
      'https://team-infinity-test.herokuapp.com'; // https://xxx.herokuapp.com

  Future<bool> requestPermission() async {
    PermissionStatus microphoneStatus = await Permission.microphone.request();
    if (microphoneStatus != PermissionStatus.granted) {
      log('Error: Microphone permission not granted!!!');
      return false;
    }
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus != PermissionStatus.granted) {
      log('Error: Camera permission not granted!!!');
      return false;
    }
    return true;
  }

  /// Get the ZEGOCLOUD's API access token
  ///
  /// There are some API of ZEGOCLOUD need to pass the token to use.
  /// We use Heroku service for test.
  /// You can get your temporary token from ZEGOCLOUD Console [My Projects -> project's Edit -> Basic Configurations] : https://console.zegocloud.com/project  for both User1 and User2.
  /// Read more about the token: https://docs.zegocloud.com/article/14140
  Future<String> getToken(String userID) async {
    final response =
        await http.get(Uri.parse('$tokenServerUrl/access_token?uid=$userID'));
    if (response.statusCode == 200) {
      final jsonObj = jsonDecode(response.body);
      return jsonObj['token'];
    } else {
      return "";
    }
  }

  /// Get the necessary arguments to join the room for start the talk or live streaming
  ///
  ///  TODO DO NOT use special characters for userID and roomID.
  ///  We recommend only contain letters, numbers, and '_'.
  Future<Map<String, String>> getJoinRoomArgs(String userID) async {
    // final userID = math.Random().nextInt(10000).toString();
    final String token = await getToken(userID);
    return {
      'userID': userID,
      'token': token,
      'roomID': roomID,
      'appID': appID.toString(),
    };
  }

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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.pink,
              size: 28,
            )),
        Text(
          chatterUser.name,
          style: const TextStyle(
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
          child: const Icon(
            Icons.phone,
            color: Colors.pink,
            size: 28,
          ),
        ),
        const SizedBox(width: 15),
        InkWell(
          onTap: () async {
            await requestPermission();
            Navigator.pushReplacementNamed(context, '/call_page',
                arguments: await getJoinRoomArgs(
                    FirebaseAuth.instance.currentUser!.uid));
          },
          child: Container(
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
        ),
        const SizedBox(width: 22),
      ]),
    );
  }
}
