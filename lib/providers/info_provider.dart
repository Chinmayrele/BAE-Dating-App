import 'package:bar_chat_dating_app/models/que_ans_info.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoProviders with ChangeNotifier {
  final List<UserInfos> _userInfo = [];
  final List<UserInfos> _usersData = [];
  final List<QueAnsInfo> _queAnsInfo = [];

  List<UserInfos> get userInfo => [..._userInfo];
  List<UserInfos> get usersData => [..._usersData];
  List<QueAnsInfo> get queAnsInfo => [..._queAnsInfo];

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
      "age": info.age,
      "about": info.about,
      "interest": info.interest,
      "address": info.address,
      "imageUrls": info.imageUrls
    });
    // _userInfo.add(info);
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
    _queAnsInfo.add(info);
    notifyListeners();
  }

  // Future<void> fetchSingleUserData(String userID) async {
  //   print('USER ID FETCHING...');
  //   FirebaseFirestore.instance.collection('profile').doc().snapshots().map(
  //     (e) {
  //       final users = UserInfos(
  //         userId: e['userId'],
  //         name: e['name'],
  //         email: e['email'],
  //         phoneNo: e['phoneNo'],
  //         gender: e['gender'],
  //         genderChoice: e['genderChoice'],
  //         age: e['age'],
  //         about: e['about'],
  //         interest: e['interest'],
  //         address: e['address'],
  //         imageUrls: e['imageUrls'],
  //       );
  //       //IF GENDER && YOURSELF REMOVE CONDITION
  //       if (users.userId != FirebaseAuth.instance.currentUser!.uid) {
  //         _usersData.add(users);
  //       }
  //       notifyListeners();
  //     },
  //   );
  //   notifyListeners();
  // }

  Future<void> fetchUsersData(String genderPreference) async {
    print('12342353464565786786756545756585857857');
    FirebaseFirestore.instance.collection('profile').snapshots().map(
      (e) {
        e.docs.map(
          (e) {
            print("PRINTING USER ID IN FETCH METHOD: ${e['userId']}");
            final us = UserInfos(
              userId: e['userId'],
              name: e['name'],
              email: e['email'],
              phoneNo: e['phoneNo'],
              gender: e['gender'],
              genderChoice: e['genderChoice'],
              age: e['age'],
              about: e['about'],
              interest: e['interest'],
              address: e['address'],
              imageUrls: e['imageUrls'],
            );
            _usersData.add(us);
            //IF GENDER && YOURSELF REMOVE CONDITION
            // if (us.gender.toLowerCase() == genderPreference.toLowerCase() &&
            //     us.userId != FirebaseAuth.instance.currentUser!.uid) {
            //   print('ONE USER ADDED: ${us.name}');
            //   _usersData.add(us);
            // }
          },
        );
            notifyListeners();
      },
    );
  }

  Future<void> fetchQueAnsData() async {
    print('12342353464565786786756545756585857857');
    final data = await FirebaseFirestore.instance
        .collection('profile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('queAnsSec')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
    print('///////////////////');
    _queAnsInfo.add(userInf);
    print(_queAnsInfo[0].vacationStatus);

    notifyListeners();
    // });
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
        age: e['age'],
        about: e['about'],
        interest: e['interest'],
        address: e['address'],
        imageUrls: e['imageUrls']);
    print(data.data().toString());
    print('///////////////////');
    _userInfo.add(userInf);
    print(_userInfo[0].name);

    notifyListeners();
    // });
  }
}
