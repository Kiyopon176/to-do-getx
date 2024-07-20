import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/controllers/task_controller.dart';
import 'package:to_do_getx/models/task.model.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key, required this.task, required this.topicName});
  final Task task;
  final String topicName;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> with TickerProviderStateMixin {
  bool isDeleted = false;

  late AnimationController _collapseController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _collapseController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _collapseController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _collapseController.dispose();
    super.dispose();
  }

  void deleteItem() {
    _collapseController.forward().then((_) {
      final TaskController taskController = Get.find();
      taskController.deleteTask(widget.task, widget.topicName);
      setState(() {
        isDeleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    if (isDeleted) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizeTransition(
        sizeFactor: _fadeAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Slidable(
            key: ValueKey(widget.task.content),
            startActionPane: widget.task.isCompleted != true
                ? ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    taskController.toggleTaskCompleted(widget.task, widget.topicName);
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.done,
                  label: 'Complete',
                  borderRadius: BorderRadius.circular(25),
                ),
              ],
            )
                : ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    taskController.toggleTaskCompleted(widget.task, widget.topicName);
                  },
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  icon: Icons.done,
                  label: 'Not yet',
                  borderRadius: BorderRadius.circular(25),
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    deleteItem();
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(25),
                ),
              ],
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: widget.task.isCompleted ? Colors.green.shade300 : Colors.purple.shade300,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      widget.task.content,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
