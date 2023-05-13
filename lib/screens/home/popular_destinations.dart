import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';
import 'package:travela_mobile/widgets/home/popular_places.dart';

class PopularDestinations extends StatelessWidget {
  const PopularDestinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final destinations =
        ModalRoute.of(context)!.settings.arguments as Set<List<Destination>>;
    //get the list of destinations from the arguments
    final List<Destination> destinationList = destinations.toList()[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Popular Destinations'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        itemCount: destinationList.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                height: MediaQuery.of(context).size.height * 0.25,
                child: PlaceCard(
                  destination:
                      '${destinationList[index].city}, ${destinationList[index].country}',
                  image: destinationList[index].imageUrl,
                ),
              ),
              Expanded(
                child: Text(
                  destinationList[index].description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
