import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  UserEntity({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
  });

  static UserEntity empty = UserEntity(id: '');

  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email, phone: $phone, imageUrl: $imageUrl)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, phone, imageUrl];
}
