class TaskModel {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  late final DateTime dateTime;
  late final int priority;
  final bool isDone;
  final String userId;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.dateTime,
    required this.priority,
    required this.isDone,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'priority': priority,
      'isDone': isDone,
      'userId': userId,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      categoryId: map['categoryId'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      priority: map['priority'],
      isDone: map['isDone'],
      userId: map['userId'],
    );
  }
}
