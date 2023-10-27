import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PeopleInterface.dart';
import 'CommonPeopleRegistration.dart';

class CommonPeopleLoginPage extends StatefulWidget {
  const CommonPeopleLoginPage({Key? key}) : super(key: key);

  @override
  _CommonPeopleLoginPageState createState() => _CommonPeopleLoginPageState();
}

class _CommonPeopleLoginPageState extends State<CommonPeopleLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
  final String baseUrl = 'https://0b4f-2401-4900-4dd7-a6e5-11b4-7be6-b5dd-2c0c.ngrok.io/login'; // Replace with your actual Ngrok URL
 // Replace with your backend login API URL

  // Validate the input fields
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    // Show an alert if any field is empty
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Missing Information'),
          content: Text('Please fill in all fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return; // Return early if any field is empty
  }

  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Login successful
      final successMessage = responseData['success'];
      // Handle successful login, you can navigate to the dashboard or other pages here
      // For this example, we'll show a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Successful'),
            content: Text(successMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the dashboard or other pages after successful login
                  // For example, navigate to CommonPeopleDashboardApp()
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CommonPeopleDashboardApp()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Login failed, show an alert with the error message
      final errorMessage = responseData['error'];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error: $e');
    // Handle other errors, e.g., network issues (omitting code for brevity)
  }
}


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common People Login'),
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
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call the loginUser function to send login data to the backend
                  loginUser();
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10), // Add some spacing
              ElevatedButton(
                onPressed: () {
                  // Navigate to the registration page when the "Register" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CommonPeopleRegistration()),
                  );
                },
                child: const Text('Register'), // Text for the "Register" button
              ),
            ],
          ),
        ),
      ),
    );
  }
}



