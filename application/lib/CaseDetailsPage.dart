import 'package:flutter/material.dart';

class CaseDetailsPage extends StatefulWidget {
  @override
  _CaseDetailsPageState createState() => _CaseDetailsPageState();
}

class _CaseDetailsPageState extends State<CaseDetailsPage> {
  Case? _selectedCase;

  final List<Case> cases = [
    Case(
      caseTitle: 'Case 1',
      caseDetails: 'Details of Case 1',
      caseProgress: 'In progress',
      caseHandler: 'Lawyer A',
    ),
    Case(
      caseTitle: 'Case 2',
      caseDetails: 'Details of Case 2',
      caseProgress: 'Completed',
      caseHandler: 'Lawyer B',
    ),
    // Add more cases as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
      ),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final currentCase = cases[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: ExpansionTile(
                title: Text(currentCase.caseTitle),
                subtitle: Text(currentCase.caseProgress),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Case Details: ${currentCase.caseDetails}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Case Handler: ${currentCase.caseHandler}'),
                      ],
                    ),
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

class Case {
  final String caseTitle;
  final String caseDetails;
  final String caseProgress;
  final String caseHandler;

  Case({
    required this.caseTitle,
    required this.caseDetails,
    required this.caseProgress,
    required this.caseHandler,
  });
}
