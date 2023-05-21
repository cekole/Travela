import 'package:bubble/bubble.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/providers/destinations_provider.dart';
import 'package:travela_mobile/providers/group_provider.dart';
import 'package:travela_mobile/providers/recommendation_provider.dart';
import 'package:travela_mobile/screens/groups/groups_page.dart';
import 'package:travela_mobile/widgets/group/suggestionsForGroup.dart';
import 'package:travela_mobile/widgets/home/popular_places.dart';
import 'package:travela_mobile/widgets/home/suggestions.dart';

class EditTravelGroup extends StatefulWidget {
  const EditTravelGroup({Key? key}) : super(key: key);

  @override
  State<EditTravelGroup> createState() => _EditTravelGroupState();
}

class _EditTravelGroupState extends State<EditTravelGroup> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  RangeValues _currentPriceRangeValues = const RangeValues(40, 80);
  RangeValues _currentRatingRangeValues = const RangeValues(3, 5);
  RangeValues _currentDistanceRangeValues = const RangeValues(0, 1000);
  String _currentSeason = 'Summer';

  List currentChatMessages = [];

  @override
  void initState() {
    super.initState();
    final groupData = Provider.of<GroupProvider>(context, listen: false);
    groupData.getTripSuggestions(currentGroupIdForSuggestions);
    groupData.getChat(currentGroupIdForSuggestions).then((messages) {
      setState(() {
        currentChatMessages = messages;
      });
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    final groupData = Provider.of<GroupProvider>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    TextEditingController groupNameController = TextEditingController();
    final travelGroup =
        ModalRoute.of(context)!.settings.arguments as TravelGroup;

    groupData.getDraftTrips(travelGroup.id);
    currentGroupIdForSuggestions = travelGroup.id;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(travelGroup.groupName),
        actions: [
          buildPopUp(context, travelGroup, groupNameController, groupData),
        ],
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
                child: Column(
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
                    //chat messages,
                    //Ex: currentChatMessages = [{senderId: 11, senderName: aaaa, content: a, timestamp: 2023-05-21T12:27:36.030039Z}]
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                          itemCount: currentChatMessages.length,
                          itemBuilder: (context, index) {
                            return Row(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentChatMessages[index]
                                            ['senderName'],
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        currentChatMessages[index]['content'],
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
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
                        controller: _messageController,
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
                      onPressed: () {
                        print(_messageController.text);
                        print(userId);
                        groupData
                            .sendMessage(
                                travelGroup.id, _messageController.text)
                            .then((value) {
                          _messageController.clear();
                          groupData.getChat(travelGroup.id).then((messages) {
                            setState(() {
                              currentChatMessages = messages;
                            });
                          });
                        });
                      },
                      icon: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  searchDialog(context);
                },
                child: Text('Arrange Trip'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    decoration: BoxDecoration(),
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
                                ],
                              ),
                              ExpansionTileCard(
                                baseColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                expandedColor:
                                    Theme.of(context).backgroundColor,
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  child: Icon(Icons.directions_car),
                                ),
                                title: // çağla ekleyecek
                                    Text("buraya çağlaekleyince gelecek"),
                                subtitle: pastTrips.length > 0
                                    ? Text(pastTrips[0].period)
                                    : Text(''),
                                children: [
                                  Divider(
                                    thickness: 1,
                                    height: 1,
                                  ),
                                  ListTile(
                                    title: Text('Locations'),
                                    subtitle: pastTrips.length > 0
                                        ? Text(pastTrips
                                            .map((e) => e.locations)
                                            .join(','))
                                        : Text(''),
                                    leading: Icon(Icons.location_on),
                                  ),
                                  ListTile(
                                    title: Text('Travelers'),
                                    subtitle: Text(
                                        'You, Yağmur Eryılmaz, Efe Şaman, Çağla Ataoğlu, Efe Ertürk'),
                                    leading: Icon(Icons.people),
                                  ),
                                  ListTile(
                                    title: Text('Transportation'),
                                    subtitle: Text(
                                        'Car \n8/20/2021 12:00 PM - 8/24/2021 12:00 PM'),
                                    leading: Icon(Icons.mode_of_travel_sharp),
                                  ),
                                  ListTile(
                                    title: Text('Accomodation'),
                                    subtitle: pastTrips.length > 0
                                        ? Text(pastTrips
                                            .map((e) => e.accomodation)
                                            .join(','))
                                        : Text(''),
                                    leading: Icon(Icons.hotel),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Trip Options')),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> buildPopUp(
      BuildContext context,
      TravelGroup travelGroup,
      TextEditingController groupNameController,
      GroupProvider groupData) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onSelected: (value) {
        if (value == 'create_poll') {
          print(currentChatMessages);
          // Add functionality for create_poll button
        } else if (value == 'show_common_dates') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //close button
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      Text(
                        'Common Dates',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      IgnorePointer(
                        child: SfDateRangePicker(
                          backgroundColor: Colors.white,
                          headerStyle: DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                          ),
                          selectionMode: DateRangePickerSelectionMode.values[2],
                          initialSelectedRange: PickerDateRange(
                            DateTime.parse(travelGroup.commonStartDate),
                            DateTime.parse(travelGroup.commonEndDate),
                          ),
                          startRangeSelectionColor:
                              Theme.of(context).primaryColor,
                          endRangeSelectionColor:
                              Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Start Date: ${DateFormat.yMMMd().format(
                          DateTime.parse(travelGroup.commonStartDate),
                        )}\nEnd Date: ${DateFormat.yMMMd().format(
                          DateTime.parse(travelGroup.commonEndDate),
                        )}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (value == 'add_participants') {
          showAddFriendDialog(context);
        } else if (value == 'update_group_info') {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //close button
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      Text(
                        'Change Group Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      TextField(
                        controller: groupNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter new group name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          groupData.updateGroup(travelGroup.id,
                              groupNameController.text, "no need");
                          Navigator.of(context).pop();
                        },
                        child: Text('Update Group Name'),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (value == 'delete_group') {
          groupData.deleteGroup(travelGroup.id).then((value) {
            if (value) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Group Deleted'),
                    content: Text('Group has been deleted'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupsPage()),
                          );
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Error'),
                    content: Text('Something went wrong'),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            }
          });
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'create_poll',
          child: ListTile(
            leading: Icon(Icons.poll),
            title: Text('Create Poll'),
          ),
        ),
        PopupMenuItem(
          value: 'show_common_dates',
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Show Common Dates'),
          ),
        ),
        PopupMenuItem(
          value: 'add_participants',
          child: ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Add Participants'),
          ),
        ),
        PopupMenuItem(
          value: 'update_group_info',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Update Group Info'),
          ),
        ),
        PopupMenuItem(
          value: 'delete_group',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Group'),
          ),
        ),
      ],
      icon: Icon(Icons.more_vert),
    );
  }

  Future<dynamic> searchDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.all(4.0),
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
                  Navigator.of(context).pushNamed('/destination_list');
                },
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SuggestionsForGroup(
                  isArranged: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopularPlaces(
                  isArranged: true,
                ),
              ),
              //arrange button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    /* Navigator.of(context).pushNamed('/destination_list'); */
                  },
                  child: Text(
                    'Add To Draft',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ),
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

void showAddFriendDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
                pageNum = 2;
              },
              child: Text('OK'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Add Members'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: currentFriendIds.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          currentFriendUsernames[index],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            final groupData = Provider.of<GroupProvider>(
                              context,
                              listen: false,
                            );
                            Navigator.pushReplacementNamed(context, '/groups');
                            groupData.getGroupByUserId(userId).then(
                                  (value) => groupData
                                      .addUserToGroup(
                                    currentGroupId,
                                    currentFriendIds[index].toString(),
                                  )
                                      .then((value) {
                                    if (value) {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoAlertDialog(
                                                title: Text('Success'),
                                                content: Text(
                                                    'Successfully added ${currentFriendUsernames[index]} to group'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('OK'))
                                                ],
                                              ));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CupertinoAlertDialog(
                                                title: Text('Error'),
                                                content: Text(
                                                    'Failed to add ${currentFriendUsernames[index]} to group'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('OK'))
                                                ],
                                              ));
                                    }
                                  }),
                                );

                            /* groupData.addUserToGroup(
                                groupData.groups.last.id, userId); */
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.grey.shade700,
                    indent: 30,
                    endIndent: 30,
                    thickness: 1,
                  )),
                  Text("OR", style: TextStyle(color: Colors.grey.shade700)),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade700,
                      indent: 30,
                      endIndent: 30,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/create_travel_group');
                },
                child: Center(
                  child: Text(
                    'Arrange an Individual Trip',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
