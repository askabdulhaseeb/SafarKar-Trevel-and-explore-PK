import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myFonts.dart';
import 'package:safarkarappfyp/core/myPhotos.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';
import 'package:safarkarappfyp/screens/widgets/homeAppBar.dart';

class PlaceDetailScreen extends StatefulWidget {
  static final routeName = '/PlaceDetailsScreen';
  Place place;
  PlaceDetailScreen({Place p}) {
    place = p;
  }
  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: widget.place.getPlaceID(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (widget.place.getPlaceImageUrl() == null ||
                          widget.place.getPlaceImageUrl().isEmpty)
                      ? AssetImage(appLogo)
                      : NetworkImage(widget.place.getPlaceImageUrl()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  (widget.place.getPlaceName() == null)
                      ? 'Name Not Found'
                      : widget.place.getPlaceName(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: englishText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text('Rating: ${widget.place.getPlaceRating()}'),
                    Icon(Icons.star_rate_rounded),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.place.getPlaceFormattedAddress(),
                ),
                // TODO: Show Types
                // TODO: Show Reviews
              ],
            ),
          ),
        ],
      ),
    );
  }
}
