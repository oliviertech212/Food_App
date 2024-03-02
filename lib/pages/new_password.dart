import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ourbrandname.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      // backgroundColor: AppColors.bgprimaryColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              // color: AppColors.bgSecondary,
              padding: const EdgeInsets.all(8.0),
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
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: brandName(context),
                      ),
                      // Text(
                      //   '  Your password must be',
                      //   style: TextStyle(
                      //     color: AppColors.textPrimarycolor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Text(
                      //   'at-least 9 characters long',
                      //   style: TextStyle(
                      //     color: AppColors.textPrimarycolor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      const SizedBox(height: 60),
                      Form(
                          key: _formKey,
                          child: Column(children: [
                            MyTextField(
                                labelText: "Enter New Password",
                                inputControl: _passwordController,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value.length < 5) {
                                    return 'Password must be at least 9 characters';
                                  }
                                  return '';
                                },
                                maxLength: 9),
                            MyTextField(
                                labelText: "Reconfirm new password",
                                inputControl: _confirmPasswordController,
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  } else if (value !=
                                      _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return '';
                                },
                                maxLength: 9),
                            const SizedBox(height: 10),
                            MyElevatedButton(
                              context,
                              50.0,
                              'Eat Away!',
                              () {
                                print('Button clicked');
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );
                                  print("Password reset successful");
                                } else {
                                  print("Password reset failed");
                                }
                                Navigator.pushNamed(context, '/login');
                              },
                            ),
                          ]))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
