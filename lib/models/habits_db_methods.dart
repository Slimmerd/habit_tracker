
import 'package:habit_tracker/models/app_db.dart';

import 'habit_model.dart';

class HabitsDBMethods {
  Future getAll() async {
    final db = await AppDatabase.instance.database;

    final habitsInfo = await db.query(tableHabits);
    final habitsDates = await db.query(tableHabitDates);
    List<Habit>? habits = [];

    habitsInfo.forEach((result) {
      List<Object?> data = habitsDates.where((element) =>
      element['habitID'] == result['_id'])
          .map((e) => e['date']).toList();

      Habit habit = Habit.fromJson(result);
      habit.dayList = data;
      print('GetAll $data');
      habits.add(habit);

    });
// ORDER BY ${HabitFields.createdTime} DESC
    return habits;
  }

  Future create(Habit habit) async {
    final db = await AppDatabase.instance.database;
    final id = await db.insert(tableHabits, habit.toJson());

    return habit.copy(id: id);
  }

  Future update(Habit habit) async {
    final db = await AppDatabase.instance.database;
    final newResult = await db.update(tableHabits, habit.toJson(),
        where: "_id = ?", whereArgs: [habit.id]);

    return newResult;
  }

  Future dayComplete(Habit habit, DateTime date) async {
    final db = await AppDatabase.instance.database;
    final String dateString = date.toString().substring(0, 10);
    var newResult = await db.delete(tableHabitDates,
        where: "habitID = ? and date = ?", whereArgs: [habit.id, dateString]);

    print(dateString);
    print(newResult);

    if (newResult == 0) {
      newResult = await db.insert(
        tableHabitDates,
        {'habitID': habit.id, 'date': dateString},
      );
      return true;
    } else
      return false;
  }

  Future delete(int id) async {
    final db = await AppDatabase.instance.database;

    db.delete(tableHabits, where: "_id = ?", whereArgs: [id]);

    return true;
  }

  Future deleteAll() async {
    final db = await AppDatabase.instance.database;

    db.rawDelete('''
    DELETE FROM $tableHabits
    ''');

  }

  Future resetProgress(int id) async {
    final db = await AppDatabase.instance.database;

    db.rawDelete('''
    DELETE FROM $tableHabitDates WHERE habitID = $id
    ''');
  }


}