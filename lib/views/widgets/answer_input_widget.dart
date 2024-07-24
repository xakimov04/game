import 'package:flutter/material.dart';

class AnswerInput extends StatelessWidget {
  final String text;
  final bool isCorrect;
  const AnswerInput({
    super.key,
    required this.text,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.8),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isCorrect ? const Color(0xff3E87FF) : Colors.red,
              width: 5,
            ),
          ),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
