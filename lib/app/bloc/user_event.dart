part of 'user_bloc.dart';

abstract class UserEvent {}

class SignIn extends UserEvent {
  final String email;
  final String password;

  SignIn({required this.email, required this.password});
}

class SignOut extends UserEvent {}

class CheckSignInStatus extends UserEvent {}
