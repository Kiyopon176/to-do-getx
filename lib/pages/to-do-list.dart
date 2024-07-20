import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/widgets/task_view.dart';
import 'package:to_do_getx/controllers/task_controller.dart';
import 'package:to_do_getx/models/task.model.dart';

class ToDo_List extends StatefulWidget {
  const ToDo_List({super.key});

  @override
  State<ToDo_List> createState() => _ToDo_ListState();
}

class _ToDo_ListState extends State<ToDo_List> {
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final String topicName = arguments['topicName'] ?? 'default';
    final tasks = arguments['tasks'];
    TaskController taskController = Get.put(TaskController());
    taskController.loadTasks(topicName);

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Добавить задание'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "Напишите задание",
                        hintText: "Сделать домашнюю работу"
                    ),
                    controller: controller,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Подтвердить'),
                onPressed: () {
                  taskController.addTask(Task(controller.text, false), topicName);
                  controller.text = '';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(topicName),
        actions: [
          const Icon(Icons.arrow_left)
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Obx(() => ListView(
          children: [
            ...taskController.tasks.map((task) => TaskView(
              task: task,
              topicName: topicName,
            )),
            GestureDetector(
              onTap: _showMyDialog,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add, size: 25,)),
                    const Text("Добавить задание")
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
