part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserSignedOut extends UserState {}

class UserSignedIn extends UserState {
  final User user;

  const UserSignedIn(this.user);

  @override
  List<Object> get props => [user];
}
