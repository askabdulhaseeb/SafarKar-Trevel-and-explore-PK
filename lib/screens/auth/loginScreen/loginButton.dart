import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safarkarappfyp/auth/authorisation.dart';
import 'package:safarkarappfyp/core/myColors.dart';
import 'package:safarkarappfyp/screens/startingScreen/startingScreen.dart';
import 'package:safarkarappfyp/screens/widgets/showLoadingDialog.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required GlobalKey<FormState> loginFormkey,
    @required TextEditingController email,
    @required TextEditingController password,
  })  : _loginFormkey = loginFormkey,
        _email = email,
        _password = password,
        super(key: key);

  final GlobalKey<FormState> _loginFormkey;
  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_loginFormkey.currentState.validate()) {
          TextInput.finishAutofillContext();
          showLoadingDislog(context, 'Loading data');
          User _user = await AuthMethods().loginWithEmailAndPassword(
            _email.text.trim(),
            _password.text.trim(),
          );
          Navigator.of(context).pop();
          if (_user != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                StartingScreen.routeName, (route) => false);
          } else {
            Fluttertoast.showToast(
              msg: 'Incorrect Email or Password',
              backgroundColor: Colors.red,
            );
          }
        }
      },
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[300], greenShade],
          ),
        ),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
