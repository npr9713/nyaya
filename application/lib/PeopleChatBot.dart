import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  bool _loading = false;

  Future<void> _handleSubmitted(String text) async {
    // Show a loading indicator while waiting for the response
    setState(() {
      _loading = true;
    });

    // Send the user's message to the Flask server
    final response = await http.post(
      Uri.parse('http://localhost:9500/ask_question'), // Update with your Flask server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_input': text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final botResponse = data['response'] as String;

      ChatMessage message = ChatMessage(
        text: botResponse,
        isUser: false,
      );

      setState(() {
        _messages.insert(0, message);
        _loading = false; // Hide loading indicator
      });
    } else {
      // Handle the case where the server returns an error
      print('Request failed with status: ${response.statusCode}');
      _loading = false; // Hide loading indicator
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageController,
                onSubmitted: (text) {
                  _handleSubmitted(text);
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (_loading == false) {
                  _handleSubmitted(_messageController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isUser)
            CircleAvatar(
              child: Text('Bot'),
            ),
          Container(
            decoration: BoxDecoration(
              color: isUser
                  ? Colors.blue[200]
                  : Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(10.0),
            constraints: BoxConstraints(
              maxWidth: 250.0,
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ChatbotPage()));
