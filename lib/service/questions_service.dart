import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class QuestionsService {
  final _questionsFirebase = FirebaseFirestore.instance.collection('questions');

  Stream<QuerySnapshot> getQuestions() async* {
    yield* _questionsFirebase.snapshots();
  }
}
