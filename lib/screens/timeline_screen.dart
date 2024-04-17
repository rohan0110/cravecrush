import 'package:flutter/material.dart';
import 'package:cravecrush/models/timeline_date.dart';

class TimelinePage extends StatelessWidget {
  final List<TimelineDay> daysList;

  const TimelinePage({Key? key, required this.daysList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(0, 18, 6, 255),
        elevation: 0, // Remove app bar shadow
      ),
      extendBodyBehindAppBar: true, // Extend background behind app bar
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 254, 62, 29), // Deep purple
              Color.fromARGB(255, 87, 62, 227), // Vibrant pink
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 0.8],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: kToolbarHeight), // Match app bar height
              Expanded(
                child: ListView.builder(
                  itemCount: daysList.length,
                  itemBuilder: (context, index) {
                    final day = daysList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // Changed to white background for all cards
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: day.completed ? Color.fromARGB(255, 3, 252, 11) : Color.fromARGB(255, 78, 253, 213),
                          child: Icon(
                            day.completed ? Icons.check : Icons.circle,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          '${day.dayNumber}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: day.completed ? Color.fromARGB(255, 169, 0, 253) :  Color.fromARGB(255, 244, 129, 42),
                          ),
                        ),
                        subtitle: Text(
                          day.changes,
                          style: TextStyle(color: Color.fromARGB(167, 0, 0, 0)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}