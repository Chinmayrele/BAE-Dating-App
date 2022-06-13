import 'dart:convert';

import 'package:bar_chat_dating_app/shared_preferences/location_value.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tinder_clone_app/data/user_info_form.dart';

import '../data/user_info_form.dart';

class PersonInfo extends StatefulWidget {
  final bool isEdit;
  final double latitude;
  final double longitude;
  PersonInfo({
    Key? key,
    required this.isEdit,
    this.latitude = 0,
    this.longitude = 0,
  }) : super(key: key);

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  double latitude = 0;
  double longitude = 0;
  bool isLocLoading = true;
  @override
  void initState() {
    getLocationUser();
    super.initState();
  }

  getLocationUser() async {
    final location = await getLocationFlag();
    if (location.isNotEmpty) {
      Map<String, dynamic> mp = json.decode(location);
      latitude = mp['latitude'];
      longitude = mp['longitude'];
      setState(() {
        isLocLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: isLocLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    children: const [
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //       Icons.arrow_back,
                      //       color: Colors.pink,
                      //       size: 26,
                      //     )),
                      SizedBox(width: 22),
                      Text(
                        'Fill Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // UserInfoForm(
                  //     latitude: widget.latitude, longitude: widget.longitude),
                  UserInfoForm(latitude: latitude, longitude: longitude),
                ],
              ),
      ),
    );
  }
}
