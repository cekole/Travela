import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/transportation_provider.dart';

class TransportationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transportation'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        itemCount: currentTransportations.length,
        itemBuilder: (context, index) {
          final duration = currentTransportations[index][0] as String;
          final price = currentTransportations[index][1] as String;
          final departure = currentTransportations[index][2] as String;
          final arrival = currentTransportations[index][3] as String;

          return Container(
            padding: const EdgeInsets.all(4.0),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Duration: $duration',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price: $price',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Departure: $departure',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Arrival: $arrival',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
