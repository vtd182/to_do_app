part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final List<TaskModel> tasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> incompleteTasks;
  final List<CategoryModel> categories;
  final List<TaskModel> completedTasksByDate;
  final List<TaskModel> incompleteTasksByDate;

  const HomePageState({
    this.tasks = const [],
    this.completedTasks = const [],
    this.incompleteTasks = const [],
    this.categories = const [],
    this.completedTasksByDate = const [],
    this.incompleteTasksByDate = const [],
  });

  HomePageState copyWith({
    List<TaskModel>? tasks,
    List<TaskModel>? completedTasks,
    List<TaskModel>? incompleteTasks,
    List<CategoryModel>? categories,
    List<TaskModel>? completedTasksByDate,
    List<TaskModel>? incompleteTasksByDate,
  }) {
    return HomePageState(
      tasks: tasks ?? this.tasks,
      completedTasks: completedTasks ?? this.completedTasks,
      incompleteTasks: incompleteTasks ?? this.incompleteTasks,
      categories: categories ?? this.categories,
      completedTasksByDate: completedTasksByDate ?? this.completedTasksByDate,
      incompleteTasksByDate:
          incompleteTasksByDate ?? this.incompleteTasksByDate,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        completedTasks,
        incompleteTasks,
        categories,
        completedTasksByDate,
        incompleteTasksByDate,
      ];
}
