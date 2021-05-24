import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/database/databaseMethod.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';
import 'package:safarkarappfyp/providers/tripDateTimeProvider.dart';
import 'package:safarkarappfyp/screens/suggestedPlannerScreen/seggestedPlannerScreen.dart';

class GeneratePlannerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _plannerCondition(context);
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
            'Show Plan',
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

  _plannerCondition(BuildContext context) {
    if (Provider.of<PlacesProvider>(context, listen: false).startingPoint ==
            null ||
        Provider.of<PlacesProvider>(context, listen: false).endingPoint ==
            null ||
        Provider.of<TripDateTimeProvider>(context, listen: false)
                .startingDate ==
            null ||
        Provider.of<TripDateTimeProvider>(context, listen: false).endingDate ==
            null ||
        Provider.of<TripDateTimeProvider>(context, listen: false)
                .departureTime ==
            null ||
        Provider.of<TripDateTimeProvider>(context, listen: false).returnTime ==
            null) {
      // All things are null

      Fluttertoast.showToast(
        msg: 'Pleace Fill Requirments given in the form',
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 4,
      );
    } else {
      DatabaseMethods().storePlaceInfoInFirebase(
          Provider.of<PlacesProvider>(context, listen: false).startingPoint);
      DatabaseMethods().storePlaceInfoInFirebase(
          Provider.of<PlacesProvider>(context, listen: false).endingPoint);
      Navigator.of(context).pushNamed(SuggestedPlannerScreen.routeName);
    }
  }
}
