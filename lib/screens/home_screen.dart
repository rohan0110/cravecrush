import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:cravecrush/models/timeline_date.dart';
import 'package:cravecrush/screens/guide_screen.dart';
import 'package:cravecrush/screens/login_screen.dart';
import 'package:cravecrush/screens/navbar_screen.dart';
import 'package:cravecrush/screens/wallet_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'timeline_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<TimelineDay> daysList; // Removed const keyword
  final TextEditingController _entryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    daysList = getDummyTimelineDays(); // Initialize daysList in initState
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to your login page
    );
  }

  void _navigateToGuidePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewsHomePage()),
    );
  }

  void _navigateToWalletPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WalletPage()),
    );
  }

  void _navigateToHealthPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TimelinePage(daysList: daysList)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text(
          'Quit Smoke',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dashboard Container
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF43291F),
                borderRadius: BorderRadius.circular(0.0),
              ),
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.all(20.0),
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CraveCrush',
                      textAlign: TextAlign.center,
                    ),
                    // Image Widget
                    // Wrap Image.asset with Transform to move it upwards
                    Transform.translate(
                      offset: const Offset(0, -45), // Adjust the vertical offset to shift the image upwards
                      child: Image.asset(
                        'assets/images/homepage.png', // Replace with your image path
                        width: 400, // Set image width
                        height: 200, // Set image height
                        fit: BoxFit.contain, // Adjust how the image fits inside the container
                      ),
                    ),
                    // Display Smoke-Free Hours
                    FutureBuilder<int>(
                      future: _fetchSmokeFreeHours(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Display a loading indicator while fetching data
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}'); // Display an error message if fetching data fails
                        } else {
                          int smokeFreeHours = snapshot.data ?? 0; // Get the smoke-free hours from the snapshot
                          return Text('Smoke-Free Hours: $smokeFreeHours'); // Display the smoke-free hours in your UI
                        }
                      },
                    ),
                    // Button to Reset Timer
                    ElevatedButton(
                      onPressed: () {
                        _showSmokeEntryDialog(context);
                      },
                      child: const Text('Smoked a Cigarette'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Row for Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 110, // Set the width of the button
                  height: 100, // Set the height of the button
                  child: _buildIconButton('Wallet', Icons.account_balance_wallet),
                ),
                SizedBox(
                  width: 110, // Set the width of the button
                  height: 100, // Set the height of the button
                  child: _buildIconButton('Health Progress', Icons.favorite),
                ),
                SizedBox(
                  width: 110, // Set the width of the button
                  height: 100, // Set the height of the button
                  child: _buildIconButton('Guide', Icons.book),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Emergency Support Button
            _buildEmergencySupportButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(String label, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        if (label == 'Guide') {
          _navigateToGuidePage(); // Navigate to the guide page
        } else if (label == 'Wallet') {
          _navigateToWalletPage(); // Navigate to the wallet page
        } else if (label == 'Health Progress') {
          _navigateToHealthPage(); // Navigate to the health page
        } else {
          // Perform action when other buttons are pressed
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10), // Adjust padding as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26, // Set icon size
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16, // Set text size
            ),
          ),
        ],
      ),
    );
  }

  // Function to Build Emergency Support Button
  Widget _buildEmergencySupportButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20), // Adjust top margin to move button below
      child: ElevatedButton(
        onPressed: () {
          // Perform action when emergency support button is pressed
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(30), // Adjust button size here
          shape: const CircleBorder(),
          backgroundColor: Colors.red, // Set button background color
        ),
        child: const Icon(
          Icons.warning,
          color: Colors.white, // Set icon color
          size: 40, // Set icon size
        ),
      ),
    );
  }

  void _showSmokeEntryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Smoking Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                _submitSmokeEntry('Yes');
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Your entry for today has been submitted.'),
                  ),
                );
              },
              child: Text('Yes'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                _submitSmokeEntry('No');
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Your entry for today has been submitted.'),
                  ),
                );
              },
              child: Text('No'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitSmokeEntry(String smokingStatus) async {
    // Get the current user's UID
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      // Get the current date
      DateTime now = DateTime.now();
      String formattedDate = '${now.year}-${now.month}-${now.day}';

      try {
        // Set the entry in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('entries')
            .doc(formattedDate)
            .set({
          'status': smokingStatus,
        });
        print('Entry added successfully');
      } catch (e) {
        print('Error adding entry: $e');
      }
    } else {
      print('User is not logged in');
    }
  }

  Future<int> _fetchSmokeFreeHours() async {
    // Get the current user's UID
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      try {
        // Fetch all entries for the current user
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('entries')
            .get();

        // Calculate smoke-free hours
        int smokeFreeHours = 0;
        snapshot.docs.forEach((doc) {
          if (doc.exists) {
            Map<String, dynamic> data = doc.data();
            if (data['status'] == 'No') {
              smokeFreeHours += 24; // Assuming each entry represents 24 hours of being smoke-free
            }
          }
        });

        return smokeFreeHours;
      } catch (e) {
        print('Error fetching smoke-free hours: $e');
        return 0;
      }
    } else {
      print('User is not logged in');
      return 0;
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }
}
