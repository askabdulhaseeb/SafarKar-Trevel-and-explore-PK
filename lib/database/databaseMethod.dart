import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';
import 'package:safarkarappfyp/models/app_user.dart';

class DatabaseMethods {
  static const String _fUser = 'users';
  Future addUserInfoToFirebase({
    @required String userId,
    @required String name,
    @required String phoneNumber,
    @required String email,
    String imageURL,
  }) async {
    Map<String, String> userInfoMap = {
      'uid': userId,
      'displayName': name?.trim() ?? '',
      'phoneNumber': phoneNumber?.trim() ?? '',
      'email': email?.trim() ?? '',
      'imageURL': imageURL?.trim() ?? '',
    };
    return await FirebaseFirestore.instance
        .collection(_fUser)
        .doc(userId)
        .set(userInfoMap)
        .catchError((Object obj) {
      print(obj.toString());
    });
  }

  storeUserInfoInLocalStorageFromFirebase(String uid) async {
    DocumentSnapshot docs =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    final AppUser user = AppUser.fromDocument(docs);
    UserLocalData.setUserUID(uid);
    UserLocalData.setUserEmail(user?.email ?? '');
    UserLocalData.setUserDisplayName(user?.displayName ?? '');
    UserLocalData.setUserPhoneNumber(user?.phoneNumber ?? '');
    UserLocalData.setUserImageUrl(user?.imageURL ?? '');
    UserLocalData.setUserInterest(user?.interest ?? []);
  }

  storeUserInfoInLocalStorageFromGoogle(User user) {
    UserLocalData.setUserUID(user?.uid);
    UserLocalData.setUserDisplayName(user?.displayName);
    UserLocalData.setUserEmail(user?.email);
    UserLocalData.setUserImageUrl(user?.photoURL);
    UserLocalData.setUserPhoneNumber(user?.phoneNumber);
  }

  Future<DocumentSnapshot> getUserInfofromFirebase(String uid) async {
    return FirebaseFirestore.instance.collection(_fUser).doc(uid).get();
  }

  updateUserDoc(
      {@required String uid, @required Map<String, dynamic> userMap}) async {
    return await FirebaseFirestore.instance
        .collection(_fUser)
        .doc(uid)
        .update(userMap);
  }
}
