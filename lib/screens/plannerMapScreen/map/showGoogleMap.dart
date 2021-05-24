import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safarkarappfyp/models/location/assistantMethods.dart';

class ShowGoogleMap extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  _ShowGoogleMapState createState() => _ShowGoogleMapState();
}

class _ShowGoogleMapState extends State<ShowGoogleMap> {
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController _googleMapController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Position _currentPosition;

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

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      key: _scaffoldKey,
      mapType: MapType.normal,
      initialCameraPosition: ShowGoogleMap._kGooglePlex,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _completer.complete(controller);
        _googleMapController = controller;
        _getUserCurrentLocation();
      },
    );
  }
}
