import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  const AuthService._();

  static AuthService get instance => const AuthService._();

  bool authCheck() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> register(
    String email,
    String password,
    String repeatPassword,
  ) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('users').add(
        {
          'id': userCredential.user?.uid,
          'email': email,
        },
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

  Future<(String?, bool?)> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final firebaseUser = userCredential.user;

      final snap = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser?.uid)
          .get();

      bool isRegister = false;

      if (snap.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('users').add(
          {
            'id': userCredential.user?.uid,
            'email': googleUser?.email,
            'name': googleUser?.displayName,
            'photoUrl': googleUser?.photoUrl,
          },
        );

        isRegister = true;
      }

      return (null, isRegister);
    } catch (e) {
      return ('Unexpected error occurred!', null);
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

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}
