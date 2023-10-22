import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Sample user data, replace with actual user data from your storage or database
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';
  String _userPhoneNumber = '123-456-7890';
  String _userAddress = '123 Main St, City, Country';

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the user's data
    _nameController.text = _userName;
    _emailController.text = _userEmail;
    _phoneNumberController.text = _userPhoneNumber;
    _addressController.text = _userAddress;
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    setState(() {
      // Save changes to user data
      _userName = _nameController.text;
      _userEmail = _emailController.text;
      _userPhoneNumber = _phoneNumberController.text;
      _userAddress = _addressController.text;

      // Exit edit mode
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveChanges,
            ),
          IconButton(
            icon: _isEditing ? const Icon(Icons.cancel) : const Icon(Icons.edit),
            onPressed: _toggleEditing,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              enabled: _isEditing,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              enabled: _isEditing,
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              enabled: _isEditing,
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
              enabled: _isEditing,
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: ProfilePage()));
