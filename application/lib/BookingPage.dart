// ignore: file_names
import 'package:flutter/material.dart';
import 'BookingSucessful.dart'; // Import the SuccessPage widget

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? selectedCaseType;
  List<String> caseTypes = ['Civil', 'Criminal', 'Juvenile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
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
                'Complete the booking form:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCaseType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCaseType = newValue;
                  });
                },
                items: caseTypes.map((String caseType) {
                  return DropdownMenuItem<String>(
                    value: caseType,
                    child: Text(caseType),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Type of Case',
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(labelText: 'Criminal Charges'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SuccessPage when "Submit Booking" is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SuccessPage()),
                  );
                },
                child: const Text('Submit Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
