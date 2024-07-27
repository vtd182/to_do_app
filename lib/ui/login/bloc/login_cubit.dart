import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/authentication_repository/authentication_repository.dart';

part 'login_state.dart';

// admin@admin.com
// admin123
class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubit({required this.authenticationRepository}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await authenticationRepository.loginByEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
