import 'dart:async';
import 'dart:convert';

import 'package:bar_chat_dating_app/data/location_permi.dart';
import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:bar_chat_dating_app/screens/person_info.dart';
import 'package:bar_chat_dating_app/screens/que_screen.dart';
import 'package:bar_chat_dating_app/screens/start_screen.dart';
import 'package:bar_chat_dating_app/shared_preferences/user_values.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print("INIT State");
    timerFunction();

    super.initState();
  }

  timerFunction() async {
    Future.delayed(const Duration(seconds: 3), () async {
    final String isVisited = await getVisitingFlag();
    print("Value String: ${isVisited}");
    if (isVisited.isNotEmpty) {
      Map<String, dynamic> mp = json.decode(isVisited);
      print("Value : ${mp.length}");
      if (mp.containsKey('isProfileDone') && mp['isProfileDone']) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const HomePageScreen()));
      } else if (mp.containsKey('isLocDone') && mp['isLocDone']) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => PersonInfo(
                  isEdit: false,
                )));
      } else if (mp.containsKey('isQueAnsDone') && mp['isQueAnsDone']) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const LocationPermi()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const QueScreen()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const StartScreen()));
    }

    // setState(() {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (ctx) => const StartScreen()));
    // });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: size.height * 0.4,
        // width: size.width * 0.2,
        child: Image.asset(
          'assets/images/bae_flogo.png',
        ),
      )),
    );
  }
}
