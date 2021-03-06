import 'package:flutter/material.dart';
import 'package:jessic_flutter/api.dart';

class UserState extends ChangeNotifier {
  String _uid;
  String _username;
  String _nickname;
  String _avatarUrl;
  bool _isLogined = false;

  get uid => _uid;
  get username => _username;
  get nickname => _nickname;
  get avatarUrl => _avatarUrl;
  get isLogined => _isLogined;

  updateState(val, data) {
    var profile = data['profile'];
    _uid = profile['userId'].toString();
    _nickname = profile['nickname'].toString();
    _avatarUrl = profile['nickname'].toString();
    _isLogined = true;
    _username = val.toString();

    return _isLogined;
  }

  getState(String phone, String pwd) async {
    String uid = await Api.login(phone, pwd);
    var data = await Api.getUserDetail(uid);
    return updateState(phone, data);
  }

  logout() {
    _uid = '';
    _username = '';
    _nickname = '';
    _avatarUrl = '';
    _isLogined = false;
  }
}
