final String tableHabits = 'Habits';
final String tableHabitDates = 'HabitDates';

class HabitFields {
  static final String id = '_id';
  static final String title = 'title';
  static final String createdTime = 'createdTime';
  static final String dayList = 'dayList';
}

class Habit {
  final int? id;
  final String title;
  final int? notificationId;
  late List? dayList;
  final DateTime createdTime;

   Habit(
      {this.id,
      required this.title,
      this.notificationId,
      required this.createdTime,
      this.dayList
      });

  Map<String, Object?> toJson() => {
        HabitFields.id: id,
        HabitFields.title: title,
        HabitFields.createdTime: createdTime.toIso8601String().substring(0, 10)
      };

  Habit copy({
    int? id,
    String? title,
    int? notificationId,
    List? dayList,
    DateTime? createdTime,
  }) =>
      Habit(
          id: id ?? this.id,
          title: title ?? this.title,
          notificationId: notificationId ?? this.notificationId,
          dayList: dayList ?? this.dayList,
          createdTime: createdTime ?? this.createdTime);


  static Habit fromJson(Map<String, Object?> json) => Habit(
    id: json[HabitFields.id] as int?,
      title: json[HabitFields.title] as String,
      dayList: json['date'] as List?,
      createdTime: DateTime.parse(json[HabitFields.createdTime] as String),
  );
}
