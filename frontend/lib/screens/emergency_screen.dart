import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyResponseScreen extends StatelessWidget {
  const EmergencyResponseScreen({super.key});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Help'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hotline Contacts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            emergencyButton(
                'Call Suicide Prevention Hotline', 'tel:1234567890'),
            emergencyButton('Call Emergency Services', 'tel:911'),
            const SizedBox(height: 20),
            const Text(
              'Predefined Messages',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            predefinedMessageButton(
                'I need help', 'sms:1234567890?body=I%20need%20help'),
            predefinedMessageButton('Emergency, please contact me',
                'sms:1234567890?body=Emergency,%20please%20contact%20me'),
          ],
        ),
      ),
    );
  }

  Widget emergencyButton(String text, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => _launchURL(url),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(text),
      ),
    );
  }

  Widget predefinedMessageButton(String text, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => _launchURL(url),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(text),
      ),
    );
  }
}
