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
}
