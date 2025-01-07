import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> register(
    String email,
    String password,
    String repeatPassword,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Authentication failed!';
      }
    } catch (e) {
      return 'Unexpected error occurred!';
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        return 'Wrong password or invalid email!';
      } else {
        return 'Authentication failed!';
      }
    } catch (e) {
      return 'Unexpected error occurred!';
    }
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return 'Failed to send password reset email: ${e.message}';
    } catch (e) {
      return 'An unexpected error occurred';
    }
  }
}
