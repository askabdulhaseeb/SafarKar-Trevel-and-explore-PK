import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safarkarappfyp/models/plan.dart';

class PlanMethods {
  static const _fPlan = 'plans';
  getPlansOfSpecificUser({@required String uid}) async {
    return await FirebaseFirestore.instance
        .collection(_fPlan)
        .where('uid', isEqualTo: uid)
        .get();
  }

  storePlanAtFirebase(Plan plan) async {
    await FirebaseFirestore.instance
        .collection('plans')
        .add(plan.toMap())
        .then((value) => FirebaseFirestore.instance
            .collection('plans')
            .doc(value.id)
            .update({'planID': value.id}))
        .catchError((Object obj) {
      print('Error');
    });
  }
}
