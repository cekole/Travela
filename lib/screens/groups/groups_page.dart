import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/screens/trips/trips_page.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/widgets/home/popular_places.dart';
import 'package:travela_mobile/widgets/home/suggestions.dart';
import 'package:travela_mobile/widgets/custom_drawer.dart';

class GroupsPage extends StatefulWidget {
  static const String routeName = '/groups';

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  DateTime _currentStartDate = DateTime.now();
  DateTime _currentEndDate = DateTime.now().add(const Duration(days: 365));

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
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            formGroup(context);
          },
          label: Text('Form Group')),
      appBar: AppBar(
        title: Text('Groups'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  height: 10,
                  thickness: 2,
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    shrinkWrap: true,
                    itemCount: Provider.of<TravelGroupProvider>(context)
                        .travelGroups
                        .length,
                    itemBuilder: (context, index) {
                      final travelGroup =
                          Provider.of<TravelGroupProvider>(context)
                              .travelGroups[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                        ),
                        child: ExpansionTileCard(
                          baseColor: Theme.of(context)
                              .backgroundColor
                              .withOpacity(0.2),
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/edit_travel_group',
                                  arguments: travelGroup,
                                );
                              },
                            ),
                          ),
                          title: Text(travelGroup.name),
                          subtitle: Text(
                            travelGroup.destinations
                                .map((destination) =>
                                    '${destination.city}, ${destination.country}')
                                .join(' | '),
                            overflow: TextOverflow.ellipsis,
                          ),
                          children: [
                            Builder(
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...travelGroup.participants
                                          .map(
                                            (member) => ListTile(
                                              title: Text(member.name),
                                              subtitle: Text(
                                                  '${member.country.countryName}'),
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  margin: EdgeInsets.all(10),
                  child: ExpansionTileCard(
                    borderRadius: BorderRadius.circular(10),
                    baseColor:
                        Theme.of(context).backgroundColor.withOpacity(0.2),
                    title: const Text('Select Date'),
                    children: [
                      SfDateRangePicker(
                        enablePastDates: false,
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: PickerDateRange(
                          _currentStartDate,
                          _currentEndDate,
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
    );
  }
}

void formGroup(BuildContext context) {
  final TextEditingController textController = TextEditingController();
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Form Travel Group',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                String groupName = textController.text;
                showAddFriendDialog(context);
              },
              child: Text('Add Friends'),
            ),
          ],
        ),
      ),
    ),
  );
}

void showAddFriendDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Invite Members'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                title: Text('Friends'),
                children: [
                  Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: ListView(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                          ),
                          title: Text('Yağmur Eryılmaz'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                          ),
                          title: Text('Efe Şaman'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                          ),
                          title: Text('Çağla Ataoğlu'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1616166330073-8e1b5e1b5f1c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                          ),
                          title: Text('Efe Ertürk'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                Navigator.of(context).pop();
              },
              child: Text('Create'),
            ),
          ],
        );
      });
}
