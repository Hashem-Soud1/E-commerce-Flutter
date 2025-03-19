part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess();
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

final class AuthSignigOut extends AuthState {}

final class AuthSignedOut extends AuthState {
  AuthSignedOut();
}

final class AuthSignOutFailure extends AuthState {
  final String message;

  AuthSignOutFailure(this.message);
}
