import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/functions/firebaseauthentication.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ourbrandname.dart';
import 'package:foodapp/widgets/ElevatedButton.dart';
import 'package:foodapp/services/database_service.dart';

class MySignupPage extends StatefulWidget {
  final User? user;
  final ValueChanged<String>? onSubmit;

  const MySignupPage({Key? key, this.user, this.onSubmit}) : super(key: key);

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;

// -firebase auth instance
  final FirebaseAuthenticationService _auth = FirebaseAuthenticationService();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String username = _usernameController.text;
    String confirmPassword = _confirmPasswordController.text;

    setState(() {
      loading = true;
    });

    User? user = await _auth.signUpWithEmailAndPassword(
        email, password, username, context);
    if (user != null) {
      loading = false;
      print('User created');
      Navigator.pushNamed(context, '/verification');
    } else {
      loading = false;
      print('User not created');
      Navigator.pushNamed(context, '/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // backgroundColor: AppColors.bgSecondary.withOpacity(0.2),
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
                    // Theme.of(context).primaryColor.withOpacity(0.50),
                    // Theme.of(context).primaryColor,

                    // Theme.of(context).primaryColor.withOpacity(0.29),
                    // Theme.of(context).primaryColor,
                    Theme.of(context).primaryColorLight.withOpacity(0.1),
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
            ),
            // Container with rounded corners
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                      indent: 150,
                      endIndent: 150,
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
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          MyTextField(
                            labelText: "UserName",
                            inputControl: _usernameController,
                            keyboardType: TextInputType.text,
                            field: "username",
                            validator: (value) {},
                          ),

                          const SizedBox(height: 12.0),
                          MyTextField(
                            labelText: "Email",
                            inputControl: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            field: 'email',
                            validator: (value) {},
                          ),

                          const SizedBox(height: 12.0),
                          MyTextField(
                            labelText: "Password",
                            inputControl: _passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            // maxLength: 9,
                            field: "password",
                            validator: (value) {},
                          ),

                          const SizedBox(height: 12.0),
                          MyTextField(
                              labelText: "confirmPassword",
                              inputControl: _confirmPasswordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              maxLength: 9,
                              field: "confirmPassword",
                              validator: (value) {}),

                          const SizedBox(height: 10.0),

                          // MyTextField(
                          //     labelText: "ConfirmPassword",
                          //     inputControl: _passwordController,
                          //     obscureText: true,
                          //     keyboardType: TextInputType.visiblePassword,
                          //     textInputAction: TextInputAction.next,
                          //     maxLength: 8),

                          // const SizedBox(height: 10.0),

                          MyElevatedButton(context, 50.0, 'Never Hungry Again!',
                              () async {
                            // Navigator.pushNamed(context, '/signup');
                            print(
                                'Button clicked $loading ${_formKey.currentState!.validate()} ');

                            if (_formKey.currentState!.validate()) {
                              print('Form validated');
                              _signUp();
                            } else {
                              print(
                                  'Form not validated'); // Debugging print statement
                            }
                          }, loading),

                          // const SizedBox(height: 12.0),
                          // MyElevatedButton(context, double.infinity, 'Sign In', () {
                          //   Navigator.pushNamed(context, '/signin');
                          // }),
                        ])),

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
