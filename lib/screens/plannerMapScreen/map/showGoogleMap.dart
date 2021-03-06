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

  setInitialCam() {
    CameraPosition _currentCameraPosition = new CameraPosition(
      target: _origin.position,
      zoom: 14,
    );

    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));
  }

  _initPage() async {
    _origin = _getMarker(widget.place[widget.plan?.departurePlaceID]);
    _destination = _getMarker(widget.place[widget.plan?.destinationPlaceID]);
    _getDuration();
    setInitialCam();
    setState(() {});
  }

  @override
  void initState() {
    _initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
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
            // _getUserCurrentLocation();
            setInitialCam();
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
        ),
        if (_info != null)
          Positioned(
            top: 20.0,
            left: 60,
            right: 60,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: greenShade,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Distance: ${_info.totalDistance}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Time: ${_info.totalDuration}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
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
