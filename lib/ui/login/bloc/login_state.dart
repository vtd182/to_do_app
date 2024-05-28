part of 'login_cubit.dart';

class LoginState extends Equatable {
  String title;
  LoginState(this.title);

  @override
  List<Object> get props => [
        title,
      ];
}
