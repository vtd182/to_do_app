import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../data/models/category.dart';
import 'my_firebase_options.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: MyFirebaseOptions.databaseUrl,
  ).ref();

  Future<void> addObject(String path, Map<String, dynamic> data) async {
    await _database.child(path).push().set(data);
  }

  Future<List<Map<String, dynamic>>> getAllObjects(String path) async {
    DataSnapshot snapshot = (await _database.child(path).once()).snapshot;
    Map<String, dynamic>? data = snapshot.value as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries.map((e) => Map<String, dynamic>.from(e.value)).toList();
  }

  Future<void> updateObject(
      String path, String id, Map<String, dynamic> data) async {
    await _database.child('$path/$id').update(data);
  }

  Future<void> deleteObject(String path, String id) async {
    await _database.child('$path/$id').remove();
  }

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
    DataSnapshot snapshot =
        (await _database.child('categories').once()).snapshot;
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
            },
          ),
        );
      },
    );
    return categories;
  }
}
