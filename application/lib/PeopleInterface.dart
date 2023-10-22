// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:application/CaseDetailsPage.dart';
import 'package:application/CommonPeopleLoginPage.dart';
import 'package:application/PeopleMessage.dart';
import 'package:flutter/material.dart';
import 'PeopleProfile.dart'; // Import the ProfilePage widget
import 'lawyerSearch.dart'; // Import the SearchPage widget
import 'PeopleChatBot.dart'; // Import the ChatbotPage widget

void main() {
  runApp(const CommonPeopleDashboardApp());
}

class CommonPeopleDashboardApp extends StatelessWidget {
  const CommonPeopleDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common People Dashboard',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const CommonPeopleDashboard(),
    );
  }
}

class CommonPeopleDashboard extends StatefulWidget {
  const CommonPeopleDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CommonPeopleDashboardState createState() => _CommonPeopleDashboardState();
}

class _CommonPeopleDashboardState extends State<CommonPeopleDashboard> {
  // ignore: unused_field
  int _selectedIndex = 0;

  Future<void> _showExitConfirmationDialog() async {
    bool confirmExit = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to Logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                confirmExit = true;
                Navigator.of(context).pop();
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmExit) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CommonPeopleLoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common People Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _showExitConfirmationDialog();
            },
          ),
        ],
      ),
      body: const Center(
        // Your body content here
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('john.doe@example.com'),
              currentAccountPicture: CircleAvatar(
                child: FlutterLogo(size: 42.0),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()), // Navigate to the ProfilePage
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Case Details'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CaseDetailsPage()), // Navigate to the ProfilePage
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search Lawyer'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chatbot'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatbotPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text('Messages'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MessagePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//void main() => runApp(const MaterialApp(home: ProfilePage()));

