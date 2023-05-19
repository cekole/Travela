import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/user_provider.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
    required this.title,
    required this.requestNames,
    required this.requestIds,
  }) : super(key: key);

  final String? title;
  final List requestNames;
  final List requestIds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTileCard(
        onExpansionChanged: (value) async {
          final userData = Provider.of<UserProvider>(context, listen: false);
          await userData.getAllIncomingRequests();
        },
        baseColor: Colors.grey.withOpacity(0.2),
        shadowColor: Colors.black,
        title: Text(title!),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: requestNames.length,
            itemBuilder: (context, index) {
              final userData =
                  Provider.of<UserProvider>(context, listen: false);
              return ListTile(
                title: Text(requestNames[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await userData.acceptFriendRequest(
                            userId, requestIds[index].toString());
                        requestNames.removeAt(index);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                                title: Text('Request accepted'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      // navigate to Groups page
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        '/home',
                                        (route) => false,
                                      );
                                      pageNum = 2;
                                    },
                                    child: Text('Ok'),
                                  ),
                                ]);
                          },
                        );
                      },
                      icon: Icon(Icons.check),
                    ),
                    IconButton(
                      onPressed: () async {
                        await userData.rejectFriendRequest(
                            userId, requestIds[index].toString());
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text('Request rejected'),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      '/home',
                                      (route) => false,
                                    );
                                  },
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.close),
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
