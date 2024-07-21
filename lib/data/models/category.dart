import 'package:flutter/cupertino.dart';
import 'package:flutter_iconpicker/Models/icon_pack.dart';
import 'package:flutter_iconpicker/Serialization/icondata_serialization.dart';

class CategoryModel {
  String id;
  String name;
  IconData? icon;
  int backgroundColor;
  int iconColor;
  String userId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': serializeIcon(icon!, iconPack: IconPack.allMaterial),
      'backgroundColor': backgroundColor,
      'iconColor': iconColor,
      'userId': userId,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      icon: deserializeIcon(Map<String, dynamic>.from(map['icon']),
          iconPack: IconPack.allMaterial),
      backgroundColor: map['backgroundColor'],
      iconColor: map['iconColor'],
      userId: map['userId'],
    );
  }
}
