import 'package:habit_tracker/models/todo_model.dart';

final String tableTodoCategory = 'TodoCategories';

class TodoCategoryFields {
  static final String id = 'id';
  static final String name = 'name';
  static final String createdTime = 'createdTime';
  static final String todoList = 'todoList';
  static final String icon = 'icon';
  static final String color = 'color';
  static final String isArchived = 'isArchived';
}

class TodoCategory {
  final int? id;
  final String name;
  final int color;
  final String icon;
  final int? isArchived;
  final int? notificationId;
  late List<Todo>? todoList;
  final DateTime createdTime;

  TodoCategory(
      {this.id,
      required this.name,
      required this.color,
      required this.icon,
      this.isArchived = 0,
      this.notificationId,
      required this.createdTime,
      this.todoList
      });

  Map<String, Object?> toJson() => {
        TodoCategoryFields.id: id,
        TodoCategoryFields.name: name,
        TodoCategoryFields.icon: icon,
        TodoCategoryFields.color: color,
        TodoCategoryFields.isArchived: isArchived,
        TodoCategoryFields.createdTime:
            createdTime.toIso8601String().substring(0, 10)
      };

  TodoCategory copy({
    int? id,
    String? name,
    String? icon,
    int? color,
    int? notificationId,
    List<Todo>? todoList,
    DateTime? createdTime,
  }) =>
      TodoCategory(
          id: id ?? this.id,
          name: name ?? this.name,
          notificationId: notificationId ?? this.notificationId,
          todoList: todoList ?? this.todoList,
          createdTime: createdTime ?? this.createdTime,
          icon: icon ?? this.icon,
          color: color ?? this.color);

  static TodoCategory fromJson(Map<String, Object?> json) => TodoCategory(
        id: json[TodoCategoryFields.id] as int?,
        name: json[TodoCategoryFields.name] as String,
        todoList: json[TodoCategoryFields.todoList] as List<Todo>?,
        createdTime:
            DateTime.parse(json[TodoCategoryFields.createdTime] as String),
        icon: json[TodoCategoryFields.icon] as String,
        color: json[TodoCategoryFields.color] as int,
      );
}
