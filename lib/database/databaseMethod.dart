import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/models/plan.dart';
import 'package:safarkarappfyp/providers/placesproviders.dart';

class DatabaseMethods {
  Future addUserInfoToFirebase({
    @required String userId,
    @required String name,
    @required String phoneNumber,
    @required String email,
  }) async {
    Map<String, String> userInfoMap = {
      'uid': userId,
      'displayName': name.trim(),
      'phoneNumber': phoneNumber.trim(),
      'email': email.trim(),
    };
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap)
        .catchError((Object obj) {
      print(obj.toString());
    });
  }

  storeUserInfoInLocalStorageFromFirebase(String uid) async {
    DocumentSnapshot _user =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    UserLocalData.setUserUID(uid);
    UserLocalData.setUserEmail(_user.data()['email'] ?? '');
    UserLocalData.setUserDisplayName(_user.data()['displayName'] ?? '');
    UserLocalData.setUserPhoneNumber(_user.data()['phoneNumber'] ?? '');
    UserLocalData.setUserImageUrl(_user.data()['imageUrl'] ?? '');
  }

  storeUserInfoInLocalStorageFromGoogle(User user) {
    UserLocalData.setUserUID(user.uid);
    UserLocalData.setUserDisplayName(user.displayName);
    UserLocalData.setUserEmail(user.email);
    UserLocalData.setUserImageUrl(user.photoURL);
    UserLocalData.setUserPhoneNumber(user.phoneNumber);
  }

  Future<QuerySnapshot> getUserInfofromFirebase(String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();
  }

  storePlaceInfoInFirebase(Place place) {
    Map<String, dynamic> _placeMap = {
      'place_id': place.getPlaceID(),
      'name': place.getPlaceName(),
      'image_url': place.getPlaceImageUrl(),
      'lat': place.getPlaceLatitude(),
      'lng': place.getPlaceLongitude(),
      'rating': place.getPlaceRating(),
      'formatted_address': place.getPlaceFormattedAddress(),
      'types': place.getPlaceTypes(),
      'reviews': place.getPlaceReviews()
    };
    FirebaseFirestore.instance
        .collection('places')
        .doc(place.getPlaceID())
        .set(_placeMap)
        .catchError((Object obj) {
      print(obj.toString());
    });
  }

  Future<Place> getPlacesObjectFromFirebase(String pid) async {
    DocumentSnapshot place = await FirebaseFirestore.instance
        .collection("places")
        .doc(pid)
        .get().then((place) => null)
        .onError((error, stackTrace) => null);

    // if (place.data() != null) {
      // Place newPlace = Place(
    //     id: pid,
    //     name: place.data()['name'],
    //     lat: place.data()['lat'],
    //     long: place.data()['lng'],
    //     address: place.data()['formatted_address'],
    //     imageUrl: place.data()['image_url'],
    //     rating: (place.data()['rating'] + 0.0),
    //     types: (place.data()['types'] == null)
    //         ? []
    //         : place.data()['types'].cast<String>(),
    //     // reviews: List<Map<String, dynamic>>.generate(
    //     //   place.data()['reviews'].length,
    //     //   (index) =>
    //     //   List<Map<String,dynamic>>.
    //     //   from(place.data()['reviews'].elementAt(index));
    //     // ),
    //   );
    //   print('${newPlace.getPlaceName()} ID: ${newPlace.getPlaceID()}');
    //   return newPlace;
    // }
    return null;
  }

  storePlanAtFirebase(Plan plan) async {
    //
    await FirebaseFirestore.instance
        .collection('plans')
        .add(plan.toMap())
        .catchError((Object obj) {
      print('Error');
    });
  }
}
