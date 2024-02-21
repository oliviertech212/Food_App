import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/ourbrandname.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      body: Container(
        color: AppColors.bgSecondary,
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
                MyTextField(
                  labelText: "Email",
                  inputControl: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next),
                const SizedBox(height: 10),
                MyTextField(
                  labelText: "Password",
                  inputControl: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  maxLength: 8),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {}, 
                  child: Text('forgot password?',
                    style: TextStyle(
                      color: AppColors.textPrimarycolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.bgprimaryColor,
                  ), 
                  child: Text('Eat Away!',
                    style: TextStyle(
                      color: AppColors.textWhitecolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: <Widget>[
                    const Text('or Sign in with'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.email),
                          onPressed: () {
                            //  email sign in
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.facebook),
                          onPressed: () {
                            // Facebook sign in
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.bgprimaryColor,),
                  child: Text('sign up',
                    style: TextStyle(
                      color: AppColors.textWhitecolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}