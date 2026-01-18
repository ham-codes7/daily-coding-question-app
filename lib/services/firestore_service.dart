import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/coding_question.dart';
import '../models/user_attempt.dart';
import '../models/user_progress.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch today's coding question (same for all users)
  Future<CodingQuestion?> getTodayQuestion() async {
    final today = DateTime.now();
    final todayString =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final query = await _db
        .collection('questions')
        .where('date', isEqualTo: todayString)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return CodingQuestion.fromMap(doc.id, doc.data());
  }

  /// Submit user's attempt (locks solution)
  Future<void> submitAttempt(
    String userId,
    UserAttempt attempt,
  ) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('attempts')
        .doc(attempt.questionId)
        .set(attempt.toMap());
  }

  /// Check if user already attempted today's question
  Future<bool> hasAttempted(
    String userId,
    String questionId,
  ) async {
    final doc = await _db
        .collection('users')
        .doc(userId)
        .collection('attempts')
        .doc(questionId)
        .get();

    return doc.exists;
  }

  /// Update streak logic
  Future<void> updateUserProgress(String userId) async {
    final userRef = _db.collection('users').doc(userId);
    final snapshot = await userRef.get();

    UserProgress progress;

    if (!snapshot.exists || snapshot.data()?['progress'] == null) {
      progress = UserProgress(
        currentStreak: 1,
        lastAttemptDate: DateTime.now(),
      );
    } else {
      progress = UserProgress.fromMap(snapshot['progress']);

      final lastDate = progress.lastAttemptDate;
      final today = DateTime.now();

      final isConsecutive =
          lastDate != null &&
          today.difference(lastDate).inDays == 1;

      progress = UserProgress(
        currentStreak:
            isConsecutive ? progress.currentStreak + 1 : 1,
        lastAttemptDate: today,
      );
    }

    await userRef.set({
      'progress': progress.toMap(),
    }, SetOptions(merge: true));
  }
}
