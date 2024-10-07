import 'package:flutter/material.dart';

class StartQuiz extends StatelessWidget {
  final void Function() changeScreen;

  const StartQuiz(this.changeScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: NetworkImage(
                "https://www.shutterstock.com/image-vector/quiz-comic-pop-art-style-600nw-1506580442.jpg"),
          ),
          const SizedBox(
            height: 60,
          ),
          ElevatedButton(
              onPressed: changeScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff06b2d0),
                foregroundColor: Colors.white,
                minimumSize: const Size(70, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  "START QUIZ!",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
