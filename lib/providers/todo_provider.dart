import 'package:flutter/material.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_db_methods.dart';
import 'package:habit_tracker/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
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

  Future<void> addTodo(Todo todo) async {
    await db.createTodo(todo).then((value) {
      var categoryIndex = _todoCategories
          .indexWhere((element) => element.id == todo.categoryID);
      _todoCategories[categoryIndex].todoList!.add(value);

      notifyListeners();
    });
  }

  Future<void> updateTodoCategory(TodoCategory todoCategory) async {
    await db.updateTodoCategory(todoCategory).then((value) {
      var categoryIndex = _todoCategories
          .indexWhere((element) => element.id == todoCategory.id);
      _todoCategories[categoryIndex] = todoCategory;

      notifyListeners();
    });
  }

  Future<void> updateTodo(Todo todo) async {
    await db.updateTodo(todo).then((value) {
      var categoryIndex = _todoCategories
          .indexWhere((element) => element.id == todo.categoryID);
      _todoCategories[categoryIndex].todoList![_todoCategories[categoryIndex]
          .todoList!
          .indexWhere((element) => element.id == todo.id)] = todo;

      notifyListeners();
    });
  }

  /// Delete categories
  Future<void> deleteTodoCategory(TodoCategory todoCategory) async {
    await db.deleteTodoCategory(todoCategory.id!).then((value) {
      _todoCategories.removeWhere((element) => element == todoCategory);

      notifyListeners();
    });
  }

  Future<void> deleteAllTodoCategories() async {
    await db.deleteAllTodoCategories().then((value) {
      _todoCategories.clear();

      notifyListeners();
    });
  }

  ///Delete todos
  Future<void> deleteTodo(Todo todo) async {
    await db.deleteTodo(todo.id!).then((value) {
      var categoryIndex = _todoCategories
          .indexWhere((element) => element.id == todo.categoryID);
      _todoCategories[categoryIndex].todoList!.remove(todo);

      notifyListeners();
    });
  }

  Future<void> todoCompleted(Todo todo) async {
    final int? index = todo.isCompleted;

    db.dayComplete(todo).then((value) {
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
