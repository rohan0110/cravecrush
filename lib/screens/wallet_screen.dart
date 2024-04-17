import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int numCigarettes = 0;
  double pricePerCigarette = 0.0;
  late String uid; // Variable to store the user's UID

  // Function to retrieve user data from Firestore
  void _getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          numCigarettes = snapshot.data()?['num_cigarettes'];
          pricePerCigarette = snapshot.data()?['price_per_cigarette'];
        });
      }
    }).catchError((error) {
      print('Failed to fetch user data: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser(); // Call method to get current user's UID
  }

  // Method to get the current user's UID
  void _getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
      _getUserData(); // Fetch user data once the UID is obtained
    }
  }

  @override
  Widget build(BuildContext context) {
    double dailySaving = numCigarettes * pricePerCigarette; // Assuming user's savings per cigarette

    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet,
              size: 100.0,
              color: Colors.green,
            ),
            SizedBox(height: 20.0),
            Text(
              'Daily Savings',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              '\$$dailySaving', // Display daily savings
              style: TextStyle(fontSize: 36.0, color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
