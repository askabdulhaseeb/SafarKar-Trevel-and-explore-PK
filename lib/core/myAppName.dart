import 'package:flutter/material.dart';
import 'myColors.dart';
import 'myFonts.dart';

Text safar = Text(
  'Safar',
  style: TextStyle(
    color: greenShade,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: englishText,
  ),
);
Text kar = Text(
  'Kar',
  style: TextStyle(
    color: blackShade,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontFamily: englishText,
  ),
);

Row appName = Row(
  children: [
    safar,
    kar,
  ],
);
