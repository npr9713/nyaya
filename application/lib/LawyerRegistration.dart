import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

class LawyerRegistrationPage extends StatefulWidget {
  const LawyerRegistrationPage({super.key});

  @override
  _LawyerRegistrationPageState createState() => _LawyerRegistrationPageState();
}

class _LawyerRegistrationPageState extends State<LawyerRegistrationPage> {
  final TextEditingController locationController = TextEditingController();
  List<String> suggestions = [];
  String selectedLocation = ''; // Global variable to store the selected location

  Future<void> fetchSuggestions(String input) async {
    final String apiKey = 'pk.eyJ1IjoicHJhdGhlZXAxNjE2IiwiYSI6ImNsYThjb2ZyNzAyOTUzcXFkbHM3amVwY2wifQ.qRhoxfXkAlxOnW4_uG-NBQ'; // Replace with your Mapbox API key
    final String baseUrl = 'https://api.mapbox.com/search/searchbox/v1/suggest';
    final String sessionToken = Uuid().v4(); // Generate a session token

    final String url =
        '$baseUrl?q=$input&language=en&limit=5&session_token=$sessionToken&access_token=$apiKey';

    final response = await http.get(Uri.parse(url));

 
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final suggestions = data['suggestions'];

    
if (suggestions != null && suggestions.isNotEmpty) {
  setState(() {
    this.suggestions = suggestions
      .map<String>((dynamic suggestion) => suggestion['name'] as String)
      .toList();
  });
}

    } else {
      print("failed to suggest");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyer Registration'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(labelText: 'Bar Council Number'),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true, // Hide password
                decoration: InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              // Location field with suggestions
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (input) {
                  fetchSuggestions(input); // Call the function to fetch suggestions
                },
              ),

              // Suggestions container
              if (suggestions.isNotEmpty)
                Container(
                  height: 200, // Adjust the height as needed
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Update the input field with the selected suggestion
                            locationController.text = suggestions[index];
                            selectedLocation = suggestions[index]; // Store the selected location
                            suggestions.clear();
                            print(selectedLocation);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            suggestions[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              // ... Other form fields ...
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement registration logic here
                  // You should validate user input and store registration data.
                  // After successful registration, you can navigate to the login page or any other page.
                  // For this example, we'll navigate back to the login page.
                  Navigator.pop(context);
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
