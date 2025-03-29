import 'package:ecommerce_app/models/user_data_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _authServices = AuthServicesImpl();
  final _firestoreServices = FirestoreServices.instance;

  Future<void> loginWithEmailandPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.signInWithEmailandPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Login failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> registerWithEmailandPassword(
    String email,
    String password,
    String username,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.signUpWithEmailandPassword(
        email,
        password,
      );
      if (result) {
        await _saveUserData(email, username);
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Sign up failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _saveUserData(String email, String username) async {
    final currentUser = _authServices.getCurrentUser();
    final userData = UserDataModel(
      id: currentUser!.uid,
      email: email,
      username: username,
      createdAt: DateTime.now().toIso8601String(),
    );

    _firestoreServices.setData(
      path: ApiPaths.users(userData.id),
      data: userData.toMap(),
    );
  }

  void checkAuth() {
    final user = _authServices.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess());
    }
  }

  Future<void> signOut() async {
    emit(AuthSignigOut());
    try {
      await _authServices.signOut();
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthSignOutFailure(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthGoogleSignInLoading());
    try {
      final result = await _authServices.signInWtihGoogle();
      if (result) {
        emit(AuthGoogleSignInSuccess());
      } else {
        emit(AuthGoogleSignInFailure('Sign in with google failed'));
      }
    } catch (e) {
      emit(AuthGoogleSignInFailure(e.toString()));
    }
  }
}
