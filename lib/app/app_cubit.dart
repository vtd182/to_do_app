import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/authentication_repository/authentication_repository.dart';
import '../utils/enums/authentication_status.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthenticationRepository authenticationRepository;
  AppCubit({
    required this.authenticationRepository,
  }) : super(const AppState()) {
    authenticationRepository.status.listen((status) {
      emit(state.copyWith(status: status));
    });
  }
}
