import 'package:coffee/screens/authenticate/register.dart';
import 'package:coffee/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
       if (showSignin) {
        return SignIn(toggleView: toggleView);
       } else {
        return Register(toggleView: toggleView);
       }

  }
}