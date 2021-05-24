import 'package:flutter/material.dart';
import '../widgets/homeAppBar.dart';
import 'map/showGoogleMap.dart';

class PlannerMapScreen extends StatelessWidget {
  static final routeName = '/PlannerMapScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Stack(
        children: [
          ShowGoogleMap(),
        ],
      ),
    );
  }
}
