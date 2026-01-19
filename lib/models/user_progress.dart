class UserProgress {
  final int currentStreak;
  final DateTime? lastAttemptDate;

  UserProgress({
    required this.currentStreak,
    required this.lastAttemptDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'currentStreak': currentStreak,
      'lastAttemptDate': lastAttemptDate?.toIso8601String(),
    };
  }

  factory UserProgress.fromMap(Map<String, dynamic> data) {
    return UserProgress(
      currentStreak: data['currentStreak'] ?? 0,
      lastAttemptDate: data['lastAttemptDate'] != null
          ? DateTime.parse(data['lastAttemptDate'])
          : null,
    );
  }
}
