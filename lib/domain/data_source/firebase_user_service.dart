import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Get current user
  User? get currentUser => _auth.currentUser;

  // update display name
  Future<void> updateDisplayName(String displayName) async {
    try {
      await _auth.currentUser!.updateDisplayName(displayName);
    } catch (e) {
      rethrow;
    }
  }

  // update photo url
  Future<void> updatePhotoUrl(String photoUrl) async {
    try {
      await _auth.currentUser!.updatePhotoURL(photoUrl);
    } catch (e) {
      rethrow;
    }
  }

  // update email
  Future<void> updateEmail(String email) async {
    try {
      await _auth.currentUser!.updateEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  // update password
  Future<void> updatePassword(String password) async {
    try {
      await _auth.currentUser!.updatePassword(password);
    } catch (e) {
      rethrow;
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // get email
  Future<String> getEmail() async {
    return _auth.currentUser!.email!;
  }

  // get photo url
  Future<String> getPhotoUrl() async {
    try {
      return _auth.currentUser!.photoURL!;
    } catch (e) {
      return "";
    }
  }

  // get display name
  Future<String> getDisplayName() async {
    try {
      return _auth.currentUser!.displayName!;
    } catch (e) {
      return "";
    }
  }
}
