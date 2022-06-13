import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> setVisitingFlag({
  bool isLoginDone = false,
  bool isQueAnsDone = false,
  bool isLocDone = false,
  bool isProfileDone = false,
}) async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  Map<String, dynamic> mp = {
    "isProfileDone": isProfileDone,
    "isLocDone": isLocDone,
    "isLoginDone": isLoginDone,
    "isQueAnsDone": isQueAnsDone,
  };
  String setString = json.encode(mp);
  await sharedPreference.setString('alreadyVisitedUser', setString);
}

Future<String> getVisitingFlag() async {
  SharedPreferences sharePreference = await SharedPreferences.getInstance();
  String alreadyVisited = sharePreference.getString('alreadyVisitedUser') ?? '';
  
  return alreadyVisited;
}
