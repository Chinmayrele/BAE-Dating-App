import 'dart:async';

import 'package:bar_chat_dating_app/screens/start_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => const StartScreen()));
      });
    });
    super.initState();
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
