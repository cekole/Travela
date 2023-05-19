import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
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
                labelText: 'Search',
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
                          return AnswerCard(
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
                            return AnswerCard(
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

class _AnswerCardState extends State<AnswerCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onSelect(widget.destination);
        });
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        ),
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
      ),
    );
  }
}
