import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> signInWithEmailandPassword(String email, String password);
  Future<bool> signUpWithEmailandPassword(String email, String password);
  Future<bool> signInWtihGoogle();
  User? getCurrentUser();
  Future<void> signOut();
}

class AuthServicesImpl extends AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signInWithEmailandPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signUpWithEmailandPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> signInWtihGoogle() async {
    final gUser = await GoogleSignIn().signIn();
    final gAuth = await gUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
