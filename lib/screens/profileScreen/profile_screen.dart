import 'package:flutter/material.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/models/app_user.dart';
import 'package:safarkarappfyp/screens/widgets/circularProfileImage.dart';

class ProfileScreen extends StatelessWidget {
  final AppUser _user;
  const ProfileScreen({AppUser user}) : _user = user;
  static const routeName = '/profileScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: greenShade),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [CircularProfileImage(imageUrl: _user.imageURL)],
        ),
      ),
    );
  }
}
