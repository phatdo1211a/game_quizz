import 'package:flutter/material.dart';
import 'package:game_quizz/play/views/questions_page.dart';

class AppRoutes {
  AppRoutes._();
  static Map<String, WidgetBuilder> routes() {
    return {
      QuestionsPage.id: (context) => QuestionsPage(),
    };
  }
}
