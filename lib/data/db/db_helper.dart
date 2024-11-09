import 'package:sqflite/sqflite.dart';
import 'package:task_management/data/models/task_model.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("creating a new one");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title String,"
          "note TEXT,"
          "date String,"
          "startTime String,"
          "endTime String,"
          "remind INTEGER,"
          "repeat String,"
          "color INTEGER,"
          "isCompleted INTEGER)",
        );
      });
    } catch (e) {
      print("Database Error is $e");
    }
  }

  static Future<int> insert(TaskModel? task) async {
    return await _db!.insert(_tableName, task!.toJson());
  }
}
