import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/database/planMethods.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/models/plan.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';
import 'package:safarkarappfyp/providers/tripDateTimeProvider.dart';
import 'package:safarkarappfyp/screens/homeScreen/homeScreen.dart';

class SavePlanButton extends StatelessWidget {
  final GlobalKey<FormState> _globalKey;
  final TextEditingController controller;
  const SavePlanButton({
    @required globalKey,
    @required this.controller,
  }) : this._globalKey = globalKey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_globalKey.currentState.validate()) {
          TripDateTimeProvider tripDateTimeProvider =
              Provider.of<TripDateTimeProvider>(context, listen: false);
          PlacesProvider placesProvider =
              Provider.of<PlacesProvider>(context, listen: false);
          Plan _plan = Plan(
            planID: '',
            uid: UserLocalData.getUserUID(),
            planName: controller?.text?.trim(),
            departurePlaceID: placesProvider?.startingPoint?.getPlaceID(),
            destinationPlaceID: placesProvider?.endingPoint?.getPlaceID(),
            planType: placesProvider?.endingPoint?.getPlaceTypes(),
            isPublic: true,
            likes: 0,
            budget: 0,
            timeStemp: Timestamp.now(),
            departureTime:
                tripDateTimeProvider?.departureTime?.getFormatedTime(),
            destinationTime:
                tripDateTimeProvider?.returnTime?.getFormatedTime(),
            departureDate:
                tripDateTimeProvider?.startingDate?.getFormatedDate(),
            returnDate: tripDateTimeProvider?.endingDate?.getFormatedDate(),
          );
          await PlanMethods().storePlanAtFirebase(_plan);
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        } else {
          print('Error in Button');
        }
      },
      child: Container(
        height: 44,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: greenShade,
        ),
        child: Center(
          child: Text(
            'Save My Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
