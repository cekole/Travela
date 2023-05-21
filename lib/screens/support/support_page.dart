import 'package:flutter/material.dart';
import 'package:travela_mobile/appConstant.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
            pageNum = 0;
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 16.0),
            Text(
              'If you need any assistance or have any questions, feel free to reach out to us:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('travela@gmail.com'),
              onTap: () {
                // Open email client with pre-filled recipient
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('+90 5674561133'),
              onTap: () {
                // Initiate phone call
              },
            ),
          ],
        ),
      ),
    );
  }
}
