import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/controllers/topic_controller.dart';
import '../controllers/selectIconController.dart';
import '../widgets/selectableIcon.dart';

class AddTopic extends StatefulWidget {
  const AddTopic({super.key});

  @override
  State<AddTopic> createState() => _AddTopicState();
}

class _AddTopicState extends State<AddTopic> {
  final TextEditingController _labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TopicController topicController = Get.put(TopicController());
    IconController iconController = Get.put(IconController());
    return Container(
      color: Colors.pink,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _labelController,
            decoration: const InputDecoration(
                labelText: "Название темы:",
                hintText: "Домашняя работа, Шоппинг..."
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Выберите иконку:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: iconController.icons.length,
                itemBuilder: (context, index) {
                  IconData icon = iconController.icons[index];
                  bool isSelected = icon == iconController.selectedIcon.value;
                  return SelectableIcon(
                    icon: icon,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        iconController.selectIcon(icon);
                      });
                    },
                  );
                },
              );
            }),
          ),
          GestureDetector(
            onTap: () {
              String label = _labelController.text;
              IconData? selectedIcon = iconController.selectedIcon.value;
              if (selectedIcon != null && label.isNotEmpty) {
                setState(() {
                  topicController.addTopic(
                    Icon(selectedIcon),
                    label,
                      (){},
                  );
                  Navigator.pop(context);
                });
              } else {
              }
            },
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Добавить тему",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}