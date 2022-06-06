import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:bar_chat_dating_app/screens/person_info.dart';
import 'package:flutter/material.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermi extends StatefulWidget {
  const LocationPermi({Key? key}) : super(key: key);

  @override
  State<LocationPermi> createState() => _LocationPermiState();
}

class _LocationPermiState extends State<LocationPermi> {
  // final Location location = Location();
  double? latitude;
  double? longitude;
  var locationMessage = '';

  // PermissionStatus _permissionGranted = PermissionStatus.denied;
  var isloading = true;

  @override
  void initState() {
    // _checkPermissions();
    _getLocation();
    // _requestPermission();
    super.initState();
  }

  Future<void> _getLocation() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Service are Disabled!');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission Error has been Denied!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permission are permanently denied, We cannot request permissions');
    }
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage = '${position.latitude}, ${position.longitude}';
      latitude = position.latitude;
      longitude = position.longitude;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => PersonInfo(
                isEdit: false,
                latitude: latitude!,
                longitude: longitude!,
              )));
      isloading = false;
    });
  }

  // Future<void> _checkPermissions() async {
  //   final PermissionStatus permissionGrantedResult =
  //       await location.hasPermission();
  //   setState(() {
  //     _permissionGranted = permissionGrantedResult;
  //   });
  // }

  // Future<void> _requestPermission() async {
  //   if (_permissionGranted != PermissionStatus.granted) {
  //     final PermissionStatus permissionRequestedResult =
  //         await location.requestPermission();
  //     setState(() {
  //       _permissionGranted = permissionRequestedResult;
  //       print(_permissionGranted);
  //       _permissionGranted == PermissionStatus.denied
  //           ? isloading = true
  //           : Navigator.of(context).pushReplacement(MaterialPageRoute(
  //               builder: (ctx) => const PersonInfo(
  //                     isEdit: false,
  //                   )));
  //     });
  //   }
  //   // else {
  //   //   Navigator.of(context).pushReplacement(
  //   //       MaterialPageRoute(builder: (ctx) => HomePageScreen()));
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isloading ? Center(child: CircularProgressIndicator()) : Container(),
        // isloading
        //     ? const Center(child: CircularProgressIndicator())
        //     : Column(
        //         children: [
        //           const SizedBox(height: 100),
        //           const Text(
        //             'OOPPSS!!!',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           ElevatedButton(
        //               onPressed: () async {
        //                 // await _requestPermission();
        //                 // await _getLocation();
        //                 // if (latitude == null && longitude == null) {
        //                 //   isloading = false;
        //                 // } else {
        //                 //   Navigator.of(context)
        //                 //       .pushReplacement(MaterialPageRoute(
        //                 //           builder: (ctx) => PersonInfo(
        //                 //                 isEdit: false,
        //                 //                 latitude: latitude!,
        //                 //                 longitude: longitude!,
        //                 //               )));
        //                 // }
        //               },
        //               child: const Text('Retry'))
        //         ],
        //       )
        );
  }
}
