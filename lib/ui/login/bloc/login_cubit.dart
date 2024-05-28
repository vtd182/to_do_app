import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/authentication_repository/authentication_repository.dart';

part 'login_state.dart';

// admin1@admin.com
// admin123
class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository}) : super(LoginState(""));

  void login(String email, String password) {
    try {
      authenticationRepository.loginByEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }
}
