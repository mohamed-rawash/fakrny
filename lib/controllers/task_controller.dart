import 'package:fakrny/models/task.dart';
import 'package:get/get.dart';

import '../database/db_helper.dart';

class TaskController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    return DBHelper.insert(task);
  }

  getTasks() async{
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson( data)).toList());
  }

  deleteTasks(Task task) async{
    await DBHelper.delete(task);
    getTasks();
  }

  deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  markTaskCompleted(int id) async {
      await DBHelper.update(id);
    getTasks();
  }
}
