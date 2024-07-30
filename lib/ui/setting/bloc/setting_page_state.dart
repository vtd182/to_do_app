part of 'setting_page_cubit.dart';

class SettingPageState extends Equatable {
  String? displayName;
  String? email;
  String? photoUrl;
  SettingPageState({
    this.displayName,
    this.email,
    this.photoUrl,
  });

  @override
  List<Object> get props => [];

  SettingPageState copyWith(
      {String? displayName, String? email, String? photoUrl}) {
    return SettingPageState(
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl);
  }
}

class SettingLoading extends SettingPageState {}

class SettingUpdateDisplayNameSuccess extends SettingPageState {}

class SettingUpdateDisplayNameFailure extends SettingPageState {
  final String error;
  SettingUpdateDisplayNameFailure(this.error);
}

class SettingUpdateEmailSuccess extends SettingPageState {}

class SettingUpdateEmailFailure extends SettingPageState {
  final String error;
  SettingUpdateEmailFailure(this.error);
}

class SettingUpdatePhotoUrlSuccess extends SettingPageState {}

class SettingUpdatePhotoUrlFailure extends SettingPageState {
  final String error;
  SettingUpdatePhotoUrlFailure(this.error);
}
