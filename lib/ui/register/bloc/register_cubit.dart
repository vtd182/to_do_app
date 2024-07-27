import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/authentication_repository/authentication_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterCubit({required this.authenticationRepository})
      : super(RegisterInitial());

  Future<void> register(String email, String password) async {
    emit(RegisterLoading());
    try {
      await authenticationRepository.registerByEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
