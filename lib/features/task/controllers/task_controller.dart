import 'package:get/get.dart';
import 'package:task_management/data/db/db_helper.dart';
import 'package:task_management/data/models/task_model.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? task}) async {
    return await DbHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    print("Task query $tasks");
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel task) async {
    await DbHelper.delete(task);
    getTasks();
  }

  void makeTaskCompleted(int id) async {
    await DbHelper.update(id);
    getTasks();
  }
}
