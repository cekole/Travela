import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/widgets/popular_places.dart';
import 'package:travela_mobile/widgets/suggestions.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  RangeValues _currentPriceRangeValues = const RangeValues(40, 80);
  RangeValues _currentRatingRangeValues = const RangeValues(3, 5);
  RangeValues _currentDistanceRangeValues = const RangeValues(0, 1000);
  String _currentSeason = 'Summer';
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Travela',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          pinned: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
          ],
          backgroundColor: Colors.white,
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Where Do You Want To Go?',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        _filterModal(context);
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                Divider(
                  thickness: 0,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: PopularPlaces(),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: SuggestionsForYou(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> _filterModal(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        /* return StatefulBuilder(
          builder: ((context, setState) { */
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
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
                                _currentPriceRangeValues.end.round().toString(),
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
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
                                  activeColor: Theme.of(context).primaryColor,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
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
                      Divider(),
                      Text('More'),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        /*  }),
        ); */
      },
    );
  }
}
