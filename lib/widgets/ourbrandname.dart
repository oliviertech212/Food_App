import 'package:flutter/material.dart';

import 'package:foodapp/utils/colors.dart';

Widget brandName(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('WeDeliver',
              style: TextStyle(
                color: AppColors.textPrimarycolor,
                fontFamily: 'Roboto',
                fontSize: 55,
                fontWeight: FontWeight.bold,
              )),
          Text(
            'on time with WeDeliver',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ));
}

class MyTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final dynamic maxLength;
  final String field;
  final inputControl;
  final void Function(String?)? validator;

  const MyTextField({
    Key? key,
    required this.labelText,
    required this.inputControl,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLength,
    this.validator,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          focusColor: AppColors.bgprimaryColor,
          // errorStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: AppColors.bgprimaryColor),
          ),
          filled: true,
          // fillColor: AppColors.bgSecondary,
          labelText: labelText,
          labelStyle: TextStyle(
            color: AppColors.textPrimarycolor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.all(20)),
      controller: inputControl,
      // - optional parameter for password field
      obscureText: obscureText,
      keyboardType: keyboardType,

      validator: field == "email"
          ? (value) {
              validator?.call(value);
              if (value == null || value.isEmpty) {
                return "Please enter an email";
              } else if (!value.contains('@') ||
                  !value.contains('.') ||
                  value.length < 5) {
                return 'Please enter a valid email';
              }

              return null;
            }
          : field == "password"
              ? (value) {
                  validator?.call(value);
                  if (value == null || value.isEmpty) {
                    return "Please enter a password";
                  } else if (value.length < 5) {
                    return 'Password must be at least 5 characters';
                  }

                  return null;
                }
              : field == "confirmPassword"
                  ? (value) {
                      validator?.call(value);
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 5) {
                        return 'Password must be at least 5 characters';
                      }

                      return null;
                    }
                  : field == "verification"
                      ? (
                          value,
                        ) {
                          validator?.call(value);
                          if (value == null || value.isEmpty) {
                            return "Please enter a verification code";
                          } else if (value.length < 6) {
                            return 'Verification code must be at least 6 characters';
                          }

                          return null;
                        }
                      : field == "username"
                          ? (value) {
                              validator?.call(value);
                              if (value == null || value.isEmpty) {
                                return "Please enter a username";
                              } else if (value.length < 3) {
                                return 'Username must be at least 3 characters';
                              }

                              return null;
                            }
                          : field == "phone"
                              ? (value) {
                                  validator?.call(value);
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a phone number";
                                  } else if (value.length < 10) {
                                    return "Phone number must be at least 10 characters";
                                  }

                                  return null;
                                }
                              : field == "code"
                                  ? (value) {
                                      validator?.call(value);
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a verification code";
                                      } else if (value.length < 6) {
                                        return "Verification code must be at least 6 characters";
                                      }

                                      return null;
                                    }
                                  : null,

      textInputAction: textInputAction,
      maxLength: maxLength,
    );
  }
}

 

// "Delight your taste buds with delicious food delivered right on time with WeDeliver. Experience the joy of perfectly-timed meals at your doorstep."