
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/controllers/task_controller.dart';
import 'package:to_do_getx/controllers/topic_controller.dart';
import 'package:to_do_getx/models/data.model.dart';
import 'package:to_do_getx/models/quote.model.dart';
import 'package:to_do_getx/quote_service.dart';
import 'package:to_do_getx/widgets/topic.dart';

import '../widgets/custom_pop_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showCustomDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AddTopic();
        });
  }
  TopicController topicController = Get.put(TopicController());
  void goTo(String topicName){
    Navigator.pushNamed(context, '/To-doList', arguments: {
      'topicName':topicName,
    });
  }
  void getTopics() async {
    Data data = Data();
    topicController.loadTopics();
    topics = await data.loadTopic();
  }

  String quote_text = '';
  void getQuote() async {
    QuoteService qs = QuoteService();
    Quote quote = await qs.getQuote();
    setState(() {
      quote_text = quote.quote;
    });
    print(quote_text);
  }

  @override
  void initState() {
    super.initState();
    getTopics();
    getQuote();
  }

  List<TopicView> topics = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
              "To-do List",
              style: TextStyle(fontSize: 25),
            )),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Obx(() => GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 120 / 120,
                ),
                itemCount: topicController.topics.length,
                itemBuilder: (context, index) {
                  if (index != topicController.topics.length - 1) {
                    return TopicView(
                        label: topicController.topics[index].label,
                        icon: topicController.topics[index].icon,
                        onPressed: (){
                          goTo(topicController.topics[index].label);
                        }
                    );
                  } else {
                    return TopicView(
                      label: topicController.topics[index].label,
                      icon: topicController.topics[index].icon,
                      onPressed: showCustomDialog,
                    );
                  }
                },
              ),)
            ),
            Container(
              child: Text(quote_text),
            )
          ],
        ),
      ),
    );
  }

}
