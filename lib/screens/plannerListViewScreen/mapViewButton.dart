import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/core/myFonts.dart';
import '../plannerMapScreen/plannerMapScreen.dart';

class MapViewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: GestureDetector(
        onTap: () {
          //TODO:on Select Trip Go to Ralitive Planner Page
          Navigator.of(context).pushNamed(PlannerMapScreen.routeName);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: greenShade,
          ),
          child: Text(
            'Map View',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: englishText,
            ),
          ),
        ),
      ),
    );
  }
}
