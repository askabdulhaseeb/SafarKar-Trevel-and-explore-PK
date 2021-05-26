import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';
import 'package:safarkarappfyp/providers/tripDateTimeProvider.dart';
import 'package:safarkarappfyp/screens/suggestedPlannerScreen/widgets/savePlanButton.dart';
import 'package:safarkarappfyp/screens/suggestedPlannerScreen/widgets/validePlanName.dart';
import 'widgets/SuggestPlannerHeaderText.dart';
import 'package:safarkarappfyp/screens/widgets/homeAppBar.dart';

import 'widgets/showPlaceWithDateAndTime.dart';

class SuggestedPlannerScreen extends StatelessWidget {
  static final routeName = '/SuggestedPlannerScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _planName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SuggestPlannerHeaderText(),
              ValidePlanName(planName: _planName),
              const SizedBox(height: 10),
              Flexible(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ShowPlaceWithDateAndTime(
                      place: Provider.of<PlacesProvider>(context, listen: false)
                          .startingPoint,
                      tripDate: Provider.of<TripDateTimeProvider>(context,
                              listen: false)
                          .startingDate,
                      tripTime: Provider.of<TripDateTimeProvider>(context,
                              listen: false)
                          .departureTime,
                    ),
                    SizedBox(height: 10),
                    ShowPlaceWithDateAndTime(
                      place: Provider.of<PlacesProvider>(context, listen: false)
                          .endingPoint,
                      tripDate: Provider.of<TripDateTimeProvider>(context,
                              listen: false)
                          .endingDate,
                      tripTime: Provider.of<TripDateTimeProvider>(context,
                              listen: false)
                          .returnTime,
                    ),
                    const SizedBox(height: 10),
                    SavePlanButton(
                      globalKey: _globalKey,
                      controller: _planName,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // button
        ),
      ),
    );
  }
}
