import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchOptions extends StatelessWidget {
  const SearchOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Search For'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Transportation Options',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/transportation_options');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/transportation/transport.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width * 0.9,
                height: height * 0.2,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Accommodation Options',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/hotel_page');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: AssetImage('assets/images/hotel/accomodation2.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width * 0.9,
                height: height * 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
