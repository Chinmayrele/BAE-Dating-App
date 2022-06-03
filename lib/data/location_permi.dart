import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:bar_chat_dating_app/screens/person_info.dart';
import 'package:bar_chat_dating_app/screens/que_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPermi extends StatefulWidget {
  const LocationPermi({Key? key}) : super(key: key);

  @override
  State<LocationPermi> createState() => _LocationPermiState();
}

class _LocationPermiState extends State<LocationPermi> {
  final Location location = Location();

  PermissionStatus _permissionGranted = PermissionStatus.denied;
  var isloading = false;

  @override
  void initState() {
    // _checkPermissions();
    _requestPermission();
    super.initState();
  }

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
        print(_permissionGranted);
        _permissionGranted == PermissionStatus.denied
            ?  isloading = true
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const PersonInfo(isEdit: false,)));
      });
    }
    // else {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (ctx) => HomePageScreen()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !isloading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'OOPPSS!!!',
                    style: TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await _requestPermission();
                      },
                      child: const Text('Retry'))
                ],
              ));
  }
}
