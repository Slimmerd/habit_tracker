import 'package:habit_tracker/models/app_db.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';

class TodosDBMethods {
  Future getAll() async {
    final db = await AppDatabase.instance.database;

    final todoCategoriesInfo = await db.query(tableTodoCategory);
    final todos = await db.query(tableTodos);
    List<TodoCategory>? todoCategories = [];

    todoCategoriesInfo.forEach((result) {
      List<Todo>? data = todos
          .where((element) => element['categoryID'] == result['id'])
          .map((e) => Todo.fromJson(e))
          .cast<Todo>()
          .toList();

      TodoCategory todoCategory = TodoCategory.fromJson(result);
      todoCategory.todoList = data;

      print('GetAllTodos $data');
      todoCategories.add(todoCategory);
    });
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

  Future updateTodo(Todo todo) async{
    final db = await AppDatabase.instance.database;
    final id = await db.update(tableTodos, todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);

    return todo.copy(id: id);
  }

  Future dayComplete(Todo todo) async {
    final db = await AppDatabase.instance.database;
    // final String dateString = date.toString().substring(0, 10);
    var newResult =
        await db.query(tableTodos, where: "id = ?", whereArgs: [todo.id]);

    print(newResult);

    if (todo.isCompleted == 0) {
      await db.rawUpdate('''
        UPDATE Todos SET isCompleted = ? WHERE id = ?
        ''', [1, todo.id]);
      return true;
    } else {
      await db.rawUpdate('''
        UPDATE Todos SET isCompleted = ? WHERE id = ?
        ''', [0, todo.id]);
      return false;
    }
  }

  Future deleteTodoCategory(int id) async {
    final db = await AppDatabase.instance.database;

    db.delete(tableTodoCategory, where: "id = ?", whereArgs: [id]);

    return true;
  }

  Future deleteAllTodoCategories() async {
    final db = await AppDatabase.instance.database;

    db.rawDelete('''
    DELETE FROM $tableTodoCategory
    ''');
  }

  Future deleteTodo(int id) async {
    final db = await AppDatabase.instance.database;

    db.delete(tableTodos, where: "id = ?", whereArgs: [id]);

    return true;
  }

// Future deleteTodos() async {
//   final db = await AppDatabase.instance.database;
//
//   db.rawDelete('''
//   DELETE FROM $tableTodoCategory
//   ''');
//
// }

}
