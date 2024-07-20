import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/models/data.model.dart';
import 'package:to_do_getx/widgets/topic.dart';

class TopicController extends GetxController {
  RxList<TopicView> _topics = <TopicView>[
    TopicView(label: "Домашние дела", icon: Icon(Icons.home), onPressed: () {}),
    TopicView(label: "Работа", icon: Icon(Icons.work), onPressed: () {}),
    TopicView(label: "Добавить тему", icon: Icon(Icons.add), onPressed: () {}),
  ].obs;

  List<TopicView> get topics => _topics;

  Data data = Data();

  @override
  void onInit() {
    super.onInit();
    loadTopics();
  }

  void loadTopics() async {
    List<TopicView> loadedTopics = await data.loadTopic();
    if (loadedTopics.isNotEmpty) {
      _topics.assignAll(loadedTopics);
    }
  }

  void addTopic(Icon icon, String label, void Function()? onPressed) {
    _topics.insert(0, TopicView(icon: icon, label: label, onPressed: onPressed));
    data.updateTopics(_topics);
  }
}
