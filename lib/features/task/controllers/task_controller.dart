import 'package:get/get.dart';
import 'package:task_management/data/db/db_helper.dart';
import 'package:task_management/data/models/task_model.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<int> addTask({TaskModel? task}) async {
    return await DbHelper.insert(task);
  }
}
