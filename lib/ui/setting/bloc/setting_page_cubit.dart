import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/data_source/firebase_user_service.dart';

part 'setting_page_state.dart';

class SettingPageCubit extends Cubit<SettingPageState> {
  final FirebaseUserService firebaseUserService;

  SettingPageCubit({required this.firebaseUserService})
      : super(SettingPageState()) {
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
    emit(SettingLoading());
    try {
      await firebaseUserService.updateDisplayName(displayName);
      emit(state.copyWith(displayName: displayName));
    } catch (e) {
      emit(SettingUpdateDisplayNameFailure(e.toString()));
    }
  }

  void updateEmail(String email) async {
    emit(SettingLoading());
    try {
      await firebaseUserService.updateEmail(email);
      emit(state.copyWith(email: email));
    } catch (e) {
      emit(SettingUpdateEmailFailure(e.toString()));
    }
  }

  void updatePhotoUrl(String photoUrl) async {
    emit(SettingLoading());
    try {
      await firebaseUserService.updatePhotoUrl(photoUrl);
      emit(state.copyWith(photoUrl: photoUrl));
    } catch (e) {
      emit(SettingUpdatePhotoUrlFailure(e.toString()));
    }
  }
}
