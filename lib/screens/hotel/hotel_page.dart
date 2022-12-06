import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Hotels'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Hotel 1',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/hotelRoom1');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: AssetImage('assets/images/hotel/hotelRoom.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width * 0.9,
                height: height * 0.2,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Hotel 2',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/HotelRoom2');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: AssetImage('assets/images/hotel/hotelRoom.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width * 0.9,
                height: height * 0.2,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Hotel 3',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/HotelRoom2');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: AssetImage('assets/images/hotel/hotelRoom.png'),
                    fit: BoxFit.cover,
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
