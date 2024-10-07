import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random/constants/questions.dart';
import 'package:random/screens/report.dart';

class Result extends StatelessWidget {
  final List<String> results;
  final void Function() changeScreen;

  const Result({
    super.key,
    required this.results,
    required this.changeScreen,
  });

  List<Map<String, Object>> get resultSummaryData {
    List<Map<String, Object>> summary = [];

    for (int i = 0; i < questions.length; i++) {
      summary.add({
        "index": i + 1,
        "question": questions[i].question,
        "correct_answer": questions[i].options[0],
        "user_answer": results[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final queLength = questions.length;
    final correctAnswers = resultSummaryData.where((data) {
      return data["correct_answer"] == data["user_answer"];
    }).length;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Results",
            style: GoogleFonts.lato(
              fontSize: 25,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'You got $correctAnswers out of $queLength questions correct.',
            style: GoogleFonts.lato(
              fontSize: 15,
              color: Colors.blue.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            height: 350,
            margin: const EdgeInsets.fromLTRB(50, 10, 50, 30),
            child: Report(results: resultSummaryData),
          ),
          OutlinedButton(
            onPressed: () {
              changeScreen();
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white,
              maximumSize: const Size(120, 50),
              minimumSize: const Size(120, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.restore,
                  size: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  "Retry",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
