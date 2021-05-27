import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/database/databaseMethod.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import '../homeScreen/homeScreen.dart';

class PlansFeedScreen extends StatefulWidget {
  static final routeName = '/PlansFeedScreen';
  @override
  _PlansFeedScreenState createState() => _PlansFeedScreenState();
}

class _PlansFeedScreenState extends State<PlansFeedScreen> {
  _initPage() async {
    await DatabaseMethods().storeUserInfoInLocalStorageFromFirebase(
      UserLocalData.getUserUID(),
    );
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/startingScreenBackgroundPic.png',
            fit: BoxFit.fill,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black]),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 70,
            right: 70,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: greenShade,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "   Let's Travel Pakistan  ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
