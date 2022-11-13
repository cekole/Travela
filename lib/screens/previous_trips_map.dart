import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travela_mobile/widgets/maps/extended_friends_map.dart';
import 'package:travela_mobile/widgets/maps/extended_previous_trips_map.dart';

class PreviousTripsMap extends StatelessWidget {
  const PreviousTripsMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Trips Map'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ExtendedPreviousTripsMap(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.filter_list),
                label: Text('Options'),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SafeArea(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Add Photos'),
                              leading: Icon(Icons.add_a_photo),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                            ListTile(
                              title: Text('Rate'),
                              leading: Icon(Icons.star),
                              trailing: DropdownButton(
                                value: 5,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('1'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('2'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('3'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('4'),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('5'),
                                    value: 5,
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                            ListTile(
                              title: Text('Share To All'),
                              leading: Icon(Icons.share),
                              trailing: Switch.adaptive(
                                  value: true, onChanged: (value) {}),
                            ),
                            ListTile(
                              title: Text('Date'),
                              leading: Icon(Icons.date_range),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                            ListTile(
                              title: Text('Location'),
                              leading: Icon(Icons.location_on),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Share Trip'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
