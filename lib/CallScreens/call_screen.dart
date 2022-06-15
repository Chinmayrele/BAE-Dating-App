import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/constants.dart';
import '../models/call.dart';
import '../models/log.dart';
import '../resources/call_methods.dart';

class CallScreen extends StatefulWidget {
  final Call call;

  const CallScreen({
    Key? key,
    required this.call,
  }) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final CallMethods callMethods = CallMethods();

  late SharedPreferences preferences;
  late StreamSubscription callStreamSubscription;

  final _users = <int>[];
  String APP_ID = "94ecdf171b054f03997a56d21ce2f0f8";
  final _infoStrings = <String>[];
  bool muted = false;
  bool hasUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPostFrameCallback();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();

    _engine.setEventHandler(RtcEngineEventHandler(
      error: (dynamic code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },

      joinChannelSuccess: (
        String channel,
        int uid,
        int elapsed,
      ) {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      },

      userJoined: (int uid, int elapsed) {
        setState(() {
          hasUserJoined = true;
          final info = 'onUserJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
      },

      userInfoUpdated: (int i, userInfo) {
        setState(() {
          final info = 'onUpdatedUserInfo: ${userInfo.toString()}';
          _infoStrings.add(info);
        });
      },

      rejoinChannelSuccess: (String string, int a, int b) {
        setState(() {
          final info = 'onRejoinChannelSuccess: $string';
          _infoStrings.add(info);
        });
      },

      // userOffline :(int a,  b) {
      //    callMethods.endCall(call: widget.call);
      //    setState(() {
      //      final info = 'onUserOffline: a: ${a.toString()}, b: ${b.toString()}';
      //      _infoStrings.add(info);
      //    });
      //  },

      localUserRegistered: (int i, String s) {
        setState(() {
          final info = 'onRegisteredLocalUser: string: s, i: ${i.toString()}';
          _infoStrings.add(info);
        });
      },

      leaveChannel: (a) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },

      connectionLost: () {
        setState(() {
          const info = 'onConnectionLost';
          _infoStrings.add(info);
        });
      },

      userOffline: (int uid, reason) {
        // if call was picked
        setState(() {
          final info = 'userOffline: $uid';
          _infoStrings.add(info);
          _users.remove(uid);
        });
      },

      firstRemoteVideoFrame: (
        int uid,
        int width,
        int height,
        int elapsed,
      ) {
        setState(() {
          final info = 'firstRemoteVideo: $uid ${width}x $height';
          _infoStrings.add(info);
        });
      },
    ));

    await _engine.setParameters(
        '''{"che.video.lowBitRateStreamParameter":{"width":320,"height":180,"frameRate":15,"bitRate":140}}''');
    await _engine.joinChannel(null, widget.call.channelId.toString(), null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
  }

  addPostFrameCallback() async {
    preferences = await SharedPreferences.getInstance();
    callStreamSubscription = callMethods
        .callStream(uid: preferences.getString("uid").toString())
        .listen((DocumentSnapshot ds) {
      if (ds.data() == null) {
        Navigator.of(context).pop();
      }
    });
  }

  /// Helper function to get list of native views
  List _getRenderViews() {
    final List list = [];
    _users.forEach((int uid) => list.add(uid));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[_videoView(views[0])],
        );
      case 2:
        return Column(
          children: <Widget>[
        _expandedVideoRow([views[0]]),
        _expandedVideoRow([views[1]])
          ],
        );
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {
              callMethods.endCall(
                call: widget.call,
              );

              if (!hasUserJoined) {
                Log log = Log(
                    callerName: widget.call.callerName,
                    callerPic: widget.call.callerPic,
                    receiverName: widget.call.receiverName,
                    receiverPic: widget.call.receiverPic,
                    timestamp: DateTime.now().toString(),
                    callStatus: CALL_STATUS_MISSED,
                    logId: null);

                FirebaseFirestore.instance
                    .collection("profile")
                    .doc(widget.call.receiverId)
                    .collection("callLogs")
                    .doc(log.timestamp)
                    .set({
                  "callerName": log.callerName,
                  "callerPic": log.callerPic,
                  "receiverName": log.receiverName,
                  "receiverPic": log.receiverPic,
                  "timestamp": log.timestamp,
                  "callStatus": log.callStatus
                });
              }
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return Container();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    callStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            // _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
