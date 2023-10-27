import 'package:flutter/material.dart';
import 'PeopleInterface.dart';
void main() {
  runApp(const MyApp());
}

class Message {
  final String sender;
  final String message;
  final bool isWardenMessage;

  Message({
    required this.sender,
    required this.message,
    required this.isWardenMessage,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MessagePage(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}

class MessagePage extends StatelessWidget {
  final List<Message> messages = [
    Message(sender: 'Warden', message: 'Prisoner visitation at 2:00 PM', isWardenMessage: true),
    Message(sender: 'Lawyer', message: 'Legal update for your case', isWardenMessage: false),
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Box'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: message.isWardenMessage ? Colors.blue.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.isWardenMessage ? 'Warden' : 'Lawyer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    message.message,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
