import 'package:flutter/material.dart';
import 'package:application/BookingPage.dart';

void main() {
  runApp(const MyApp());
}

class Lawyer {
  final String name;
  final String specialization;
  final int age;
  final int experienceYears;
  final String barCouncilNumber;
  final String phoneNumber;
  final String location;
  final List<String> comments;
  final double rating;
  final String profileImagePath; // Add profile image path

  Lawyer({
    required this.name,
    required this.specialization,
    required this.age,
    required this.experienceYears,
    required this.barCouncilNumber,
    required this.phoneNumber,
    required this.location,
    required this.comments,
    required this.rating,
    required this.profileImagePath,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/lawyerSearch',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      routes: {
        '/lawyerSearch': (context) => const SearchPage(),
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<Lawyer> lawyers = [
    Lawyer(
      name: 'Nandha Kumar',
      specialization: 'Criminal Lawyer',
      age: 46,
      experienceYears: 10,
      barCouncilNumber: '100987',
      phoneNumber: '9597652987',
      location: 'Chennai',
      comments: ['Excellent lawyer!', 'Very knowledgeable.'],
      rating: 4.5,
      profileImagePath: 'assets/nandy.jpeg', // Replace with actual image path
    ),
    Lawyer(
      name: 'Pratheep',
      specialization: 'Divorce Lawyer',
      age: 35,
      experienceYears: 8,
      barCouncilNumber: '100988',
      phoneNumber: '9876543210',
      location: 'New York',
      comments: ['Helped me a lot.', 'Highly recommended.'],
      rating: 4.8,
      profileImagePath: 'assets/pratheep.png', // Replace with actual image path
    ),
    Lawyer(
      name: 'Jayasree',
      specialization: 'Corporate Lawyer',
      age: 40,
      experienceYears: 12,
      barCouncilNumber: '100989',
      phoneNumber: '1234567890',
      location: 'San Francisco',
      comments: ['Great communication.', 'Very professional.'],
      rating: 4.6,
      profileImagePath: 'assets/jayasree.jpeg', // Replace with actual image path
    ),
  ];

  List<Lawyer> filteredLawyers = [];

  @override
  void initState() {
    super.initState();
    filteredLawyers = lawyers;
  }

  void _filterLawyers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLawyers = lawyers;
      } else {
        filteredLawyers = lawyers.where((lawyer) {
          return lawyer.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  // Filter options
  String? selectedSpecialization;
  double? selectedRating;
  int? selectedExperience;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyers Search'),
        actions: [
          IconButton(
            onPressed: () {
              _showFilterDialog(context);
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextField(
              controller: searchController,
              onChanged: _filterLawyers, // Call filter function on text change
              decoration: const InputDecoration(
                labelText: 'Search Lawyers',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            // Display filtered lawyer profiles
            for (var lawyer in filteredLawyers)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      // Display profile picture
                      backgroundImage: AssetImage(lawyer.profileImagePath),
                      radius: 30, // Adjust the size as needed
                    ),
                    title: Text(
                      'Lawyer Name: ${lawyer.name}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(lawyer.specialization),
                  ),
                  ExpansionTile(
                    title: const Text('Details'),
                    children: [
                      ListTile(
                        title: Text('Age: ${lawyer.age}'),
                      ),
                      ListTile(
                        title: Text('Year of Experience: ${lawyer.experienceYears}'),
                      ),
                      ListTile(
                        title: Text('Bar Council Number: ${lawyer.barCouncilNumber}'),
                      ),
                      ListTile(
                        title: Text('Phone Number: ${lawyer.phoneNumber}'),
                      ),
                      ListTile(
                        title: Text('Location: ${lawyer.location}'),
                      ),
                      ListTile(
                        title: Text('Rating: ${lawyer.rating.toStringAsFixed(1)}'),
                      ),
                      const ListTile(
                        title: Text('Comments:'),
                      ),
                      for (var comment in lawyer.comments)
                        ListTile(
                          title: Text('- $comment'),
                        ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookingPage()),
                      );
                    },
                    child: const Text('Contact now'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showFilterDialog(BuildContext context) async {
    // ...
  }

  void _applyFilters() {
    // ...
  }
}

