import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/destination.dart';
import 'package:travela_mobile/providers/authentication_provider.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';

class QuestionnarePage extends StatefulWidget {
  QuestionnarePage({super.key});

  @override
  State<QuestionnarePage> createState() => _QuestionnarePageState();
}

class _QuestionnarePageState extends State<QuestionnarePage> {
  TextEditingController _searchController = TextEditingController();
  bool isMessageDisplayed = false;
  List<Destination> _selectedDestinations = [];
  @override
  void initState() {
    final authenticationData =
        Provider.of<AuthenticationProvider>(context, listen: false);
    final userData = Provider.of<UserProvider>(context, listen: false);
    final destinatinationsData =
        Provider.of<DestinationsProvider>(context, listen: false);
    authenticationData.getCurrentUser().then(
      (value) {
        userData.getUserIdByUsername(currentUser.username);
        destinatinationsData.fetchAndSetCities();
      },
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final destinatinationsData =
        Provider.of<DestinationsProvider>(context, listen: false);
    destinatinationsData.fetchAndSetCities();
  }

  @override
  Widget build(BuildContext context) {
    final destinatinationsData = Provider.of<DestinationsProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Welcome to Travela'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: SizedBox(),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(
                        () {}); // Trigger UI update when search text changes
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for a destination',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Choose your top 3 destinations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                        Provider.of<DestinationsProvider>(context,
                                listen: false)
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
                              return AnswerCardQ(
                                destination:
                                    destinatinationsData.destinations[index],
                                onSelect: (destination) {},
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                          ),
                        );
                      } else {
                        return Consumer<DestinationsProvider>(
                          builder: (context, destinationData, child) {
                            List<Destination> destinations =
                                destinationData.destinations;
                            if (_searchController.text.isNotEmpty) {
                              destinations = destinations.where((destination) {
                                return destination.city
                                    .toLowerCase()
                                    .contains(_searchController.text);
                              }).toList();
                            }
                            return ListView.separated(
                              itemCount:
                                  destinatinationsData.destinations.length,
                              itemBuilder: (context, index) {
                                final filteredDestinations =
                                    destinatinationsData.destinations
                                        .where((destination) => destination.city
                                            .toLowerCase()
                                            .contains(
                                              _searchController.text
                                                  .toLowerCase(),
                                            ))
                                        .toList();

                                if (index >= filteredDestinations.length) {
                                  //if none show a placeholder
                                  if (filteredDestinations.isEmpty) {
                                    if (destinations.isEmpty &&
                                        !isMessageDisplayed) {
                                      isMessageDisplayed = true;
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
                                  }
                                  return SizedBox.shrink();
                                }
                                return AnswerCardQ(
                                  destination: filteredDestinations[index],
                                  onSelect: (destination) {
                                    if (_selectedDestinations.length < 3) {
                                      if (_selectedDestinations.any((element) =>
                                          element.city == destination.city)) {
                                        _selectedDestinations.removeWhere(
                                            (element) =>
                                                element.city ==
                                                destination.city);
                                        print('${destination.city} removed');
                                        print(_selectedDestinations.length);
                                      } else {
                                        _selectedDestinations.add(destination);
                                        print('${destination.city} added');
                                      }
                                    } else {
                                      if (_selectedDestinations.any((element) =>
                                          element.city == destination.city)) {
                                        _selectedDestinations.removeWhere(
                                            (element) =>
                                                element.city ==
                                                destination.city);
                                        print('${destination.city} removed');
                                        print(_selectedDestinations.length);
                                      } else {
                                        print(
                                            'Maximum number of destinations selected');
                                      }
                                    }
                                  },
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        label: Text('Submit'),
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          final userData =
                              Provider.of<UserProvider>(context, listen: false);
                          if (_selectedDestinations.length < 3) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Theme.of(context).platform ==
                                        TargetPlatform.iOS
                                    ? CupertinoAlertDialog(
                                        title: Text('Error'),
                                        content: Text(
                                            'Please select at least 3 destinations'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      )
                                    : AlertDialog(
                                        title: Text('Error'),
                                        content: Text(
                                            'Please select 3 destinations'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                              },
                            );
                          } else {
                            for (var destination in _selectedDestinations) {
                              print('user id is ${userId}');
                              print('destination id is ${destination.id}');
                              userData.addVisitedCity(userId, destination.id);
                            }
                            userData.setAvailableFrom(
                              userId,
                              DateTime.now()
                                  .toString()
                                  .split(' ')[0]
                                  .toString(),
                            );

                            userData.setAvailableTo(
                              userId,
                              DateTime.now()
                                  .toString()
                                  .split(' ')[0]
                                  .toString(),
                            );

                            Navigator.pushReplacementNamed(context, '/home');
                            pageNum = 0;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerCardQ extends StatefulWidget {
  const AnswerCardQ({
    super.key,
    required this.destination,
    required this.onSelect,
  });

  final Destination destination;
  final Function(Destination) onSelect;

  @override
  State<AnswerCardQ> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCardQ> {
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
