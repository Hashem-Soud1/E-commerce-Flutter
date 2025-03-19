import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailandPassword(String email, String password);
  Future<bool> signUpWithEmailandPassword(String email, String password);
  User? getCurrentUser();
  Future<void> signOut();
}

class AuthServicesImpl extends AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginWithEmailandPassword(String email, String password) async {
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
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
