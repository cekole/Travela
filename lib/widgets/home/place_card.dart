import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/models/attraction.dart';
import 'package:travela_mobile/providers/activities_provider.dart';
import 'package:travela_mobile/providers/group_provider.dart';
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
  final placeholderImage = AssetImage('assets/images/placeholder.jpg');
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
      onTap: () async {
        final destinationsData =
            Provider.of<DestinationsProvider>(context, listen: false);
        final selectedDestination = destinationsData.destinations
            .firstWhere((element) => element.imageUrl == widget.image);
        final activitiesData =
            Provider.of<ActivitiesProvider>(context, listen: false);

        placeCardBottomSheet(context, userData, selectedDestination);
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
  ) async {
    final attractionData =
        Provider.of<DestinationsProvider>(context, listen: false);
    return showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: SingleChildScrollView(
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
                          setState(() {
                            toggleFavorite();
                          });
                          try {
                            bool success = await userData.addFavouriteCity(
                                userId, selectedDestination.id);
                            if (success) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => Theme.of(
                                                context)
                                            .platform ==
                                        TargetPlatform.iOS
                                    ? CupertinoAlertDialog(
                                        title: Text('Added to Favourites'),
                                        // OK BUTTON
                                        actions: [
                                          CupertinoDialogAction(
                                            child: Text('OK'),
                                            onPressed: () {
                                              //navigate to home page
                                              Navigator.pushReplacementNamed(
                                                  context, '/favorites');
                                            },
                                          ),
                                        ],
                                      )
                                    : AlertDialog(
                                        title: Text('Added to Favourites'),
                                        // OK BUTTON
                                        actions: [
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              //navigate to home page
                                              Navigator.pushReplacementNamed(
                                                  context, '/favorites');
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
                                      Theme.of(context).platform ==
                                              TargetPlatform.iOS
                                          ? CupertinoAlertDialog(
                                              title: Text('Already added'),
                                              actions: [
                                                CupertinoDialogAction(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            )
                                          : AlertDialog(
                                              title: Text('Already added'),
                                              actions: [
                                                TextButton(
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
                  child: FutureBuilder<List<Attraction>>(
                    future: attractionData
                        .getAttractionsByCityId(selectedDestination.id)
                        .then(
                          (value) => Future.delayed(
                              Duration(milliseconds: 500), () => value),
                        ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While data is loading, show shimmer effect
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              5, // Adjust the number of shimmer items as needed
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        // Handle error state
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // When data is available, show the actual ListView
                        final selectedAttractions = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedAttractions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: selectedAttractions[index].imageUrl == ""
                                    ? const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/destinations/placeholder.jpg'),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(
                                            selectedAttractions[index]
                                                .imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        selectedAttractions[index].name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),

                widget.isArranged!
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            final tripData = Provider.of<TripProvider>(context,
                                listen: false);
                            tripData.addLocation(
                              int.parse(currentTripId),
                              int.parse(selectedDestination.id),
                            );
                            Navigator.of(context).pushNamed(
                              '/search_options',
                              arguments: selectedDestination,
                            );
                          },
                          child: Text('Add to Trip'),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
