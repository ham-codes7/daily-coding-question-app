import '../models/coding_question.dart';
import '../models/user_attempt.dart';

class MockFirestoreService {
  bool _hasAttempted = false;
  int _currentStreak = 0;

  CodingQuestion getTodayQuestion() {
    return CodingQuestion(
      id: 'demo_q1',
      title: 'Reverse a String',
      description:
          'Given a string, reverse it without using built-in reverse functions.',
      solution:
          'Start from the last character and build a new string by iterating backwards.',
      difficulty: 'Easy',
      topic: 'Strings',
      date: DateTime.now(),
    );
  }

  bool hasAttempted(String userId, String questionId) {
    return _hasAttempted;
  }

  void submitAttempt(String userId, UserAttempt attempt) {
    _hasAttempted = true;
    _currentStreak += 1;
  }

  int getCurrentStreak() {
    return _currentStreak;
  }
}
