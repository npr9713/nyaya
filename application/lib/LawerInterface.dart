import 'package:flutter/material.dart';

void main() {
  runApp(const LawyerInterfaceApp());
}

class LawyerInterfaceApp extends StatelessWidget {
  const LawyerInterfaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lawyer Interface',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const LawyerDashboard(),
    );
  }
}

class LawyerDashboard extends StatefulWidget {
  const LawyerDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LawyerDashboardState createState() => _LawyerDashboardState();
}

class _LawyerDashboardState extends State<LawyerDashboard> {
  List<ClientRequest> clientRequests = [
    ClientRequest('John Doe', '123-456-7890', 'Criminal Case'),
    ClientRequest('Jane Smith', '987-654-3210', 'Civil Case'),
    ClientRequest('Alice Johnson', '555-555-5555', 'Family Law Case'),
    ClientRequest('Bob Brown', '111-222-3333', 'Personal Injury Case'),
    // Add more client requests as needed
  ];

  List<OngoingCase> ongoingCases = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyer Dashboard'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Client Requests',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (var request in clientRequests)
                buildClientRequestCard(request),
              const SizedBox(height: 20),
              const Text(
                'Ongoing Cases',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (var ongoingCase in ongoingCases)
                buildOngoingCaseCard(ongoingCase),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClientRequestCard(ClientRequest request) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(request.clientName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(request.phoneNumber),
            Text(request.caseType),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Move the client request to ongoing cases
                setState(() {
                  ongoingCases.add(OngoingCase(request));
                  clientRequests.remove(request);
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // Show a confirmation dialog before deleting the client request
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: const Text('Do you want to delete this client request?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Delete the client request
                          setState(() {
                            clientRequests.remove(request);
                          });
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOngoingCaseCard(OngoingCase ongoingCase) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(ongoingCase.clientRequest.clientName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(ongoingCase.clientRequest.caseType),
            LinearProgressIndicator(
              value: ongoingCase.progress / 100.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ClientRequest {
  final String clientName;
  final String phoneNumber;
  final String caseType;

  ClientRequest(this.clientName, this.phoneNumber, this.caseType);
}

class OngoingCase {
  final ClientRequest clientRequest;
  int progress;

  OngoingCase(this.clientRequest, {this.progress = 0});
}


