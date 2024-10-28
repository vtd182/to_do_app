import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/category.dart';
import '../../../data/models/task.dart';
import '../../../domain/data_source/firebase_service.dart';
import '../../../domain/data_source/notification_service.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final FirebaseService firebaseService;
  final NotificationService notificationService;

  HomePageCubit({
    required this.firebaseService,
    required this.notificationService,
  }) : super(const HomePageState()) {
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

    checkPendingNotifications();
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
    _scheduleNotificationForTask(task); // Schedule notification only for new task
    fetchTasks(); // Update tasks list without scheduling again
  }

  void updateTask(TaskModel task) async {
    await firebaseService.updateTask(task);
    _cancelNotificationForTask(task); // Cancel previous notification if it exists
    _scheduleNotificationForTask(task); // Schedule notification for updated task
    fetchTasks(); // Update tasks list without scheduling again
  }

  void deleteTask(String taskId) async {
    await firebaseService.deleteTask(taskId);
    notificationService.cancelNotification(taskId.hashCode); // Cancel notification for deleted task
    fetchTasks(); // Update tasks list without scheduling again
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

  // Clear data when signing out
  void clear() async {
    await firebaseService.clearAllData();
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

  void onQueryTasksByDate(DateTime dateTime) async {
    final completedTasks = await firebaseService.getCompletedTasksByDate(dateTime);
    final incompleteTasks = await firebaseService.getUncompletedTasksByDate(dateTime);
    emit(
      state.copyWith(completedTasksByDate: completedTasks, incompleteTasksByDate: incompleteTasks),
    );
  }

  // Schedule a notification for a task 10 minutes before its due time
  void _scheduleNotificationForTask(TaskModel task) {
    final now = DateTime.now();
    final taskTime = task.dateTime!;
    final notificationTime = taskTime.subtract(const Duration(minutes: 10));

    if (notificationTime.isAfter(now)) {
      notificationService.scheduleNotification(
        task.id.hashCode, // Unique ID for notification
        'Task Reminder',
        'You have a task "${task.name}" due in 10 minutes.',
        notificationTime,
      );
    }
  }

  // Cancel notification for a specific task
  void _cancelNotificationForTask(TaskModel task) {
    notificationService.cancelNotification(task.id.hashCode);
  }

  void checkPendingNotifications() async {
    final pendingNotifications = await notificationService.getAllPendingNotification();

    for (var pendingNotification in pendingNotifications) {
      print('Pending notification: ${pendingNotification.id}, ${pendingNotification.title}, ${pendingNotification.body}');
    }
  }
}
