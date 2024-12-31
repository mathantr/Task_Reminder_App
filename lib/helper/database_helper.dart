import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/task.dart';

class DatabaseHelper {
  static final _databaseName = "TaskDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'task_table';

  static final columnId = '_id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnReminderTime = 'reminderTime';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnReminderTime TEXT NOT NULL
      )
      ''');
  }

  Future<int> insert(Task task) async {
    Database? db = await instance.database;
    return await db!.insert(table, task.toMap());
  }

  Future<List<Task>> queryAllTasks() async {
    Database? db = await instance.database;
    final tasks = await db!.query(table);
    return tasks.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> delete(String title) async {
    Database? db = await instance.database;
    return await db!
        .delete(table, where: '$columnTitle = ?', whereArgs: [title]);
  }

  Future<int> update(Task task) async {
    Database? db = await instance.database;
    return await db!.update(table, task.toMap(),
        where: '$columnId = ?', whereArgs: [task.title]);
  }
}
