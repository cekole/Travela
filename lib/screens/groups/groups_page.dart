import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/providers/group_provider.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/screens/friends/friends_page.dart';
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
  bool _isExpandedGroup = false;
  bool _isExpandedCalendar = false;
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    _refreshGroups();
    _getParticipants();
  }

  Future<void> _refreshGroups() async {
    final groupData = Provider.of<GroupProvider>(context, listen: false);
    await groupData.fetchAndSetGroupsByUserId(userId);
  }

  Future<void> _getParticipants() async {
    final groupData = Provider.of<GroupProvider>(context, listen: false);
    for (TravelGroup group in groupData.groups) {
      await groupData.getParticipants(group.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Opacity(
        opacity: _isExpandedCalendar || _isExpandedGroup ? 0.1 : 1,
        child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              formGroup(context);
            },
            label: Text('Form Group')),
      ),
      appBar: AppBar(
        title: Text('Groups'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.people_alt_outlined),
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const FriendsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshGroups,
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              shrinkWrap: true,
              itemCount: Provider.of<GroupProvider>(context).groups.length,
              itemBuilder: (context, index) {
                final travelGroup = Provider.of<GroupProvider>(
                  context,
                ).groups[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  child: ExpansionTileCard(
                    onExpansionChanged: (value) async {
                      final groupData = Provider.of<GroupProvider>(
                        context,
                        listen: false,
                      );
                      setState(() {
                        _isExpandedGroup = value;

                        // Update participants locally before fetching the updated list
                        if (_isExpandedGroup) {
                          currentGroupUsernames.clear();
                        }
                      });
                      if (_isExpandedGroup) {
                        final groupNames =
                            await groupData.getParticipants(travelGroup.id);
                      }
                    },
                    baseColor:
                        Theme.of(context).backgroundColor.withOpacity(0.2),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          final groupData = Provider.of<GroupProvider>(context,
                              listen: false);
                          groupData
                              .getParticipants(travelGroup.id)
                              .then((value) => Navigator.of(context).pushNamed(
                                    '/edit_travel_group',
                                    arguments: travelGroup,
                                  ));
                        },
                      ),
                    ),
                    title: Text(travelGroup.groupName),
                    children: [
                      Builder(
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                ...currentGroupUsernames
                                    .map((username) => ListTile(
                                          title: Text(username),
                                        ))
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
          ],
        ),
      ),
    );
  }
}

void formGroup(BuildContext context) {
  final groupData = Provider.of<GroupProvider>(context, listen: false);
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
                if (groupName.isEmpty) {
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text('Error'),
                    content: Text('Group name cannot be empty'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                } else {
                  groupData
                      .addGroup(
                        groupName,
                        userId,
                      )
                      .then(
                        (value) => showAddFriendDialog(context),
                      );
                }
              },
              child: Text('Create Group'),
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
          title: Text('Add Friends'),
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
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
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
                                        ),
                                      );
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
                height: 20,
              ),
              Row(
                children: <Widget>[
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
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          TextEditingController _controller =
                              TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text('Send friend request'),
                                content: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: 'Enter username',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  onSubmitted: (value) {
                                    print(value);
                                  },
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
                                      print(currentUser.name);
                                      print('$userId');
                                      print(
                                          'friend username' + _controller.text);

                                      final userData =
                                          Provider.of<UserProvider>(context,
                                              listen: false);
                                      userData
                                          .getUserIdByUsername(_controller.text)
                                          .then(
                                        (value) {
                                          print('friend id' + friendId);
                                          userData
                                              .sendFriendRequest(
                                                  userId, friendId)
                                              .then(
                                            (value) {
                                              Navigator.of(context).pop();
                                              if (value) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CupertinoAlertDialog(
                                                      title: Text('Success'),
                                                      content: Text(
                                                          'Friend request sent'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
                                                  builder: (context) {
                                                    return CupertinoAlertDialog(
                                                      title: Text('Error'),
                                                      content: Text(
                                                          'Failed to send friend request'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Send'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Center(
                          child: Text(
                            'Send Friend Request',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
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
