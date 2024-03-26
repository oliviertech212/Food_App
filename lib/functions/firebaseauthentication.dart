import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/dialogs/authdialog.dart';
import 'package:foodapp/firebase_options.dart';
import 'package:path/path.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseAuthenticationService {
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ErrorDialog(e.code, context);
    } catch (e) {
      ErrorDialog(e.toString(), context);
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password,
      String username, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(username);
        await user.reload();
        // User? updatedUser = _auth.currentUser;
      }
    } on FirebaseAuthException catch (e) {
      ErrorDialog(e.code, context);
    } catch (e) {
      ErrorDialog(e.toString(), context);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> changePassword(String password) async {
    await auth.currentUser!.updatePassword(password);
  }

  Future<User?> getCurrentUser() async {
    final user = auth.currentUser;
    return user;
  }

  Future<bool> isEmailVerified() async {
    final user = auth.currentUser;
    return user!.emailVerified;
  }
}
