import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_getx/controllers/topic_controller.dart';
import 'package:to_do_getx/widgets/topic.dart';

class Data {
  Data() {
    Hive.initFlutter();
  }


  Future<List<TopicView>> loadTopic() async {
    var box = await Hive.openBox('to_do_getx');
    TopicController topicController = Get.put(TopicController());
    List<dynamic> list = box.get("topics") ?? [];
    return list.cast<TopicView>();
  }

  void updateTopics(List<TopicView> topics) async {
    var box = await Hive.openBox<dynamic>('to_do_getx');
    box.put("topics", topics);
    print(box.values);
  }
}

class TopicViewAdapter extends TypeAdapter<TopicView> {
  @override
  final int typeId = 0;

  @override
  TopicView read(BinaryReader reader) {
    final label = reader.readString();
    final codePoint = reader.readInt();
    final fontFamily = reader.readString();
    final icon = Icon(IconData(codePoint, fontFamily: fontFamily));
    return TopicView(label: label, icon: icon, onPressed: () {});
  }

  @override
  void write(BinaryWriter writer, TopicView obj) {
    writer.writeString(obj.label);
    writer.writeInt(obj.icon.icon!.codePoint); // Сохранение codePoint
    writer.writeString(obj.icon.icon!.fontFamily!); // Сохранение fontFamily
  }
}
