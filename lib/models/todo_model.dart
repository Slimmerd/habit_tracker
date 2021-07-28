final String tableTodos = 'Todos';

class TodoFields {
  static final String id = 'id';
  static final String categoryID = 'categoryID';
  static final String name = 'name';
  static final String createdTime = 'createdTime';
  static final String due = 'due';
  static final String isCompleted = 'isCompleted';
  static final String notes = 'notes';
}

class Todo {
  final int? id;
  final int categoryID;
  final String name;
  final DateTime? due;
  final DateTime createdTime;
  late int isCompleted;
  final String? notes;

  Todo(
      {this.id,
      required this.createdTime,
      required this.categoryID,
      required this.name,
      this.due,
      this.isCompleted = 0,
      this.notes
      });

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.name: name,
        TodoFields.categoryID: categoryID,
        TodoFields.isCompleted: isCompleted,
        TodoFields.due: due?.toIso8601String(),
        TodoFields.notes: notes != null ? notes : '',
        TodoFields.createdTime: createdTime.toIso8601String().substring(0, 10)
      };

  Todo copy({
    int? id,
    int? categoryID,
    String? name,
    String? notes,
    int? isCompleted,
    // int? notificationId,
    DateTime? due,
    DateTime? createdTime,
  }) =>
      Todo(
          id: id ?? this.id,
          name: name ?? this.name,
          notes: notes ?? this.notes,
          isCompleted: isCompleted ?? this.isCompleted,
          due: due ?? this.due,
          // notificationId: notificationId ?? this.notificationId,
          createdTime: createdTime ?? this.createdTime,
          categoryID: categoryID ?? this.categoryID);

  static Todo fromJson(Map<String, Object?> json) => Todo(
        id: json[TodoFields.id] as int?,
        name: json[TodoFields.name] as String,
        isCompleted: json[TodoFields.isCompleted] as int,
        notes: json[TodoFields.notes] as String?,
        createdTime: DateTime.parse(json[TodoFields.createdTime] as String),
        due: DateTime.tryParse(json[TodoFields.due].toString()), //fix type string to optional
        categoryID: json[TodoFields.categoryID] as int,
      );
}
