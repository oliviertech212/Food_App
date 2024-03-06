import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';
import 'package:foodapp/widgets/ourbrandname.dart';

class verification extends StatefulWidget {
  const verification({super.key});

  @override
  State<verification> createState() => _verificationState();
}

class _verificationState extends State<verification> {
  final _verificationCodeController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // backgroundColor: AppColors.bgSecondary.withOpacity(0.2),
      body: Stack(
        children: [
          SizedBox(height: 20),
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
                  Theme.of(context).primaryColor.withOpacity(0.29),
                  Theme.of(context).primaryColor,
                  // Theme.of(context).primaryColorLight.withOpacity(0.63),
                  // Theme.of(context).primaryColor,
                  // AppColors.bgSecondary
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(top: 150.0),
              // margin: const EdgeInsets.fromLTRB(20.0, 200.0, 20, 20.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                  // bottom: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'verification code.',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    const Text('A verification has been sent to your email'),
                    const SizedBox(height: 20),
                    MyTextField(
                      labelText: "Enter verification code",
                      inputControl: _verificationCodeController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      maxLength: 6,
                      field: 'verification',
                    ),

                    const SizedBox(height: 20),
                    MyElevatedButton(context, 50.0, 'Reset Password', () {
                      Navigator.pushNamed(context, '/new-password');
                    }, loading),
                    // ElevatedButton(
                    //   child: const Text(
                    //     'Reset Password',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/new-password');
                    //   },
                    // ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Change Email',
                        style: TextStyle(
                          color: AppColors.bgprimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
