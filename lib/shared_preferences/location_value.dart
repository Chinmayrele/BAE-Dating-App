import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> setLocationFlag({
  double latitude = 0,
  double longitude = 0,
}) async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  Map<String, dynamic> mp = {
    "latitude": latitude,
    "longitude": longitude,
  };
  String setString = json.encode(mp);
  await sharedPreference.setString('alreadyLocationAssigned', setString);
}

Future<String> getLocationFlag() async {
  SharedPreferences sharePreference = await SharedPreferences.getInstance();
  String alreadyVisited = sharePreference.getString('alreadyLocationAssigned') ?? '';
  return alreadyVisited;
}