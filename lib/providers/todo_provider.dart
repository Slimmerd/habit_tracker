import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/models/todo_db_methods.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  final List<TodoCategory> _todoCategories = [];
  final TodosDBMethods db;
  late Future dbGet;


  TodoProvider() : db = TodosDBMethods() {
    dbGet = db.getAll().then((value) {
      _todoCategories.addAll(value);
      notifyListeners();
    });
  }

  List<TodoCategory> get todoCategories => _todoCategories;

  Future<void> addCategoryTodo(TodoCategory todoCategory) async {
    await db.createTodoCategory(todoCategory).then((value) {
      _todoCategories.add(value);
      notifyListeners();
    });
  }

  Future<void> addTodo(Todo todo, TodoCategory todoCategory) async {
    await db.createTodo(todo).then((value) {
      print(value);
      todoCategory.todoList!.add(value);
      // _todoCategories.where((element) => element.id == todo.categoryID).todoList.add(value);
      notifyListeners();
    });
  }

  Future<void> delete(Habit habit) async{
    await db.delete(habit.id!).then((value) {
      _todoCategories.removeWhere((element) => element == habit);
      notifyListeners();
    });
  }

  Future<void> deleteAllTodoCategories() async{
    await db.deleteAllTodoCategories().then((value) {
      _todoCategories.clear();
      notifyListeners();
    });
  }

  Future<void> todoCompleted (Todo todo) async {
    // final String dateString = date.toString().substring(0, 10);
    final int? index = todo.isCompleted;

    db.dayComplete(todo).then((value){

      if (index == 0) {
        todo.isCompleted = 1;
        return true;
      } else {
        todo.isCompleted = 0;
        return false;
      }

    }).whenComplete(() => notifyListeners());
  }

}