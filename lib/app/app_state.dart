part of 'app_cubit.dart';

class AppState extends Equatable {
  final AuthenticationStatus status;

  const AppState({
    this.status = AuthenticationStatus.unauthenticated,
  });

  AppState copyWith({
    AuthenticationStatus? status,
    List<TaskModel>? tasks,
    List<TaskModel>? completedTasks,
    List<TaskModel>? incompleteTasks,
    List<CategoryModel>? categories,
  }) {
    return AppState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
