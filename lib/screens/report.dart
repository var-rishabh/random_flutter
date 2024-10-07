import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Report extends StatelessWidget {
  final List<Map<String, Object>> results;
  const Report({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: results.map((data) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.shade700,
                child: Text(
                  (data["index"] as int).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["question"] as String,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Correct: ${data["correct_answer"]}',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.green.shade800,
                      ),
                    ),
                    Text(
                      'Yours: ${data["user_answer"]}',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.blue.shade500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
