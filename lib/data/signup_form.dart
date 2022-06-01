import 'package:bar_chat_dating_app/screens/phone_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_tinder_clone_app/screens/home_page_screen.dart';
// import 'package:flutter_tinder_clone_app/screens/login_number.dart';

import '../auth/login.dart';
import '../auth/signup.dart';
import '../screens/home_page_screen.dart';
// import 'package:mobiflix_flutter/auth/login.dart';
// import 'package:mobiflix_flutter/auth/signup.dart';

class SignUpForm extends StatefulWidget {
  final bool isLogin;
  final bool isLoading;
  final void Function(String email, String password, String username,
      bool isLogin, BuildContext context) submitFn;
  SignUpForm({
    Key? key,
    required this.isLogin,
    required this.submitFn,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _form = GlobalKey<FormState>();
  String _emailAddress = '';
  String _userName = '';
  String _password = '';

  _trySubmit(BuildContext context) {
    var isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      widget.submitFn(
        _emailAddress.trim(),
        _password.trim(),
        _userName.trim(),
        widget.isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          (widget.isLogin != true)
              ? Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextFormField(
                    // autofocus: true,
                    maxLength: 25,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white24,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        // fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink)),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                        floatingLabelStyle: TextStyle(color: Colors.pink),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          // gapPadding: 8,
                          borderRadius: BorderRadius.circular(20),
                        )),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Enter Username with Min Length 7';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _userName = val.toString();
                    },
                  ),
                )
              : SizedBox(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white24,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink)),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  floatingLabelStyle: TextStyle(color: Colors.pink),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Email Address';
                } else if (!(val.contains('@') && val.contains('.com'))) {
                  return 'Enter a Valid Email Address';
                }
                return null;
              },
              onSaved: (val) {
                _emailAddress = val.toString();
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              cursorColor: Colors.white,
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white24,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.pink)),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ),
                  floatingLabelStyle: TextStyle(color: Colors.pink),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter your Password';
                } else if (value.length < 7) {
                  return 'For Strong Password Length Must be Min 8 Characters';
                }
                return null;
              },
              onSaved: (val) {
                _password = val.toString();
              },
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 10),
          Container(
            // width: deviceSize.width * 0.7,
            width: 250,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                // _trySubmit(context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => HomePageScreen()));
              },
              child: widget.isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      widget.isLogin ? 'Log In' : 'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
              style: ElevatedButton.styleFrom(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.all(18),
                  primary: Colors.pink),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isLogin
                    ? 'Don\'t have an Account?'
                    : 'Already have an Account?',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    widget.isLogin
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => SignUp()))
                        : Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => PhoneLogin()));
                  },
                  child: Text(
                    widget.isLogin ? 'Sign In' : 'Log In',
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          Divider(
            color: Colors.white,
            indent: 30,
            endIndent: 30,
            thickness: 0.5,
          ),
          SizedBox(height: 8),
          Text(
            'Or Connect with',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(height: 8),
          SizedBox(
            // width: deviceSize.width * 0.5,
            width: 180,
            height: widget.isLogin ? 45 : 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/images/google_logo.png'),
                  ),
                  Text(
                    'Google',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 20,
                primary: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
