import 'package:clean_coding/config/components/loading_widget.dart';
import 'package:clean_coding/config/components/round_button.dart';
import 'package:clean_coding/config/routes/routes_name.dart';
import 'package:clean_coding/services/splash/splash_services.dart';
import 'package:clean_coding/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    _splashServices.inLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Logo"),
              LoadingWidget(),
              // RoundButton(
              //   title: "Move",
              //   onPress: () {
              //     Navigator.pushNamed(context, RoutesName.homeScreen);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
