import 'package:habit_tracker/models/app_db.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';

import 'habit_model.dart';

class TodosDBMethods {
  Future getAll() async {
    final db = await AppDatabase.instance.database;

    final todoCategoriesInfo = await db.query(tableTodoCategory);
    final todos = await db.query(tableTodos);
    List<TodoCategory>? todoCategories = [];

    todoCategoriesInfo.forEach((result) {
      List<Todo>? data = todos.where((element) =>
      element['categoryID'] == result['id'])
          .map((e) => Todo.fromJson(e)).cast<Todo>().toList();

      TodoCategory todoCategory = TodoCategory.fromJson(result);
      todoCategory.todoList = data;

      print('GetAllTodos $data');
      todoCategories.add(todoCategory);

    });
// ORDER BY ${HabitFields.createdTime} DESC
    return todoCategories;
  }

  Future createTodoCategory(TodoCategory todoCategory) async {
    final db = await AppDatabase.instance.database;
    final id = await db.insert(tableTodoCategory, todoCategory.toJson());

    return todoCategory.copy(id: id);
  }

  Future createTodo(Todo todo) async {
    final db = await AppDatabase.instance.database;
    final id = await db.insert(tableTodos, todo.toJson());

    return todo.copy(id: id);
  }

  Future update(Habit habit) async {
    final db = await AppDatabase.instance.database;
    final newResult = await db.update(tableHabits, habit.toJson(),
        where: "id = ?", whereArgs: [habit.id]);

    return newResult;
  }

  Future dayComplete(Todo todo) async {
    final db = await AppDatabase.instance.database;
    // final String dateString = date.toString().substring(0, 10);
    var newResult = await db.query(tableTodos,
        where: "id = ?", whereArgs: [todo.id]);

    // print(dateString);
    print(newResult);

    if (todo.isCompleted == 0) {
      await db.rawUpdate(
        '''
        UPDATE Todos SET isCompleted = ? WHERE id = ?
        ''', [1,todo.id]
      );
      return true;
    } else{
      await db.rawUpdate(
          '''
        UPDATE Todos SET isCompleted = ? WHERE id = ?
        ''', [0,todo.id]
      );
      return false;
    }
  }

  Future delete(int id) async {
    final db = await AppDatabase.instance.database;

    db.delete(tableHabits, where: "_id = ?", whereArgs: [id]);

    return true;
  }

  Future deleteAllTodoCategories() async {
    final db = await AppDatabase.instance.database;

    db.rawDelete('''
    DELETE FROM $tableTodoCategory
    ''');

  }



}