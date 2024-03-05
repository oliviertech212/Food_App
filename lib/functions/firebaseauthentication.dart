import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodapp/firebase_options.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseAuthenticationService {
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print("error occured during sign in: $e");
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String username) async {
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
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("error occured during sign up: $e");
    }
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
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
