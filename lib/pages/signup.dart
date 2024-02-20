import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ourbrandname.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';

class MySignupPage extends StatefulWidget {
  const MySignupPage({super.key});

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgprimaryColor.withOpacity(0.2),
      body: Center(
        child: Stack(
          children: [
            // Your SizedBox with brandName
            SizedBox(
              height: 200,
              width: double.infinity,
              child: brandName(context),
            ),
            // Container with gradient opacity
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
            ),
            // Container with rounded corners
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 150),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: const BorderRadius.vertical(
                    top:
                        Radius.circular(20), // Small rounded corners at the top
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(children: [
                    Divider(
                      color: AppColors.bgprimaryColor,
                      height: 50,
                      thickness: 5,
                      indent: 200,
                      endIndent: 200,
                    ),

                    const SizedBox(height: 12.0),
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            color: AppColors.bgprimaryColor,
                          ),
                    ),

                    // TextField(
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     labelText: 'Password',
                    //     hintStyle: TextStyle(
                    //       color: Colors.black,
                    //     ),
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(50)),
                    //     contentPadding: EdgeInsets.all(20),
                    //   ),
                    //   obscureText: true,
                    //   style: const TextStyle(color: Colors.black),
                    //   // controller: _passwordController,
                    //   obscuringCharacter: "*",
                    //   autocorrect: false,
                    //   enableSuggestions: false,
                    //   // maxLength: 8,
                    // ),
                    const SizedBox(height: 12.0),
                    MyTextField(
                        labelText: "UserName",
                        inputControl: _usernameController),

                    const SizedBox(height: 12.0),
                    MyTextField(
                        labelText: "Email",
                        inputControl: _usernameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next),

                    const SizedBox(height: 12.0),
                    MyTextField(
                        labelText: "Password",
                        inputControl: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        maxLength: 8),

                    const SizedBox(height: 12.0),
                    MyTextField(
                        labelText: "ConfirmPassword",
                        inputControl: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        maxLength: 8),

                    const SizedBox(height: 10.0),

                    MyTextField(
                        labelText: "ConfirmPassword",
                        inputControl: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        maxLength: 8),

                    const SizedBox(height: 10.0),

                    MyElevatedButton(context, 50.0, 'Never Hungry Again!', () {
                      // Navigator.pushNamed(context, '/signup');
                    }),
                    // const SizedBox(height: 12.0),
                    // MyElevatedButton(context, double.infinity, 'Sign In', () {
                    //   Navigator.pushNamed(context, '/signin');
                    // }),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "or Sign Up With",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: AppColors.textSecondarycolor,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
