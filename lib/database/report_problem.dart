import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:safarkarappfyp/database/userLocalData.dart';

class ReportProblemMethods {
  reportProblem({@required String problem}) async {
    print('object');
    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(UserLocalData.getUserUID())
        .set({
      'uid': UserLocalData.getUserUID(),
      'text': problem.trim(),
    }).onError((error, stackTrace) => print('Report Problem Database Error'));
  }
}
