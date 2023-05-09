import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:travela_mobile/appConstant.dart';
import 'package:travela_mobile/providers/user_provider.dart';
import 'package:travela_mobile/widgets/friend_card.dart';
import 'package:travela_mobile/widgets/request_card.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          FriendCard(
            title: 'Friends',
          ),
          RequestCard(
            title: 'Requests',
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text('Send a friend request'),
                        content: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
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
                              final userData = Provider.of<UserProvider>(
                                  context,
                                  listen: false);
                              userData.sendFriendRequest('$userId', '11');
                              Navigator.of(context).pop();
                            },
                            child: Text('Send'),
                          ),
                        ],
                      );
                    });
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
