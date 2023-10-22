import 'package:application/main.dart';
import 'package:flutter/material.dart';
import 'JailerRegistration.dart'; // Import the JailerRegistrationPage widget
import 'JailerInterface.dart'; // Import the JailerDashboard page

void main() {
  runApp(const JailerLoginApp());
}

class JailerLoginApp extends StatelessWidget {
  const JailerLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jailer Login',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const JailerLoginPage(),
    );
  }
}

class JailerLoginPage extends StatefulWidget {
  const JailerLoginPage({super.key});

  @override
  _JailerLoginPageState createState() => _JailerLoginPageState();
}

class _JailerLoginPageState extends State<JailerLoginPage> {
  String? selectedLocation;
  List<String> jailLocations = [
    'Delhi',
    'Mumbai',
    'Kolkata',
    'Chennai',
    'Bangalore',
  ];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jailer Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NyayaSahayakScreen()),
            );
          },
        ),
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
              const Text(
                'Login as Jailer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true, // Hide password
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                },
                items: jailLocations.map((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Jail Location',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement login logic here
                  // You can validate user input and authenticate
                  // For now, print the input values as an example
                  print('Email: ${emailController.text}');
                  print('Password: ${passwordController.text}');
                  print('Selected Location: $selectedLocation');

                  // Navigate to the JailerDashboard page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JailerDashboard()),
                  );
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the registration page when the registration button is pressed.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JailerRegistrationPage()),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the tree
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
