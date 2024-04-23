import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late String uid;
  double pricePerCigarette = 0.0;
  late int numCigarettes;
  late int smokingDays;
  late int nonSmokingDays;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
      });
      _fetchUserData();
    }
  }

  void _fetchUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (snapshot.exists) {
        setState(() {
          numCigarettes = snapshot.data()?['num_cigarettes'] ?? 0;
          pricePerCigarette = snapshot.data()?['price_per_cigarette'] ?? 0.0;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    _fetchSmokingDays();
  }

  void _fetchSmokingDays() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('entries').get();
      setState(() {
        smokingDays = snapshot.docs.where((doc) => doc.data()['status'] == 'Yes').length;
        nonSmokingDays = snapshot.docs.where((doc) => doc.data()['status'] == 'No').length;
      });
    } catch (e) {
      print('Error fetching smoking days: $e');
    }
  }

  double _calculateTotalSavings() {
    return numCigarettes * pricePerCigarette * nonSmokingDays;
  }

  double _calculateDailySavings() {
    return numCigarettes * pricePerCigarette;
  }

  double _calculateTotalSpent() {
    return numCigarettes * pricePerCigarette * smokingDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            _buildInfoCard(
              title: 'Total No of Days',
              value: '${smokingDays + nonSmokingDays}',
              icon: Icons.calendar_today,
              color: Colors.blue,
            ),
            SizedBox(height: 20.0),
            _buildInfoCard(
              title: 'No of Smoking Days',
              value: '$smokingDays',
              icon: Icons.smoking_rooms,
              color: Colors.red,
            ),
            SizedBox(height: 20.0),
            _buildInfoCard(
              title: 'No of Non-Smoking Days',
              value: '$nonSmokingDays',
              icon: Icons.check_circle_outline,
              color: Colors.green,
            ),
            SizedBox(height: 20.0),
            _buildInfoCard(
              title: 'Total Amount Saved',
              value: '\u20B9${_calculateTotalSavings().toStringAsFixed(2)}',
              icon: Icons.attach_money,
              color: Colors.green,
            ),
            SizedBox(height: 20.0),
            _buildInfoCard(
              title: 'Savings Today',
              value: '\u20B9${_calculateDailySavings().toStringAsFixed(2)}',
              icon: Icons.monetization_on,
              color: Colors.green,
            ),
            SizedBox(height: 20.0),
            _buildInfoCard(
              title: 'Total Amount Spent',
              value: '\u20B9${_calculateTotalSpent().toStringAsFixed(2)}',
              icon: Icons.money_off,
              color: Colors.red,
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  title,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
