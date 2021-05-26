import 'dart:convert';
import 'package:flutter/material.dart';

class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final List<String> interest;

  AppUser({
    @required this.uid,
    @required this.displayName,
    @required this.email,
    @required this.phoneNumber,
    @required this.interest,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'interest': interest,
    };
  }

  factory AppUser.fromDocument(docs) {
    return AppUser(
      uid: docs.data()['uid'],
      displayName: docs.data()['displayName'],
      email: docs.data()['email'],
      phoneNumber: docs.data()['phoneNumber'],
      interest: List<String>.from(docs.data()['interest']),
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      displayName: map['displayName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      interest: List<String>.from(map['interest']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
