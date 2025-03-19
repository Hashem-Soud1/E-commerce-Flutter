import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/services/firebase_auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _authServices = AuthServicesImpl();

  Future<void> loginWithEmailandPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.loginWithEmailandPassword(
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
  ) async {
    emit(AuthLoading());
    try {
      final result = await _authServices.signUpWithEmailandPassword(
        email,
        password,
      );
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Sign up failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void checkAuth() {
    final user = _authServices.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess());
    }
  }

  Future<void> SignOut() async {
    emit(AuthSignigOut());
    try {
      await _authServices.signOut();
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthSignOutFailure(e.toString()));
    }
  }
}
