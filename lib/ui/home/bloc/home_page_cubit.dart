import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/category.dart';
import '../../../data/models/task.dart';
import '../../../domain/data_source/firebase_service.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final FirebaseService firebaseService;

  HomePageCubit({required this.firebaseService})
      : super(const HomePageState()) {
    _initialize();
  }

  void _initialize() async {
    final tasks = await firebaseService.getTasks();
    final categories = await firebaseService.getCategories();
    final completedTasks = tasks.where((task) => task.isDone).toList();
    final incompleteTasks = tasks.where((task) => !task.isDone).toList();
    emit(state.copyWith(
      tasks: tasks,
      completedTasks: completedTasks,
      incompleteTasks: incompleteTasks,
      categories: categories,
    ));
  }

  void fetchTasks() async {
    final tasks = await firebaseService.getTasks();
    final categories = await firebaseService.getCategories();
    final completedTasks = tasks.where((task) => task.isDone).toList();
    final incompleteTasks = tasks.where((task) => !task.isDone).toList();
    emit(state.copyWith(
      tasks: tasks,
      completedTasks: completedTasks,
      incompleteTasks: incompleteTasks,
      categories: categories,
    ));
  }

  void addTask(TaskModel task) async {
    await firebaseService.addTask(task);
    _initialize();
  }

  void updateTask(TaskModel task) async {
    await firebaseService.updateTask(task);
    _initialize();
  }

  void deleteTask(String taskId) async {
    await firebaseService.deleteTask(taskId);
    _initialize();
  }

  void addCategory(CategoryModel category) async {
    await firebaseService.addCategory(category);
    _initialize();
  }

  void updateCategory(CategoryModel category) async {
    await firebaseService.updateCategory(category);
    _initialize();
  }

  void deleteCategory(String categoryId) async {
    await firebaseService.deleteCategory(categoryId);
    _initialize();
  }

  CategoryModel? findCategory(String categoryId) {
    CategoryModel? categoryModel;
    for (var category in state.categories) {
      if (category.id == categoryId) {
        categoryModel = category;
        break;
      }
    }
    return categoryModel;
  }
}
