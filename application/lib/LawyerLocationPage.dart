import 'package:flutter/material.dart';

class LawyerLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Lawyer Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select a location to search for lawyers near that area.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            // You can add location selection widgets here
          ],
        ),
      ),
    );
  }
}
