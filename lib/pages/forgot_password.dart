import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ourbrandname.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static String id = 'forgot-password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgprimaryColor.withOpacity(0.2),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: brandName(context),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 150),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot Password.',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      MyTextField(
                  labelText: "Enter your account email",
                  inputControl: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        child: const Text('Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/verification');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],),
            ),
          );
  }
}
