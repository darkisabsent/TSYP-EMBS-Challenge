import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;
  String avatarSVG = '';

  @override
  void initState() {
    super.initState();
    _loadAvatar();
    _sendInitialMessage();
  }

  Future<void> _loadAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarSVG = prefs.getString('avatarSVG') ?? '';
    });
  }

  Future<void> _sendInitialMessage() async {
    setState(() {
      _messages.add({'text': 'How can I help you today?', 'isBot': true});
    });
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'text': message, 'isBot': false});
      _isTyping = true;
    });

    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:5000/chat'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'question': message}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _messages.add({'text': data['answer'], 'isBot': true});
        _isTyping = false;
      });
    } else {
      setState(() {
        _messages.add({'text': 'Error: ${response.statusCode}', 'isBot': true});
        _isTyping = false;
      });
    }
  }

  void _handleSubmitted(String message) {
    if (message.isNotEmpty) {
      _sendMessage(message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Chat with Your AI Assistant'),
          ],
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return chatBubble(message['text'], isBot: message['isBot']);
              },
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
                  Text('AI Assistant is typing...'),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                quickReplyButton('I feel stressed'),
                quickReplyButton('Tell me a joke'),
                quickReplyButton('Emergency Assistance'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _handleSubmitted(_controller.text.trim());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatBubble(String message, {required bool isBot}) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isBot ? Colors.teal[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBot && avatarSVG.isNotEmpty)
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 15,
                child: SvgPicture.string(avatarSVG),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                children: [
                  if (isBot) const Text('📘 '),
                  Expanded(child: Text(message)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quickReplyButton(String text) {
    return ElevatedButton(
      onPressed: () {
        _sendMessage(text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }
}
