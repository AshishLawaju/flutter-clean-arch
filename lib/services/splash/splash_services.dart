import 'dart:async';

import 'package:clean_coding/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class SplashServices {

  void inLogin(BuildContext context){
    Timer(Duration(seconds: 3),()=>Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.loginScreen,
      (route)=>false
    ));  

  }
}