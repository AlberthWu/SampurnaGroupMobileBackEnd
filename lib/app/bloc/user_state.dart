part of 'user_bloc.dart';

abstract class UserState {}

class UserSignedOut extends UserState {}

class UserSignedIn extends UserState {
  final userModel user;

  UserSignedIn(this.user);
}

class UserErrorState extends UserState {
  final String errorMessage;
  final List<errorsModel>? errors;

  UserErrorState({required this.errorMessage, this.errors});
}
