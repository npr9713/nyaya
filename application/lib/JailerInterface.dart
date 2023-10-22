import 'package:flutter/material.dart';
//import 'JailerLogin.dart';

void main() {
  runApp(const JailerApp());
}

class JailerApp extends StatelessWidget {
  const JailerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jailer Interface',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const JailerDashboard(),
    );
  }
}

class JailerDashboard extends StatefulWidget {
  const JailerDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JailerDashboardState createState() => _JailerDashboardState();
}



class _JailerDashboardState extends State<JailerDashboard> {
  List<Prisoner> prisoners = []; // List to store prisoner data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jailer Interface'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navigate to AddPrisonerScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPrisonerScreen(),
                      ),
                    ).then((newPrisoner) {
                      if (newPrisoner != null) {
                        setState(() {
                          prisoners.add(newPrisoner);
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  ),
                  child: const Text(
                    'Add New Prisoner',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to SearchPrisonerScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPrisonerScreen(prisoners),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  ),
                  child: const Text(
                    'Search Prisoner',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Total Prisoners: ${prisoners.length}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Prisoner {
  final String id;
  final String name;
  final String details;

  Prisoner({required this.id, required this.name, required this.details});
}

class AddPrisonerScreen extends StatefulWidget {
  const AddPrisonerScreen({super.key});

  @override
  _AddPrisonerScreenState createState() => _AddPrisonerScreenState();
}

class _AddPrisonerScreenState extends State<AddPrisonerScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Prisoner'),
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
            children: <Widget>[
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'Prisoner ID'),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Prisoner Name'),
              ),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(labelText: 'Prisoner Details'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Validate input and create a new Prisoner object
                  final String id = idController.text;
                  final String name = nameController.text;
                  final String details = detailsController.text;

                  if (id.isNotEmpty && name.isNotEmpty) {
                    Navigator.pop(
                      context,
                      Prisoner(id: id, name: name, details: details),
                    );
                  }
                },
                child: const Text('Save Prisoner'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    detailsController.dispose();
    super.dispose();
  }
}

class SearchPrisonerScreen extends StatefulWidget {
  final List<Prisoner> prisoners;

  const SearchPrisonerScreen(this.prisoners, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPrisonerScreenState createState() => _SearchPrisonerScreenState();
}

class _SearchPrisonerScreenState extends State<SearchPrisonerScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Prisoner> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      // Filter prisoners based on search query
      final query = searchController.text.toLowerCase();
      setState(() {
        searchResults = widget.prisoners.where((prisoner) {
          return prisoner.name.toLowerCase().contains(query) ||
              prisoner.id.toLowerCase().contains(query);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Prisoner'),
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
            children: <Widget>[
              TextField(
                controller: searchController,
                decoration: const InputDecoration(labelText: 'Search by Name or ID'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final prisoner = searchResults[index];
                    return ListTile(
                      title: Text(prisoner.name),
                      subtitle: Text(prisoner.id),
                      onTap: () {
                        // Navigate to PrisonerDetailsScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PrisonerDetailsScreen(prisoner),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class PrisonerDetailsScreen extends StatelessWidget {
  final Prisoner prisoner;

  const PrisonerDetailsScreen(this.prisoner, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prisoner Details'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ID: ${prisoner.id}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Name: ${prisoner.name}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Details: ${prisoner.details}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
