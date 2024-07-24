import 'package:game/service/questions_service.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quetions_models.dart';

class QuestionsController extends GetxController {
  final QuestionsService questionsService = QuestionsService();

  final RxList<QuestionsModels> _questions = <QuestionsModels>[].obs;

  List<QuestionsModels> get questions => _questions;

  RxInt olmos = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  void fetchQuestions() {
    questionsService.getQuestions().listen((QuerySnapshot snapshot) {
      final questionsList = snapshot.docs.map((doc) {
        if (doc.data() != null) {
          return QuestionsModels.fromJson(doc.data() as Map<String, dynamic>);
        } else {
          return QuestionsModels(
              id: '', question: 'Unknown', answer: 'Unknown');
        }
      }).toList();

      _questions.assignAll(questionsList);
    }, onError: (e) {
      Get.snackbar('Error', 'Failed to fetch questions: $e');
    });
  }
}
