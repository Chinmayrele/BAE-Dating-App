import 'package:bar_chat_dating_app/models/que_ans_info.dart';
import 'package:bar_chat_dating_app/screens/que_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_tinder_clone_app/screens/home_page_screen.dart';

import '../data/signup_form.dart';
import '../screens/home_page_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const routeName = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _isLoading = false;
  void _signUp(String email, String password, String username, bool isLogin,
      BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (!isLogin) {
        authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(authResult.user!.uid)
        //     .set({
        //   'username': username,
        //   'email': email,
        // });
        if (authResult.user != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const QueScreen()));
        }
      }
    } on PlatformException catch (err) {
      var message = 'ERROR!!! Please Check Your Credentials';
      if (err.message != null) {
        message = err.message.toString();
      }
      //debugPrint('$Error' + message);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: const Text('Email Already Exists. Log-In Yourself!'),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
      //debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: deviceSize.height * 0.22,
              // width: double.infinity,
              child: Image.asset(
                'assets/images/bae_flogo.png',
              ),
            ),
            const SizedBox(height: 10),
            Text('Sign Up',
                style: GoogleFonts.kdamThmor(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)
                // TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 30),
                ),
            const SizedBox(height: 10),
            const Text(
              'Please Sign Up to Start Using our App',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: deviceSize.height * 0.03,
            ),
            SignUpForm(
              isLogin: false,
              submitFn: _signUp,
              isLoading: _isLoading,
            ),
          ],
        ),
      )),
    );
  }
}
