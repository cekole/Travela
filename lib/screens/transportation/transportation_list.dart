import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/transportation_provider.dart';

class TransportationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            currentTransportations = [];
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
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

          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListTile(
              title: Text(
                'Duration: ${duration.substring(2, 3)} Hours ${duration.substring(5, 6)} Minutes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price: €$price',
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
