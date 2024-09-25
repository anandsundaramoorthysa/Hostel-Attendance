import 'package:flutter/material.dart';

class GirlsHostelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Girls Hostel'),
        backgroundColor: Colors.teal.shade800, // Consistent AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select Room',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 20),
            // Room numbers A1 to A10
            Expanded(
              child: ListView(
                children: List.generate(10, (index) {
                  final roomNumber = 'A${index + 1}';
                  return _buildRoomButton(context, roomNumber);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomButton(BuildContext context, String roomName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to Room Details Page
          Navigator.pushNamed(context, '/roomDetails', arguments: roomName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent.shade700, // Matching color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          roomName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
