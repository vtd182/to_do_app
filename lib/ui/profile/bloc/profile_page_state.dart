part of 'profile_page_cubit.dart';

class ProfilePageState extends Equatable {
  String? displayName;
  String? email;
  String? photoUrl;
  ProfilePageState({
    this.displayName,
    this.email,
    this.photoUrl,
  });

  @override
  List<Object> get props => [];

  ProfilePageState copyWith(
      {String? displayName, String? email, String? photoUrl}) {
    return ProfilePageState(
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl);
  }
}

class ProfileLoading extends ProfilePageState {}

class ProfileUpdateDisplayNameSuccess extends ProfilePageState {}

class ProfileUpdateDisplayNameFailure extends ProfilePageState {
  final String error;
  ProfileUpdateDisplayNameFailure(this.error);
}

class ProfileUpdateEmailSuccess extends ProfilePageState {}

class ProfileUpdateEmailFailure extends ProfilePageState {
  final String error;
  ProfileUpdateEmailFailure(this.error);
}

class ProfileUpdatePhotoUrlSuccess extends ProfilePageState {}

class ProfileUpdatePhotoUrlFailure extends ProfilePageState {
  final String error;
  ProfileUpdatePhotoUrlFailure(this.error);
}
