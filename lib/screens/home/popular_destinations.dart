import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/attraction.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/screens/register/questionnaire_page.dart';
import 'package:travela_mobile/widgets/home/place_card.dart';
import 'package:travela_mobile/widgets/home/popular_places.dart';

class PopularDestinations extends StatefulWidget {
  const PopularDestinations({Key? key}) : super(key: key);

  @override
  State<PopularDestinations> createState() => _PopularDestinationsState();
}

class _PopularDestinationsState extends State<PopularDestinations> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final destinationsData =
        Provider.of<DestinationsProvider>(context, listen: false);
    destinationsData.fetchAndSetCities();
  }

  @override
  Widget build(BuildContext context) {
    final destinationsData =
        Provider.of<DestinationsProvider>(context, listen: false);
    final destinations =
        ModalRoute.of(context)!.settings.arguments as Set<List<Destination>>;
    print(destinations.length);
    //get the list of destinations from the arguments
    final List<Destination> destinationList = destinations.toList()[0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Destinations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {}); // Trigger UI update when search text changes
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder(
                future: Future.wait(
                  [
                    Provider.of<DestinationsProvider>(context, listen: false)
                        .fetchAndSetCities(),
                  ],
                ).then(
                  (value) => Future.delayed(Duration(seconds: 1)),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.separated(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return AnswerCardHome(
                            destination:
                                destinationsData.popularDestinationsList[index],
                            onSelect: (destination) {},
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                      ),
                    );
                  } else {
                    return Consumer<DestinationsProvider>(
                      builder: (context, destinationsData, child) {
                        List<Destination> destinations =
                            destinationsData.destinations;
                        if (_searchController.text.isNotEmpty) {
                          destinations = destinations.where((destination) {
                            return destination.city
                                .toLowerCase()
                                .contains(_searchController.text);
                          }).toList();
                        }
                        return ListView.separated(
                          itemCount: destinationsData.destinations.length,
                          itemBuilder: (context, index) {
                            final filteredDestinations = destinationsData
                                .destinations
                                .where((destination) =>
                                    destination.city.toLowerCase().contains(
                                          _searchController.text.toLowerCase(),
                                        ))
                                .toList();
                            if (index >= filteredDestinations.length) {
                              //if none show a placeholder
                              if (filteredDestinations.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No destinations found',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                );
                              }
                              return SizedBox.shrink();
                            }
                            return AnswerCardHome(
                              destination: filteredDestinations[index],
                              onSelect: (destination) {},
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerCardHome extends StatefulWidget {
  const AnswerCardHome({
    super.key,
    required this.destination,
    required this.onSelect,
  });

  final Destination destination;
  final Function(Destination) onSelect;

  @override
  State<AnswerCardHome> createState() => _AnswerCardHomeState();
}

class _AnswerCardHomeState extends State<AnswerCardHome> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //open bottom sheet
        placeCardBottomSheet(
          context,
          Provider.of<UserProvider>(context, listen: false),
          widget.destination,
          widget.destination.activities,
        );
        final attractionData =
            Provider.of<DestinationsProvider>(context, listen: false);
      },
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.destination.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        height: 150,
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
                  '${widget.destination.city}, ${widget.destination.country}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> placeCardBottomSheet(
      BuildContext context,
      UserProvider userData,
      Destination selectedDestination,
      List<String> selectedAttractions) {
    final attractionData =
        Provider.of<DestinationsProvider>(context, listen: false);
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
                        image: NetworkImage(selectedDestination.imageUrl),
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
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
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
                              image: selectedAttractions[index].imageUrl == null
                                  ? const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/placeholder.png'),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image: NetworkImage(
                                          selectedAttractions[index].imageUrl),
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

              SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
