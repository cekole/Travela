import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/widgets/transportation_card.dart';

class TransportationOptionsPage extends StatelessWidget {
  const TransportationOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Transportation Options'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          TransportationCard(
              title: 'Plane', imageUrl: 'assets/images/plane.png'),
          const SizedBox(height: 16),
          TransportationCard(title: 'Bus', imageUrl: 'assets/images/bus.png'),
          const SizedBox(height: 16),
          TransportationCard(
              title: 'Train', imageUrl: 'assets/images/train.png'),
        ],
      ),
    );
  }
}
