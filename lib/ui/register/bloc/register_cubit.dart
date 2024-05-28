import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/authentication_repository/authentication_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterCubit({required this.authenticationRepository})
      : super(RegisterState(""));

  void register(String email, String password) {
    try {
      authenticationRepository.registerByEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }
}
