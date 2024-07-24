import 'package:flutter/material.dart';
import 'package:game/controller/questions_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../widgets/answer_input_widget.dart';
import '../widgets/help_button.dart';
import '../widgets/raiting_widgets.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final questionController = Get.put(QuestionsController());
  List<String> selectedLetters = [];
  List<String> answerLetters = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswerCorrect = true;
  final PageController _pageController = PageController();

  List<String> _generateAnswerLetters(String answer) {
    const alphabet = 'ABDEFGHJKLMMNOPQRSTUVYGSHCHNG';
    final random = Random();
    final answerLetters = answer.split('');
    final extraLetters = List<String>.generate(
      3,
      (_) => alphabet[random.nextInt(alphabet.length)],
    );
    final allLetters = answerLetters + extraLetters;
    allLetters.shuffle();
    return allLetters;
  }

  @override
  void initState() {
    super.initState();
    if (questionController.questions.isNotEmpty) {
      answerLetters = _generateAnswerLetters(
          questionController.questions[currentQuestionIndex].answer);
    }
  }

  void _onLetterTap(String letter) {
    if (selectedLetters.length <
        questionController.questions[currentQuestionIndex].answer.length) {
      setState(() {
        selectedLetters.add(letter);
        _checkAnswer();
      });
    }
  }

  void _checkAnswer() {
    final currentAnswer =
        questionController.questions[currentQuestionIndex].answer;
    if (selectedLetters.join().toLowerCase() == currentAnswer.toLowerCase()) {
      isAnswerCorrect = true;
      if (currentQuestionIndex < questionController.questions.length - 1) {
        _goToNextQuestion();
      } else {
        _showResultDialog();
      }
    } else if (selectedLetters.length ==
        currentAnswer.length) {
      isAnswerCorrect = false;
    } else {
      isAnswerCorrect = true;
    }
  }

  void _goToNextQuestion() {
    setState(() {
      score++;
      currentQuestionIndex++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.bounceIn,
      );
      _clearSelectedLetters();
    });
  }

  void _clearSelectedLetters() {
    setState(() {
      selectedLetters.clear();
      isAnswerCorrect = true;
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text('You answered $score out of ${questionController.questions.length} questions correctly.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            "assets/images/fon.png",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 10,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: RaitingWidget(
                        image: 'star',
                      ),
                    ),
                    const Gap(5),
                    Expanded(
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 104,
                            height: 80,
                            child: Image.asset("assets/icons/true.png"),
                          ),
                          Positioned(
                            top: 22,
                            left: 44,
                            child: Text(
                              "$score", // Display the score here
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(5),
                    const Expanded(
                      child: RaitingWidget(
                        image: 'olmos',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HelpButton(
                      onTap: () {},
                      image: 'help',
                    ),
                    HelpButton(
                      onTap: () {},
                      image: 'store',
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(
                    () {
                      if (questionController.questions.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final question =
                            questionController.questions[currentQuestionIndex];
                        return PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.vertical,
                          itemCount: questionController.questions.length,
                          itemBuilder: (context, index) {
                            final question =
                                questionController.questions[index];
                            final answerLetters =
                                _generateAnswerLetters(question.answer);
                            return SizedBox(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    question.question,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          question.answer.length,
                                          (index) {
                                            return AnswerInput(
                                              text:
                                                  index < selectedLetters.length
                                                      ? selectedLetters[index]
                                                      : "",
                                              isCorrect: isAnswerCorrect,
                                            );
                                          },
                                        ),
                                      ),
                                      const Gap(20),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: answerLetters
                                            .map(
                                              (letter) => GestureDetector(
                                                onTap: () => setState(() {
                                                  _onLetterTap(letter);
                                                }),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff3E87FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      letter.toUpperCase(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      const Gap(20),
                                      FilledButton(
                                        onPressed: _clearSelectedLetters,
                                        child: const Text("Clear Letters"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
