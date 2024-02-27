import 'package:flutter/material.dart';
import 'package:foodapp/models/users.dart';
import 'package:foodapp/pages/welcome_screen.dart';
import 'package:foodapp/services/users.dart';
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
  final _usernameController = TextEditingController();
  final _useremailController = TextEditingController();
  final _passwordController = TextEditingController();

  final userDB = UserDB();

  @override
  void initState() {
    if (widget.user != null) {
      _usernameController.text = widget.user!.username!;
      _useremailController.text = widget.user!.email;
      _passwordController.text = widget.user!.password;
    }
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _useremailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    MyTextField(
                        labelText: "UserName",
                        inputControl: _usernameController),

                    const SizedBox(height: 12.0),
                    MyTextField(
                        labelText: "Email",
                        inputControl: _useremailController,
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

                      final username = _usernameController.text;
                      final email = _useremailController.text;
                      final password = _passwordController.text;

                      // Validate user input (e.g., check passwords match, email format, etc.)

                      try {
                        final user = User(
                          username: username,
                          email: email,
                          password: password,
                        );

                        final id = await userDB.createUser(user);

                        userDB.getUsers();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyWelcomePage(),
                          ),
                        );
                        print('User $id inserted');
                      } catch (error) {
                        print('Error inserting user: $error');
                      } finally {
                        Navigator.pushNamed(context, '/login');
                      }
                    }),

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
