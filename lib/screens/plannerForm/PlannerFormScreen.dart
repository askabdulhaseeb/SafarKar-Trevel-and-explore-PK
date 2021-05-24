import 'package:flutter/material.dart';
import 'package:safarkarappfyp/screens/plannerForm/dateTimepicker/ShowDateTImePickers.dart';
import 'package:safarkarappfyp/screens/plannerForm/widgets/generatePlannerButton.dart';
import 'package:safarkarappfyp/screens/widgets/homeAppBar.dart';
import 'aboutLocations/showLocatedPoints.dart';
import 'aboutLocations/widgets/editLocation.dart';
import 'widgets/plannerFormHeader.dart';

class PlannerFormScreen extends StatelessWidget {
  static final routeName = '/PlannerFormScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlannerFormHeader(),
                ShowLocatedPoints(),
                EditLocation(),
                ShowDateTimePickers(),
              ],
            ),
            GeneratePlannerButton(),
          ],
        ),
      ),
    );
  }
}
