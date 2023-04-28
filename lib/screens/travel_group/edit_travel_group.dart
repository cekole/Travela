import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/recommendation_provider.dart';
import 'package:travela_mobile/widgets/home/suggestions.dart';

class EditTravelGroup extends StatefulWidget {
  const EditTravelGroup({Key? key}) : super(key: key);

  @override
  State<EditTravelGroup> createState() => _EditTravelGroupState();
}

class _EditTravelGroupState extends State<EditTravelGroup> {
  TextEditingController _searchController = TextEditingController();
  RangeValues _currentPriceRangeValues = const RangeValues(40, 80);
  RangeValues _currentRatingRangeValues = const RangeValues(3, 5);
  RangeValues _currentDistanceRangeValues = const RangeValues(0, 1000);
  String _currentSeason = 'Summer';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final travelGroup =
        ModalRoute.of(context)!.settings.arguments as TravelGroup;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(travelGroup.name),
        actions: [],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Container(height: 0),
              Container(
                margin: EdgeInsets.all(8.0),
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Chat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                ),
                              ),
                              Bubble(
                                nip: BubbleNip.leftBottom,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      travelGroup.participants[0].name,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      'Hello',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Bubble(
                                nip: BubbleNip.rightBottom,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      travelGroup.participants[1].name,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      'Hi',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //send message textfield
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 15,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SuggestionsForYou(),
              Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.grey.shade700,
                  indent: 35,
                  endIndent: 35,
                  thickness: 1,
                )),
                Text("OR"),
                Expanded(
                    child: Divider(
                  color: Colors.grey.shade700,
                  indent: 35,
                  endIndent: 35,
                  thickness: 1,
                )),
              ]),

              ElevatedButton(
                onPressed: () {
                  searchDialog(context);
                },
                child: Text('Arrange Trip'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Create Poll'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Show Common Dates'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> searchDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Dialog.fullscreen(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter a place name',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {},
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text('Price Range'),
                              Expanded(
                                child: RangeSlider(
                                  activeColor: Theme.of(context).primaryColor,
                                  values: _currentPriceRangeValues,
                                  max: 100,
                                  labels: RangeLabels(
                                    _currentPriceRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentPriceRangeValues.end
                                        .round()
                                        .toString(),
                                  ),
                                  onChanged: (values) {
                                    setState(() {
                                      _currentPriceRangeValues = values;
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentPriceRangeValues.start
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Min'),
                                    ],
                                  ),
                                  VerticalDivider(),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentPriceRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Max'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text('Rating (0-5)'),
                              Expanded(
                                child: Row(
                                  children: [
                                    RangeSlider(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      values: _currentRatingRangeValues,
                                      max: 5,
                                      labels: RangeLabels(
                                        _currentRatingRangeValues.start
                                            .round()
                                            .toString(),
                                        _currentRatingRangeValues.end
                                            .round()
                                            .toString(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _currentRatingRangeValues = value;
                                        });
                                      },
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                _currentRatingRangeValues.start
                                                    .round()
                                                    .toString(),
                                              ),
                                            ),
                                            Text('Min'),
                                          ],
                                        ),
                                        VerticalDivider(),
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                _currentRatingRangeValues.end
                                                    .round()
                                                    .toString(),
                                              ),
                                            ),
                                            Text('Max'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text('Distance(km)'),
                              Expanded(
                                child: RangeSlider(
                                  activeColor: Theme.of(context).primaryColor,
                                  values: _currentDistanceRangeValues,
                                  max: 1000,
                                  labels: RangeLabels(
                                    _currentDistanceRangeValues.start
                                        .round()
                                        .toString(),
                                    _currentDistanceRangeValues.end
                                        .round()
                                        .toString(),
                                  ),
                                  onChanged: (values) {
                                    setState(() {
                                      _currentDistanceRangeValues = values;
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentDistanceRangeValues.start
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Min'),
                                    ],
                                  ),
                                  VerticalDivider(),
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          _currentDistanceRangeValues.end
                                              .round()
                                              .toString(),
                                        ),
                                      ),
                                      Text('Max'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text('Season'),
                              Spacer(),
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return DropdownButton(
                                    value: _currentSeason,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('Winter'),
                                        value: 'Winter',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Summer'),
                                        value: 'Summer',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Spring'),
                                        value: 'Spring',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Autumn'),
                                        value: 'Autumn',
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _currentSeason = value.toString();
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Apply'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/destination_list');
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> gridClick(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 20),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.place_sharp),
                title: Text('Previously Visited Places'),
                onTap: () {
                  final recommendationData =
                      Provider.of<RecommendationProvider>(context,
                          listen: false);
                  recommendationData.getToken();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add Places'),
                          content: Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter places by comma',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onSubmitted: (value) {
                                  recommendationData.setPreviousCities(value);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your current location',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onSubmitted: (value) {
                                  recommendationData.setNation(value);
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Recommendaed header
                              Text(
                                'Recommended',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                height: 200,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: recommendationData
                                      .enteredLocations.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        recommendationData
                                            .enteredLocations[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                recommendationData.fetchAndSetRecommendations(
                                    recommendationData.previousCities,
                                    recommendationData.nation);
                                if (recommendationData
                                        .enteredLocations.length <=
                                    0) {
                                  //Progress indicator
                                  CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.black);
                                }
                              },
                              child: Text('Add'),
                            ),
                            //ListView.builder for showing places
                          ],
                        );
                      });
                },
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}
