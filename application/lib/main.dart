import 'package:flutter/material.dart';
import 'CommonPeopleLoginPage.dart' as CommonPeople;
import 'JailerLogin.dart' as Jailer;
import 'LawyerLogin.dart' as Lawyer;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const NyayaSahayakApp());
}

class NyayaSahayakApp extends StatelessWidget {
  const NyayaSahayakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NYAYA SAHAYAK',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: const NyayaSahayakScreen(),
    );
  }
}

class NyayaSahayakScreen extends StatefulWidget {
  const NyayaSahayakScreen({super.key});

  @override
  _NyayaSahayakScreenState createState() => _NyayaSahayakScreenState();
}

class _NyayaSahayakScreenState extends State<NyayaSahayakScreen> {
  String? selectedRole = 'Common People';
  List<String> roles = ['Common People', 'Lawyer', 'Jailer'];
  String locationMessage = '';
  int latitude = 0;
  int longitude = 0;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.whileInUse) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          locationMessage =
              'Latitud: ${position.latitude}, Longitude: ${position.longitude}';
          latitude = (position.latitude).toInt();
          longitude = (position.longitude).toInt();
          print(latitude);
          print(longitude);
        });
      } catch (e) {
        print('Error getting location: $e');
        setState(() {
          locationMessage = 'Unable to fetch location';
        });
      }
    } else {
      setState(() {
        locationMessage = 'Location permission denied';
      });
    }
  }

  void _handleRoleChange(String? newValue) {
    setState(() {
      selectedRole = newValue;
    });

    if (newValue == 'Common People') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CommonPeople.CommonPeopleLoginPage()),
      );
    } else if (newValue == 'Lawyer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Lawyer.LawyerLoginPage()),
      );
    } else if (newValue == 'Jailer') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Jailer.JailerLoginApp()),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('NYAYA SAHAYAK'),
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromARGB(184, 21, 1, 44),
    ),
    body: Stack(
      children: <Widget>[
        // Background image
        Image.asset(
          'assets/bg_image01.png', // Replace with your image path
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Select Your Role:',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
               
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedRole,
                  onChanged: _handleRoleChange,
                  items: roles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 25),
                      ),
                    );
                  }).toList(),
                  style: const TextStyle(fontSize: 25, color: Colors.blue),
                  elevation: 3,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 32,
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}




}
