import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/providers/activities_provider.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({
    super.key,
    required this.destination,
    required this.image,
  });

  final String destination;
  final String image;
  @override
  Widget build(BuildContext context) {
    final destinationsData =
        Provider.of<DestinationsProvider>(context, listen: false);
    final selectedDestination = destinationsData.destinations
        .firstWhere((element) => element.imageUrl == image);
    final activitiesData =
        Provider.of<ActivitiesProvider>(context, listen: false);
    final selectedActivities =
        activitiesData.getActivitiesByDestinationId(selectedDestination.id);
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                //like button
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                destination,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                selectedDestination.description,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            //Suggested Activities
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Suggested Activities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedActivities.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  selectedActivities[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            selectedActivities[index].name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
