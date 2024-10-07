import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:random/constants/questions.dart';
import 'package:random/widgets/option_button.dart';

class Question extends StatefulWidget {
  final void Function(String answer) addAnswer;

  const Question({super.key, required this.addAnswer});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int currentQuestionIndex = 0;
  int currentQuestionNumber = 1;

  void updateQuestionIndex(String ans) {
    widget.addAnswer(ans);

    setState(() {
      currentQuestionIndex++;
      currentQuestionNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainQuestion = questions[currentQuestionIndex];
    final queLength = questions.length;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question $currentQuestionNumber of $queLength',
            style: GoogleFonts.lato(
              color: Colors.blue.shade800,
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            mainQuestion.question,
            style: GoogleFonts.lato(
              color: Colors.blue.shade900,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...mainQuestion.shuffledAnswers.map((answer) => OptionButton(
                    optionText: answer,
                    onTap: () {
                      updateQuestionIndex(answer);
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}
