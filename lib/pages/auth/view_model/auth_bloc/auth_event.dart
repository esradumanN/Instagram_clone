part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({
    required this.username,
    required this.password,
  });
}

class AutoLoginEvent extends AuthEvent {
  final String username;
  final String password;

  AutoLoginEvent({
    required this.username,
    required this.password,
  });
}

class ClearAuthEvent extends AuthEvent {}
