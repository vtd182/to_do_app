import 'package:realm/realm.dart';

part 'category_realm_entity.realm.dart';

@RealmModel()
class $_CategoryRealmEntity {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late int? iconCodePoint;
  late String? backgroundColorHex; // Color hex
  late String? iconColorHex; // Color hex
}
