import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/models/directions.dart';
import 'package:safarkarappfyp/models/location/assistantMethods.dart';
import 'package:safarkarappfyp/models/plan.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';

import 'directions_repository.dart';

class ShowGoogleMap extends StatefulWidget {
  final Plan plan;
  final Map<String, dynamic> place;

  const ShowGoogleMap({
    Key key,
    @required this.plan,
    @required this.place,
  }) : super(key: key);
  @override
  _ShowGoogleMapState createState() => _ShowGoogleMapState();
}

class _ShowGoogleMapState extends State<ShowGoogleMap> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController _googleMapController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Position _currentPosition;
  Marker _origin, _destination;
  Directions _info;

  _getUserCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    CameraPosition _currentCameraPosition = new CameraPosition(
      target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      zoom: 14,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(
        _currentPosition, context, true);

    print(address);
  }

  _initPage() async {
    _origin = _getMarker(widget.place[widget.plan?.departurePlaceID]);
    _destination = _getMarker(widget.place[widget.plan?.destinationPlaceID]);
    _getDuration();
    setState(() {});
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      key: _scaffoldKey,
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _completer.complete(controller);
        _googleMapController = controller;
        _getUserCurrentLocation();
      },
      markers: {
        if (_origin != null) _origin,
        if (_destination != null) _destination
      },
      polylines: {
        if (_info != null)
          Polyline(
            polylineId: PolylineId(widget.plan.planID),
            color: greenShade,
            width: 5,
            points: _info.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
      },
      // onLongPress: _addMarker,
    );
  }

  Marker _getMarker(Place place) {
    return Marker(
      markerId: MarkerId(place.getPlaceID()),
      infoWindow: InfoWindow(title: place.getPlaceName()),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(place.getPlaceLatitude(), place.getPlaceLongitude()),
    );
  }

  void _getDuration() async {
    final directions = await DirectionsRepository().getDirections(
      origin: _origin.position,
      destination: _destination.position,
    );
    setState(() => _info = directions);
  }
}
