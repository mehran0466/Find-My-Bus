import 'package:find_my_bus/screens/ContactUsScreen.dart';
import 'package:find_my_bus/screens/LoginScreen.dart';
import 'package:find_my_bus/screens/UserProfileScreen.dart';
import 'package:find_my_bus/screens/changeLanguageScreen.dart';
import 'package:find_my_bus/screens/driverScreens/ReportIssueScreen.dart';
import 'package:find_my_bus/screens/passangerScreens/EmergencyNumbers.dart';
import 'package:find_my_bus/screens/passangerScreens/RoutesListScreen.dart';
import 'package:flutter/material.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  final List<Map<String, dynamic>> routes = [
    {
      'routeNumber': 'Route 1',
      'stops': ['Stop 1', 'Stop 2', 'Stop 3']
    },
    {
      'routeNumber': 'Route 2',
      'stops': ['Stop A', 'Stop B', 'Stop C']
    },
    {
      'routeNumber': 'Route 3',
      'stops': ['Stop X', 'Stop Y', 'Stop Z']
    },
  ];

  String? selectedRoute;
  String? busId;
  bool journeyStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Driver Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.red.shade600,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red.shade600,
              ),
              accountName: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                                name: 'Driver Name',
                                email: 'driver@example.com',
                                imagePath: 'assets/images/logo_image.jpg',
                              )));
                },
                child: const Text(
                  'Driver Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              accountEmail: const Text('View Profile'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo_image.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.directions_bus, color: Colors.yellow),
              title: const Text('Routes List'),
              subtitle: const Text('All the routes we offer'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Routeslistscreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: const Text('Change Language'),
              subtitle: const Text('Change language preferences'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeLanguageScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.share,
                  color: Color.fromARGB(255, 54, 244, 241)),
              title: const Text('Share Your Location'),
              subtitle: const Text(
                  'Share your live location with your friends & family'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support, color: Colors.purple),
              title: const Text('Connect us'),
              subtitle: const Text('Your words mean a lot to us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUsScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem, color: Colors.orange),
              title: const Text('Report an Issue'),
              subtitle:
                  const Text('Tell us about any problems you encountered'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportIssueScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.call, color: Colors.red),
              title: const Text('Call Emergency'),
              subtitle: const Text('Contact emergency services immediately'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmergencyContactsScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.orange),
              title: const Text('Logout'),
              subtitle: const Text('Sign out of your account'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (!journeyStarted) {
                  _showStartJourneyDialog();
                } else {
                  setState(() {
                    journeyStarted = false;
                  });
                }
              },
              backgroundColor: Colors.red.shade600,
              child: Icon(
                journeyStarted ? Icons.stop : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStartJourneyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Start Journey'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Route'),
                value: selectedRoute,
                onChanged: (String? newRoute) {
                  setState(() {
                    selectedRoute = newRoute;
                  });
                },
                items: routes
                    .map((route) => DropdownMenuItem<String>(
                          value: route['routeNumber'],
                          child: Text(route['routeNumber']),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: const InputDecoration(labelText: 'Bus ID'),
                onChanged: (value) {
                  setState(() {
                    busId = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (selectedRoute != null && busId != null) {
                  setState(() {
                    journeyStarted = true;
                  });
                }
              },
              child: const Text('Start Journey'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
