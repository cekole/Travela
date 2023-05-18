import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/providers/authentication_provider.dart';
import 'package:travela_mobile/providers/group_provider.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/screens/trips/trips_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime _currentStartDate = DateTime.now();
  DateTime _currentEndDate = DateTime.now().add(const Duration(days: 7));

  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();
  DateTime rangeStartDate = DateTime.now();
  DateTime rangeEndDate = DateTime.now().add(const Duration(days: 7));

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    _dateRangePickerController.selectedRange = PickerDateRange(
        args.value.startDate, args.value.endDate ?? args.value.startDate);

    print(args.value);
    if (args.value is PickerDateRange) {
      setState(() {
        rangeStartDate = args.value.startDate;
        rangeEndDate = args.value.endDate;
      });
    } else if (args.value is DateTime) {
      setState(() {
        rangeStartDate = args.value;
        rangeEndDate = args.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: SizedBox(),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            currentUser.email,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/edit_profile');
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            currentFriendIds.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Friends',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            Provider.of<GroupProvider>(
                              context,
                              listen: false,
                            ).groups.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Groups',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Travela',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                ),
                title: Text('Location'),
              ),
              Divider(
                height: 1,
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                ),
                title: Text('Notification'),
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.privacy_tip,
                ),
                title: Text('Privacy'),
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Current Available Dates',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.date_range,
                      ),
                      title: Text('Start Date: ${currentAvailableFrom}'),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.date_range,
                      ),
                      title: Text('End Date: ${currentAvailableTo}'),
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Change Your Available Dates',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(height: 20, thickness: 2),
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
                  baseColor: Theme.of(context).backgroundColor.withOpacity(0.2),
                  title: const Text('Select Date Range'),
                  children: [
                    SfDateRangePicker(
                      controller: _dateRangePickerController,
                      headerStyle: DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                      ),
                      enablePastDates: false,
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: PickerDateRange(
                        DateTime.parse(currentAvailableFrom),
                        DateTime.parse(currentAvailableTo),
                      ),
                      startRangeSelectionColor: Theme.of(context).primaryColor,
                      endRangeSelectionColor: Theme.of(context).primaryColor,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            final userData = Provider.of<UserProvider>(context,
                                listen: false);
                            userData
                                .setAvailableFrom(
                              userId,
                              DateFormat('yyyy-MM-dd').format(rangeStartDate),
                            )
                                .then(
                              (value) {
                                userData.setAvailableTo(
                                  userId,
                                  DateFormat('yyyy-MM-dd').format(rangeEndDate),
                                );
                              },
                            );
                            _currentStartDate = rangeStartDate;
                            _currentEndDate = rangeEndDate;
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void formGroup(BuildContext context) {
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
              ListTile(
                title: Text('Add Members'),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text('Invite Members'),
                            content: ListView(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter username',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
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
                                  Navigator.of(context).pop();
                                },
                                child: Text('Send Invite'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
