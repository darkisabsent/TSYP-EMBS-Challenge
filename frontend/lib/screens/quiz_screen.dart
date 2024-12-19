import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<String> _questions = [
    "How do you typically recharge your energy?",
    "How do you handle stress?",
    "What is your preferred way to relax?",
    "How often do you feel overwhelmed?",
    "How do you express your emotions?",
    "What is your sleep pattern like?",
    "How do you handle conflicts?",
    "What is your level of physical activity?",
    "How do you maintain your mental health?",
    "What is your social interaction preference?"
  ];

  final List<List<String>> _answers = [
    ["Spending time alone", "Being around people", "A mix of both"],
    ["Exercise", "Meditation", "Talking to someone"],
    ["Reading", "Watching TV", "Going for a walk"],
    ["Rarely", "Sometimes", "Often"],
    ["Talking", "Writing", "Keeping to myself"],
    ["Regular", "Irregular", "Depends on the day"],
    ["Calmly", "Aggressively", "Avoiding it"],
    ["High", "Moderate", "Low"],
    ["Therapy", "Self-care", "Ignoring it"],
    ["Introverted", "Extroverted", "Ambivert"]
  ];

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuizSummaryScreen()),
        );
      }
    });
  }

  void _skipQuestion() {
    _nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self-Assessment Quiz'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover yourself and improve your emotional well-being.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
              backgroundColor: Colors.deepPurple[100],
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _questions[_currentQuestionIndex],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ..._answers[_currentQuestionIndex].map((answer) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: Text(
                            answer,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _skipQuestion,
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizSummaryScreen extends StatelessWidget {
  const QuizSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Summary'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thanks for completing the quiz!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Insights will appear once AI integration is ready.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.deepPurple,
    );
  }
}
