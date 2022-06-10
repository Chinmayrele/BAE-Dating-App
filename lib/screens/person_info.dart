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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            UserInfoForm(
                latitude: widget.latitude, longitude: widget.longitude),
          ],
        ),
      ),
    );
  }
}
