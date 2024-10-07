import 'package:flutter/material.dart';
import 'package:random/constants/questions.dart';

// screens
import 'package:random/screens/question.dart';
import 'package:random/screens/result.dart';
import 'package:random/screens/start.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  String? activeScreen;
  List<String> answersList = [];

  void addAnswer(String answer) {
    setState(() {
      answersList.add(answer);
    });

    if (answersList.length >= questions.length) {
      changeScreen('result-screen');
    }
  }

  @override
  void initState() {
    activeScreen = 'start-screen';
    // activeScreen = 'result-screen';
    super.initState();
  }

  void changeScreen(String updateScreen) {
    setState(() {
      activeScreen = updateScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? currentScreen;

    if (activeScreen == 'start-screen') {
      currentScreen = StartQuiz(() => changeScreen('question-screen'));
    } else if (activeScreen == 'question-screen') {
      currentScreen = Question(addAnswer: addAnswer);
    } else if (activeScreen == 'result-screen') {
      currentScreen = Result(
        results: answersList,
        changeScreen: () => changeScreen('start-screen'),
      );
      setState(() {
        answersList = [];
      });
    }

    return MaterialApp(
      home: Scaffold(
        body: currentScreen,
      ),
    );
  }
}
