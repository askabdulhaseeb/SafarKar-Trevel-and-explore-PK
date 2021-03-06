import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/core/myFonts.dart';

class TimeContainer extends StatelessWidget {
  final String time;
  TimeContainer({
    @required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        time,
        style: TextStyle(
          color: blackShade,
          fontFamily: englishText,
          fontSize: 14,
        ),
      ),
    );
  }
}
