import 'package:flutter/material.dart';
import 'package:share/share.dart';

class DailyInspirationScreen extends StatefulWidget {
  const DailyInspirationScreen({super.key});

  @override
  _DailyInspirationScreenState createState() => _DailyInspirationScreenState();
}

class _DailyInspirationScreenState extends State<DailyInspirationScreen> {
  final List<Map<String, String>> _quotes = [
    {
      "quote": "Be patient with yourself. Nothing in nature blooms all year.",
      "author": "Anonymous"
    },
    {
      "quote": "The best time for new beginnings is now.",
      "author": "Anonymous"
    },
    {
      "quote": "Believe you can and you're halfway there.",
      "author": "Theodore Roosevelt"
    },
  ];

  int _currentQuoteIndex = 0;

  void _nextQuote() {
    setState(() {
      _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Inspiration'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.deepPurple, 
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _quotes[_currentQuoteIndex]["quote"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.white, 
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "- ${_quotes[_currentQuoteIndex]["author"]!}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Share.share(_quotes[_currentQuoteIndex]["quote"]!);
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share This Inspiration'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _nextQuote,
                      child: const Text(
                        'Next Quote',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Start your day with positivity. Reflect on today’s inspiration.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
