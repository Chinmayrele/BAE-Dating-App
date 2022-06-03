import 'package:flutter/material.dart';
// import 'package:flutter_tinder_clone_app/auth/login.dart';
// import 'package:flutter_tinder_clone_app/auth/signup.dart';
// // import 'package:mobiflix_flutter/auth/signup.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_tinder_clone_app/screens/login_number.dart';
// import 'package:flutter_tinder_clone_app/screens/phone_login.dart';

import '../auth/login.dart';
import './phone_login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: deviceSize.height * 0.1),
            //  CircleAvatar(
            //   radius: 50,
            //   backgroundColor: Colors.transparent,
            //   // foregroundColor: Colors.transparent,
            //   backgroundImage: AssetImage('assets/images/tttt.png'),
            // ),
            //  SizedBox(height: deviceSize.height*0.02),
            SizedBox(
              height: deviceSize.height * 0.14,
              width: double.infinity,
              child: Image.asset(
                'assets/images/bae_flogo.png',
                // fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: deviceSize.height * 0.2),
            const Text(
              '𝓦𝓔𝓛𝓒𝓞𝓜𝓔!',
              style: TextStyle(
                letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
            SizedBox(height: deviceSize.height * 0.02),
            // Container(
            //   margin: EdgeInsets.only(left: deviceSize.width * 0.2),
            //   width: deviceSize.width * 0.8,
            //   child: const Text(
            //     'Create an Account and Get Started Now!',
            //     // 'Create an Account and Plan your Customizable trip Now!',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            SizedBox(height: deviceSize.height * 0.03),
            Container(
              margin: EdgeInsets.all(deviceSize.width * 0.05),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const PhoneLogin()));
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(25),
                    primary: Colors.pink),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an Account?',
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => const Login()));
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
