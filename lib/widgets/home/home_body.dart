import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travela_mobile/widgets/home/popular_places.dart';
import 'package:travela_mobile/widgets/home/suggestions.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  RangeValues _currentPriceRangeValues = const RangeValues(40, 80);
  RangeValues _currentRatingRangeValues = const RangeValues(3, 5);
  RangeValues _currentDistanceRangeValues = const RangeValues(0, 1000);
  DateTime _currentStartDate = DateTime.now();
  DateTime _currentEndDate = DateTime.now().add(const Duration(days: 365));
  String _currentSeason = 'Summer';
  TextEditingController _searchController = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final DateTime rangeStartDate = args.value.startDate;
      final DateTime rangeEndDate = args.value.endDate;
    } else if (args.value is DateTime) {
      final DateTime selectedDate = args.value;
    } else if (args.value is List<DateTime>) {
      final List<DateTime> selectedDates = args.value;
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
    }
  }

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
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextField(
                    onTap: () {
                      showDialog(
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
                                  onSubmitted: (value) {
                                    Navigator.of(context)
                                        .pushNamed('/search_options');
                                  },
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
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    values:
                                                        _currentPriceRangeValues,
                                                    max: 100,
                                                    labels: RangeLabels(
                                                      _currentPriceRangeValues
                                                          .start
                                                          .round()
                                                          .toString(),
                                                      _currentPriceRangeValues
                                                          .end
                                                          .round()
                                                          .toString(),
                                                    ),
                                                    onChanged: (values) {
                                                      setState(() {
                                                        _currentPriceRangeValues =
                                                            values;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Text(
                                                            _currentPriceRangeValues
                                                                .start
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
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Text(
                                                            _currentPriceRangeValues
                                                                .end
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
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        values:
                                                            _currentRatingRangeValues,
                                                        max: 5,
                                                        labels: RangeLabels(
                                                          _currentRatingRangeValues
                                                              .start
                                                              .round()
                                                              .toString(),
                                                          _currentRatingRangeValues
                                                              .end
                                                              .round()
                                                              .toString(),
                                                        ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _currentRatingRangeValues =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                child: Text(
                                                                  _currentRatingRangeValues
                                                                      .start
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
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                child: Text(
                                                                  _currentRatingRangeValues
                                                                      .end
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
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    values:
                                                        _currentDistanceRangeValues,
                                                    max: 1000,
                                                    labels: RangeLabels(
                                                      _currentDistanceRangeValues
                                                          .start
                                                          .round()
                                                          .toString(),
                                                      _currentDistanceRangeValues
                                                          .end
                                                          .round()
                                                          .toString(),
                                                    ),
                                                    onChanged: (values) {
                                                      setState(() {
                                                        _currentDistanceRangeValues =
                                                            values;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Text(
                                                            _currentDistanceRangeValues
                                                                .start
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
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Text(
                                                            _currentDistanceRangeValues
                                                                .end
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
                                                          _currentSeason =
                                                              value.toString();
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
                                ExpansionTileCard(
                                  borderRadius: BorderRadius.circular(10),
                                  baseColor: Colors.grey[200],
                                  expandedColor: Colors.grey[200],
                                  title: const Text('Select Date'),
                                  children: [
                                    SfDateRangePicker(
                                      enablePastDates: false,
                                      onSelectionChanged: _onSelectionChanged,
                                      selectionMode:
                                          DateRangePickerSelectionMode.range,
                                      initialSelectedRange: PickerDateRange(
                                        _currentStartDate,
                                        _currentEndDate,
                                      ),
                                    ),
                                  ],
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
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/destination_list');
                                  },
                                  child: Text('Search'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    controller:
                        _searchController, // TODO: Implement search functionality
                    decoration: InputDecoration(
                      hintText: 'Where Do You Want To Go?',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      /* suffixIcon: IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () {
                          _filterModal(context);
                        },
                      ), */
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
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
}
