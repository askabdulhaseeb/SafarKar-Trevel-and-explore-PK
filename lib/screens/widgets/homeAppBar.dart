import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safarkarappfyp/core/myAppName.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/core/myPhotos.dart';
import 'package:safarkarappfyp/database/databaseMethod.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/models/app_user.dart';
import 'package:safarkarappfyp/models/location/assistantMethods.dart';
import 'package:safarkarappfyp/providers/tripDateTimeProvider.dart';
import 'package:safarkarappfyp/screens/profileScreen/profile_screen.dart';
import 'circularProfileImage.dart';

AppBar homeAppBar(context) {
  // TripTime _getTripTimeObject(DateTime dateTime) {
  //   TripTime _tripTime = TripTime();
  //   final hour = DateFormat('hh').format(dateTime);
  //   final minute = DateFormat('mm').format(dateTime);
  //   final aa = DateFormat('a').format(dateTime);
  //   final formatedTime = hour + ':' + minute + ' ' + aa;

  //   _tripTime.setHour(hour);
  //   _tripTime.setMinute(minute);
  //   _tripTime.setFormatedTime(formatedTime);
  //   return _tripTime;
  // }

  // TripDate _getTripDateObject(DateTime dateTime) {
  //   TripDate _tripDate = TripDate();
  //   final date = DateFormat('dd').format(dateTime);
  //   final month = DateFormat('MM').format(dateTime);
  //   final year = DateFormat('yyyy').format(dateTime);

  //   _tripDate.setDate(date);
  //   _tripDate.setMonth(month);
  //   _tripDate.setYear(year);
  //   _tripDate.setFormatedDate('$date/$month/$year');
  //   return _tripDate;
  // }

  return AppBar(
    leadingWidth: 26,
    centerTitle: false,
    iconTheme: IconThemeData(color: greenShade),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          child: Image.asset(appLogo),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: appName,
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: GestureDetector(
          onTap: () async {
            // AssistantMethods.getEndingPositionFromAPI(
            //   'ChIJpV--2wg_IjkRncKTQJKoXrQ',
            //   context,
            // );
            // AssistantMethods.getStartingPositionFromAPI(
            //   'ChIJa-SNe8NHsz4Rhgk1dLoNEEs',
            //   context,
            // );
            // TripDate _tripDate = _getTripDateObject(DateTime.now());
            // Provider.of<TripDateTimeProvider>(context, listen: false)
            //     .updateTripEndingDate(tripDate: _tripDate);
            // Provider.of<TripDateTimeProvider>(context, listen: false)
            //     .updateTripStartingDate(tripDate: _tripDate);

            // TripTime _tripTime = _getTripTimeObject(DateTime.now());
            // Provider.of<TripDateTimeProvider>(context, listen: false)
            //     .updateTripReturnTime(tripTime: _tripTime);
            // Provider.of<TripDateTimeProvider>(context, listen: false)
            //     .updateTripDepartureTime(tripTime: _tripTime);
            print(UserLocalData.getUserUID());
            final DocumentSnapshot docs =
                await DatabaseMethods().getUserInfofromFirebase(
              UserLocalData.getUserUID(),
            );
            AppUser _user = AppUser.fromDocument(docs);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfileScreen(user: _user),
            ));
          },
          child: CircularProfileImage(
            imageUrl: UserLocalData.getUserImageUrl(),
          ),
        ),
      ),
      // TODO: Import Profile Pic here By NetworkImage('Path')
    ],
  );
}
