import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safarkarappfyp/database/placesMethods.dart';
import 'package:safarkarappfyp/database/planMethods.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/models/plan.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';
import 'package:safarkarappfyp/screens/myPlannerScreen/planTile/plan_tile.dart';
import 'package:safarkarappfyp/screens/widgets/homeAppBar.dart';

class MyPlannerScreen extends StatefulWidget {
  static const routeName = '/MyPLannerScreen';
  @override
  _MyPlannerScreenState createState() => _MyPlannerScreenState();
}

class _MyPlannerScreenState extends State<MyPlannerScreen> {
  List<Plan> _plan = [];
  Map<String, Place> _places = {};
  bool isLoading = false;

  void _getAllPlaces() async {
    print(isLoading);
    setState(() {
      isLoading = true;
    });
    final QuerySnapshot gettedData = await PlanMethods().getPlansOfSpecificUser(
      uid: UserLocalData.getUserUID(),
    );

    _plan.clear();
    gettedData.docs.forEach((docs) {
      _plan.add(Plan.fromDocument(docs));
    });

    _plan.forEach((plan) async {
      Place depPlace, disPlace;
      if (!_places.containsKey(plan.departurePlaceID)) {
        depPlace = await PlacesMethods()
            .getPlacesObjectFromFirebase(plan.departurePlaceID);
        _places.putIfAbsent(plan.departurePlaceID, () => depPlace);
      }
      if (!_places.containsKey(plan.destinationPlaceID)) {
        disPlace = await PlacesMethods()
            .getPlacesObjectFromFirebase(plan.destinationPlaceID);
        _places.putIfAbsent(plan.destinationPlaceID, () => disPlace);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _getAllPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Here are all your plans',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _plan?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (_plan?.length == 0)
                          return Center(
                            child: Text(
                              '''You don't have any plan to show yet''',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                          );
                        return PlanTile(plan: _plan[index], place: _places);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
