import 'dart:async';
import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myFonts.dart';
import 'package:safarkarappfyp/core/myPhotos.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/screens/planFeedScreen/plans_feed_screen.dart';
import '../../screens/auth/loginScreen/loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static final routeName = '/WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        (UserLocalData.getUserUID() == null || UserLocalData.getUserUID() == '')
            ? Navigator.of(context).pushReplacementNamed(LoginScreen.routeName)
            : Navigator.of(context).pushNamedAndRemoveUntil(
                PlansFeedScreen.routeName, (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.22),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(appLogo),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Image.asset(safarKarUrdu),
              ),
              Text(
                'Your personal Travel Planner',
                style: TextStyle(
                  fontFamily: englishText,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
