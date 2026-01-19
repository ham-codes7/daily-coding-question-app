import 'package:flutter/material.dart';
import '../models/coding_question.dart';
import '../models/user_attempt.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import '../config/app_config.dart';
import '../services/mock_firestore_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MockFirestoreService _mockService = MockFirestoreService();
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  CodingQuestion? _question;
  bool _isLoading = true;
  bool _hasAttempted = false;

  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

Future<void> _loadQuestion() async {
  if (AppConfig.demoMode) {
    final question = _mockService.getTodayQuestion();

    setState(() {
      _question = question;
      _hasAttempted =
          _mockService.hasAttempted('demo_user', question.id);
      _isLoading = false;
    });
    return;
  }

  // Production Firebase logic stays below (unchanged)
}


Future<void> _submitAnswer() async {
  if (_question == null) return;

  final attempt = UserAttempt(
    questionId: _question!.id,
    userAnswer: _answerController.text,
    submittedAt: DateTime.now(),
  );

  if (AppConfig.demoMode) {
    _mockService.submitAttempt('demo_user', attempt);
    setState(() {
      _hasAttempted = true;
    });
    return;
  }

  //  Production Firebase logic stays below
}


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_question == null) {
      return const Scaffold(
        body: Center(child: Text('No question for today')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Coding Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _question!.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_question!.difficulty} • ${_question!.topic}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(_question!.description),
            const SizedBox(height: 24),

            if (!_hasAttempted) ...[
              TextField(
                controller: _answerController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write your approach / pseudocode here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submitAnswer,
                child: const Text('Submit Attempt'),
              ),
            ] else ...[
              const Text(
                'Official Solution:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(_question!.solution),
            ],
          ],
        ),
      ),
    );
  }
}
