import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/pages/login.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
            colors: [
              Colors.white,
              // Theme.of(context).primaryColor.withOpacity(0.29),
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Center(
          child: Column(children: [
            const Padding(padding: EdgeInsets.all(30)),
            const Text(
                "We've sent verification Email. please verify your account"),
            const Text(
                "If you haven't received the email, press the button below"),
            const Padding(padding: EdgeInsets.all(30)),
            MyElevatedButton(context, 40.0, "Verify Email", () async {
              final user = FirebaseAuth.instance.currentUser;
              user?.sendEmailVerification();
              //    print(user);
            }, loading),
            SizedBox(height: 20),
            MyElevatedButton(context, 40.0, "Restart", () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            }, loading),
          ]),
        ),
      ),
    );
  }
}
