import 'dart:async';

import 'package:clean_coding/config/routes/routes_name.dart';
import 'package:clean_coding/services/session_manager/session_controller.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void inLogin(BuildContext context) {
    SessionController()
        .getUserFromPreference()
        .then((value) {
          if (SessionController().isLogin ?? false) {
            Timer(
              Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.homeScreen,
                (route) => false,
              ),
            );
          } else {
            Timer(
              Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.loginScreen,
                (route) => false,
              ),
            );
          }
        })
        .onError((error, StackTrace) {
          Timer(
            Duration(seconds: 2),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.loginScreen,
              (route) => false,
            ),
          );
        });
  }
}
