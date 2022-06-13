import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:bar_chat_dating_app/screens/person_info.dart';
import 'package:bar_chat_dating_app/shared_preferences/location_value.dart';
import 'package:bar_chat_dating_app/shared_preferences/user_values.dart';
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
    await setLocationFlag(
        latitude: position.latitude, longitude: position.longitude);
    await setVisitingFlag(isLocDone: true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : Container(),
    );
  }
}
