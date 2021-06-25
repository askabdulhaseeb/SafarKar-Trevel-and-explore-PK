import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/database/databaseMethod.dart';
import 'package:safarkarappfyp/database/planMethods.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/models/app_user.dart';
import 'package:safarkarappfyp/models/plan.dart';
import 'package:safarkarappfyp/models/suggest_places.dart';
import 'package:safarkarappfyp/screens/planFeedScreen/feed_tile.dart';
import '../homeScreen/homeScreen.dart';

class PlansFeedScreen extends StatefulWidget {
  static final routeName = '/PlansFeedScreen';
  @override
  _PlansFeedScreenState createState() => _PlansFeedScreenState();
}

class _PlansFeedScreenState extends State<PlansFeedScreen> {
  // List<String> _userInterest;
  // QuerySnapshot _querySnapshot;
  Stream _feed;
  _initPage() async {
    SuggestPlacesFromAPI().getSuggestion();
    // await DatabaseMethods().storeUserInfoInLocalStorageFromFirebase(
    //   UserLocalData.getUserUID(),
    // );
    // _userInterest = UserLocalData.getUserInterest();
    // _userInterest.forEach((type) async {
    //   var temp = await PlanMethods().getPlanOfSpecificType(type: type);
    // });
    _feed = await PlanMethods().getAllPublicPlans();
    setState(() {});
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
          // Image.asset(
          //   'assets/images/startingScreenBackgroundPic.png',
          //   fit: BoxFit.fill,
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.center,
          //         end: Alignment.bottomCenter,
          //         colors: [Colors.transparent, Colors.black]),
          //   ),
          // ),
          StreamBuilder(
            stream: _feed,
            // initialData: initialData ,
            builder: (context, snapshot) {
              return (snapshot.hasData)
                  ? ListView.builder(
                      itemCount: snapshot?.data?.docs?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Plan _plan =
                            Plan.fromDocument(snapshot?.data?.docs[index]);
                        return (_plan.uid != UserLocalData.getUserUID())
                            ? FeedTile(plan: _plan)
                            : Container();
                      },
                    )
                  : Container();
            },
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
