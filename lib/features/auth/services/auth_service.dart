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
}
