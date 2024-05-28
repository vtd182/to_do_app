part of 'app_cubit.dart';

class AppState extends Equatable {
  final AuthenticationStatus status;

  const AppState({this.status = AuthenticationStatus.unauthenticated});

  AppState copyWith({
    final AuthenticationStatus? status,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
      ];
}
