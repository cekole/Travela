import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travela_mobile/models/travel_group.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';
import 'package:travela_mobile/screens/trips/trips_page.dart';
import 'package:travela_mobile/providers/travel_group_provider.dart';

class GroupsPage extends StatefulWidget {
  static const String routeName = '/groups';

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Travel Groups',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _travelGroupModal(context);
                          },
                          tooltip: 'Form A Travel Group',
                          icon: const Icon(Icons.view_headline_sharp),
                        )
                      ],
                    ),
                  ),
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
                        return ExpansionTileCard(
                          baseColor: Theme.of(context)
                              .backgroundColor
                              .withOpacity(0.4),
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
                    child: ExpansionTile(
                      title: Text('Calendar'),
                      children: [
                        Builder(builder: (context) {
                          return TableCalendar(
                            focusedDay: DateTime.now(),
                            firstDay: DateTime(2022),
                            lastDay: DateTime(2024),
                            calendarFormat: CalendarFormat.month,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            daysOfWeekVisible: true,
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              selectedDecoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle: TextStyle(color: Colors.white),
                              todayDecoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              defaultDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              weekendDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                formGroup(context);
              },
              child: Text(
                'Form Group',
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<dynamic> _travelGroupModal(BuildContext context) {
  final travelGroupData =
      Provider.of<TravelGroupProvider>(context, listen: false);
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            final travelGroup = travelGroupData.travelGroups[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/edit_travel_group',
                    arguments: travelGroup,
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(travelGroup.name),
                subtitle: Text(
                  travelGroup.destinations
                      .map((destination) =>
                          '${destination.city}, ${destination.country}')
                      .join(' | '),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
          itemCount: travelGroupData.travelGroups.length,
        ),
      );
    },
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
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
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