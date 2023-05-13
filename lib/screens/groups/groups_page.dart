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

  @override
  void initState() {
    super.initState();
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
      body: ListView(
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
                  onExpansionChanged: (value) {
                    final groupData = Provider.of<GroupProvider>(
                      context,
                      listen: false,
                    );
                    final groupNames =
                        groupData.getParticipants(travelGroup.id).then((value) {
                      print(currentGroupUsernames);
                    });
                    setState(() {
                      _isExpandedGroup = value;
                    });
                  },
                  baseColor: Theme.of(context).backgroundColor.withOpacity(0.2),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        final groupData =
                            Provider.of<GroupProvider>(context, listen: false);
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
                  subtitle: Text(
                    travelGroup.commonStartDate.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
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
                groupData
                    .addGroup(
                      groupName,
                      userId,
                    )
                    .then(
                      (value) => showAddFriendDialog(context),
                    );
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
                            groupData.getGroupByUserId(userId).then(
                                  (value) => groupData.addUserToGroup(
                                    currentGroupId,
                                    currentFriendIds[index].toString(),
                                  ),
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
