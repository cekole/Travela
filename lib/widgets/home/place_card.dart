import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/activities_provider.dart';
import 'package:travela_mobile/providers/trip_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/screens/home/home_page.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    Key? key,
    required this.destination,
    required this.image,
    required this.isArranged,
  }) : super(key: key);

  final String destination;
  final String image;
  final bool? isArranged;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        final destinationsData =
            Provider.of<DestinationsProvider>(context, listen: false);
        final selectedDestination = destinationsData.destinations
            .firstWhere((element) => element.imageUrl == widget.image);
        final activitiesData =
            Provider.of<ActivitiesProvider>(context, listen: false);
        print(selectedDestination.activities);
        final selectedActivities = selectedDestination.activities;

        placeCardBottomSheet(
            context, userData, selectedDestination, selectedActivities);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8),
              width: MediaQuery.of(context).size.width * 0.35,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.destination.split(', ')[0],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (widget.destination.split(', ')[1] ==
                        "United States of America")
                    ? "USA"
                    : widget.destination.split(', ')[1],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> placeCardBottomSheet(
      BuildContext context,
      UserProvider userData,
      Destination selectedDestination,
      List<String> selectedActivities) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
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
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Color.fromARGB(255, 10, 9, 9)),
                      onPressed: () async {
                        toggleFavorite();
                        try {
                          bool success = await userData.addFavouriteCity(
                              userId, selectedDestination.id);
                          if (success) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: Text('Added to Favourites'),
                                // OK BUTTON
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () {
                                      //navigate to home page
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // Handle the case when the method returns false
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                      title: Text('Already added'),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ));
                          }
                        } catch (error) {
                          // Handle any errors that occurred during the addFavouriteCity operation
                          print('Error: $error');
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  selectedDestination.city,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              selectedActivities[index],
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

              widget.isArranged!
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          final tripData =
                              Provider.of<TripProvider>(context, listen: false);
                          tripData
                              .addTrip(
                            's',
                            '',
                            int.parse(currentGroupIdForSuggestions),
                          )
                              .then((value) {
                            //get the trip id
                            tripData.addLocation(
                              value,
                              int.parse(selectedDestination.id),
                            );
                          });
                          Navigator.of(context).pushNamed('/search_options',
                              arguments: widget.destination);
                        },
                        child: Text('Add to Trip'),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
