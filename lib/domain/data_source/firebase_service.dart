import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:to_do_app/data/models/task.dart';

import '../../data/models/category.dart';
import 'my_firebase_options.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: MyFirebaseOptions.databaseUrl,
  ).ref();

  // add category with id
  Future<void> addCategory(CategoryModel category) async {
    await _database.child('categories/${category.id}').set(category.toMap());
  }

  // get category by id
  Future<CategoryModel?> getCategoryById(String id) async {
    DataSnapshot snapshot =
        (await _database.child('categories/$id').once()).snapshot;
    if (snapshot.value == null) return null;

    // Explicitly converting the data to Map<String, dynamic>
    final data = Map<String, dynamic>.from(snapshot.value as Map);

    return CategoryModel.fromMap(data);
  }

  // update category
  Future<void> updateCategory(CategoryModel category) async {
    await _database.child('categories/${category.id}').update(category.toMap());
  }

  Future<List<CategoryModel>> getCategories() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Query query =
        _database.child('categories').orderByChild('userId').equalTo(userId);
    DataSnapshot snapshot = (await query.once()).snapshot;
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    List<CategoryModel> categories = [];
    data.forEach(
      (key, value) {
        Map<String, dynamic> categoryData = Map<String, dynamic>.from(value);
        categories.add(
          CategoryModel.fromMap(
            {
              'id': key,
              'name': categoryData['name'],
              'icon': categoryData[
                  'icon'], // Assuming 'icon' is already serialized correctly
              'backgroundColor': categoryData['backgroundColor'],
              'iconColor': categoryData['iconColor'],
              'userId': categoryData['userId'],
            },
          ),
        );
      },
    );
    return categories;
  }

  // add task with id
  Future<void> addTask(TaskModel task) async {
    await _database.child('tasks/${task.id}').set(task.toMap());
  }

  // update task
  Future<void> updateTask(TaskModel task) async {
    await _database.child('tasks/${task.id}').update(task.toMap());
  }

  // get task by id
  Future<TaskModel?> getTaskById(String id) async {
    DataSnapshot snapshot =
        (await _database.child('tasks/$id').once()).snapshot;
    if (snapshot.value == null) return null;
    // Explicitly converting the data to Map<String, dynamic>
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return TaskModel.fromMap(data);
  }

  // delete task
  Future<void> deleteTask(String id) async {
    await _database.child('tasks/$id').remove();
  }

  // get tasks of userid
  Future<List<TaskModel>> getTasks() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Query query =
        _database.child('tasks').orderByChild('userId').equalTo(userId);
    DataSnapshot snapshot = (await query.once()).snapshot;
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    List<TaskModel> tasks = [];
    data.forEach(
      (key, value) {
        Map<String, dynamic> taskData = Map<String, dynamic>.from(value);
        tasks.add(
          TaskModel.fromMap(
            {
              'id': key,
              'name': taskData['name'],
              'description': taskData['description'],
              'categoryId': taskData['categoryId'],
              'dateTime': taskData['dateTime'],
              'priority': taskData['priority'],
              'isDone': taskData['isDone'],
              'userId': taskData['userId'],
            },
          ),
        );
      },
    );
    return tasks;
  }

  // delete task
  Future<void> deleteCategory(String id) async {
    await _database.child('categories/$id').remove();
  }
}
