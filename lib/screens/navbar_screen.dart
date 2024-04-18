import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cravecrush/screens/user_profile_screen.dart';

import 'callender_screen.dart'; // Import ProfilePage


class NavBar extends StatelessWidget {
  const NavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Rohan Gunge"),
            accountEmail: Text("gungerohan@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('images/download.jpeg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () async {
              // Get current user's UID
              String? uid = FirebaseAuth.instance.currentUser?.uid;
              if (uid != null) {
                // Navigate to profile screen and pass UID
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(uid: uid)),
                );
              } else {
                // Handle if user is not authenticated
                print('User is not authenticated');
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
            onTap: () => print('Message tapped'),
          ),
          ListTile(
            leading: Icon(Icons.line_axis),
            title: Text('Stats'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => print('share tapped'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () => print('notification tapped'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => print('Logout tapped'),
          ),
        ],
      ),
    );
  }
}
