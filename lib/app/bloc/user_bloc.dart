import 'package:asm/app/models/auth/user.dart';
import 'package:asm/app/models/errors_model.dart';
import 'package:asm/app/service/auth/user_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserSignedOut()) {
    on<SignIn>((event, emit) async {
      if (state is UserSignedOut || state is UserErrorState) {
        var result = await userModel.loginPost(
          email: event.email,
          password: event.password,
        );

        if (result.status) {
          if (result.errors!.isNotEmpty) {
            emit(
              UserErrorState(
                  errorMessage: result.message, errors: result.errors),
            );
          } else {
            emit(
              UserErrorState(errorMessage: result.message),
            );
          }
        } else {
          String? token = result.data.token;

          if (token!.isNotEmpty) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('email', event.email);
            pref.setString('token', token);
            emit(UserSignedIn(result.data));
          }
        }
      }
    });

    on<SignOut>((event, emit) async {
      if (state is UserSignedIn) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('email');
        pref.remove('token');

        emit(UserSignedOut());
      }
    });

    on<CheckSignInStatus>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = pref.getString('email');
      String? token = pref.getString('token');

      if (email != null && token != null) {
        bool tokenValid = UserService.isTokenValid(token);

        if (tokenValid) {
          userModel? user = UserService.getUser(email: email, token: token);
          if (user != null) {
            emit(UserSignedIn(user));
          }
        }
      } else {
        emit(UserSignedOut());
      }
    });
  }
}
