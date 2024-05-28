part of 'register_cubit.dart';

class RegisterState extends Equatable {
  String title;
  RegisterState(this.title);

  @override
  List<Object> get props => [
        title,
      ];
}
