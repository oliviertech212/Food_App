import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';
import 'package:foodapp/widgets/ourbrandname.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static String id = 'forgot-password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgprimaryColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white,
                  AppColors.bgprimaryColor,
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 20,
            right: 20,
            child: Column(
              children: [
                brandName(context),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.bgprimaryColor,
                      width: 2,
                    ),
                  ),
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   children: [
                  //     const Text(
                  //       'Forgot Password.',
                  //       style: TextStyle(fontSize: 30, color: Colors.black),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     const SizedBox(height: 20),
                  //     TextFormField(
                  //       controller: _usernameController,
                  //       decoration: InputDecoration(
                  //         labelText: "Enter your account email",
                  //       ),
                  //       keyboardType: TextInputType.emailAddress,
                  //       textInputAction: TextInputAction.next,
                  //     ),
                  //     const SizedBox(height: 20),
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/verification');
                  //       },
                  //       child: const Text(
                  //         'Reset Password',
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot Password.',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                          labelText: "Enter your account email",
                          inputControl: _usernameController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next),
                      const SizedBox(height: 20),
                      MyElevatedButton(
                        context,
                        50.0,
                        'Reset Password',
                        () {
                          Navigator.pushNamed(context, '/verification');
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
