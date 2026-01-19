class CodingQuestion {
  final String id;
  final String title;
  final String description;// these are all the fields for a coding question
  final String solution;
  final String difficulty; // Easy / Medium / Hard
  final String topic; // Arrays, Strings, Math, etc.
  final DateTime date; // Which day this question belongs to

  CodingQuestion({
    required this.id,
    required this.title,
    required this.description,
    required this.solution,//required this. means these fields must be provided when creating an instance of CodingQuestion
    required this.difficulty,
    required this.topic,
    required this.date,
  });

  factory CodingQuestion.fromMap(String id, Map<String, dynamic> data) {//this statement means that this factory constructor creates a CodingQuestion instance from a map of data
    return CodingQuestion(
      id: id,
      title: data['title'],
      description: data['description'],
      solution: data['solution'],
      difficulty: data['difficulty'],
      topic: data['topic'],
      date: DateTime.parse(data['date']),
    );
  }
}
