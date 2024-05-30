import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'my_firebase_options.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: MyFirebaseOptions.databaseUrl,
  ).ref();

  // Thêm một đối tượng vào Firebase
  Future<void> addObject(String path, Map<String, dynamic> data) async {
    await _database.child(path).push().set(data);
  }

  // Lấy tất cả các đối tượng từ Firebase
  Future<List<Map<String, dynamic>>> getAllObjects(String path) async {
    DataSnapshot snapshot =
        (await _database.child(path).once()) as DataSnapshot;
    Map<String, dynamic>? data = snapshot.value as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries.map((e) => Map<String, dynamic>.from(e.value)).toList();
  }

  // Cập nhật một đối tượng trong Firebase
  Future<void> updateObject(
      String path, String id, Map<String, dynamic> data) async {
    await _database.child('$path/$id').update(data);
  }

  // Xóa một đối tượng khỏi Firebase
  Future<void> deleteObject(String path, String id) async {
    await _database.child('$path/$id').remove();
  }
}
