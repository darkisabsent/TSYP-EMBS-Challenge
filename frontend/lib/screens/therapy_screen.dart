import 'package:flutter/material.dart';

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Therapy'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Sessions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                sessionCard('Dr. Smith', '2023-10-25 10:00 AM', 'Video'),
                sessionCard('Dr. Johnson', '2023-10-26 2:00 PM', 'Audio'),
                sessionCard('Dr. Brown', '2023-10-27 4:00 PM', 'In-Person'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Schedule a Session',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Session Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Video', child: Text('Video')),
                DropdownMenuItem(value: 'Audio', child: Text('Audio')),
                DropdownMenuItem(value: 'In-Person', child: Text('In-Person')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Preferred Time Slot',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Morning', child: Text('Morning')),
                DropdownMenuItem(value: 'Afternoon', child: Text('Afternoon')),
                DropdownMenuItem(value: 'Evening', child: Text('Evening')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Therapist',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Dr. Smith', child: Text('Dr. Smith')),
                DropdownMenuItem(
                    value: 'Dr. Johnson', child: Text('Dr. Johnson')),
                DropdownMenuItem(value: 'Dr. Brown', child: Text('Dr. Brown')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Book Session'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Notes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget sessionCard(String therapist, String dateTime, String sessionType) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Therapist: $therapist', style: const TextStyle(fontSize: 16)),
            Text('Date/Time: $dateTime', style: const TextStyle(fontSize: 16)),
            Text('Session Type: $sessionType',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Join Now'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
