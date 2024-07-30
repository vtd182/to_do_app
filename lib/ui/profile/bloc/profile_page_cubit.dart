import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/data_source/firebase_user_service.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final FirebaseUserService firebaseUserService;

  ProfilePageCubit({required this.firebaseUserService})
      : super(ProfilePageState()) {
    print("ProfilePageCubit");
    _initialize();
  }

  void _initialize() async {
    final displayName = await firebaseUserService.getDisplayName();
    final email = await firebaseUserService.getEmail();
    final photoUrl = await firebaseUserService.getPhotoUrl();
    emit(state.copyWith(
        displayName: displayName, email: email, photoUrl: photoUrl));
  }

  void updateDisplayName(String displayName) async {
    emit(ProfileLoading());
    try {
      await firebaseUserService.updateDisplayName(displayName);
      _initialize();
    } catch (e) {
      emit(ProfileUpdateDisplayNameFailure(e.toString()));
    }
  }

  void updateEmail(String email) async {
    emit(ProfileLoading());
    try {
      await firebaseUserService.updateEmail(email);
      _initialize();
    } catch (e) {
      emit(ProfileUpdateEmailFailure(e.toString()));
    }
  }

  void updatePhotoUrl(String photoUrl) async {
    emit(ProfileLoading());
    try {
      await firebaseUserService.updatePhotoUrl(photoUrl);
      _initialize();
    } catch (e) {
      emit(ProfileUpdatePhotoUrlFailure(e.toString()));
    }
  }
}
