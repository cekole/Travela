import 'dart:io';
import 'dart:typed_data';

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
import 'package:travela_mobile/providers/file_storage_provider.dart';
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
  String placeholderImage =
      'assets/images/profile/anonymous-avatar-icon-25.jpg.png';
  String imageUrl = ''; // The URL of the actual image

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
    final fileStorageData = Provider.of<FileStorageProvider>(context);
    final pic = fileStorageData.fetchProfilePic(userId);
    imageUrl = pic.toString();

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
                      Expanded(
                        child: FutureBuilder<Uint8List>(
                          future: fileStorageData.fetchProfilePic(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Image.asset(
                                  placeholderImage,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else if (snapshot.hasData) {
                              final profilePic = snapshot.data!;
                              return CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child:
                                    Image.memory(profilePic, fit: BoxFit.cover),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                                child: Image.asset(
                                  placeholderImage,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userUsername,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            userEmail,
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
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
                      //convert currentAvailableFrom to a date
                      title: Text(
                          'Start Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(currentAvailableFrom))}'),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.date_range,
                      ),
                      title: Text(
                          'End Date:   ${DateFormat('dd-MM-yyyy').format(DateTime.parse(currentAvailableTo))}'),
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
                                userData
                                    .setAvailableTo(
                                  userId,
                                  DateFormat('yyyy-MM-dd').format(rangeEndDate),
                                )
                                    .then((value) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Platform.isIOS
                                        ? CupertinoAlertDialog(
                                            title: Text('Success'),
                                            content: Text(
                                                'Your available dates have been updated'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          '/home',
                                                          (route) => false);
                                                  pageNum = 4;
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          )
                                        : AlertDialog(
                                            title: Text('Success'),
                                            content: Text(
                                                'Your available dates have been updated'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          '/home',
                                                          (route) => false);
                                                  pageNum = 4;
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                  );
                                });
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
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text('Invite Members'),
                          content: CupertinoTextField(
                            placeholder: 'Enter username',
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: CupertinoColors.systemGrey),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            CupertinoDialogAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Send Invite'),
                            ),
                          ],
                        );
                      },
                    );
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
