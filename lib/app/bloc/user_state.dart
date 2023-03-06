part of 'user_bloc.dart';

abstract class UserState {}

class UserSignedOut extends UserState {}

class UserSignedIn extends UserState {
  final User user;

  UserSignedIn(this.user);
}
