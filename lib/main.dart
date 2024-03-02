import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/pages/home.dart';
import 'package:foodapp/pages/login.dart';
import 'package:foodapp/services/database_service.dart';
import 'package:foodapp/utils/theme.dart';
import 'package:foodapp/pages/signup.dart';
import 'package:foodapp/pages/forgot_password.dart';
import 'package:foodapp/pages/verification.dart';
import 'package:foodapp/pages/new_password.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized

  // Set up database and platform-specific initializations
  try {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    } else if (kIsWeb) {
      //- Use databaseFactoryFfiWeb for web
      databaseFactory = databaseFactoryFfiWeb;
    }

    // Initialize the database service
    final databaseService = DatabaseService();
    await databaseService.initialize();
    await databaseService.getDatabaseVersion();

    print("database initialized${databaseService.database}");

    // Start the application
    runApp(const FoodApp());
  } catch (error) {
    print('Error initializing database main: ${error.toString()}');
    // Handle other potential errors gracefully
  }
}

class FoodApp extends StatefulWidget {
  const FoodApp({super.key});

  @override
  State<FoodApp> createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
  var _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldKey,
      theme: foodApptheme,
      title: 'welcome',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const MySignupPage(),
        '/forgot-password': (context) => ForgotPassword(),
        '/verification': (context) => const verification(),
        '/new-password': (context) => const NewPassword(),
      },
    );
  }
}
