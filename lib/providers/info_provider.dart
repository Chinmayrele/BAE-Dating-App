import 'package:bar_chat_dating_app/models/que_ans_info.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class InfoProviders with ChangeNotifier {
  final List<UserInfos> _userInfo = [];
  final List<UserInfos> _usersData = [];
  // late UserInfos _userData;
  final List<QueAnsInfo> _queAnsInfo = [];
  int _curIndex = 0;

  List<UserInfos> get userInfo => [..._userInfo];
  List<UserInfos> get usersData => [..._usersData];
  // UserInfos get userData => _userData;
  List<QueAnsInfo> get queAnsInfo => [..._queAnsInfo];
  int get curIndex => _curIndex;

  Future<void> addUserProfileInfo(UserInfos info) async {
    await FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'userId': info.userId,
      'name': info.name,
      'email': info.email,
      "phoneNo": info.phoneNo,
      "gender": info.gender,
      "genderChoice": info.genderChoice,
      "iLike": info.iLike,
      "isViewed": info.isViewed,
      "whoLikedMe": info.whoLikedMe,
      "intersectionLikes": info.intersectionLikes,
      "latitude": info.latitude,
      "longitude": info.longitude,
      "age": info.age,
      "about": info.about,
      "interest": info.interest,
      "address": info.address,
      "imageUrls": info.imageUrls,
      "isSubscribed": info.isSubscribed,
    });
    notifyListeners();
  }

  Future<void> addQueAnsInfo(QueAnsInfo info) async {
    await FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('queAnsSec')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "relationStatus": info.relationStatus,
      "vacationStatus": info.vacationStatus,
      "nightStatus": info.nightStatus,
      "smokeStatus": info.smokeStatus,
      "drinkStatus": info.drinkStatus,
      "exerciseStatus": info.exerciseStatus,
      "heightStatus": info.heightStatus,
    });
    // _queAnsInfo.add(info);
    notifyListeners();
  }

  Future<UserInfos> fetchSingleUserData(String userID) async {
    print('USER ID FETCHING...');
    final data = await FirebaseFirestore.instance
        .collection('profile')
        .doc(userID)
        .get();
    final e = data.data();
    final userDatas = UserInfos(
      userId: e!['userId'],
      name: e['name'],
      email: e['email'],
      phoneNo: e['phoneNo'],
      gender: e['gender'],
      genderChoice: e['genderChoice'],
      iLike: e['iLike'],
      isViewed: e['isViewed'],
      whoLikedMe: e['whoLikedMe'],
      intersectionLikes: e['intersectionLikes'],
      latitude: e['latitude'],
      longitude: e['longitude'],
      age: e['age'],
      about: e['about'],
      interest: e['interest'],
      address: e['address'],
      imageUrls: e['imageUrls'],
      isSubscribed: e['isSubscribed'],
    );
    //IF GENDER && YOURSELF REMOVE CONDITION
    // if (users.userId != FirebaseAuth.instance.currentUser!.uid) {
    //   _usersData.add(users);
    // }
    print('USER DATA SINGLE FETCH PROVIDER: ${userDatas.latitude}');
    return userDatas;
  }

  Future<void> fetchUsersData(
      String genderPreference, double lati, double longi) async {
    print('12342353464565786786756545756585857857');
    final data = await FirebaseFirestore.instance.collection('profile').get();
    print("DATA SIZE IMP: ${data.size}");
    print("DATA DOCS LENGTH: ${data.docs.length}");
    final e = data.docs;
    for (int i = 0; i < e.length; i++) {
      final us = UserInfos(
          userId: e[i]['userId'],
          name: e[i]['name'],
          email: e[i]['email'],
          phoneNo: e[i]['phoneNo'],
          gender: e[i]['gender'],
          genderChoice: e[i]['genderChoice'],
          iLike: e[i]['iLike'],
          isViewed: e[i]['isViewed'],
          whoLikedMe: e[i]['whoLikedMe'],
          intersectionLikes: e[i]['intersectionLikes'],
          latitude: e[i]['latitude'],
          longitude: e[i]['longitude'],
          age: e[i]['age'],
          about: e[i]['about'],
          interest: e[i]['interest'],
          address: e[i]['address'],
          imageUrls: e[i]['imageUrls'],
          isSubscribed: e[i]['isSubscribed']);
      final distance =
          Geolocator.distanceBetween(lati, longi, us.latitude, us.longitude);

      //  IF GENDER && YOURSELF REMOVE CONDITION   && !_userInfo[0].isViewed.contains(us.userId)
      if (us.gender.toLowerCase() == genderPreference.toLowerCase() &&
          us.userId != FirebaseAuth.instance.currentUser!.uid &&
          distance < 100000 &&
          !_userInfo[0].isViewed.contains(us.userId)) {
        _usersData.add(us);
      }
    }
    notifyListeners();
  }

  Future<QueAnsInfo> fetchQueAnsData(String useId) async {
    print('12342353464565786786756545756585857857');
    final data = await FirebaseFirestore.instance
        .collection('profile')
        .doc(useId)
        .collection('queAnsSec')
        .doc(useId)
        .get();
    final e = data.data();
    final userInf = QueAnsInfo(
      relationStatus: e!['relationStatus'],
      vacationStatus: e['vacationStatus'],
      exerciseStatus: e['exerciseStatus'],
      smokeStatus: e['smokeStatus'],
      drinkStatus: e['drinkStatus'],
      nightStatus: e['nightStatus'],
      heightStatus: e['heightStatus'],
    );
    print(data.data().toString());
    return userInf;
    // _queAnsInfo.add(userInf);
    // print(
    //     "QUE ANS FETCH METHOD PROVIDER VACATION STATUS: ${_queAnsInfo[0].vacationStatus}");
    // notifyListeners();
  }

  Future<void> fetchUSerProfileData() async {
    print('12342353464565786786756545756585857857');
    final data = await FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final e = data.data();
    final userInf = UserInfos(
      userId: e!['userId'],
      name: e['name'],
      email: e['email'],
      phoneNo: e['phoneNo'],
      gender: e['gender'],
      genderChoice: e['genderChoice'],
      iLike: e['iLike'],
      isViewed: e['isViewed'],
      whoLikedMe: e['whoLikedMe'],
      intersectionLikes: e['intersectionLikes'],
      latitude: e['latitude'],
      longitude: e['longitude'],
      age: e['age'],
      about: e['about'],
      interest: e['interest'],
      address: e['address'],
      imageUrls: e['imageUrls'],
      isSubscribed: e['isSubscribed'],
    );
    print(data.data().toString());
    print('///////////////////');
    _userInfo.add(userInf);
    print("FETCH PROFILE USER DATA PROVIDER NAME: ${_userInfo[0].name}");
    notifyListeners();
  }

  changeIndex(int ind) {
    _curIndex = ind;
    // notifyListeners();
  }
}
