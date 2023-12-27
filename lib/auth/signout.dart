import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      print("Signed Out");
    });
    User? user = FirebaseAuth.instance.currentUser;
    return const MaterialApp(
      home: Login(),
    );
  }
}
