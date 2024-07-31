import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/utils/enums/authentication_status.dart';

import '../data_source/firebase_auth_service.dart';
import 'entities/user_entity.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;
  Stream<UserEntity> get user;

  Future<void> loginByEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> registerByEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuthService firebaseAuthService;

  final _statusController = StreamController<AuthenticationStatus>();
  final _userController = StreamController<UserEntity>();

  AuthenticationRepositoryImpl({
    required this.firebaseAuthService,
  }) {
    firebaseAuthService.user.listen((firebaseUser) {
      final isAuthenticated = firebaseUser != null;
      final user = isAuthenticated ? firebaseUser.toUserEntity : UserEntity.empty;
      _userController.sink.add(user);
      if (isAuthenticated) {
        _statusController.sink.add(AuthenticationStatus.authenticated);
      } else {
        // unknowe
        _statusController.sink.add(AuthenticationStatus.unauthenticated);
      }
    });
  }

  @override
  Future<void> loginByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuthService.loginByEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> registerByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuthService.registerByEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  // TODO: implement status
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _statusController.stream;
  }

  @override
  // TODO: implement user
  Stream<UserEntity> get user async* {
    yield* _userController.stream;
  }
}

extension UserFirebaseAuth on User {
  UserEntity get toUserEntity {
    return UserEntity(
      id: uid,
      name: displayName ?? '',
      email: email ?? '',
      phone: phoneNumber ?? '',
      imageUrl: photoURL ?? '',
    );
  }
}
