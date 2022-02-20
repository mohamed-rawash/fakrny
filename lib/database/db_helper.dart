import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static int _version = 1;
  static String _tableName = "tasks";

  static init() async {
    if (_db != null) {
      debugPrint('Database is already created');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'my_database.db';
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
              'CREATE TABLE $_tableName('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title STRING, note TEXT, date STRING, '
              'startTime STRING, endTime STRING, '
              'remind INTEGER, repeat STRING, '
              'color INTEGER, '
              'isCompleted INTEGER)',
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    return await _db!.insert(_tableName, task!.toJson());
  }

  static Future<int> delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteAll() async {
    return await _db!.delete(_tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    return await _db!.rawUpdate("""
  UPDATE tasks
  SET isCompleted = ?
  WHERE id = ?""", [1, id]);
  }
}
