import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarCustomizationScreen extends StatefulWidget {
  const AvatarCustomizationScreen({super.key});

  @override
  _AvatarCustomizationScreenState createState() =>
      _AvatarCustomizationScreenState();
}

class _AvatarCustomizationScreenState extends State<AvatarCustomizationScreen> {
  String _avatarName = '';

  void _saveAvatar() async {
    String avatarData = await FluttermojiFunctions().encodeMySVGtoString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatarSVG', avatarData);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your buddy $_avatarName is ready to chat!'),
          content: Text('Your avatar has been saved successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/chatbot');
              },
              child: Text('Start Talking'),
            ),
          ],
        );
      },
    );
  }

  void _resetAvatar() {
    setState(() {
      _avatarName = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Customize Your Buddy'),
            Text(
              'Create an avatar that feels like a companion.',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // Avatar Preview Section
                Expanded(
                  child: Center(
                    child: FluttermojiCircleAvatar(
                      radius: 100,
                    ),
                  ),
                ),
                // Customization Panels
                FluttermojiCustomizer(
                  scaffoldWidth: MediaQuery.of(context).size.width * 0.85,
                  scaffoldHeight: MediaQuery.of(context).size.height * 0.5,
                ),
              ],
            ),
          ),
          // Bottom Section - Controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Give your buddy a name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _avatarName = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _resetAvatar,
                      child: Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _saveAvatar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Save & Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
