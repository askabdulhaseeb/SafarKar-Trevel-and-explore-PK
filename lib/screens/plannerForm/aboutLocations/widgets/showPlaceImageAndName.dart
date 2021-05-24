import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myFonts.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';
import 'package:safarkarappfyp/screens/widgets/drawer/circlerImageLarge.dart';

class ShowPlaceImageAndName extends StatelessWidget {
  final Place place;
  const ShowPlaceImageAndName({
    Key key,
    @required this.place,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CirclerImageLarge(imageUrl: place.getPlaceImageUrl() ?? ''),
        Text(
          place.getPlaceName() ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: englishText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
