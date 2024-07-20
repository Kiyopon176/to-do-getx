import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_getx/controllers/task_controller.dart';
import 'package:to_do_getx/models/data.model.dart';
import 'package:to_do_getx/models/quote.model.dart';
import 'package:to_do_getx/models/task.model.dart';
import 'package:to_do_getx/pages/home_page.dart';
import 'package:to_do_getx/pages/to-do-list.dart';
import 'package:to_do_getx/quote_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TopicViewAdapter());
  Hive.registerAdapter(TaskAdapter());
  var box = await Hive.openBox('to_dogetx');
  box.put('shoppins', [Task("hello", false),Task("hell1o", false),]);
  QuoteService qs = QuoteService();
  qs.getQuote();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/To-doList': (context) => const ToDo_List(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
