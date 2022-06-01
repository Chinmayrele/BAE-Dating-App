import 'package:bar_chat_dating_app/models/que_ans_info.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:flutter/cupertino.dart';

class InfoProviders with ChangeNotifier {
  final List<UserInfo> _userInfo = [];
  final List<QueAnsInfo> _queAnsInfo = [];

  List<UserInfo> get userInfo => [..._userInfo];
  List<QueAnsInfo> get queAnsInfo => [..._queAnsInfo];

  addUserProfileInfo(UserInfo info) {
    _userInfo.add(info);
    notifyListeners();
  }

  addQueAnsInfo(QueAnsInfo info) {
    _queAnsInfo.add(info);
    notifyListeners();
  }
}
