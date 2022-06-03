import 'package:flutter/material.dart';
// import 'package:flutter_tinder_clone_app/data/user_info_form.dart';

import '../data/user_info_form.dart';

class PersonInfo extends StatefulWidget {
  final bool isEdit;
  const PersonInfo({Key? key, required this.isEdit}) : super(key: key);

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
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.pink,
                      size: 26,
                    )),
                const SizedBox(width: 15),
                const Text(
                  'Fill Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const UserInfoForm(),
          ],
        ),
      ),
    );
  }
}
