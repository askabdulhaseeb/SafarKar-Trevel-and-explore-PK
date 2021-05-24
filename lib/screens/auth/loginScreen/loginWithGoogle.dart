import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safarkarappfyp/auth/authorisation.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/core/myPhotos.dart';
import '../../homeScreen/homeScreen.dart';
import '../../widgets/showLoadingDialog.dart';

class LoginWithGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: greenShade,
      onTap: () async {
        showLoadingDislog(context, 'Wait');
        User _user = await AuthMethods().signInWithGoogle(context);
        Navigator.of(context).pop();
        if (_user != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        } else {
          Fluttertoast.showToast(
            msg: 'Authentication Fails',
            backgroundColor: Colors.red,
          );
        }
      },
      child: Container(
        height: 44,
        width: 190,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: blackShade,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              googleLogo,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 10),
            Text('Login with Google'),
          ],
        ),
      ),
    );
  }
}
