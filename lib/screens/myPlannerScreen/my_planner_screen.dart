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

  void _getAllPlaces() async {
    _plan.forEach((plan) async {
      Place depPlace, disPlace;
      if (!_places.containsKey(plan.departurePlaceID)) {
        // print('Add 1: ${plan.departurePlaceID}');
        depPlace = await PlacesMethods()
            .getPlacesObjectFromFirebase(plan.departurePlaceID);
        _places.putIfAbsent(plan.departurePlaceID, () => depPlace);
      }
      if (!_places.containsKey(plan.destinationPlaceID)) {
        // print('Add 2: ${plan.destinationPlaceID}');
        disPlace = await PlacesMethods()
            .getPlacesObjectFromFirebase(plan.destinationPlaceID);
        _places.putIfAbsent(plan.destinationPlaceID, () => disPlace);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
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
            FutureBuilder(
              future: PlanMethods().getPlansOfSpecificUser(
                uid: UserLocalData.getUserUID(),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot?.data?.docs != null) {
                    _plan.clear();
                    snapshot?.data?.docs?.forEach((docs) {
                      _plan.add(Plan.fromDocument(docs));
                    });
                    _getAllPlaces();
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot?.data?.docs?.length ?? 0,
                      itemBuilder: (context, index) {
                        return PlanTile(plan: _plan[index], place: _places);
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'We are facing some issue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
