import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/models/habits_db_methods.dart';

class HabitProvider extends ChangeNotifier{
  final List<Habit> _habits = [];
  final HabitsDBMethods db;
  late Future dbGet;


  HabitProvider() : db = HabitsDBMethods() {
    dbGet = db.getAll().then((value) {
      _habits.addAll(value);
      notifyListeners();
    });
  }

  List<Habit> get habits => _habits;

  Future<void> add(Habit habit) async {
    await db.create(habit).then((value) {
      _habits.add(value);
      notifyListeners();
    });
  }

  Future<void> update(Habit habit) async {
    await db.update(habit).then((value){
      var habitIndex = _habits.indexWhere((element) => element.id == habit.id);
      _habits[habitIndex] = habit;
      notifyListeners();
    });
  }

  Future<void> delete(Habit habit) async{
    await db.delete(habit.id!).then((value) {
      _habits.removeWhere((element) => element == habit);
      notifyListeners();
    });
  }
  
  Future<void> deleteAll() async{
    await db.deleteAll().then((value) {
        _habits.clear();
        notifyListeners();
    });
  }

  Future<void> resetProgress(Habit habit) async{
    await db.resetProgress(habit.id!).then((value){
      var habitIndex = _habits.indexWhere((element) => element.id == habit.id);
      _habits[habitIndex].dayList!.clear();
      notifyListeners();
    });
  }

  Future<void> dayCompleted (Habit habit, DateTime date) async {
    final String dateString = date.toString().substring(0, 10);
    final int index = habit.dayList!.indexOf(dateString);

    db.dayComplete(habit, date).then((value){

      if (index == -1) {
        habit.dayList!.add(dateString);
        return true;
      } else {
        habit.dayList!.remove(dateString);
        return false;
      }

    }).whenComplete(() => notifyListeners());
  }

}