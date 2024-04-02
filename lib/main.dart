import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizappbymaruf/controller/quiz_controller.dart';

import 'package:quizappbymaruf/pages/main_menu.dart';

void main() {
  Get.put(QuizController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainMenu(),
    );
  }
}

