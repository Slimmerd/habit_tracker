import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/models/todo_category_model.dart';
import 'package:habit_tracker/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('habits.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textTypeNT = 'TEXT NOT NULL';
    final textType = 'TEXT';
    final integerType = 'INTEGER NOT NULL';
    // final boolType = 'BOOLEAN NOT NULL';

    // Habits
    await db.execute('''
     CREATE TABLE $tableHabits (
     ${HabitFields.id} $idType,
     ${HabitFields.title} $textTypeNT,
     ${HabitFields.createdTime} $textTypeNT
     )
     ''');

    await db.execute('''CREATE TABLE $tableHabitDates (
            id $idType,
            habitID $integerType,
            date $textTypeNT,
            FOREIGN KEY (habitID)
            REFERENCES $tableHabitDates (id)
            ON DELETE CASCADE
            )''');

    // Todos
    await db.execute('''
    CREATE TABLE $tableTodoCategory (
    ${TodoCategoryFields.id} $idType,
    ${TodoCategoryFields.name} $textTypeNT,
    ${TodoCategoryFields.color} $integerType,
    ${TodoCategoryFields.icon} $integerType,
    ${TodoCategoryFields.isArchived} $integerType,
    ${TodoCategoryFields.createdTime} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableTodos(
    ${TodoFields.id} $idType,
    ${TodoFields.categoryID} $integerType,
    ${TodoFields.name} $textTypeNT,
    ${TodoFields.notes} $textType,
    ${TodoFields.createdTime} $textTypeNT,
    ${TodoFields.due} $textType,
    ${TodoFields.isCompleted} $integerType,
    FOREIGN KEY (categoryID)
    REFERENCES $tableTodoCategory (id)
    ON DELETE CASCADE
    )
    ''');
  }

  Future close() async {
    final db = await AppDatabase.instance.database;

    db.close();
  }
}
