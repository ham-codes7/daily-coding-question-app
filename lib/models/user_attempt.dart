class UserAttempt {
  final String questionId;
  final String userAnswer;
  final DateTime submittedAt;

  UserAttempt({
    required this.questionId,
    required this.userAnswer,
    required this.submittedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'userAnswer': userAnswer,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }
}
