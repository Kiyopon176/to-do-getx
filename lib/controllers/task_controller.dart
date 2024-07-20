import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:to_do_getx/models/task.model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  Future<void> loadTasks(String topicName) async {
    var box = await Hive.openBox('to_dogetx');
    var list = box.get(topicName);
    if (list != null && list is List) {
      tasks.clear();
      tasks.addAll(list.cast<Task>());
    } else {
      tasks.clear();
    }
  }

  Future<void> addTask(Task task, String topicName) async {
    var box = await Hive.openBox('to_dogetx');
    var list = box.get(topicName);
    List<Task> currentTasks;
    if (list != null && list is List) {
      currentTasks = List<Task>.from(list.cast<Task>());
    } else {
      currentTasks = <Task>[];
    }
    currentTasks.add(task);
    await box.put(topicName, currentTasks);
    tasks.clear();
    tasks.addAll(currentTasks);
  }

  Future<void> deleteTask(Task task, String topicName) async {
    var box = await Hive.openBox('to_dogetx');
    tasks.remove(task);
    await box.put(topicName, tasks);
  }

  Future<void> _saveTasks(String topicName) async {
    var box = await Hive.openBox('to_dogetx');
    await box.put(topicName, tasks.toList());
  }

  void updateTask(Task updatedTask, String topicName) {
    int taskIndex = tasks.indexWhere((task) => task.content == updatedTask.content && task.isCompleted == updatedTask.isCompleted);
    if (taskIndex != -1) {
      tasks[taskIndex] = updatedTask;
      tasks.refresh();
      _saveTasks(topicName);
    }
  }
  Future<void> toggleTaskCompleted(Task task, String topicName) async{
    task.isCompleted = !task.isCompleted;
    updateTask(task, topicName);
    tasks.refresh();
  }
}
class TaskAdapter extends TypeAdapter<Task> {
  @override
  Task read(BinaryReader reader) {
    final content = reader.read();
    final isCompleted = reader.readBool();
    return Task(content, isCompleted);
  }

  @override
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.write(obj.content);
    writer.writeBool(obj.isCompleted);
  }
}
