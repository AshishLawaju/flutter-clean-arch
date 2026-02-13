import 'dart:convert';

import 'package:clean_coding/models/user/user_model.dart';
import 'package:clean_coding/services/storage/local_storage.dart';
import 'package:flutter/rendering.dart';

class SessionController {
  static final SessionController _session = SessionController.internal();

  final LocalStorage localStorage = LocalStorage();

  UserModel user = UserModel();
  bool? isLogin;
  //private constructor ho yo chai for aru instances create na hooss singleton pattern
  SessionController.internal() {
    isLogin = false;
  }

  factory SessionController() {
    return _session;
  }

  Future<void> saveuserInPreference(dynamic user) async {
    localStorage.setValue('token', jsonEncode(user));
    localStorage.setValue('isLogin', 'true');
  }

  Future<void> getUserFromPreference() async {
    try {
      var userData = await localStorage.readValue('token');
      var isLogin = await localStorage.readValue('isLogin');

      if (userData.isNotEmpty) {
        SessionController().user = UserModel.fromJson(jsonDecode(userData));
      }

      SessionController().isLogin = isLogin == 'true' ? true : false;
    } catch (e) {

      debugPrint(e.toString());
    }
  }
}
